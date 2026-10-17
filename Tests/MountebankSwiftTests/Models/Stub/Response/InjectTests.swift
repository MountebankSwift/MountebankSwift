import MountebankSwift

import Testing

@Suite
struct InjectTests {

    @Test
    func injectBodySingleLine() throws {
        try assertEncode(
            Inject.Examples.injectBodySingleLine.value,
            Inject.Examples.injectBodySingleLine.json
        )
        try assertDecode(
            Inject.Examples.injectBodySingleLine.json,
            Inject.Examples.injectBodySingleLine.value
        )
    }

    @Test
    func injectBodyMultiline() throws {
        try assertEncode(
            Inject.Examples.injectBodyMultiline.value,
            Inject.Examples.injectBodyMultiline.json
        )
        try assertDecode(
            Inject.Examples.injectBodyMultiline.json,
            Inject.Examples.injectBodyMultiline.value
        )
    }
}
