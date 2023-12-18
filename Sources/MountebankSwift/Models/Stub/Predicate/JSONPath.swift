import Foundation

public struct JSONPath: Codable, Equatable {
    /// The JSONPath selector
    let selector: String

    public init(selector: String) {
        self.selector = selector
    }
}
