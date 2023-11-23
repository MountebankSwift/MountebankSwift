import MountebankSwift

import XCTest

final class StubPredicateParametersTests: XCTestCase {
    func testCaseSensitive() throws {
        try assertEncode(
            Stub.Predicate.Parameters.Examples.caseSensiteve.value,
            Stub.Predicate.Parameters.Examples.caseSensiteve.json
        )
        try assertDecode(
            Stub.Predicate.Parameters.Examples.caseSensiteve.json,
            Stub.Predicate.Parameters.Examples.caseSensiteve.value
        )
    }

    func testExcept() throws {
        try assertEncode(
            Stub.Predicate.Parameters.Examples.except.value,
            Stub.Predicate.Parameters.Examples.except.json
        )
        try assertDecode(
            Stub.Predicate.Parameters.Examples.except.json,
            Stub.Predicate.Parameters.Examples.except.value
        )
    }

    func testXPath() throws {
        try assertEncode(
            Stub.Predicate.Parameters.Examples.xPath.value,
            Stub.Predicate.Parameters.Examples.xPath.json
        )
        try assertDecode(
            Stub.Predicate.Parameters.Examples.xPath.json,
            Stub.Predicate.Parameters.Examples.xPath.value
        )
    }

    func testJSONPath() throws {
        try assertEncode(
            Stub.Predicate.Parameters.Examples.jsonPath.value,
            Stub.Predicate.Parameters.Examples.jsonPath.json
        )
        try assertDecode(
            Stub.Predicate.Parameters.Examples.jsonPath.json,
            Stub.Predicate.Parameters.Examples.jsonPath.value
        )
    }

    func testFull() throws {
        try assertEncode(
            Stub.Predicate.Parameters.Examples.full.value,
            Stub.Predicate.Parameters.Examples.full.json
        )
        try assertDecode(
            Stub.Predicate.Parameters.Examples.full.json,
            Stub.Predicate.Parameters.Examples.full.value
        )
    }
}
