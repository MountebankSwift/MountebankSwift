import MountebankSwift

import XCTest

final class StubResponseParametersTests: XCTestCase {
    func testAll() throws {
        try assertEncode(
            Stub.Response.Parameters.Examples.all.value,
            Stub.Response.Parameters.Examples.all.json
        )
        try assertDecode(
            Stub.Response.Parameters.Examples.all.json,
            Stub.Response.Parameters.Examples.all.value
        )
    }
}
