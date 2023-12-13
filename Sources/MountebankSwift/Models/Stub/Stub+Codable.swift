import Foundation

extension Stub: Codable, Equatable {
    enum CodingKeys: CodingKey {
        case predicates
        case responses
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(predicates, forKey: .predicates)
        try container.encode(responses.map(\.codable), forKey: .responses)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        predicates = try container.decode([Predicate].self, forKey: .predicates)
        responses = try container.decode([CodableResponse].self, forKey: .responses)
            .map(\.stubResponse)
    }

    public static func == (lhs: Stub, rhs: Stub) -> Bool {
        lhs.predicates == rhs.predicates &&
        lhs.responses.map(\.codable) == rhs.responses.map(\.codable)
    }
}

extension CodableResponse {
    var stubResponse: any StubResponse {
        switch self {
        case .is(let value as any StubResponse),
            .proxy(let value as any StubResponse),
            .inject(let value as any StubResponse),
            .fault(let value as any StubResponse):
            return value
        }
    }
}

extension StubResponse {
    var codable: CodableResponse {
        if let response = self as? Is {
            return .is(response)
        } else if let response = self as? Proxy {
            return .proxy(response)
        } else if let response = self as? Inject {
            return .inject(response)
        } else if let response = self as? Fault {
            return .fault(response)
        }

        fatalError("Unknown StubResponse")
    }
}

