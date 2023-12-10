import Foundation

public protocol StubResponse: Codable, Equatable {}

extension Stub {
    // TODO make this type internal
    public enum Response: Codable, Equatable {
        case `is`(Stub.Response.Is)
        case proxy(Stub.Response.Proxy)
        case inject(Stub.Response.Inject)
        case fault(Stub.Response.Fault)
    }
}

extension Stub.Response {
    public init?(response: any StubResponse) {
        if let response = response as? Stub.Response.Is {
            self = .is(response)
        } else if let response = response as? Stub.Response.Proxy {
            self = .proxy(response)
        } else if let response = response as? Stub.Response.Inject {
            self = .inject(response)
        } else if let response = response as? Stub.Response.Fault {
            self = .fault(response)
        } else {
            assertionFailure("Unknown StubResponse")
            return nil
        }
    }
}

// TODO: Move to own file
extension Stub.Response {
    public struct Inject: Codable, StubResponse {
        public let injection: String

        public init(_ injection: String) {
            self.injection = injection
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.injection = try container.decode(String.self)
        }

        public func encode(to encoder: Encoder) throws {
            try injection.encode(to: encoder)
        }
    }
}

