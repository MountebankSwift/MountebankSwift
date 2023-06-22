import Foundation

// https://www.mbtest.org/docs/api/contracts
extension Stub {
    public enum Response: Codable {
        public enum Mode: String, Codable {
            case text
            case binary
        }

        public struct Is: Codable {
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

            init(statusCode: Int = 200, headers: [String : String]? = nil, body: String? = nil, mode: Mode? = nil) {
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
                headers = try container.decodeIfPresent([String: String].self, forKey: .headers) ?? [:]
                body = try container.decodeIfPresent(String.self, forKey: .body)
                mode = try container.decodeIfPresent(Mode.self, forKey: .mode)
            }

        }

        public struct Proxy: Codable {
            let to: String
            let mode: String
        }

        public enum ResponseFault: String, Codable {
            case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
            case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
        }

        public struct Parameters: Codable {
            let `repeat`: Int?

            init(repeatCount: Int? = nil) {
                self.repeat = repeatCount
            }
        }

        case `is`(Is, Parameters?)
        case proxy(Proxy, Parameters?)
        case inject(injection: String, Parameters?)
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
                try parameters?.encode(to: encoder)
            case .proxy(let proxyData, let parameters):
                try container.encode(proxyData, forKey: .proxy)
                try parameters?.encode(to: encoder)
            case .inject(let injectData, let parameters):
                try container.encode(injectData, forKey: .inject)
                try parameters?.encode(to: encoder)
            case .fault(let faultData, let parameters):
                try container.encode(faultData, forKey: .fault)
                try parameters?.encode(to: encoder)
            }
        }

        public init(from decoder: Decoder) throws {
            fatalError()
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        let isData = try container.decodeIfPresent(Is.self, forKey: .is)
    //
    //        switch type {
    //        case "is":
    //            let isData = try container.decode(Is.self, forKey: .data)
    //            let parameters = try container.decodeIfPresent(Parameters.self, forKey: .parameters)
    //            self = .is(isData, parameters)
    //        case "proxy":
    //            let proxyData = try container.decode(Proxy.self, forKey: .data)
    //            let parameters = try container.decodeIfPresent(Parameters.self, forKey: .parameters)
    //            self = .proxy(proxyData, parameters)
    //        case "inject":
    //            let injection = try container.decode(String.self, forKey: .data)
    //            let parameters = try container.decodeIfPresent(Parameters.self, forKey: .parameters)
    //            self = .inject(injection: injection, parameters)
    //        default:
    //            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid response type")
    //        }
        }

    }
}


