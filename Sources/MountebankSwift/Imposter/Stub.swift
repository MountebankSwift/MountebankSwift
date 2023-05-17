import Foundation

public struct Stub: Encodable {
    let predicates: [Predicate]
    let responses: [Response]

    enum CodingKeys: String, CodingKey {
        case predicates
        case responses
    }
}
