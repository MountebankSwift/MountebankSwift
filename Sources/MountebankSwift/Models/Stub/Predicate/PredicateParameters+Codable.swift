import Foundation

extension PredicateParameters {
    enum DecodingError: Error {
        case empty
    }

    enum CodingKeys: String, CodingKey {
        case caseSensitive
        case except
        case xPath = "xpath"
        case jsonPath = "jsonpath"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caseSensitive = try container.decodeIfPresent(Bool.self, forKey: .caseSensitive)
        except = try container.decodeIfPresent(String.self, forKey: .except)
        xPath = try container.decodeIfPresent(XPath.self, forKey: .xPath)
        jsonPath = try container.decodeIfPresent(JSONPath.self, forKey: .jsonPath)

        if isEmpty {
            throw DecodingError.empty
        }
    }

    public func encode(to encoder: Encoder) throws {
        if isEmpty {
            return
        }

        var container = encoder.container(keyedBy: CodingKeys.self)

        if let caseSensitive {
            try container.encode(caseSensitive, forKey: .caseSensitive)
        }

        if let except {
            try container.encode(except, forKey: .except)
        }

        if let xPath {
            try container.encode(xPath, forKey: .xPath)
        }

        if let jsonPath {
            try container.encode(jsonPath, forKey: .jsonPath)
        }
    }
}
