import Foundation

public struct Stub: Codable, Equatable {
    public let predicates: [Stub.Predicate]
    public let responses: [Stub.Response]

    enum CodingKeys: String, CodingKey {
        case predicates
        case responses
    }

    public init(predicates: [Stub.Predicate], responses: [Stub.Response]) {
        self.predicates = predicates
        self.responses = responses
    }
}
