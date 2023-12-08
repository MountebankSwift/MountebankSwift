import Foundation

extension Stub {
    /// See https://www.mbtest.org/docs/api/predicates
    public indirect enum Predicate: Codable, Equatable {
//        case simple(
//            method: HTTPMethod? = nil,
//            path: String? = nil,
//            query: JSON? = nil,
//            headers: JSON? = nil,
//            data: JSON? = nil,
//            Parameters? = nil
//        )

        /// The request field matches the predicate
        /// https://www.mbtest.org/docs/api/predicates#predicates-equals
        case equals(JSON, Parameters? = nil)

        /// Performs nested set equality on the request field,
        /// useful when the request field is an object (e.g. the query field in http)
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

        /// The request field matches the JavaScript regular expression
        /// defined with the predicate.
        /// https://www.mbtest.org/docs/api/predicates#predicates-matches
        case matches(JSON, Parameters? = nil)

        /// If true, the request field must exist. If false,
        /// the request field must not exist.
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
        /// The JavaScript should be a function that accepts the request object
        /// (and optionally a logger) and returns true or false.
        /// https://www.mbtest.org/docs/api/predicates#predicates-inject
        case inject(String)
    }
}
