import Foundation

public struct Stub: Codable {
    let predicates: [Predicate]
    let responses: [Response]

    enum CodingKeys: String, CodingKey {
        case predicates
        case responses
    }
}
