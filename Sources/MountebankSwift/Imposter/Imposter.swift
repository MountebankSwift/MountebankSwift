import Foundation


// TODO MB responses containing imposters will could also contain
// public let requests: [Request]
// public let numberOfRequests: Int

public struct Imposter: Codable, Equatable {
    public let port: Int?
    public let scheme: Scheme
    public let name: String?
    public let stubs: [Stub]
    public let defaultResponse: Stub.Response?
    public let recordRequests: Bool?

    enum CodingKeys: String, CodingKey {
        case port
        case scheme = "protocol"
        case name
        case stubs
        case recordRequests
        case defaultResponse
    }

    public init(
        port: Int? = nil,
        scheme: Scheme,
        name: String? = nil,
        stubs: [Stub],
        defaultResponse: Stub.Response? = nil,
        recordRequests: Bool? = nil
    ) {
        self.port = port
        self.scheme = scheme
        self.name = name
        self.stubs = stubs
        self.defaultResponse = defaultResponse
        self.recordRequests = recordRequests
    }
}
