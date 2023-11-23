import Foundation

public struct Config: Codable, Equatable {
    public struct Options: Codable, Equatable {
        public struct Log: Codable, Equatable {
            let level: LogLevel
        }

        public let port: Int
        public let localOnly: Bool
        public let ipWhitelist: [String]
        public let origin: Bool
        public let protofile: String
        public let pidfile: String?
        public let log: Log?
        public let noParse: Bool?
        public let formatter: String?
        public let configFile: String?
        public let allowInjection: Bool
        public let debug: Bool
    }

    public struct Process: Codable, Equatable {
        public let nodeVersion: String
        public let architecture: String
        public let platform: String
        public let rss: Int
        public let heapTotal: Int
        public let heapUsed: Int
        public let uptime: Double
        public let cwd: String
    }

    public let version: String
    public let options: Options
    public let process: Process
}
