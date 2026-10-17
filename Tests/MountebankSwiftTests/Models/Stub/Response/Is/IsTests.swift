import MountebankSwift

import Foundation
import Testing

@Suite
struct IsTests {

    @Test
    func text() throws {
        try assertEncode(
            Is.Examples.text.value,
            Is.Examples.text.json
        )
        try assertDecode(
            Is.Examples.text.json,
            Is.Examples.text.value
        )
    }

    @Test
    func html() throws {
        try assertEncode(
            Is.Examples.html.value,
            Is.Examples.html.json
        )
        try assertDecode(
            Is.Examples.html.json,
            Is.Examples.html.value
        )
    }

    @Test
    func json() throws {
        try assertEncode(
            Is.Examples.json.value,
            Is.Examples.json.json
        )
        try assertDecode(
            Is.Examples.json.json,
            Is.Examples.json.value
        )
    }

    @Test
    func binary() throws {
        try assertEncode(
            Is.Examples.binary.value,
            Is.Examples.binary.json
        )
        try assertDecode(
            Is.Examples.binary.json,
            Is.Examples.binary.value
        )
    }

    @Test
    func http404() throws {
        try assertEncode(
            Is.Examples.http404.value,
            Is.Examples.http404.json
        )
        try assertDecode(
            Is.Examples.http404.json,
            Is.Examples.http404.value
        )
    }

    @Test
    func encodable() throws {
        try assertEncode(
            Is.Examples.jsonEncodable.value,
            Is.Examples.jsonEncodable.json
        )
        // Not possible to decode json back into codable
    }

    @Test
    func encodableCustomDateFormatAndKeyEncodingStrategy() throws {
        try assertEncode(
            Is.Examples.jsonEncodableCustomDateFormatAndKeyEncodingStrategy.value,
            Is.Examples.jsonEncodableCustomDateFormatAndKeyEncodingStrategy.json
        )
        // Not possible to decode json back into codable
    }

    @Test
    func httpResponse404() throws {
        try assertEncode(
            Is.Examples.http404.value,
            Is.Examples.http404.json
        )
        try assertDecode(
            Is.Examples.http404.json,
            Is.Examples.http404.value
        )
    }

    @Test
    func settingDefaultBahavoirsConcurrent() async throws {
        await confirmation(expectedCount: 1000) { confirm in
            DispatchQueue.concurrentPerform(iterations: 1000) { _ in
                Is.setDefaultBehaviors(behaviors: [])
                _ = Is()
                confirm()
            }
        }
    }

    @Test
    func responseParameters() throws {
        // Parameters should not be encoded to the json here but on a higher level, so no decode test here
        try assertEncode(
            Is.Examples.withResponseParameters.value,
            Is.Examples.withResponseParameters.json
        )
    }

    @Test
    func invalidHeaders() throws {
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
