import Foundation

/// Used for encoding / decoding only
internal enum CodableResponse: Codable, Equatable {
    case `is`(Is)
    case proxy(Proxy)
    case inject(Inject)
    case fault(Fault)

    enum DecodingError: Error {
        case invalidType
    }

    enum CodingKeys: String, CodingKey {
        case `is`
        case proxy
        case inject
        case fault
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .is(let response):
            try container.encode(response, forKey: .is)
            try response.parameters?.encode(to: encoder)
        case .proxy(let response):
            try container.encode(response, forKey: .proxy)
        case .inject(let response):
            try container.encode(response, forKey: .inject)
        case .fault(let response):
            try container.encode(response, forKey: .fault)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let response = try container.decodeIfPresent(Is.self, forKey: .is) {
            if let parameters = try? ResponseParameters(from: decoder) {
                self = .is(
                    Is(
                        statusCode: response.statusCode,
                        headers: response.headers,
                        body: response.body,
                        parameters: parameters
                    )
                )
            } else {
                self = .is(response)
            }
        } else if let response = try container.decodeIfPresent(Proxy.self, forKey: .proxy) {
            self = .proxy(response)
        } else if let response = try container.decodeIfPresent(Fault.self, forKey: .fault) {
            self = .fault(response)
        } else if let response = try container.decodeIfPresent(Inject.self, forKey: .inject) {
            self = .inject(response)
        } else {
            throw DecodingError.invalidType
        }
    }
}
