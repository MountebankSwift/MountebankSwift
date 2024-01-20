import MountebankSwift

import XCTest

class IsTests: XCTestCase {

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

    func testHttp404() throws {
        try assertEncode(
            Is.Examples.http404.value,
            Is.Examples.http404.json
        )
        try assertDecode(
            Is.Examples.http404.json,
            Is.Examples.http404.value
        )
    }
}
