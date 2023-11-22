import XCTest
@testable import MountebankSwift

final class ImposterTests: XCTestCase {
    func testSimple() throws {
        try assertEncode(
            Imposter.Examples.simple.value,
            Imposter.Examples.simple.json
        )
        try assertDecode(
            Imposter.Examples.simple.json,
            Imposter.Examples.simple.value
        )
    }

    func testAdvanced() throws {
        try assertEncode(
            Imposter.Examples.advanced.value,
            Imposter.Examples.advanced.json
        )
        try assertDecode(
            Imposter.Examples.advanced.json,
            Imposter.Examples.advanced.value
        )
    }
}
