import Foundation

public struct Stub: Codable {
    let predicates: [Stub.Predicate]
    let responses: [Stub.Response]

    enum CodingKeys: String, CodingKey {
        case predicates
        case responses
    }
}
