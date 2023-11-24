import MountebankSwift

import XCTest

final class StubResponseBehaviorTests: XCTestCase {
    func testWait() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.wait.value,
            Stub.Response.Behavior.Examples.wait.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.wait.json,
            Stub.Response.Behavior.Examples.wait.value
        )
    }
    func testWaitJavascript() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.waitJavascript.value,
            Stub.Response.Behavior.Examples.waitJavascript.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.waitJavascript.json,
            Stub.Response.Behavior.Examples.waitJavascript.value
        )
    }
    func testCopy() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.copy.value,
            Stub.Response.Behavior.Examples.copy.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.copy.json,
            Stub.Response.Behavior.Examples.copy.value
        )
    }
    func testLookup() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.lookup.value,
            Stub.Response.Behavior.Examples.lookup.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.lookup.json,
            Stub.Response.Behavior.Examples.lookup.value
        )
    }
    func testDecorate() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.decorate.value,
            Stub.Response.Behavior.Examples.decorate.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.decorate.json,
            Stub.Response.Behavior.Examples.decorate.value
        )
    }
    func testShellTransform() throws {
        try assertEncode(
            Stub.Response.Behavior.Examples.shellTransform.value,
            Stub.Response.Behavior.Examples.shellTransform.json
        )
        try assertDecode(
            Stub.Response.Behavior.Examples.shellTransform.json,
            Stub.Response.Behavior.Examples.shellTransform.value
        )
    }
}
