import Foundation

/// Imposter as documented on:
/// [mbtest.org/docs/api/contracts?type=imposter](https://www.mbtest.org/docs/api/contracts?type=imposter)
public struct Imposter: Codable, Equatable {

    /// Mountebank does also support `tcp`, `smtp` and custom protocols
    /// implemented in community plugins.
    ///
    /// Please submit a feature request issue on Github for support if you need other protocols
    public enum ImposterNetworkProtocol: Codable, Equatable {
        /// Options for the http protocol documented on:
        /// [mbtest.org/docs/protocols/http](https://www.mbtest.org/docs/protocols/http)
        /// - Parameters:
        ///   - allowCORS: When true, mountebank will allow all Cross-Origin Resource Sharing preflight
        ///     requests on the imposter
        case http(allowCORS: Bool? = false)

        /// Options for the https protocol documented on:
        /// [mbtest.org/docs/protocols/https](https://www.mbtest.org/docs/protocols/https)
        /// - Parameters:
        ///   - allowCORS: When true, mountebank will allow all CORS preflight requests on the imposter.
        ///   - rejectUnauthorized: When true, mountebank will validate the certificate against the list
        ///     of supplied Certificate Authoritys.
        ///   - certificateAuthority: Use when setting rejectUnauthorized to true to provide a list of
        ///     certificates to validate against. When rejectUnauthorized is true and mutualAuth is true,
        ///     mountebank will request a client certificate.
        ///   - key: The SSL private key for creating an https server/ Must be a PEM-formatted string.
        ///     Defaults to a built-in private key.
        ///   - certificate: The SSL certificate for creating an https server. Must be a PEM-formatted string.
        ///     Defaults to a built-in self-signed certificate.
        ///   - mutualAuth: When true, the server will request a client certificate. Since the goal is simply to
        ///     virtualize a server requiring mutual auth, invalid certificates will not be rejected.
        ///   - ciphers: For older (and insecure) https servers, this field allows you to override the
        ///     cipher used to communicate.
        case https(
            allowCORS: Bool? = false,
            rejectUnauthorized: Bool? = nil,
            certificateAuthority: String? = nil,
            key: String? = nil,
            certificate: String? = nil,
            mutualAuth: Bool? = nil,
            ciphers: String? = nil
        )
    }

    /// The port to run the imposter on.
    ///
    /// Defaults to a randomly assigned port that will be returned in the response
    public let port: Int?

    /// Extra options for a network protocol
    public let networkProtocol: ImposterNetworkProtocol

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

    public init(
        port: Int? = nil,
        networkProtocol: ImposterNetworkProtocol,
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
