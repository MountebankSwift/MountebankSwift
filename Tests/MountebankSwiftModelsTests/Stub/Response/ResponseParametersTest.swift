import MountebankSwiftModels
@testable import MountebankExampleData
import XCTest

final class ResponseParametersTests: XCTestCase {
    func testRepeating() throws {
        try assertEncode(
            ResponseParameters.Examples.repeating.value,
            ResponseParameters.Examples.repeating.json
        )
        try assertDecode(
            ResponseParameters.Examples.repeating.json,
            ResponseParameters.Examples.repeating.value
        )
    }

    func testBehaviors() throws {
        try assertEncode(
            ResponseParameters.Examples.behaviors.value,
            ResponseParameters.Examples.behaviors.json
        )
        try assertDecode(
            ResponseParameters.Examples.behaviors.json,
            ResponseParameters.Examples.behaviors.value
        )
    }

    func testFull() throws {
        try assertEncode(
            ResponseParameters.Examples.full.value,
            ResponseParameters.Examples.full.json
        )
        try assertDecode(
            ResponseParameters.Examples.full.json,
            ResponseParameters.Examples.full.value
        )
    }
}
