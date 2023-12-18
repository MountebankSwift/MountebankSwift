import Foundation

extension Imposter {
    public struct RecordedRequest: Equatable, Codable, CustomDebugStringConvertible {
        public let method: HTTPMethod?
        public let path: String?
        public let query: [String: String]?
        public let headers: [String: String]?
        public let body: JSON?
        public let form: String?

        public let timestamp: Date
        public let requestFrom: String
        public let ip: String

        init(
            method: HTTPMethod,
            path: String,
            query: [String: String]? = nil,
            headers: [String: String]? = nil,
            body: JSON? = nil,
            form: String? = nil,
            requestFrom: String,
            ip: String,
            timestamp: Date
        ) {
            self.method = method
            self.path = path
            self.query = query
            self.headers = headers
            self.body = body
            self.form = form
            self.requestFrom = requestFrom
            self.ip = ip
            self.timestamp = timestamp
        }

        public var debugDescription: String {
            [method.map { "\($0.rawValue)" }, path]
                .compactMap { $0 }
                .joined(separator: " ")
        }
    }
}
