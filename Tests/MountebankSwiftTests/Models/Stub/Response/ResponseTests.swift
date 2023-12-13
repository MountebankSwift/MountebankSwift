import MountebankSwift

import XCTest

final class ResponseTests: XCTestCase {
    func testText() throws {
        try assertEncode(
            Is.Examples.text.value,
            Is.Examples.text.json
        )
        try assertDecode(
            Is.Examples.text.json,
            Is.Examples.text.value
        )
    }

    func testHtml() throws {
        try assertEncode(
            Is.Examples.html.value,
            Is.Examples.html.json
        )
        try assertDecode(
            Is.Examples.html.json,
            Is.Examples.html.value
        )
    }

    func testJson() throws {
        try assertEncode(
            Is.Examples.json.value,
            Is.Examples.json.json
        )
        try assertDecode(
            Is.Examples.json.json,
            Is.Examples.json.value
        )
    }

    func testCodable() throws {
        try assertEncode(
            Is.Examples.jsonEncodable.value,
            Is.Examples.jsonEncodable.json
        )
        // Not possibel to decode json back into codable
    }

    func testBinary() throws {
        try assertEncode(
            Is.Examples.binary.value,
            Is.Examples.binary.json
        )
        try assertDecode(
            Is.Examples.binary.json,
            Is.Examples.binary.value
        )
    }

    func testHttpResponse404() throws {
        try assertEncode(
            Is.Examples.http404.value,
            Is.Examples.http404.json
        )
        try assertDecode(
            Is.Examples.http404.json,
            Is.Examples.http404.value
        )
    }

    func testResponseParameters() throws {
        // Parameters should not be encoded to the json here but on a higher level, so no decode test here
        try assertEncode(
            Is.Examples.withResponseParameters.value,
            Is.Examples.withResponseParameters.json
        )
    }

    func testProxy() throws {
        try assertEncode(
            Proxy.Examples.proxy.value,
            Proxy.Examples.proxy.json
        )
        try assertDecode(
            Proxy.Examples.proxy.json,
            Proxy.Examples.proxy.value
        )
    }

    func testInjectBody() throws {
        try assertEncode(
            Inject.Examples.injectBody.value,
            Inject.Examples.injectBody.json
        )
        try assertDecode(
            Inject.Examples.injectBody.json,
            Inject.Examples.injectBody.value
        )
    }

    func testFaultConnectionResetByPeer() throws {
        try assertEncode(
            Fault.Examples.connectionResetByPeer.value,
            Fault.Examples.connectionResetByPeer.json
        )
        try assertDecode(
            Fault.Examples.connectionResetByPeer.json,
            Fault.Examples.connectionResetByPeer.value
        )
    }

    func testFaultRandomDataThenClose() throws {
        try assertEncode(
            Fault.Examples.randomDataThenClose.value,
            Fault.Examples.randomDataThenClose.json
        )
        try assertDecode(
            Fault.Examples.randomDataThenClose.json,
            Fault.Examples.randomDataThenClose.value
        )
    }
}
