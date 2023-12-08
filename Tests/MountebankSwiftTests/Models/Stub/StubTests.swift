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

    func testMultiplePredicatesAndResponses() throws {
        try assertEncode(
            Stub.Examples.multiplePredicatesAndResponses.value,
            Stub.Examples.multiplePredicatesAndResponses.json
        )
        try assertDecode(
            Stub.Examples.multiplePredicatesAndResponses.json,
            Stub.Examples.multiplePredicatesAndResponses.value
        )
    }

    func testWithResponseParameters() throws {
        try assertEncode(
            Stub.Examples.withResponseParameters.value,
            Stub.Examples.withResponseParameters.json
        )
        try assertDecode(
            Stub.Examples.withResponseParameters.json,
            Stub.Examples.withResponseParameters.value
        )
    }
}
