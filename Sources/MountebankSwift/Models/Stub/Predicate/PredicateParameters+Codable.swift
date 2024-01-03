import Foundation

extension PredicateParameters: Codable {
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

        try container.encodeIfPresent(caseSensitive, forKey: .caseSensitive)
        try container.encodeIfPresent(except, forKey: .except)
        try container.encodeIfPresent(xPath, forKey: .xPath)
        try container.encodeIfPresent(jsonPath, forKey: .jsonPath)
    }
}
