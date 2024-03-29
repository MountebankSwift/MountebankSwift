import Foundation

/// Parameters that can be added to a response  to finetune it.
public struct ResponseParameters: Equatable {
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
    var recreatable: String {
        structSwiftString([
            ("repeatCount", repeatCount),
            ("behaviors", behaviors),
        ])
    }
}
