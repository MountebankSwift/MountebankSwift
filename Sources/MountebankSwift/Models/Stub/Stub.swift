import Foundation

/// Stub as documented on:
/// [mbtest.org/docs/api/contracts?type=stub](https://www.mbtest.org/docs/api/contracts?type=stub)
public struct Stub: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case responses
        case predicates
    }

    public let responses: [Stub.Response]
    public let predicates: [Stub.Predicate]

    public init(responses: [Stub.Response], predicates: [Stub.Predicate]) {
        self.responses = responses
        self.predicates = predicates
    }
}
