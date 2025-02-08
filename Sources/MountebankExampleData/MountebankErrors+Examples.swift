import XCTest
@testable import MountebankSwift
@testable import MountebankSwiftModels

extension MountebankErrors {
    enum Examples {
        static let single = Example(
            value: MountebankErrors(errors: [MountebankErrors.MountebankError.Examples.simple.value]),
            json: [
                "errors": [
                    MountebankErrors.MountebankError.Examples.simple.json,
                ],
            ]
        )

        static let multiple = Example(
            value: MountebankErrors(errors: [
                MountebankErrors.MountebankError.Examples.simple.value,
                MountebankErrors.MountebankError.Examples.advanced.value,
            ]),
            json: [
                "errors": [
                    MountebankErrors.MountebankError.Examples.simple.json,
                    MountebankErrors.MountebankError.Examples.advanced.json,
                ],
            ]
        )
    }
}

extension MountebankErrors.MountebankError {
    enum Examples {
        static let simple = Example(
            value: MountebankErrors.MountebankError(code: "SIG", message: "Hello", errno: nil, syscall: nil),
            json: [
                "code": "SIG",
                "message": "Hello",
            ]
        )

        static let advanced = Example(
            value: MountebankErrors.MountebankError(code: "SIG", message: "Hello", errno: -102, syscall: "bash"),
            json: [
                "code": "SIG",
                "message": "Hello",
                "errno": -102,
                "syscall": "bash",
            ]
        )
    }
}
