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
            let dateFormatter = Self.makeDateformatter()
            try container.encodeIfPresent(dateFormatter.string(from: timestamp), forKey: .timestamp)
        }
    }

    private static func makeDateformatter() -> ISO8601DateFormatter {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds,
        ]

        return isoDateFormatter
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        level = try container.decode(LogLevel.self, forKey: .level)
        message = try container.decode(String.self, forKey: .message)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .timestamp) {
            let formatter = Self.makeDateformatter()
            timestamp = formatter.date(from: dateString)
        } else {
            timestamp = nil
        }
    }
}
