import Foundation

/// The predicate will use all the optional fields in this request to try to match an incoming request made by the
/// application under test
public struct Request: Equatable, Codable {
    public let method: HTTPMethod?
    public let path: String?
    public let query: [String: JSON]?
    public let headers: [String: JSON]?
    public let data: JSON?

    public init(
        method: HTTPMethod? = nil,
        path: String? = nil,
        query: [String: JSON]? = nil,
        headers: [String: JSON]? = nil,
        data: JSON? = nil
    ) {
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.data = data
    }

    public var debugDescription: String {
        [method.map(\.rawValue), path]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}

extension Request: Recreatable {
    var recreatable: String {
        structSwiftString([
            ("method", method),
            ("path", path),
            ("query", query),
            ("headers", headers),
            ("data", data),
        ])
    }
}
