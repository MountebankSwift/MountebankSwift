import Foundation

// https://www.mbtest.org/docs/api/contracts
public struct Imposter: Codable, Equatable {
    public let port: Int?
    public let scheme: Scheme
    public let name: String?
    public let stubs: [Stub]

    // TODO
    // public let recordRequests: Bool
    // public let requests: [Request]

    // only in response from MB
    // public let numberOfRequests: Int

    // TODO
    // public let defaultResponse: Response?

    // TODO tcp ?
    // endOfRequestResolver

    enum CodingKeys: String, CodingKey {
        case port
        case scheme = "protocol"
        case stubs
        case name
    }

    public init(port: Int?, scheme: Scheme, name: String?, stubs: [Stub]) {
        self.port = port
        self.scheme = scheme
        self.name = name
        self.stubs = stubs
    }
}

