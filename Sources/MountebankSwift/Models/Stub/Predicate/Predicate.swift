import Foundation

/// See https://www.mbtest.org/docs/api/predicates
public indirect enum Predicate: Codable, Equatable {
    /// The request field matches the predicate
    /// https://www.mbtest.org/docs/api/predicates#predicates-equals
    case equals(Request, PredicateParameters? = nil)

    /// Performs nested set equality on the request field,
    /// useful when the request field is an object (e.g. the query field in http)
    /// https://www.mbtest.org/docs/api/predicates#predicates-deepEquals
    case deepEquals(Request, PredicateParameters? = nil)

    /// The request field contains the predicate
    /// https://www.mbtest.org/docs/api/predicates#predicates-contains
    case contains(Request, PredicateParameters? = nil)

    /// The request field starts with the predicate
    /// https://www.mbtest.org/docs/api/predicates#predicates-startsWith
    case startsWith(Request, PredicateParameters? = nil)

    /// The request field ends with the predicate
    /// https://www.mbtest.org/docs/api/predicates#predicates-endsWith
    case endsWith(Request, PredicateParameters? = nil)

    /// The request field matches the JavaScript regular expression
    /// defined with the predicate.
    /// https://www.mbtest.org/docs/api/predicates#predicates-matches
    case matches(Request, PredicateParameters? = nil)

    /// If true, the request field must exist. If false,
    /// the request field must not exist.
    /// https://www.mbtest.org/docs/api/predicates#predicates-exists
    case exists(Request, PredicateParameters? = nil)

    /// Inverts a predicate
    /// https://www.mbtest.org/docs/api/predicates#predicates-not
    case not(Predicate, PredicateParameters? = nil)

    /// Logically or's two predicates together
    /// https://www.mbtest.org/docs/api/predicates#predicates-or
    case or([Predicate], PredicateParameters? = nil)

    /// Logically and's two predicates together
    /// https://www.mbtest.org/docs/api/predicates#predicates-and
    case and([Predicate], PredicateParameters? = nil)

    /// Injects JavaScript to decide whether the request matches or not.
    /// The JavaScript should be a function that accepts the request object
    /// (and optionally a logger) and returns true or false.
    /// https://www.mbtest.org/docs/api/predicates#predicates-inject
    case inject(String)
}
