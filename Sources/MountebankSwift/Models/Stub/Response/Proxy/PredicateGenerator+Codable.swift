extension PredicateGenerator: Codable {
    enum CodingKeys: String, CodingKey {
        case fields = "matches"
        case predicateOperator
        case caseSensitive
        case except
        case xpath
        case jsonpath
        case ignore
        case inject
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let inject = try container.decodeIfPresent(String.self, forKey: .inject) {
            self = .inject(inject)
        } else {
            let fields = try container.decodeIfPresent([String: JSON].self, forKey: .fields)
            let predicateOperator = try container.decodeIfPresent(PredicateOperator.self, forKey: .predicateOperator)
            let caseSensitive = try container.decodeIfPresent(Bool.self, forKey: .caseSensitive)
            let except = try container.decodeIfPresent(String.self, forKey: .except)
            let xpath = try container.decodeIfPresent(XPath.self, forKey: .xpath)
            let jsonpath = try container.decodeIfPresent(JSONPath.self, forKey: .jsonpath)
            let ignore = try container.decodeIfPresent(JSON.self, forKey: .ignore)

            self = .matches(
                fields: fields,
                predicateOperator: predicateOperator,
                caseSensitive: caseSensitive,
                except: except,
                xPath: xpath,
                jsonPath: jsonpath,
                ignore: ignore
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .matches(
            let fields,
            let predicateOperator,
            let caseSensitive,
            let except,
            let xpath,
            let jsonpath,
            let ignore
        ):
            try container.encodeIfPresent(fields, forKey: .fields)
            try container.encodeIfPresent(predicateOperator, forKey: .predicateOperator)
            try container.encodeIfPresent(caseSensitive, forKey: .caseSensitive)
            try container.encodeIfPresent(except, forKey: .except)
            try container.encodeIfPresent(xpath, forKey: .xpath)
            try container.encodeIfPresent(jsonpath, forKey: .jsonpath)
            try container.encodeIfPresent(ignore, forKey: .ignore)
        case .inject(let inject):
            try container.encode(inject, forKey: .inject)
        }
    }
}
