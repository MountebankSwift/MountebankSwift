import MountebankSwift

import XCTest

final class ProxyTests: XCTestCase {
    func testProxy() throws {
        try assertEncode(
            Proxy.Examples.simple.value,
            Proxy.Examples.simple.json
        )
        try assertDecode(
            Proxy.Examples.simple.json,
            Proxy.Examples.simple.value
        )
    }

    // TODO: Add more examples and tests
}
