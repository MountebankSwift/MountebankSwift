import MountebankSwift

import XCTest

final class FaultTests: XCTestCase {
    func testFaultConnectionResetByPeer() throws {
        try assertEncode(
            Fault.Examples.connectionResetByPeer.value,
            Fault.Examples.connectionResetByPeer.json
        )
        try assertDecode(
            Fault.Examples.connectionResetByPeer.json,
            Fault.Examples.connectionResetByPeer.value
        )
    }

    func testFaultRandomDataThenClose() throws {
        try assertEncode(
            Fault.Examples.randomDataThenClose.value,
            Fault.Examples.randomDataThenClose.json
        )
        try assertDecode(
            Fault.Examples.randomDataThenClose.json,
            Fault.Examples.randomDataThenClose.value
        )
    }
}
