import Foundation

/// Imposter as documented on:
/// [mbtest.org/docs/api/contracts?type=imposter](https://www.mbtest.org/docs/api/contracts?type=imposter)
public struct Imposter: Codable, Equatable {
    /// The port to run the imposter on.
    ///
    /// Defaults to a randomly assigned port that will be returned in the response
    public let port: Int?

    /// Defines the protocol that the imposter will respond to.
    public let networkProtocol: NetworkProtocol

    /// Descriptive name that will show up in the logs and the imposters UI.
    public var name: String?

    /// A set of behaviors used to generate a response for an imposter. An imposter can have 0 or more stubs, each of
    /// which are associated with different predicates and support different responses.
    ///
    /// You would use multiple stubs for an imposter if the types of response you return depends on something in the
    /// request, matched with a predicate.
    public var stubs: [Stub]

    /// Allows you to override the default response that Mountebank sends back if no predicate matches a request. Even
    /// if a predicate does match but the response isn't fully specified, these values get merged in to complete the
    /// response.
    public let defaultResponse: Is?

    /// If set to true, the server will record requests received, for mock verification purposes.
    public let recordRequests: Bool?

    /// The number of requests to this imposter
    public let numberOfRequests: Int?

    /// Mountebank will save all requests to the imposter for mock verification.
    ///
    /// By retrieving the imposter, your client code can determine if an expected service call was in fact made.
    public let requests: [Imposter.RecordedRequest]?

    enum CodingKeys: String, CodingKey {
        case port
        case networkProtocol = "protocol"
        case name
        case stubs
        case recordRequests
        case defaultResponse
        case numberOfRequests
        case requests
    }

    public init(
        port: Int? = nil,
        networkProtocol: NetworkProtocol,
        name: String? = nil,
        stubs: [Stub],
        defaultResponse: Is? = nil,
        recordRequests: Bool? = nil,
        numberOfRequests: Int? = nil,
        requests: [Imposter.RecordedRequest]? = nil
    ) {
        self.port = port
        self.networkProtocol = networkProtocol
        self.name = name
        self.stubs = stubs
        self.defaultResponse = defaultResponse
        self.recordRequests = recordRequests
        self.numberOfRequests = numberOfRequests
        self.requests = requests
    }
}
