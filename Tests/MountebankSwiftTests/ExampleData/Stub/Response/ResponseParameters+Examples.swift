import Foundation
import MountebankSwift

extension ResponseParameters {
    enum Examples {
        static let repeating = Example(
            value: ResponseParameters(repeatCount: 5),
            json: ["repeat": 5]
        )

        static let behaviors = Example(
            value: ResponseParameters(
                behaviors: Behavior.Examples.all.map(\.value)
            ),
            json: [
                "behaviors": .array(Behavior.Examples.all.map(\.json)),
            ]
        )

        static let full = Example(
            value: ResponseParameters(
                repeatCount: 5,
                behaviors: Behavior.Examples.all.map(\.value)
            ),
            json: [
                "repeat": 5,
                "behaviors": .array(Behavior.Examples.all.map(\.json)),
            ]
        )
    }
}
