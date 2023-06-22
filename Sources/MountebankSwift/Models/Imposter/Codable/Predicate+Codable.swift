import Foundation

extension Stub.Predicate {
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
        case .deepEquals(let deepEqualsData):
            try container.encode(deepEqualsData, forKey: .deepEquals)
        case .contains(let containsData):
            try container.encode(containsData, forKey: .contains)
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
        case .inject(let script):
            try container.encode(script, forKey: .inject)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try container.decodeIfPresent(JSON.self, forKey: .equals) {
            self = .equals(value)
        } else if let value = try container.decodeIfPresent(JSON.self, forKey: .deepEquals) {
            self = .deepEquals(value)
        } else if let value = try container.decodeIfPresent(JSON.self, forKey: .contains) {
            self = .contains(value)
        } else if let value = try container.decodeIfPresent(String.self, forKey: .equals) {
            self = .inject(value)
        } else {
            fatalError("This Predicate needs to be implemented")
        }
    }
}
