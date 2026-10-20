import MountebankSwift

import Testing

@Suite
struct ConfigTests {

    @Test
    func equals() throws {
        try assertEncode(
            Config.Examples.simple.value,
            Config.Examples.simple.json
        )
        try assertDecode(
            Config.Examples.simple.json,
            Config.Examples.simple.value
        )
    }
}
