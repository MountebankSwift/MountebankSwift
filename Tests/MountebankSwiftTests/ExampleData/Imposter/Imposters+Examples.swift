import XCTest
@testable import MountebankSwift

extension Imposters {
    enum Examples {
        static let single = Example(
            value: Imposters(imposters: [
                Imposter(port: 3535, networkProtocol: .http(), stubs: []),
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

        static let multiple = Example(
            value: Imposters(imposters: Imposter.Examples.all.map(\.value)),
            json: [
                "imposters": .array(Imposter.Examples.all.map(\.json)),
            ]
        )
    }
}
