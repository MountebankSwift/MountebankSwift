import MountebankSwift

import XCTest

final class BehaviorTests: XCTestCase {
    func testWait() throws {
        try assertEncode(
            Behavior.Examples.wait.value,
            Behavior.Examples.wait.json
        )
        try assertDecode(
            Behavior.Examples.wait.json,
            Behavior.Examples.wait.value
        )
    }
    func testWaitJavascript() throws {
        try assertEncode(
            Behavior.Examples.waitJavascript.value,
            Behavior.Examples.waitJavascript.json
        )
        try assertDecode(
            Behavior.Examples.waitJavascript.json,
            Behavior.Examples.waitJavascript.value
        )
    }
    func testCopy() throws {
        try assertEncode(
            Behavior.Examples.copy.value,
            Behavior.Examples.copy.json
        )
        try assertDecode(
            Behavior.Examples.copy.json,
            Behavior.Examples.copy.value
        )
    }
    func testLookup() throws {
        try assertEncode(
            Behavior.Examples.lookup.value,
            Behavior.Examples.lookup.json
        )
        try assertDecode(
            Behavior.Examples.lookup.json,
            Behavior.Examples.lookup.value
        )
    }
    func testDecorate() throws {
        try assertEncode(
            Behavior.Examples.decorate.value,
            Behavior.Examples.decorate.json
        )
        try assertDecode(
            Behavior.Examples.decorate.json,
            Behavior.Examples.decorate.value
        )
    }
    func testShellTransform() throws {
        try assertEncode(
            Behavior.Examples.shellTransform.value,
            Behavior.Examples.shellTransform.json
        )
        try assertDecode(
            Behavior.Examples.shellTransform.json,
            Behavior.Examples.shellTransform.value
        )
    }
}
