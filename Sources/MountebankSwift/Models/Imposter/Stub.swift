import Foundation

public struct Stub: Codable, Equatable {
    public let responses: [Stub.Response]
    public let predicates: [Stub.Predicate]

    enum CodingKeys: String, CodingKey {
        case responses
        case predicates
    }

    public init(responses: [Stub.Response], predicates: [Stub.Predicate]) {
        self.responses = responses
        self.predicates = predicates
    }
}
