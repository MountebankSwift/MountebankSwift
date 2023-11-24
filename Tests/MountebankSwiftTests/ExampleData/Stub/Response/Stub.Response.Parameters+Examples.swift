import Foundation
import MountebankSwift

extension Stub.Response.Parameters {
    enum Examples {
        static let repeating = Example(
            value: Stub.Response.Parameters(repeatCount: 5),
            json: ["repeat": 5]
        )

        static let behaviors = Example(
            value: Stub.Response.Parameters(
                behaviors: Stub.Response.Behavior.Examples.all.map(\.value)
            ),
            json: [
                "behaviors": .array(Stub.Response.Behavior.Examples.all.map(\.json))
            ]
        )

        static let full = Example(
            value: Stub.Response.Parameters(
                repeatCount: 5,
                behaviors: Stub.Response.Behavior.Examples.all.map(\.value)
            ),
            json: [
                "repeat": 5,
                "behaviors": .array(Stub.Response.Behavior.Examples.all.map(\.json))
            ]
        )
    }
}
