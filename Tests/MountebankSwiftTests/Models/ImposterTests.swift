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

    func testWithResponseData() throws {
        try assertEncode(
            Imposter.Examples.withResponseData.value,
            Imposter.Examples.withResponseData.json
        )
        try assertDecode(
            Imposter.Examples.withResponseData.json,
            Imposter.Examples.withResponseData.value
        )
    }

    func testWithExtraOptionsDataHttp() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttp.value,
            Imposter.Examples.withExtraOptionsHttp.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttp.json,
            Imposter.Examples.withExtraOptionsHttp.value
        )
    }

    func testWithExtraOptionsDataHttps() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttps.value,
            Imposter.Examples.withExtraOptionsHttps.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttps.json,
            Imposter.Examples.withExtraOptionsHttps.value
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
