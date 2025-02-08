import MountebankSwiftModels
@testable import MountebankExampleData
import XCTest

final class ConfigTests: XCTestCase {
    func testEquals() throws {
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
