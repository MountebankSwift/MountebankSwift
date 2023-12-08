import Foundation

extension Stub.Response {
    // swiftlint:disable type_name
    public struct Is: StubResponse, Codable, Equatable {
        public let statusCode: Int
        public let headers: [String: String]?
        public let body: Body?

        public let parameters: Parameters?

        public init(
            statusCode: Int = 200,
            headers: [String: String]? = nil,
            body: Body? = nil,
            repeatCount: Int? = nil,
            behaviors: [Behavior] = []
            // TODO: Discuss:
            // parameters: Parameters? = nil
        ) {
            self.statusCode = statusCode
            self.headers = headers
            self.body = body

            self.parameters = Parameters(repeatCount: repeatCount, behaviors: behaviors)
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
