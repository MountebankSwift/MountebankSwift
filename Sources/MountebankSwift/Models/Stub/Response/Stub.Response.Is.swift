import Foundation

extension Stub.Response {
    // swiftlint:disable type_name
    public struct Is: StubResponse, Codable, Equatable {
        public static var defaultBehaviors: [Behavior] = []
        public static var defaultHeaders: [String: String] = [:]

        public let statusCode: Int
        public let headers: [String: String]?
        public let body: Body?
        public let contentType: String?

        public let parameters: Parameters?

        public init(
            statusCode: Int = 200,
            headers: [String: String]? = nil,
            body: Body? = nil,
            contentType: String? = nil,
            repeatCount: Int? = nil,
            behaviors: [Behavior] = []
            // TODO: Discuss:
            // parameters: Parameters? = nil
        ) {
            self.statusCode = statusCode
            self.body = body
            self.contentType = contentType
            self.headers = Self.makeHeaders(headers: headers, body: body, contentType: contentType)

            self.parameters = Parameters(
                repeatCount: repeatCount,
                behaviors: behaviors + Self.defaultBehaviors
            )
        }

        static func makeHeaders(
            headers: [String: String]?,
            body: Body?,
            contentType: String?
        ) -> [String: String]? {
            var result = Self.defaultHeaders

            switch body {
            case .none, .text, .data:
                break
            case .json, .jsonEncodable:
                result[HTTPHeaders.contentType.rawValue] = MimeType.json.rawValue
            }

            if let contentType {
                result[HTTPHeaders.contentType.rawValue] = contentType
            }

            if let headers {
                result.merge(headers, uniquingKeysWith: { a, b in b })
            }

            return result
        }

        public init(statusCode: Int = 200, headers: [String: String]? = nil, body: String, repeatCount: Int? = nil,
                    behaviors: [Behavior] = []) {
            self.init(
                statusCode: statusCode,
                headers: headers,
                body: .text(body),
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }

        public init(statusCode: Int = 200, headers: [String: String]? = nil, body: JSON, repeatCount: Int? = nil,
                    behaviors: [Behavior] = []) {
            self.init(
                statusCode: statusCode,
                headers: headers,
                body: .json(body),
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }

        public init(statusCode: Int = 200, headers: [String: String]? = nil, body: Data, repeatCount: Int? = nil,
                    behaviors: [Behavior] = []) {
            self.init(
                statusCode: statusCode,
                headers: headers,
                body: .data(body),
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }

        public init(statusCode: Int = 200, headers: [String: String]? = nil, body: any Codable, repeatCount: Int? = nil,
                    behaviors: [Behavior] = []) {
            self.init(
                statusCode: statusCode,
                headers: headers,
                body: .jsonEncodable(body),
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }

        func with(parameters: Parameters) -> Is {
            Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                repeatCount: parameters.repeatCount,
                behaviors: parameters.behaviors ?? []
            )
        }
    }
}

extension Array where Element == Stub.Response.Is {
    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [Stub.Response.Body],
        repeatCount: Int? = nil,
        behaviors: [Stub.Response.Behavior] = []
    ) {
        self = bodies.map { body in
            Stub.Response.Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }
    }

    // Do we want these overloads for ease of use?
    public init(
        statusCode: Int = 200,
        headers: [String: String]? = nil,
        bodies: [JSON],
        repeatCount: Int? = nil,
        behaviors: [Stub.Response.Behavior] = []
    ) {
        self = bodies.map { body in
            Stub.Response.Is(
                statusCode: statusCode,
                headers: headers,
                body: body,
                repeatCount: repeatCount,
                behaviors: behaviors
            )
        }
    }
}
