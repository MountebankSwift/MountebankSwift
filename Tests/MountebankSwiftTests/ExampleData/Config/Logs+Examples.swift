import Foundation
@testable import MountebankSwift

// MARK: - Logs.Log.Examples

extension Logs.Log {
    enum Examples {
        static let warning = Example(
            value: Logs.Log(
                level: .warn,
                message: "This a warning log statement",
                date: nil),
            json: [
                "level": "warn",
                "message": "This a warning log statement",
            ])

        static let info = Example(
            value: Logs.Log(
                level: .info,
                message: "This a info log statement",
                date: nil),
            json: [
                "level": "info",
                "message": "This a info log statement",
            ])
    }
}

// MARK: - Logs.Examples

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
            ])
    }
}
