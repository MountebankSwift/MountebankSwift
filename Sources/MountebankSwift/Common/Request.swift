public struct Request: Equatable, Codable, CustomDebugStringConvertible {
    public let method: HTTPMethod?
    public let path: String?
    public let query: JSON? // TODO [String: JSON] ?
    public let headers: JSON? // TODO [String: JSON] ?
    public let data: JSON?

    public init(
        method: HTTPMethod? = nil,
        path: String? = nil,
        query: JSON? = nil,
        headers: JSON? = nil,
        data: JSON? = nil
    ) {
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.data = data
    }

    public var debugDescription: String {
        [method.map { "\($0.rawValue)" }, path]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
