import XCTest
@testable import MountebankSwift

extension Imposter {
    enum Examples {

        static let simple = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http(allowCORS: false),
                stubs: [Stub.Examples.text.value]
            ),
            json: [
                "port": 19190,
                "protocol": "http",
                "allowCORS": false,
                "stubs": [Stub.Examples.text.json],
            ]
        )

        static let json = Example(
            value: Imposter(
                port: 100,
                networkProtocol: .http(),
                stubs: [Stub.Examples.json.value]
            ),
            json: [
                "port": 100,
                "protocol": "http",
                "allowCORS": false,
                "stubs": [Stub.Examples.json.json],
            ]
        )

        static let advanced = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .https(),
                name: "Single stub",
                stubs: [
                    Stub.Examples.text.value,
                    Stub.Examples.json.value,
                    Stub.Examples.http404.value,
                ],
                defaultResponse: Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "https",
                "allowCORS": false,
                "name": "Single stub",
                "stubs": [
                    Stub.Examples.text.json,
                    Stub.Examples.json.json,
                    Stub.Examples.http404.json,
                ],
                "defaultResponse": ["statusCode": 403],
                "recordRequests": true,
            ]
        )

        static let withResponseData = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .https(),
                stubs: [Stub.Examples.text.value],
                recordRequests: true,
                numberOfRequests: 1,
                requests: [Imposter.RecordedRequest(
                    method: .get,
                    path: "/test-path",
                    requestFrom: "127.0.0.1",
                    ip: "127.0.0.1",
                    timestamp: Date(timeIntervalSince1970: 1702066146.263)
                )]
            ),
            json: [
                "port": 19190,
                "protocol": "https",
                "allowCORS": false,
                "stubs": [Stub.Examples.text.json],
                "recordRequests": true,
                "numberOfRequests": 1,
                "requests": [
                    [
                        "method": "GET",
                        "path": "/test-path",
                        "requestFrom": "127.0.0.1",
                        "ip": "127.0.0.1",
                        "timestamp": "2023-12-08T20:09:06.263Z",
                    ],
                ],
            ]
        )

        static let withExtraOptionsHttp = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http(allowCORS: true),
                stubs: [],
                recordRequests: false,
                numberOfRequests: 0,
                requests: []
            ),
            json: [
                "port": 19190,
                "protocol": "http",
                "allowCORS": true,
                "stubs": [],
                "numberOfRequests": 0,
                "requests": [],
                "recordRequests": false,
            ]
        )

        static let withExtraOptionsHttps = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .https(
                    allowCORS: true,
                    rejectUnauthorized: true,
                    certificateAuthority: ExampleCert.certificateAuthority,
                    key: ExampleCert.privateKey,
                    certificate: ExampleCert.certificate,
                    mutualAuth: false,
                    ciphers: "TLS_AES_256_GCM_SHA384"
                ),
                stubs: [],
                recordRequests: true,
                numberOfRequests: 1,
                requests: []
            ),
            json: [
                "port": 19190,
                "protocol": "https",
                "allowCORS": true,
                "rejectUnauthorized": true,
                "ca": .string(ExampleCert.certificateAuthority),
                "key": .string(ExampleCert.privateKey),
                "cert": .string(ExampleCert.certificate),
                "mutualAuth": false,
                "ciphers": "TLS_AES_256_GCM_SHA384",
                "stubs": [],
                "recordRequests": true,
                "numberOfRequests": 1,
                "requests": [],
            ]
        )

        static let includingAllStubs = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .http(allowCORS: nil),
                name: "Single stub",
                stubs: Stub.Examples.all.map(\.value),
                defaultResponse: Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "http",
                "allowCORS": nil,
                "name": "Single stub",
                "stubs": .array(Stub.Examples.all.map(\.json)),
                "defaultResponse": ["statusCode": 403],
                "recordRequests": true,
            ]
        )

        static let simpleRecordRequests = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .http(),
                stubs: [Stub.Examples.text.value],
                recordRequests: true
            ),
            json: [
                "port": 19190,
                "allowCORS": false,
                "protocol": "http",
                "stubs": [Stub.Examples.text.json],
                "recordRequests": true,
            ]
        )
    }

}
