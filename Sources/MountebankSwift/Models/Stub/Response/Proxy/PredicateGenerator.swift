import Foundation

public enum PredicateOperator: String, Codable, Sendable {
    case exists
    case equals
    case deepEquals
    case contains
    case startsWith
    case endsWith
    case matches
}

public enum PredicateGenerator: Equatable, Sendable {
    /// Defines a template for the generated predicates
    /// [mbtest.org/docs/api/proxies#proxy-predicate-generators](https://www.mbtest.org/docs/api/proxies#proxy-predicate-generators)
    /// - Parameters:
    ///   - fields: The fields that need to be equal in subsequent requests to replay the saved response. Set the field value true to generate a predicate
    ///       based on it. Nested fields, as in JSON fields or HTTP headers, are supported as well, as long as the leaf keys have a true value. If you set the
    ///       parent object key (e.g. query) to true, the generated predicate will use deepEquals, requiring the entire object graph to match.
    ///   - predicateOperator: Allows you to override the predicate operator used in the generated predicate.
    ///       This is most often used to substitute an exists operator, e.g., for whether the given xpath expression exists in the incoming request or not.
    ///       At times, it may be useful to use a contains operator if future requests can add more information to the field.
    ///   - caseSensitive: Determines if the match is case sensitive or not. This includes keys for objects such as query parameters.
    ///   - except: Defines a regular expression that is stripped out of the request field before matching.
    ///   - xpath: Defines an object containing a selector string and, optionally, an ns object field that defines a namespace map. The predicate's scope is
    ///       limited to the selected value in the request field.
    ///   - jsonpath: Defines an object containing a selector string. The predicate's scope is limited to the selected value in the request field.
    ///   - ignore: Use this option to ignore specific key of field from request based on match field.
    case matches(
        fields: [String: JSON]? = nil,
        predicateOperator: PredicateOperator? = nil,
        caseSensitive: Bool? = nil,
        except: String? = nil,
        xPath: XPath? = nil,
        jsonPath: JSONPath? = nil,
        ignore: JSON? = nil
    )

    /// Defines a JavaScript function that allows programmatic creation of the predicates.
    case inject(String)
}

extension PredicateGenerator: Recreatable {
    func recreatable(indent: Int) -> String {
        switch self {
        case .inject(let inject):
            return enumSwiftString([inject], indent: indent)
        case .matches(
            let fields,
            let predicateOperator,
            let caseSensitive,
            let except,
            let xPath,
            let jsonPath,
            let ignore
        ):
            return enumSwiftString([
                ("fields", fields),
                ("predicateOperator", predicateOperator),
                ("caseSensitive", caseSensitive),
                ("except", except),
                ("xPath", xPath),
                ("jsonPath", jsonPath),
                ("ignore", ignore),
            ], indent: indent)
        }
    }
}

extension PredicateOperator: Recreatable {
    func recreatable(indent: Int) -> String {
        enumSwiftString(indent: indent)
    }
}
