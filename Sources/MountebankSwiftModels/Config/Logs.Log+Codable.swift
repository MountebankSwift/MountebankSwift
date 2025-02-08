import Foundation

extension Logs.Log {
    enum CodingKeys: String, CodingKey, Equatable {
        case level
        case message
        case timestamp
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(level, forKey: .level)
        try container.encode(message, forKey: .message)
        if let timestamp {
            try container.encodeIfPresent(DateFormatter.shared.formatFromDate(timestamp), forKey: .timestamp)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        level = try container.decode(LogLevel.self, forKey: .level)
        message = try container.decode(String.self, forKey: .message)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .timestamp) {
            timestamp = try DateFormatter.shared.formatToDate(dateString)
        } else {
            timestamp = nil
        }
    }
}
