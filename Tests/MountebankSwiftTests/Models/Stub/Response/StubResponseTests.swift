import MountebankSwift

import XCTest

final class StubResponseTests: XCTestCase {
    func testText() throws {
        try assertEncode(
            Stub.Response.Examples.text.value,
            Stub.Response.Examples.text.json
        )
        try assertDecode(
            Stub.Response.Examples.text.json,
            Stub.Response.Examples.text.value
        )
    }

    func testHtml() throws {
        try assertEncode(
            Stub.Response.Examples.html.value,
            Stub.Response.Examples.html.json
        )
        try assertDecode(
            Stub.Response.Examples.html.json,
            Stub.Response.Examples.html.value
        )
    }

    func testJson() throws {
        try assertEncode(
            Stub.Response.Examples.json.value,
            Stub.Response.Examples.json.json
        )
        try assertDecode(
            Stub.Response.Examples.json.json,
            Stub.Response.Examples.json.value
        )
    }

    func testBinary() throws {
        try assertEncode(
            Stub.Response.Examples.binary.value,
            Stub.Response.Examples.binary.json
        )
        try assertDecode(
            Stub.Response.Examples.binary.json,
            Stub.Response.Examples.binary.value
        )
    }

    func testHttpResponse404() throws {
        try assertEncode(
            Stub.Response.Examples.http404.value,
            Stub.Response.Examples.http404.json
        )
        try assertDecode(
            Stub.Response.Examples.http404.json,
            Stub.Response.Examples.http404.value
        )
    }

    func testProxy() throws {
        try assertEncode(
            Stub.Response.Examples.proxy.value,
            Stub.Response.Examples.proxy.json
        )
        try assertDecode(
            Stub.Response.Examples.proxy.json,
            Stub.Response.Examples.proxy.value
        )
    }

    func testInjectBody() throws {
        try assertEncode(
            Stub.Response.Examples.injectBody.value,
            Stub.Response.Examples.injectBody.json
        )
        try assertDecode(
            Stub.Response.Examples.injectBody.json,
            Stub.Response.Examples.injectBody.value
        )
    }

    func testFaultConnectionResetByPeer() throws {
        try assertEncode(
            Stub.Response.Examples.connectionResetByPeer.value,
            Stub.Response.Examples.connectionResetByPeer.json
        )
        try assertDecode(
            Stub.Response.Examples.connectionResetByPeer.json,
            Stub.Response.Examples.connectionResetByPeer.value
        )
    }

    func testFaultRandomDataThenClose() throws {
        try assertEncode(
            Stub.Response.Examples.randomDataThenClose.value,
            Stub.Response.Examples.randomDataThenClose.json
        )
        try assertDecode(
            Stub.Response.Examples.randomDataThenClose.json,
            Stub.Response.Examples.randomDataThenClose.value
        )
    }

    func testResponseParameters() throws {
        try assertEncode(
            Stub.Response.Examples.responseParameters.value,
            Stub.Response.Examples.responseParameters.json
        )
        try assertDecode(
            Stub.Response.Examples.responseParameters.json,
            Stub.Response.Examples.responseParameters.value
        )
    }
}
