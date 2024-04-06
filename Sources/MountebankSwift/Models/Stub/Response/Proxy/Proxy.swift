import Foundation

/// A proxy response proxies the request to the specified destination and returns the response.
///
/// [mbtest.org/docs/api/proxies](https://www.mbtest.org/docs/api/proxies)
public struct Proxy: StubResponse, Codable, Equatable, Sendable {
    /// Replay behavior of the proxy.
    public enum Mode: String, Codable, Sendable {
        /// proxyOnce mode doesn't require you to explicitly do anything to replay the proxied responses.
        case proxyOnce
        /// The proxyAlways mode requires you to run the mb replay command (or equivalent) to
        /// switch from record mode to replay mode, but allows a richer set of data to be recorded.
        case proxyAlways
        /// proxy requests but do not record any data.
        case proxyTransparent
    }

    /// Protocol specific parameters for this proxy
    public enum NetworkProtocolParameters: Equatable, Sendable {
        /// [mbtest.org/docs/api/proxies](https://www.mbtest.org/docs/api/proxies)
        /// - Parameters:
        ///   - injectHeaders: Key-value pairs of headers to inject into the proxied request.
        case http(
            /// Key-value pairs of headers to inject into the proxied request.
            injectHeaders: [String: String]? = nil
        )

        /// [mbtest.org/docs/api/proxies](https://www.mbtest.org/docs/api/proxies)
        /// - Parameters:
        ///   - injectHeaders: Key-value pairs of headers to inject into the proxied request.
        ///   - cert: The SSL client certificate, a PEM-formatted string
        ///   - key: The SSL client private key, a PEM-formatted string
        ///   - ciphers: A valid cipher (see https://nodejs.org/api/tls.html#tls_modifying_the_default_tls_cipher_suite)
        ///              For older (and insecure) https servers. This field allows you to override the cipher used to communicate
        ///   - secureProtocol: The SSL method to use. A valid OpenSSL protocol method name
        ///   - passphrase: Shared passphrase used for a single private key
        case https(
            injectHeaders: [String: String]? = nil,
            key: String? = nil,
            certificate: String? = nil,
            ciphers: String? = nil,
            secureProtocol: String? = nil,
            passphrase: String? = nil
        )
    }

    /// Defines the origin server that the request should proxy to.
    /// A URL without the path (e.g. http://someserver:3000 or tcp://someserver:3000)
    public let to: String

    /// Defines the replay behavior of the proxy.
    public let mode: Mode?

    /// Protocol specific parameters for this proxy
    public let networkProtocolParameters: NetworkProtocolParameters?

    /// An array of objects that defines how the predicates for new stubs are created.
    /// Each object in the array defines the fields to generate predicates from.
    public let predicateGenerators: [PredicateGenerator]?

    /// If true, mountebank will add a wait behavior to the response
    /// with the same latency that the proxied call took.
    /// This is useful in performance testing scenarios where you want to
    /// simulate the actual latency of downstream services that you're virtualizing.
    public let addWaitBehavior: Bool?

    /// If defined, mountebank will add a decorate behavior to the saved response
    ///
    /// Post-processes the response using JavaScript injection before sending it. You can use a decorate behavior to
    /// add data to a proxied response or substitute data from the request into the response, for example. The value
    /// passed into the decorate behavior is a JavaScript function that can take up to three values: the request,
    /// the response, and a logger. You can either mutate the response passed in (and return nothing), or return an
    /// altogether new response.
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    public let addDecorateBehavior: String?

    /// [mbtest.org/docs/api/proxies](https://www.mbtest.org/docs/api/proxies)
    /// - Parameters:
    ///   - to: Defines the origin server that the request should proxy to.
    ///         A URL without the path (e.g. http://someserver:3000 or tcp://someserver:3000)
    ///   - networkProtocolParameters: Protocol specific parameters for this proxy
    ///   - mode: Defines the replay behavior of the proxy.
    ///   - predicateGenerators: An array of objects that defines how the predicates for new stubs are created.
    ///         Each object in the array defines the fields to generate predicates from.
    ///   - addWaitBehavior: If true, mountebank will add a wait behavior to the response
    ///         with the same latency that the proxied call took.
    ///         This is useful in performance testing scenarios where you want to
    ///         simulate the actual latency of downstream services that you're virtualizing.
    ///   - addDecorateBehavior: If defined, mountebank will add a decorate behavior to the saved response.
    ///         Post-processes the response using JavaScript injection before sending it. You can use a decorate behavior to
    ///         add data to a proxied response or substitute data from the request into the response, for example. The value
    ///         passed into the decorate behavior is a JavaScript function that can take up to three values: the request,
    ///         the response, and a logger. You can either mutate the response passed in (and return nothing), or return an
    ///         altogether new response.
    ///         The `--allowInjection` command line flag must be set to support this behavior.
    public init(
        to: String,
        networkProtocolParameters: NetworkProtocolParameters? = nil,
        mode: Mode? = nil,
        predicateGenerators: [PredicateGenerator]? = nil,
        addWaitBehavior: Bool? = nil,
        addDecorateBehavior: String? = nil
    ) {
        self.to = to
        self.networkProtocolParameters = networkProtocolParameters
        self.mode = mode
        self.predicateGenerators = predicateGenerators
        self.addWaitBehavior = addWaitBehavior
        self.addDecorateBehavior = addDecorateBehavior
    }
}

extension Proxy: Recreatable {
    var recreatable: String {
        structSwiftString([
            ("to", to),
            ("mode", mode),
            ("predicateGenerators", predicateGenerators),
            ("addWaitBehavior", addWaitBehavior),
            ("addDecorateBehavior", addDecorateBehavior),
        ])
    }
}

extension Proxy.Mode: Recreatable {
    var recreatable: String {
        enumSwiftString()
    }
}
