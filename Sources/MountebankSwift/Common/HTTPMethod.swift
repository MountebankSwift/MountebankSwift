import Foundation

/// A  HTTP request method
public enum HTTPMethod: String, Codable, Equatable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

extension HTTPMethod: Recreatable {
    var recreatable: String {
        enumSwiftString()
    }
}
