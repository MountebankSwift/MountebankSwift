import MountebankSwift

import XCTest

final class StubResponseTests: XCTestCase {
    func testText() throws {
        try assertEncode(
            Stub.Response.Is.Examples.text.value,
            Stub.Response.Is.Examples.text.json
        )
        try assertDecode(
            Stub.Response.Is.Examples.text.json,
            Stub.Response.Is.Examples.text.value
        )
    }

    func testHtml() throws {
        try assertEncode(
            Stub.Response.Is.Examples.html.value,
            Stub.Response.Is.Examples.html.json
        )
        try assertDecode(
            Stub.Response.Is.Examples.html.json,
            Stub.Response.Is.Examples.html.value
        )
    }

    func testJson() throws {
        try assertEncode(
            Stub.Response.Is.Examples.json.value,
            Stub.Response.Is.Examples.json.json
        )
        try assertDecode(
            Stub.Response.Is.Examples.json.json,
            Stub.Response.Is.Examples.json.value
        )
    }

    func testBinary() throws {
        try assertEncode(
            Stub.Response.Is.Examples.binary.value,
            Stub.Response.Is.Examples.binary.json
        )
        try assertDecode(
            Stub.Response.Is.Examples.binary.json,
            Stub.Response.Is.Examples.binary.value
        )
    }

    func testHttpResponse404() throws {
        try assertEncode(
            Stub.Response.Is.Examples.http404.value,
            Stub.Response.Is.Examples.http404.json
        )
        try assertDecode(
            Stub.Response.Is.Examples.http404.json,
            Stub.Response.Is.Examples.http404.value
        )
    }

    // TODO fix decoding error
    func skip_testResponseParameters() throws {
        try assertEncode(
            Stub.Response.Is.Examples.withResponseParameters.value,
            Stub.Response.Is.Examples.withResponseParameters.json
        )
        
        try assertDecode(
            Stub.Response.Is.Examples.withResponseParameters.json,
            Stub.Response.Is.Examples.withResponseParameters.value
        )
    }

    func testProxy() throws {
        try assertEncode(
            Stub.Response.Proxy.Examples.proxy.value,
            Stub.Response.Proxy.Examples.proxy.json
        )
        try assertDecode(
            Stub.Response.Proxy.Examples.proxy.json,
            Stub.Response.Proxy.Examples.proxy.value
        )
    }

    func testInjectBody() throws {
        try assertEncode(
            Stub.Response.Inject.Examples.injectBody.value,
            Stub.Response.Inject.Examples.injectBody.json
        )
        try assertDecode(
            Stub.Response.Inject.Examples.injectBody.json,
            Stub.Response.Inject.Examples.injectBody.value
        )
    }

    func testFaultConnectionResetByPeer() throws {
        try assertEncode(
            Stub.Response.Fault.Examples.connectionResetByPeer.value,
            Stub.Response.Fault.Examples.connectionResetByPeer.json
        )
        try assertDecode(
            Stub.Response.Fault.Examples.connectionResetByPeer.json,
            Stub.Response.Fault.Examples.connectionResetByPeer.value
        )
    }

    func testFaultRandomDataThenClose() throws {
        try assertEncode(
            Stub.Response.Fault.Examples.randomDataThenClose.value,
            Stub.Response.Fault.Examples.randomDataThenClose.json
        )
        try assertDecode(
            Stub.Response.Fault.Examples.randomDataThenClose.json,
            Stub.Response.Fault.Examples.randomDataThenClose.value
        )
    }
}
