import Foundation

extension Stub.Response {
    /// https://www.mbtest.org/docs/api/proxies
    public struct Proxy: StubResponse, Codable, Equatable {
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

        // TODO: add support for additional proxy options
        ///// An array of objects that defines how the predicates for new stubs are created.
        ///// Each object in the array defines the fields to generate predicates from.
        //let predicateGenerators: [PredicateGenerator]
        ///// If true, Mountebank will add a wait behavior to the response 
        ///// with the same latency that the proxied call took.
        ///// This is useful in performance testing scenarios where you want to
        ///// simulate the actual latency of downstream services that you're virtualizing.
        //let addWaitBehavior: Bool
        ///// If defined, Mountebank will add a decorate behavior to the saved response.
        //let addDecorateBehavior: String

        public init(to: String, mode: Mode) {
            self.to = to
            self.mode = mode
        }
    }
}

// TODO: Implement and test Proxy Parameters
//extension Stub.Response.Proxy {
//    struct Parameters {
//        /// The SSL client certificate, a PEM-formatted string
//        let cert: String?
//        /// The SSL client private key, a PEM-formatted string
//        let key: String?
//        /// A valid cipher (see https://nodejs.org/api/tls.html#tls_modifying_the_default_tls_cipher_suite)
//        /// For older (and insecure) https servers, this field allows you to override the cipher used to communicate
//        let ciphers: String?
//        /// The SSL method to use
//        /// A valid OpenSSL protocol method name
//        let secureProtocol: String?
//        /// Shared passphrase used for a single private key
//        let passphrase: String?
//        /// Key-value pairs of headers to inject into the proxied request.
//        let injectHeaders: [String: String]
//    }
//}
