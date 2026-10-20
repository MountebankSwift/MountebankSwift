import Testing
@testable import MountebankSwift

@Suite
struct MountebankErrorsTests {

    @Test
    func equalsSingle() throws {
        try assertEncode(
            MountebankErrors.Examples.single.value,
            MountebankErrors.Examples.single.json
        )
        try assertDecode(
            MountebankErrors.Examples.single.json,
            MountebankErrors.Examples.single.value
        )
    }

    @Test
    func equalsMultiple() throws {
        try assertEncode(
            MountebankErrors.Examples.multiple.value,
            MountebankErrors.Examples.multiple.json
        )
        try assertDecode(
            MountebankErrors.Examples.multiple.json,
            MountebankErrors.Examples.multiple.value
        )
    }

}
