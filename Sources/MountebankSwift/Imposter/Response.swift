import Foundation

// https://www.mbtest.org/docs/api/contracts
public extension Stub {
    enum Response: Codable, Equatable {
        public enum Mode: String, Codable, Equatable {
            case text
            case binary
        }

        public struct Is: Codable, Equatable {
            let statusCode: Int
            let headers: [String: String]? // Nice to have: Make more type safe?
            let body: String? // Nice to have: String OR JSON object
            let mode: Mode?

            enum CodingKeys: String, CodingKey {
                case statusCode
                case headers
                case body
                case mode = "_mode"
            }

            public init(statusCode: Int = 200, headers: [String : String]? = nil, body: String? = nil, mode: Mode? = nil) {
                self.statusCode = statusCode
                self.headers = headers?.isEmpty == true ? nil : headers
                self.body = body
                self.mode = mode
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(statusCode, forKey: .statusCode)
                try container.encodeIfPresent(headers, forKey: .headers)
                try container.encodeIfPresent(body, forKey: .body)
                try container.encodeIfPresent(mode, forKey: .mode)
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                statusCode = try container.decode(Int.self, forKey: .statusCode)
                headers = try container.decodeIfPresent([String: String].self, forKey: .headers)
                body = try container.decodeIfPresent(String.self, forKey: .body)
                mode = try container.decodeIfPresent(Mode.self, forKey: .mode)
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

        public enum ResponseFault: String, Codable, Equatable {
            case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
            case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
        }

        public struct Parameters: Codable, Equatable {
            let `repeat`: Int?

            public init(repeatCount: Int? = nil) {
                self.repeat = repeatCount
            }

            var isEmpty: Bool {
                return `repeat` == nil
            }
        }

        case `is`(Is, Parameters?)
        case proxy(Proxy, Parameters?)
        case inject(String, Parameters?)
        case fault(ResponseFault, Parameters?)

        enum CodingKeys: String, CodingKey {
            case `is`
            case proxy
            case inject
            case fault
            case `repeat`
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .is(let isData, let parameters):
                try container.encode(isData, forKey: .is)
                if parameters?.isEmpty == false {
                    try parameters?.encode(to: encoder)
                }
            case .proxy(let proxyData, let parameters):
                try container.encode(proxyData, forKey: .proxy)
                if parameters?.isEmpty == false {
                    try parameters?.encode(to: encoder)
                }
            case .inject(let injectData, let parameters):
                try container.encode(injectData, forKey: .inject)
                if parameters?.isEmpty == false {
                    try parameters?.encode(to: encoder)
                }
            case .fault(let faultData, let parameters):
                try container.encode(faultData, forKey: .fault)
                if parameters?.isEmpty == false {
                    try parameters?.encode(to: encoder)
                }
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            var parameters: Parameters? = try Parameters(from: decoder)
            if parameters?.isEmpty == true {
                parameters = nil
            }

            if let isData = try container.decodeIfPresent(Is.self, forKey: .is) {
                self = .is(isData, parameters)
            } else if let proxyData = try container.decodeIfPresent(Proxy.self, forKey: .proxy) {
                self = .proxy(proxyData, parameters)
            } else if let injectData = try container.decodeIfPresent(String.self, forKey: .inject) {
                self = .inject(injectData, parameters)
            } else if let faultData = try container.decodeIfPresent(ResponseFault.self, forKey: .fault) {
                self = .fault(faultData, parameters)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: .is,
                    in: container,
                    debugDescription: "Invalid response type"
                )
            }
        }
    }
}

