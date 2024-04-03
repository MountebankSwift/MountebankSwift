import XCTest
@testable import MountebankSwift

final class ImposterTests: XCTestCase {
    func testSimple() throws {
        try assertEncode(
            Imposter.Examples.simple.value,
            Imposter.Examples.simple.json
        )
        try assertDecode(
            Imposter.Examples.simple.json,
            Imposter.Examples.simple.value
        )
    }

    func testAdvanced() throws {
        try assertEncode(
            Imposter.Examples.advanced.value,
            Imposter.Examples.advanced.json
        )
        try assertDecode(
            Imposter.Examples.advanced.json,
            Imposter.Examples.advanced.value
        )
    }

    func testWithResponseData() throws {
        try assertEncode(
            Imposter.Examples.withResponseData.value,
            Imposter.Examples.withResponseData.json
        )
        try assertDecode(
            Imposter.Examples.withResponseData.json,
            Imposter.Examples.withResponseData.value
        )
    }

    func testWithExtraOptionsDataHttp() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttp.value,
            Imposter.Examples.withExtraOptionsHttp.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttp.json,
            Imposter.Examples.withExtraOptionsHttp.value
        )
    }

    func testWithExtraOptionsDataHttps() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttps.value,
            Imposter.Examples.withExtraOptionsHttps.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttps.json,
            Imposter.Examples.withExtraOptionsHttps.value
        )
    }

    func testIncludingAllStubs() throws {
        try assertEncode(
            Imposter.Examples.includingAllStubs.value,
            Imposter.Examples.includingAllStubs.json
        )
        try assertDecode(
            Imposter.Examples.includingAllStubs.json,
            Imposter.Examples.includingAllStubs.value
        )
    }

    func testInvalidHeaders() throws {
        try assertDecode(
            [
                "port": 123,
                "protocol" : "http",
                "stubs": [],
                "numberOfRequests": 1,
                "requests": [
                    [
                        "method": "GET",
                        "path": "/test-path",
                        "requestFrom": "127.0.0.1",
                        "ip": "127.0.0.1",
                        "timestamp": "2023-12-08T20:09:06.263Z",
                        "headers": [
                            "X-My-Invalid-header-type-should-be-string" : 42,
                            "X-Invalid-headers.." : "should be ignored",
                        ],
                    ],
                ],
            ],
            Imposter(
                port: 123,
                networkProtocol: .http(),
                stubs: [],
                numberOfRequests: 1,
                requests: [
                    Imposter.RecordedRequest(
                        method: .get,
                        path: "/test-path",
                        headers: ["X-Invalid-headers.." : "should be ignored"],
                        requestFrom: "127.0.0.1",
                        ip: "127.0.0.1",
                        timestamp: Date(timeIntervalSince1970: 1702066146.263)
                    ),
                ]
            )
        )
    }

    func testWriteToDisk() throws {
        try Imposter.Examples.includingAllStubs.value.writeStubsToDisk()
    }
}
