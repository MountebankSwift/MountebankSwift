import Foundation

public struct Stub: Codable, Equatable {
    let predicates: [Stub.Predicate]
    let responses: [Stub.Response]

    enum CodingKeys: String, CodingKey {
        case predicates
        case responses
    }
}
