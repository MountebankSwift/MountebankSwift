import Foundation

extension ResponseParameters {
    enum DecodingError: Error {
        case empty
    }

    enum CodingKeys: String, CodingKey {
        case repeatCount = "repeat"
        case behaviors
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        repeatCount = try container.decodeIfPresent(Int.self, forKey: .repeatCount)
        behaviors = try container.decodeIfPresent([Behavior].self, forKey: .behaviors)

        if isEmpty {
            throw DecodingError.empty
        }
    }

    public func encode(to encoder: Encoder) throws {
        if isEmpty {
            return
        }

        var container = encoder.container(keyedBy: CodingKeys.self)

        if let repeatCount {
            try container.encode(repeatCount, forKey: .repeatCount)
        }

        if let behaviors, !behaviors.isEmpty {
            try container.encode(behaviors, forKey: .behaviors)
        }
    }
}
