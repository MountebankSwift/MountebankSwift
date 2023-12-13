import MountebankSwift

import XCTest

final class LogsTests: XCTestCase {
    func testLogsSimple() throws {
        try assertEncode(
            Logs.Examples.simple.value,
            Logs.Examples.simple.json
        )
        try assertDecode(
            Logs.Examples.simple.json,
            Logs.Examples.simple.value
        )
    }

    func testLogsWithDate() throws {
        try assertEncode(
            Logs.Examples.withDate.value,
            Logs.Examples.withDate.json
        )
        try assertDecode(
            Logs.Examples.withDate.json,
            Logs.Examples.withDate.value
        )
    }
}
