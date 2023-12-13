import MountebankSwift
import XCTest

extension Imposter {
    enum Examples {
        static let simple = Example(
            value: Imposter(
                port: 19190,
                networkProtocol: .https,
                stubs: [Stub.Examples.text.value]
            ),
            json: [
                "port": 19190,
                "protocol": "https",
                "stubs": [Stub.Examples.text.json],
            ]
        )

        static let json = Example(
            value: Imposter(
                port: 100,
                networkProtocol: .http,
                stubs: [Stub.Examples.json.value]
            ),
            json: [
                "port": 100,
                "protocol": "http",
                "stubs": [Stub.Examples.json.json],
            ]
        )

        static let advanced = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .https,
                name: "Single stub",
                stubs: [
                    Stub.Examples.text.value,
                    Stub.Examples.json.value,
                    Stub.Examples.http404.value,
                ],
                defaultResponse: Stub.Response.Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "https",
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

        static let includingAllStubs = Example(
            value: Imposter(
                port: 8080,
                networkProtocol: .https,
                name: "Single stub",
                stubs: Stub.Examples.all.map(\.value),
                defaultResponse: Stub.Response.Is(statusCode: 403),
                recordRequests: true
            ),
            json: [
                "port": 8080,
                "protocol": "https",
                "name": "Single stub",
                "stubs": .array(Stub.Examples.all.map(\.json)),
                "defaultResponse": ["statusCode": 403],
                "recordRequests": true,
            ]
        )
    }
}
