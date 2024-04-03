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

    func testEncodable() throws {
        try assertEncode(
            Is.Examples.jsonEncodable.value,
            Is.Examples.jsonEncodable.json
        )
        // Not possible to decode json back into codable
    }

    func testEncodableCustomDateFormatAndKeyEncodingStrategy() throws {
        try assertEncode(
            Is.Examples.jsonEncodableCustomDateFormatAndKeyEncodingStrategy.value,
            Is.Examples.jsonEncodableCustomDateFormatAndKeyEncodingStrategy.json
        )
        // Not possible to decode json back into codable
    }

    func testHttpResponse404() throws {
        try assertEncode(
            Is.Examples.http404.value,
            Is.Examples.http404.json
        )
        try assertDecode(
            Is.Examples.http404.json,
            Is.Examples.http404.value
        )
    }

    func testResponseParameters() throws {
        // Parameters should not be encoded to the json here but on a higher level, so no decode test here
        try assertEncode(
            Is.Examples.withResponseParameters.value,
            Is.Examples.withResponseParameters.json
        )
    }

    func testInvalidHeaders() throws {
        try assertDecode(
            [
                "statusCode" : 404,
                "headers": [
                    "X-My-Invalid-header-type-should-be-string" : 42,
                    "X-Invalid-headers.." : "should be ignored",
                ],
            ],
            Is(
                statusCode: 404,
                headers: ["X-Invalid-headers.." : "should be ignored"]
            )
        )
    }
}
