import MountebankSwift

import XCTest

final class StubResponseParametersTests: XCTestCase {
    func testRepeating() throws {
        try assertEncode(
            Stub.Response.Parameters.Examples.repeating.value,
            Stub.Response.Parameters.Examples.repeating.json
        )
        try assertDecode(
            Stub.Response.Parameters.Examples.repeating.json,
            Stub.Response.Parameters.Examples.repeating.value
        )
    }

    func testBehaviors() throws {
        try assertEncode(
            Stub.Response.Parameters.Examples.behaviors.value,
            Stub.Response.Parameters.Examples.behaviors.json
        )
        try assertDecode(
            Stub.Response.Parameters.Examples.behaviors.json,
            Stub.Response.Parameters.Examples.behaviors.value
        )
    }

    func testFull() throws {
        try assertEncode(
            Stub.Response.Parameters.Examples.full.value,
            Stub.Response.Parameters.Examples.full.json
        )
        try assertDecode(
            Stub.Response.Parameters.Examples.full.json,
            Stub.Response.Parameters.Examples.full.value
        )
    }
}
