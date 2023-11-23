import Foundation

public struct Logs: Codable, Equatable {

    public struct Log: Codable, Equatable {
        public let level: LogLevel
        public let message: String
        public let date: Date?

        enum CodingKeys: String, CodingKey, Equatable {
            case level
            case message
            case date
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(level, forKey: .level)
            try container.encode(message, forKey: .message)
            try container.encodeIfPresent(date, forKey: .date)
        }

        private static func makeDateformatter() -> ISO8601DateFormatter {
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            isoDateFormatter.formatOptions = [
                .withFullDate,
                .withFullTime,
                .withDashSeparatorInDate,
                .withFractionalSeconds
            ]

            return isoDateFormatter
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            level = try container.decode(LogLevel.self, forKey: .level)
            message = try container.decode(String.self, forKey: .message)

            if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
                let formatter = Self.makeDateformatter()
                date = formatter.date(from: dateString)
            } else {
                date = nil
            }
        }

        init(
            level: LogLevel,
            message: String,
            date: Date?
        ) {
            self.level = level
            self.message = message
            self.date = date
        }

    }

    public let logs: [Log]
}
