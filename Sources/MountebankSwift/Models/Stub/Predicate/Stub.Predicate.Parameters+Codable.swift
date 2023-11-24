import Foundation

extension Stub.Predicate.Parameters {
    enum DecodingError: Error {
        case empty
    }

    enum CodingKeys: String, CodingKey {
        case caseSensitive, except, xPath = "xpath", jsonPath = "jsonpath"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caseSensitive = try container.decodeIfPresent(Bool.self, forKey: .caseSensitive)
        except = try container.decodeIfPresent(String.self, forKey: .except)
        xPath = try container.decodeIfPresent(Stub.Predicate.XPath.self, forKey: .xPath)
        jsonPath = try container.decodeIfPresent(Stub.Predicate.JSONPath.self, forKey: .jsonPath)

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
