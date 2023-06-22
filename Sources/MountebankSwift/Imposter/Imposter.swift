import Foundation

// https://www.mbtest.org/docs/api/contracts
public struct Imposter: Codable, Equatable {
    public let port: Int?
    public let scheme: Scheme
    public let name: String?
    public let stubs: [Stub]
    public let defaultResponse: Stub.Response?

    // TODO
    // public let recordRequests: Bool
    // public let requests: [Request]
    // public let numberOfRequests: Int

    enum CodingKeys: String, CodingKey {
        case port
        case scheme = "protocol"
        case stubs
        case name
        case defaultResponse
    }

    public init(
        port: Int? = nil,
        scheme: Scheme,
        name: String? = nil,
        stubs: [Stub],
        defaultResponse: Stub.Response? = nil
    ) {
        self.port = port
        self.scheme = scheme
        self.name = name
        self.stubs = stubs
        self.defaultResponse = defaultResponse
    }
}
