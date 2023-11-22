import MountebankSwift

import XCTest

final class StubPredicateParametersTests: XCTestCase {
    func testAll() throws {
        try assertEncode(
            Stub.Predicate.Parameters(caseSensitive: true, except: "^The "),
            ["except": "^The ", "caseSensitive": true]
        )
    }

    func testCaseSensitive() throws {
        try assertEncode(
            Stub.Predicate.Parameters(caseSensitive: true),
            ["caseSensitive": true]
        )

        try assertEncode(
            Stub.Predicate.Parameters(caseSensitive: false),
            ["caseSensitive": false]
        )
    }

    func testExcept() throws {
        try assertEncode(
            Stub.Predicate.Parameters(except: "^Foo "),
            ["except": "^Foo "]
        )
    }
}
