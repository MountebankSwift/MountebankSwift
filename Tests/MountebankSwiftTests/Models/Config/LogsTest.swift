import MountebankSwift

import XCTest

final class LogsTests: XCTestCase {
    func testLogs() throws {
        try assertEncode(
            Logs.Examples.simple.value,
            Logs.Examples.simple.json)
        try assertDecode(
            Logs.Examples.simple.json,
            Logs.Examples.simple.value)
    }
}
