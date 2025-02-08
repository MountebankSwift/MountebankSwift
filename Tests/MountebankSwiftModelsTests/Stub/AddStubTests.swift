import MountebankSwiftModels
@testable import MountebankExampleData

import XCTest

final class AddStubTests: XCTestCase {
    func testText() throws {
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
