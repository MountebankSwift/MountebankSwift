public struct Inject: StubResponse, Codable, Equatable {
    public let injection: String

    public init(_ injection: String) {
        self.injection = injection
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.injection = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        try injection.encode(to: encoder)
    }
}
