import Foundation

/// A  HTTP request method
public enum HTTPMethod: String, Codable, Equatable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension HTTPMethod: Recreatable {
    public func swiftString(depth: Int) -> String {
        enumSwiftString(depth: depth)
    }
}
