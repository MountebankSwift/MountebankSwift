import Foundation

/// Predicate parameter to narrow down the scope of the predicate value to a value matched by the xpath selector,
/// much like the except parameter.
///
/// [mbtest.org/docs/api/xpath](https://www.mbtest.org/docs/api/xpath)
public struct XPath: Codable, Equatable, Sendable {
    enum CodingKeys: String, CodingKey {
        case selector
        case namespace = "ns"
    }

    /// The XPath selector
    public let selector: String

    /// The XPath namespace map, aliasing a prefix to a URL, which allows you to use the prefix in the selector.
    public let namespace: [String: String]?

    public init(selector: String, namespace: [String: String]? = nil) {
        self.selector = selector
        self.namespace = namespace
    }
}

extension XPath: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([
            ("selector", selector),
            ("namespace", namespace),
        ], indent: indent)
    }
}
