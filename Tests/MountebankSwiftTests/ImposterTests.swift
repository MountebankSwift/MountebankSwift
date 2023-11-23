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

    func testIncludingAllStubs() throws {
        try assertEncode(
            Imposter.Examples.includingAllStubs.value,
            Imposter.Examples.includingAllStubs.json
        )
        try assertDecode(
            Imposter.Examples.includingAllStubs.json,
            Imposter.Examples.includingAllStubs.value
        )
    }
}
