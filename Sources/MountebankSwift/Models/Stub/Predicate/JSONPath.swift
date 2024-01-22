import Foundation

/// Predicate parameter to narrow down the scope of the predicate value to a value matched by the jsonpath selector,
/// much like the except parameter.
///
/// [mbtest.org/docs/api/jsonpath](https://www.mbtest.org/docs/api/jsonpath)
public struct JSONPath: Codable, Equatable {
    /// The JSONPath selector
    public let selector: String

    public init(selector: String) {
        self.selector = selector
    }
}
