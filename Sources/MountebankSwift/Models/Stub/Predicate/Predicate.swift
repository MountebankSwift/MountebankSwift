import Foundation

/// Predicates define whether or not a ``Stub`` matches a request. When multiple stubs are set on an imposter,
/// the first stub that matches is used to create the response.
///
/// Each predicate object contains one or more of the request fields as keys.
/// Predicates are added to a stub in an array, and all predicates are AND'd together.
///
/// [mbtest.org/docs/api/predicates](https://www.mbtest.org/docs/api/predicates)
public indirect enum Predicate: Equatable {
    /// The request field matches the predicate
    /// [mbtest.org/docs/api/predicates#predicates-equals](https://www.mbtest.org/docs/api/predicates#predicates-equals)
    case equals(Request, PredicateParameters? = nil)

    /// Performs nested set equality on the request field,
    /// useful when the request field is an object (e.g. the query field in http)
    /// [mbtest.org/docs/api/predicates#predicates-deepEquals](https://www.mbtest.org/docs/api/predicates#predicates-deepEquals)
    case deepEquals(Request, PredicateParameters? = nil)

    /// The request field contains the predicate
    /// [mbtest.org/docs/api/predicates#predicates-contains](https://www.mbtest.org/docs/api/predicates#predicates-contains)
    case contains(Request, PredicateParameters? = nil)

    /// The request field starts with the predicate
    /// [mbtest.org/docs/api/predicates#predicates-startsWith](https://www.mbtest.org/docs/api/predicates#predicates-startsWith)
    case startsWith(Request, PredicateParameters? = nil)

    /// The request field ends with the predicate
    /// [mbtest.org/docs/api/predicates#predicates-endsWith](https://www.mbtest.org/docs/api/predicates#predicates-endsWith)
    case endsWith(Request, PredicateParameters? = nil)

    /// The request field matches the JavaScript regular expression
    /// defined with the predicate.
    /// [mbtest.org/docs/api/predicates#predicates-matches](https://www.mbtest.org/docs/api/predicates#predicates-matches)
    case matches(Request, PredicateParameters? = nil)

    /// If true, the request field must exist. If false,
    /// the request field must not exist.
    /// [mbtest.org/docs/api/predicates#predicates-exists](https://www.mbtest.org/docs/api/predicates#predicates-exists)
    case exists(Request, PredicateParameters? = nil)

    /// Inverts a predicate
    /// [mbtest.org/docs/api/predicates#predicates-not](https://www.mbtest.org/docs/api/predicates#predicates-not)
    case not(Predicate, PredicateParameters? = nil)

    /// Logically or's two predicates together
    /// [mbtest.org/docs/api/predicates#predicates-or](https://www.mbtest.org/docs/api/predicates#predicates-or)
    case or([Predicate], PredicateParameters? = nil)

    /// Logically and's two predicates together
    /// [mbtest.org/docs/api/predicates#predicates-and](https://www.mbtest.org/docs/api/predicates#predicates-and)
    case and([Predicate], PredicateParameters? = nil)

    /// Injects JavaScript to decide whether the request matches or not.
    /// The JavaScript should be a function that accepts the request object
    /// (and optionally a logger) and returns true or false.
    /// [mbtest.org/docs/api/predicates#predicates-inject](https://www.mbtest.org/docs/api/predicates#predicates-inject)
    case inject(String)
}

extension Predicate {
    /// The request field matches the predicate
    /// [mbtest.org/docs/api/predicates#predicates-equals](https://www.mbtest.org/docs/api/predicates#predicates-equals)
    ///
    /// Convenience method for most used predicate.
    public static func equalsRequest(
        method: HTTPMethod? = nil,
        path: String? = nil,
        query: [String: JSON]? = nil,
        headers: [String: JSON]? = nil,
        data: JSON? = nil
    ) -> Predicate {
        Predicate.equals(
            Request(
                method: method,
                path: path,
                query: query,
                headers: headers,
                data: data
            )
        )
    }
}
