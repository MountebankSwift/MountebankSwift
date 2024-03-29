import Foundation

/// Predicate parameter to narrow down the scope of the predicate value to a value matched by the jsonpath selector,
/// much like the except parameter.
///
/// [mbtest.org/docs/api/jsonpath](https://www.mbtest.org/docs/api/jsonpath)
public struct JSONPath: Codable, Equatable, Sendable {
    /// The JSONPath selector
    public let selector: String

    public init(selector: String) {
        self.selector = selector
    }
}

extension JSONPath: Recreatable {
    var recreatable: String {
        "JSONPath(selector: \(selector.recreatable))"
    }
}
