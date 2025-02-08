import Foundation

extension Behavior: Codable {

    enum DecodingError: Error {
        case invalidType
    }

    enum CodingKeys: String, CodingKey {
        case wait
        case copy
        case lookup
        case decorate
        case shellTransform
    }

    enum CopyCodingKeys: String, CodingKey {
        case from
        case into
        case using
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let miliseconds = try? container.decode(Int.self, forKey: .wait) {
            self = .wait(miliseconds: miliseconds)
        } else if let javascript = try container.decodeIfPresent(String.self, forKey: .wait) {
            self = .waitJavascript(javascript)
        } else if let copyContainer = try? container.nestedContainer(keyedBy: CopyCodingKeys.self, forKey: .copy) {
            let from = try copyContainer.decode(JSON.self, forKey: .from)
            let into = try copyContainer.decode(String.self, forKey: .into)
            let behaviorCopyMethod = try copyContainer.decode(BehaviorCopyMethod.self, forKey: .using)

            self = .copy(from: from, into: into, using: behaviorCopyMethod)
        } else if let value = try container.decodeIfPresent(JSON.self, forKey: .lookup) {
            self = .lookup(value)
        } else if let value = try container.decodeIfPresent(String.self, forKey: .decorate) {
            self = .decorate(value)
        } else if let value = try container.decodeIfPresent(String.self, forKey: .shellTransform) {
            self = .shellTransform(value)
        } else {
            throw DecodingError.invalidType
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .wait(let miliseconds):
            try container.encode(miliseconds, forKey: .wait)
        case .waitJavascript(let javascript):
            try container.encode(javascript, forKey: .wait)
        case .copy(let from, let into, let behaviorCopyMethod):
            var copyContainer = container.nestedContainer(keyedBy: CopyCodingKeys.self, forKey: .copy)
            try copyContainer.encode(from, forKey: .from)
            try copyContainer.encode(into, forKey: .into)
            try copyContainer.encode(behaviorCopyMethod, forKey: .using)
        case .lookup(let json):
            try container.encode(json, forKey: .lookup)
        case .decorate(let string):
            try container.encode(string, forKey: .decorate)
        case .shellTransform(let string):
            try container.encode(string, forKey: .shellTransform)
        }
    }
}
