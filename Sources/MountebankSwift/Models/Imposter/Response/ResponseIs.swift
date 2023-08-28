import Foundation

extension Stub.Response {
    // swiftlint:disable type_name
    public struct Is: Codable, Equatable {
        public let statusCode: Int
        public let headers: [String: String]?
        public let body: Body?

        public init(statusCode: Int, headers: [String: String]? = nil, body: Body? = nil) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = body
        }

        public init(statusCode: Int, headers: [String: String]? = nil, body: String) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .text(body)
        }

        public init(statusCode: Int, headers: [String: String]? = nil, body: JSON) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .json(body)
        }

        public init(statusCode: Int, headers: [String: String]? = nil, body: Data) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = .data(body)
        }
    }
}
