import Foundation

extension Predicate: Codable {
    enum DecodingError: Error {
        case invalidType
    }

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
        case .equals(let json, let parameters):
            try container.encode(json, forKey: .equals)
            try parameters?.encode(to: encoder)
        case .deepEquals(let json, let parameters):
            try container.encode(json, forKey: .deepEquals)
            try parameters?.encode(to: encoder)
        case .contains(let json, let parameters):
            try container.encode(json, forKey: .contains)
            try parameters?.encode(to: encoder)
        case .startsWith(let json, let parameters):
            try container.encode(json, forKey: .startsWith)
            try parameters?.encode(to: encoder)
        case .endsWith(let json, let parameters):
            try container.encode(json, forKey: .endsWith)
            try parameters?.encode(to: encoder)
        case .matches(let json, let parameters):
            try container.encode(json, forKey: .matches)
            try parameters?.encode(to: encoder)
        case .exists(let json, let parameters):
            try container.encode(json, forKey: .exists)
            try parameters?.encode(to: encoder)
        case .not(let predicate, let parameters):
            try container.encode(predicate, forKey: .not)
            try parameters?.encode(to: encoder)
        case .or(let predicate, let parameters):
            try container.encode(predicate, forKey: .or)
            try parameters?.encode(to: encoder)
        case .and(let predicate, let parameters):
            try container.encode(predicate, forKey: .and)
            try parameters?.encode(to: encoder)
        case .inject(let javascript):
            try container.encode(javascript, forKey: .inject)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try container.decodeIfPresent(String.self, forKey: .inject) {
            self = .inject(value)
            return
        }

        let parameters = try? PredicateParameters(from: decoder)
        if let value = try container.decodeIfPresent(Request.self, forKey: .equals) {
            self = .equals(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .deepEquals) {
            self = .deepEquals(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .contains) {
            self = .contains(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .startsWith) {
            self = .startsWith(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .endsWith) {
            self = .endsWith(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .matches) {
            self = .matches(value, parameters)
        } else if let value = try container.decodeIfPresent(Request.self, forKey: .exists) {
            self = .exists(value, parameters)
        } else if let value = try container.decodeIfPresent(Predicate.self, forKey: .not) {
            self = .not(value, parameters)
        } else if let value = try container.decodeIfPresent([Predicate].self, forKey: .or) {
            self = .or(value, parameters)
        } else if let value = try container.decodeIfPresent([Predicate].self, forKey: .and) {
            self = .and(value, parameters)
        } else {
            throw DecodingError.invalidType
        }
    }
}
