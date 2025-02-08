import Foundation

extension Behavior.BehaviorCopyMethod {

    enum CodingKeys: String, CodingKey {
        case method
        case selector
        case namespace = "ns"
        case options
    }

    enum OptionsCodingKeys: String, CodingKey {
        case ignoreCase
        case multiline
    }

    private enum Method: String, Codable {
        case regex
        case xpath
        case jsonpath
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let method = try container.decode(Method.self, forKey: .method)
        let selector = try container.decode(String.self, forKey: .selector)

        switch method {
        case .regex:
            var options: [Options] = []
            if
                let optionsContainer = try? container
                    .nestedContainer(keyedBy: OptionsCodingKeys.self, forKey: .options)
            {
                if try optionsContainer.decodeIfPresent(Bool.self, forKey: .ignoreCase) == true {
                    options.append(.ignoreCase)
                }
                if try optionsContainer.decodeIfPresent(Bool.self, forKey: .multiline) == true {
                    options.append(.multiline)
                }
            }
            self = .regex(selector: selector, options: options)
        case .xpath:
            let namespace = try container.decode([String: String].self, forKey: .namespace)
            self = .xpath(selector: selector, namespace: namespace)
        case .jsonpath:
            self = .jsonpath(selector: selector)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .regex(selector: let selector, options: let options):
            try container.encode(Method.regex.rawValue, forKey: .method)
            try container.encode(selector, forKey: .selector)

            if !options.isEmpty {
                var optionsContainer = container.nestedContainer(keyedBy: OptionsCodingKeys.self, forKey: .options)

                try options.forEach { option in
                    switch option {
                    case .ignoreCase:
                        try optionsContainer.encode(true, forKey: .ignoreCase)
                    case .multiline:
                        try optionsContainer.encode(true, forKey: .multiline)
                    default:
                        break
                    }
                }
            }

        case .xpath(selector: let selector, namespace: let namespace):
            try container.encode(Method.xpath.rawValue, forKey: .method)
            try container.encode(selector, forKey: .selector)
            try container.encode(namespace, forKey: .namespace)
        case .jsonpath(selector: let selector):
            try container.encode(Method.jsonpath.rawValue, forKey: .method)
            try container.encode(selector, forKey: .selector)
        }
    }
}
