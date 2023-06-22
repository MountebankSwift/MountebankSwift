import Foundation

// TODO MB responses containing imposters will could also contain
// public let requests: [Request]
// public let numberOfRequests: Int

public struct Imposter: Codable, Equatable {
    /// The port to run the imposter on.
    ///
    /// Defaults to a randomly assigned port that will be returned in the response
    public let port: Int?

    /// Defines the protocol that the imposter will respond to.
    public let scheme: Scheme

    /// Descriptive name that will show up in the logs and the imposters UI.
    public let name: String?

    /// A set of behaviors used to generate a response for an imposter. An imposter can have 0 or more stubs, each of
    /// which are associated with different predicates and support different responses.
    ///
    /// You would use multiple stubs for an imposter if the types of response you return depends on something in the
    /// request, matched with a predicate.
    public let stubs: [Stub]

    /// Allows you to override the default response that mountebank sends back if no predicate matches a request. Even
    /// if a predicate does match but the response isn't fully specified, these values get merged in to complete the
    /// response.
    public let defaultResponse: Stub.Response.Is?

    /// If set to true, the server will record requests received, for mock verification purposes.
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
        defaultResponse: Stub.Response.Is? = nil,
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
