import MountebankSwift

import Testing

@Suite
struct ResponseParametersTests {

    @Test
    func repeating() throws {
        try assertEncode(
            ResponseParameters.Examples.repeating.value,
            ResponseParameters.Examples.repeating.json
        )
        try assertDecode(
            ResponseParameters.Examples.repeating.json,
            ResponseParameters.Examples.repeating.value
        )
    }

    @Test
    func behaviors() throws {
        try assertEncode(
            ResponseParameters.Examples.behaviors.value,
            ResponseParameters.Examples.behaviors.json
        )
        try assertDecode(
            ResponseParameters.Examples.behaviors.json,
            ResponseParameters.Examples.behaviors.value
        )
    }

    @Test
    func full() throws {
        try assertEncode(
            ResponseParameters.Examples.full.value,
            ResponseParameters.Examples.full.json
        )
        try assertDecode(
            ResponseParameters.Examples.full.json,
            ResponseParameters.Examples.full.value
        )
    }
}
