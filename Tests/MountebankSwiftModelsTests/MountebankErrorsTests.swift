import XCTest
@testable import MountebankSwift
import MountebankSwiftModels
@testable import MountebankExampleData

final class MountebankErrorsTests: XCTestCase {

    func testEqualsSingle() throws {
        try assertEncode(
            MountebankErrors.Examples.single.value,
            MountebankErrors.Examples.single.json
        )
        try assertDecode(
            MountebankErrors.Examples.single.json,
            MountebankErrors.Examples.single.value
        )
    }

    func testEqualsMultiple() throws {
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
