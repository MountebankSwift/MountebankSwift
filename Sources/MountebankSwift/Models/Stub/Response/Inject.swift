/// Mountebank allows JavaScript injection for predicates and response types for
/// situations where the built-in ones are not sufficient.
///
/// Injection only works if mb is run with the `--allowInjection` flag.
public struct Inject: StubResponse, Codable, Equatable {
    /// A Javascript string
    public let injection: String

    public init(_ injection: String) {
        self.injection = injection
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        injection = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        try injection.encode(to: encoder)
    }
}
