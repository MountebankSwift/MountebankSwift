import Foundation

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
