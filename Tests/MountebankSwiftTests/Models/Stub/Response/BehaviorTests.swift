import MountebankSwift

import Testing

@Suite
struct BehaviorTests {

    @Test
    func wait() throws {
        try assertEncode(
            Behavior.Examples.wait.value,
            Behavior.Examples.wait.json
        )
        try assertDecode(
            Behavior.Examples.wait.json,
            Behavior.Examples.wait.value
        )
    }

    @Test
    func waitJavascript() throws {
        try assertEncode(
            Behavior.Examples.waitJavascript.value,
            Behavior.Examples.waitJavascript.json
        )
        try assertDecode(
            Behavior.Examples.waitJavascript.json,
            Behavior.Examples.waitJavascript.value
        )
    }

    @Test
    func copyCode() throws {
        try assertEncode(
            Behavior.Examples.copyCode.value,
            Behavior.Examples.copyCode.json
        )
        try assertDecode(
            Behavior.Examples.copyCode.json,
            Behavior.Examples.copyCode.value
        )
    }

    @Test
    func copyQuery() throws {
        try assertEncode(
            Behavior.Examples.copyQuery.value,
            Behavior.Examples.copyQuery.json
        )
        try assertDecode(
            Behavior.Examples.copyQuery.json,
            Behavior.Examples.copyQuery.value
        )
    }

    @Test
    func copyHeader() throws {
        try assertEncode(
            Behavior.Examples.copyHeader.value,
            Behavior.Examples.copyHeader.json
        )
        try assertDecode(
            Behavior.Examples.copyHeader.json,
            Behavior.Examples.copyHeader.value
        )
    }

    @Test
    func copyJsonPath() throws {
        try assertEncode(
            Behavior.Examples.copyJsonPath.value,
            Behavior.Examples.copyJsonPath.json
        )
        try assertDecode(
            Behavior.Examples.copyJsonPath.json,
            Behavior.Examples.copyJsonPath.value
        )
    }

    @Test
    func copyXpath() throws {
        try assertEncode(
            Behavior.Examples.copyXpath.value,
            Behavior.Examples.copyXpath.json
        )
        try assertDecode(
            Behavior.Examples.copyXpath.json,
            Behavior.Examples.copyXpath.value
        )
    }

    @Test
    func lookup() throws {
        try assertEncode(
            Behavior.Examples.lookup.value,
            Behavior.Examples.lookup.json
        )
        try assertDecode(
            Behavior.Examples.lookup.json,
            Behavior.Examples.lookup.value
        )
    }

    @Test
    func decorate() throws {
        try assertEncode(
            Behavior.Examples.decorate.value,
            Behavior.Examples.decorate.json
        )
        try assertDecode(
            Behavior.Examples.decorate.json,
            Behavior.Examples.decorate.value
        )
    }

    @Test
    func shellTransform() throws {
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
