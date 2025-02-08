import Foundation

/// The log level of a log entry
public enum LogLevel: String, Codable, Sendable {
    case info
    case warn
    case error
}
