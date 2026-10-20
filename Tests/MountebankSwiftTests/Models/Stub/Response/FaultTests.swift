import MountebankSwift

import Testing

@Suite
struct FaultTests {

    @Test
    func faultConnectionResetByPeer() throws {
        try assertEncode(
            Fault.Examples.connectionResetByPeer.value,
            Fault.Examples.connectionResetByPeer.json
        )
        try assertDecode(
            Fault.Examples.connectionResetByPeer.json,
            Fault.Examples.connectionResetByPeer.value
        )
    }

    @Test
    func faultRandomDataThenClose() throws {
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
