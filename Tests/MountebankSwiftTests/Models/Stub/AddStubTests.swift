@testable import MountebankSwift

import Testing

@Suite
struct AddStubTests {

    @Test
    func text() throws {
        try assertEncode(
            AddStub.Examples.addInjectStubFirstIndex.value,
            AddStub.Examples.addInjectStubFirstIndex.json
        )
        try assertDecode(
            AddStub.Examples.addInjectStubFirstIndex.json,
            AddStub.Examples.addInjectStubFirstIndex.value
        )
    }
}
