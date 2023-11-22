import MountebankSwift

import XCTest

final class StubTests: XCTestCase {
    func testText() throws {
        try assertEncode(
            Stub.Examples.text.value,
            Stub.Examples.text.json
        )
        try assertDecode(
            Stub.Examples.text.json,
            Stub.Examples.text.value
        )
    }

    func testJSON() throws {
        try assertEncode(
            Stub.Examples.json.value,
            Stub.Examples.json.json
        )
        try assertDecode(
            Stub.Examples.json.json,
            Stub.Examples.json.value
        )
    }

    func testHTTP404() throws {
        try assertEncode(
            Stub.Examples.http404.value,
            Stub.Examples.http404.json
        )
        try assertDecode(
            Stub.Examples.http404.json,
            Stub.Examples.http404.value
        )
    }

    func testMultipleResponses() throws {
        try assertEncode(
            Stub.Examples.textWhenRefresh404.value,
            Stub.Examples.textWhenRefresh404.json
        )
        try assertDecode(
            Stub.Examples.textWhenRefresh404.json,
            Stub.Examples.textWhenRefresh404.value
        )
    }

    func testMultiplePredicates() throws {
        try assertEncode(
            Stub.Examples.multiplePredicates.value,
            Stub.Examples.multiplePredicates.json
        )
        try assertDecode(
            Stub.Examples.multiplePredicates.json,
            Stub.Examples.multiplePredicates.value
        )
    }
}
