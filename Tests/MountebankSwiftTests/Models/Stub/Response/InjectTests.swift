import MountebankSwift

import XCTest

final class InjectTests: XCTestCase {
    func testInjectBody() throws {
        try assertEncode(
            Inject.Examples.injectBody.value,
            Inject.Examples.injectBody.json
        )
        try assertDecode(
            Inject.Examples.injectBody.json,
            Inject.Examples.injectBody.value
        )
    }
}
