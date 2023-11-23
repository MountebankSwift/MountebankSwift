import Foundation

extension Stub {
    /// See https://www.mbtest.org/docs/api/predicates
    public indirect enum Predicate: Codable, Equatable {
        /// The request field matches the predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-equals
        case equals(JSON, Parameters? = nil)

        /// Performs nested set equality on the request field, useful when the request field is an object (e.g. the query field in http)
        /// https://www.mbtest.org/docs/api/predicates#predicates-deepEquals
        case deepEquals(JSON, Parameters? = nil)

        /// The request field contains the predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-contains
        case contains(JSON, Parameters? = nil)

        /// The request field starts with the predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-startsWith
        case startsWith(JSON, Parameters? = nil)

        /// The request field ends with the predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-endsWith
        case endsWith(JSON, Parameters? = nil)

        /// The request field matches the JavaScript regular expression defined with the predicate.
        /// https://www.mbtest.org/docs/api/predicates#predicates-matches
        case matches(JSON, Parameters? = nil)

        /// If true, the request field must exist. If false, the request field must not exist.
        /// https://www.mbtest.org/docs/api/predicates#predicates-exists
        case exists(JSON, Parameters? = nil)

        /// Inverts a predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-not
        case not(Stub.Predicate, Parameters? = nil)

        /// Logically or's two predicates together
        /// https://www.mbtest.org/docs/api/predicates#predicates-or
        case or([Stub.Predicate], Parameters? = nil)

        /// Logically and's two predicates together
        /// https://www.mbtest.org/docs/api/predicates#predicates-and
        case and([Stub.Predicate], Parameters? = nil)

        /// Injects JavaScript to decide whether the request matches or not.
        /// The JavaScript should be a function that accepts the request object (and optionally a logger) and returns true or false.
        /// https://www.mbtest.org/docs/api/predicates#predicates-inject
        case inject(String)
    }
}

extension Stub.Predicate {
    public struct Parameters: Codable, Equatable {
        /// Determines if the match is case sensitive or not. This includes keys for objects such as query parameters.
        let caseSensitive: Bool?
        /// Defines a regular expression that is stripped out of the request field before matching.
        let except: String?
        /// Defines an object containing a selector string and, optionally, an namespace map. The predicate's scope is limited to the selected value in the request field.
        let xPath: XPath?
        /// Defines an object containing a selector string. The predicate's scope is limited to the selected value in the request field.
        let jsonPath: JSONPath?

        var isEmpty: Bool {
            // A bit overkill, but future proof
            !Mirror(reflecting: self).children.contains(where: { "\($0.value)" != "nil" })
        }

        public init?(
            caseSensitive: Bool? = nil,
            except: String? = nil,
            xPath: XPath? = nil,
            jsonPath: JSONPath? = nil
        ) {
            self.caseSensitive = caseSensitive
            self.except = except
            self.xPath = xPath
            self.jsonPath = jsonPath

            if isEmpty {
                return nil
            }
        }
    }

    public struct XPath: Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case selector
            case namespace = "ns"
        }

        /// The XPath selector
        let selector: String

        /// The XPath namespace map, aliasing a prefix to a URL, which allows you to use the prefix in the selector.
        let namespace: [String: String]?

        public init(selector: String, namespace: [String: String]?) {
            self.selector = selector
            self.namespace = namespace
        }
    }

    public struct JSONPath: Codable, Equatable {
        /// The JSONPath selector
        let selector: String

        public init(selector: String) {
            self.selector = selector
        }
    }
}
