import Foundation

// // https://www.mbtest.org/docs/api/contracts
public extension Stub {
    public enum Predicate: Codable, Equatable {
        // The request field matches the predicate
        case equals(PredicateEquals)
        // Performs nested set equality on the request field, useful when the request field is an object (e.g. the query field in http)
        case deepEquals
        // The request field contains the predicate
        case contains
        // The request field starts with the predicate
        case startsWith
        // The request field ends with the predicate
        case endsWith
        // The request field matches the JavaScript regular expression defined with the predicate.
        case matches
        // If true, the request field must exist. If false, the request field must not exist.
        case exists
        // Inverts a predicate
        case not
        // Logically or's two predicates together
        case or
        // Logically and's two predicates together
        case and
        // Injects JavaScript to decide whether the request matches or not. See the injection page for more details.
        case inject
        
        enum CodingKeys: String, CodingKey {
            case equals
            case deepEquals
            case contains
            case startsWith
            case endsWith
            case matches
            case exists
            case not
            case or
            case and
            case inject
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .equals(let equalsData):
                try container.encode(equalsData, forKey: .equals)
            case .deepEquals:
                break
            case .contains:
                break
            case .startsWith:
                break
            case .endsWith:
                break
            case .matches:
                break
            case .exists:
                break
            case .not:
                break
            case .or:
                break
            case .and:
                break
            case .inject:
                break
            }
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let value = try container.decodeIfPresent(PredicateEquals.self, forKey: .equals) {
                self = .equals(value)
            } else {
                fatalError("TODO")
            }
        }
    }
}

public struct PredicateEquals: Codable, Equatable {
    let path: String

    public init(path: String) {
        self.path = path
    }
}
