import Foundation

public struct Logs: Codable, Equatable {

    public struct Log: Codable, Equatable {
        public let level: LogLevel
        public let message: String
        public let timestamp: Date?

        init(
            level: LogLevel,
            message: String,
            timestamp: Date?
        ) {
            self.level = level
            self.message = message
            self.timestamp = timestamp
        }
    }

    public let logs: [Log]
}
