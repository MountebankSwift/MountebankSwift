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
}
