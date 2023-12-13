import Foundation
@testable import MountebankSwift

extension Logs {
    enum Examples {
        static let simple = Example(
            value: Logs(logs: [
                Logs.Log.Examples.warning.value,
                Logs.Log.Examples.info.value,
            ]),
            json: [
                "logs": [
                    Logs.Log.Examples.warning.json,
                    Logs.Log.Examples.info.json,
                ],
            ]
        )

        static let withDate = Example(
            value: Logs(logs: [
                Logs.Log.Examples.withDate.value,
            ]),
            json: [
                "logs": [
                    Logs.Log.Examples.withDate.json,
                ],
            ]
        )
    }
}

extension Logs.Log {
    enum Examples {
        static let warning = Example(
            value: Logs.Log(
                level: .warn,
                message: "This a warning log statement",
                timestamp: nil
            ),
            json: [
                "level": "warn",
                "message": "This a warning log statement",
            ]
        )

        static let info = Example(
            value: Logs.Log(
                level: .info,
                message: "This a info log statement",
                timestamp: nil
            ),
            json: [
                "level": "info",
                "message": "This a info log statement",
            ]
        )

        static let withDate = Example(
            value: Logs.Log(
                level: .info,
                message: "This a info log statement with a date.",
                timestamp: Date(timeIntervalSince1970: 1702066146.263)
            ),
            json: [
                "level": "info",
                "message": "This a info log statement with a date.",
                "timestamp": "2023-12-08T20:09:06.263Z",
            ]
        )
    }
}
