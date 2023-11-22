import MountebankSwift
import XCTest

extension Imposter {
    enum Examples {
        static let simple = Example(
            value: Imposter(
                networkProtocol: .https,
                stubs: [Stub.Examples.text.value]
            ),
            json: [
                "protocol": "https",
                "stubs": [Stub.Examples.text.json]
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
                "recordRequests": true
            ]
        )
    }
}
