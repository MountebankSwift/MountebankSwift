import Foundation

enum ResponseEncodingError: Error {
    case invalidData
}

// https://www.mbtest.org/docs/api/contracts
public extension Stub {
    enum Response: Codable, Equatable {
        public struct Is: Codable, Equatable {
            let statusCode: Int
            let headers: [String: String]? // Nice to have: Make more type safe?
            let body: Body?

            public init(statusCode: Int, headers: [String : String]? = nil, body: Body) {
                self.statusCode = statusCode
                self.headers = headers
                self.body = body
            }

            public init(statusCode: Int, headers: [String : String]? = nil) {
                self.statusCode = statusCode
                self.headers = headers
                self.body = nil
            }

            public init(statusCode: Int, headers: [String : String]? = nil, body: String) {
                self.statusCode = statusCode
                self.headers = headers
                self.body = .text(body)
            }

            public init(statusCode: Int, headers: [String : String]? = nil, body: JSON) {
                self.statusCode = statusCode
                self.headers = headers
                self.body = .json(body)
            }

            public init(statusCode: Int, headers: [String : String]? = nil, body: Data) {
                self.statusCode = statusCode
                self.headers = headers
                self.body = .data(body)
            }
        }

        public struct Proxy: Codable, Equatable {
            let to: String
            let mode: String

            public init(to: String, mode: String) {
                self.to = to
                self.mode = mode
            }
        }

        public enum Fault: String, Codable, Equatable {
            case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
            case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
        }

        public struct Parameters: Codable, Equatable {
            let `repeat`: Int?

            var isEmpty: Bool {
                return `repeat` == nil
            }

            public init(repeatCount: Int? = nil) {
                self.repeat = repeatCount
            }
        }

        case `is`(Is, Parameters?)
        case proxy(Proxy, Parameters?)
        case inject(String, Parameters?)
        case fault(Fault, Parameters?)
    }
}
