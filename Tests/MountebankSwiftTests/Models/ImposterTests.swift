import Foundation
import Testing
@testable import MountebankSwift

@Suite
struct ImposterTests {

    @Test
    func simple() throws {
        try assertEncode(
            Imposter.Examples.simple.value,
            Imposter.Examples.simple.json
        )
        try assertDecode(
            Imposter.Examples.simple.json,
            Imposter.Examples.simple.value
        )
    }

    @Test
    func advanced() throws {
        try assertEncode(
            Imposter.Examples.advanced.value,
            Imposter.Examples.advanced.json
        )
        try assertDecode(
            Imposter.Examples.advanced.json,
            Imposter.Examples.advanced.value
        )
    }

    @Test
    func withResponseData() throws {
        try assertEncode(
            Imposter.Examples.withResponseData.value,
            Imposter.Examples.withResponseData.json
        )
        try assertDecode(
            Imposter.Examples.withResponseData.json,
            Imposter.Examples.withResponseData.value
        )
    }

    @Test
    func withExtraOptionsDataHttp() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttp.value,
            Imposter.Examples.withExtraOptionsHttp.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttp.json,
            Imposter.Examples.withExtraOptionsHttp.value
        )
    }

    @Test
    func withExtraOptionsDataHttps() throws {
        try assertEncode(
            Imposter.Examples.withExtraOptionsHttps.value,
            Imposter.Examples.withExtraOptionsHttps.json
        )
        try assertDecode(
            Imposter.Examples.withExtraOptionsHttps.json,
            Imposter.Examples.withExtraOptionsHttps.value
        )
    }

    @Test
    func includingAllStubs() throws {
        try assertEncode(
            Imposter.Examples.includingAllStubs.value,
            Imposter.Examples.includingAllStubs.json
        )
        try assertDecode(
            Imposter.Examples.includingAllStubs.json,
            Imposter.Examples.includingAllStubs.value
        )
    }

    @Test
    func invalidHeaders() throws {
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

    @Test
    func writeToDisk() throws {
        try Imposter.Examples.includingAllStubs.value.writeStubsToDisk()
    }
}
