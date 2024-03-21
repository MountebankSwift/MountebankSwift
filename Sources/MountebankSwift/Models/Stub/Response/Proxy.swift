import Foundation

/// A proxy response proxies the request to the specified destination and returns the response.
///
/// [mbtest.org/docs/api/proxies](https://www.mbtest.org/docs/api/proxies)
public struct Proxy: StubResponse, Codable, Equatable {
    /// Replay behavior of the proxy.
    public enum Mode: String, Codable {
        /// proxyOnce mode doesn't require you to explicitly do anything to replay the proxied responses.
        case proxyOnce
        /// The proxyAlways mode requires you to run the mb replay command (or equivalent) to
        /// switch from record mode to replay mode, but allows a richer set of data to be recorded.
        case proxyAlways
        /// proxy requests but do not record any data.
        case proxyTransparent
    }

    /// Defines the origin server that the request should proxy to.
    /// A URL without the path (e.g. http://someserver:3000 or tcp://someserver:3000)
    let to: String

    /// Defines the replay behavior of the proxy.
    let mode: Mode

    /// An array of objects that defines how the predicates for new stubs are created.
    /// Each object in the array defines the fields to generate predicates from.
    let predicateGenerators: [PredicateGenerator]

    /// If true, mountebank will add a wait behavior to the response
    /// with the same latency that the proxied call took.
    /// This is useful in performance testing scenarios where you want to
    /// simulate the actual latency of downstream services that you're virtualizing.
    let addWaitBehavior: Bool

    /// If defined, mountebank will add a decorate behavior to the saved response
    ///
    /// Post-processes the response using JavaScript injection before sending it. You can use a decorate behavior to
    /// add data to a proxied response or substitute data from the request into the response, for example. The value
    /// passed into the decorate behavior is a JavaScript function that can take up to three values: the request,
    /// the response, and a logger. You can either mutate the response passed in (and return nothing), or return an
    /// altogether new response.
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    let addDecorateBehavior: String?

    public init(
        to: String,
        mode: Mode = .proxyOnce,
        predicateGenerators: [PredicateGenerator] = [],
        addWaitBehavior: Bool = false,
        addDecorateBehavior: String? = nil
    ) {
        self.to = to
        self.mode = mode
        self.predicateGenerators = predicateGenerators
        self.addWaitBehavior = addWaitBehavior
        self.addDecorateBehavior = addDecorateBehavior
    }
}

// TODO: These are http/https only, what's the best place for them?
struct ProxyParameters {
    /// The SSL client certificate, a PEM-formatted string
    let cert: String?
    /// The SSL client private key, a PEM-formatted string
    let key: String?
    /// A valid cipher (see https://nodejs.org/api/tls.html#tls_modifying_the_default_tls_cipher_suite)
    /// For older (and insecure) https servers, this field allows you to override the cipher used to communicate
    let ciphers: String?
    /// The SSL method to use
    /// A valid OpenSSL protocol method name
    let secureProtocol: String?
    /// Shared passphrase used for a single private key
    let passphrase: String?
    /// Key-value pairs of headers to inject into the proxied request.
    let injectHeaders: [String: JSON]
}

public struct PredicateGenerator: Codable, Equatable {
    /// The fields that need to be equal in subsequent requests to replay the saved response. Set the field value true to generate a predicate based on it. Nested fields, as in JSON fields or HTTP headers, are supported as well, as long as the leaf keys have a true value. If you set the parent object key (e.g. query) to true, the generated predicate will use deepEquals, requiring the entire object graph to match.
    public let matches: JSON?

    /// Determines if the match is case sensitive or not. This includes keys for objects such as query parameters.
    public let caseSensitive: Bool?

    /// Defines a regular expression that is stripped out of the request field before matching.
    public let except: String?

    /// Defines an object containing a selector string and, optionally, an ns object field that defines a namespace map. The predicate's scope is limited to the selected value in the request field.
    public let xpath: XPath?

    /// Defines an object containing a selector string. The predicate's scope is limited to the selected value in the request field.
    public let jsonpath: JSONPath?

    /// Allows you to override the predicate operator used in the generated predicate. This is most often used to substitute an exists operator, e.g., for whether the given xpath expression exists in the incoming request or not. At times, it may be useful to use a contains operator if future requests can add more information to the field.
    public let predicateOperator: String?

    /// Defines a JavaScript function that allows programmatic creation of the predicates.
    public let inject: String?

    /// Use this option to ignore specific key of field from request based on match field.
    public let ignore: JSON?

    public init(
        matches: JSON? = nil,
        caseSensitive: Bool = false,
        except: String = "",
        xpath: XPath? = nil,
        jsonpath: JSONPath? = nil,
        predicateOperator: String? = nil,
        inject: String? = nil,
        ignore: JSON? = nil
    ) {
        self.matches = matches
        self.caseSensitive = caseSensitive
        self.except = except
        self.xpath = xpath
        self.jsonpath = jsonpath
        self.predicateOperator = predicateOperator
        self.inject = inject
        self.ignore = ignore
    }
}
