import Foundation

extension Stub {
    public enum Predicate: Codable, Equatable {
        /// The request field matches the predicate
        case equals(JSON)
        /// Performs nested set equality on the request field, useful when the request field is an object (e.g. the
        /// query field in http)
        case deepEquals(JSON)
        /// The request field contains the predicate
        case contains(JSON)
        /// The request field starts with the predicate
        case startsWith
        /// The request field ends with the predicate
        case endsWith
        /// The request field matches the JavaScript regular expression defined with the predicate.
        case matches
        /// If true, the request field must exist. If false, the request field must not exist.
        case exists
        /// Inverts a predicate
        case not
        /// Logically or's two predicates together
        case or
        /// Logically and's two predicates together
        case and
        /// Injects JavaScript to decide whether the request matches or not. See the injection page for more details.
        case inject(String)
    }
}
