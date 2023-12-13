import Foundation

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
