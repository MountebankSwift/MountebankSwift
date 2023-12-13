import XCTest
@testable import MountebankSwift

extension Imposters {
    enum Examples {
        static let single = Example(
            value: Imposters(imposters: [
                ImposterRef(networkProtocol: .http, port: 3535),
            ]),
            json: [
                "imposters": [
                    [
                        "protocol": "http",
                        "port": 3535,
                    ],
                ],
            ]
        )
    }
}
