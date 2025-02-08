import Foundation

/// Logs of the mountebank server
///
/// [mbtest.org/docs/api/contracts?type=logs](https://www.mbtest.org/docs/api/contracts?type=logs)
public struct Logs: Codable, Equatable, Sendable {

    public struct Log: Codable, Equatable, Sendable {
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
