//
//  Response+Codable.swift
//
//
//  Created by Tieme van Veen on 22/06/2023.
//

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
