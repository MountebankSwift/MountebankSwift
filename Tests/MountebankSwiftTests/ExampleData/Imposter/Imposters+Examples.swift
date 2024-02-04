import XCTest
@testable import MountebankSwift

extension Imposters {
    enum Examples {
        static let single = Example(
            value: Imposters(imposters: [
                Imposter(port: 3535, networkProtocol: .http(allowCORS: nil), stubs: []),
            ]),
            json: [
                "imposters": [
                    [
                        "protocol": "http",
                        "port": 3535,
                        "stubs": [],
                    ],
                ],
            ]
        )
    }
}
