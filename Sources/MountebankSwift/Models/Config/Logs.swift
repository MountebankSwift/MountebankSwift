import Foundation

/// Logs as documented on:
/// [mbtest.org/docs/api/contracts?type=logs](https://www.mbtest.org/docs/api/contracts?type=logs)
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
