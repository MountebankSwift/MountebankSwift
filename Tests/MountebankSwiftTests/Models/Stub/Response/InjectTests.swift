import MountebankSwift

import XCTest

final class InjectTests: XCTestCase {
    func testInjectBodySingleLine() throws {
        try assertEncode(
            Inject.Examples.injectBodySingleLine.value,
            Inject.Examples.injectBodySingleLine.json
        )
        try assertDecode(
            Inject.Examples.injectBodySingleLine.json,
            Inject.Examples.injectBodySingleLine.value
        )
    }

    func testInjectBodyMultiline() throws {
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
