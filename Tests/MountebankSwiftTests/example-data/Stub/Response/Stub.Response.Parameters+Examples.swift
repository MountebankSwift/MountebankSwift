import Foundation
import MountebankSwift

extension Stub.Response.Parameters {
    enum Examples {
        static let repeating = Example(
            value: Stub.Response.Parameters(repeatCount: 5),
            json: ["repeat": 5]
        )
    }
}
