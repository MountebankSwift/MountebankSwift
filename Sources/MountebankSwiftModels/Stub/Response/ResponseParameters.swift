import Foundation

/// Parameters that can be added to a response to fine-tune it.
public struct ResponseParameters: Equatable, Sendable {
    /// Repeats the response the given number of times.
    public let repeatCount: Int?
    public let behaviors: [Behavior]?

    var isEmpty: Bool {
        // A bit overkill, but future proof
        !Mirror(reflecting: self).children.contains(where: { "\($0.value)" != "nil" })
    }

    public init?(repeatCount: Int? = nil, behaviors: [Behavior] = []) {
        self.repeatCount = repeatCount
        self.behaviors = behaviors.isEmpty ? nil : behaviors

        if isEmpty {
            return nil
        }
    }
}

extension ResponseParameters: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([
            ("repeatCount", repeatCount),
            ("behaviors", behaviors),
        ], indent: indent)
    }
}
