import MountebankSwiftModels
@testable import MountebankExampleData

import XCTest

final class PredicateTests: XCTestCase {
    func testEquals() throws {
        try assertEncode(
            Predicate.Examples.equals.value,
            Predicate.Examples.equals.json
        )
        try assertDecode(
            Predicate.Examples.equals.json,
            Predicate.Examples.equals.value
        )
    }

    func testDeepEquals() throws {
        try assertEncode(
            Predicate.Examples.deepEquals.value,
            Predicate.Examples.deepEquals.json
        )
        try assertDecode(
            Predicate.Examples.deepEquals.json,
            Predicate.Examples.deepEquals.value
        )
    }

    func testContains() throws {
        try assertEncode(
            Predicate.Examples.contains.value,
            Predicate.Examples.contains.json
        )
        try assertDecode(
            Predicate.Examples.contains.json,
            Predicate.Examples.contains.value
        )
    }

    func testStartsWith() throws {
        try assertEncode(
            Predicate.Examples.startsWith.value,
            Predicate.Examples.startsWith.json
        )
        try assertDecode(
            Predicate.Examples.startsWith.json,
            Predicate.Examples.startsWith.value
        )
    }

    func testEndsWith() throws {
        try assertEncode(
            Predicate.Examples.endsWith.value,
            Predicate.Examples.endsWith.json
        )
        try assertDecode(
            Predicate.Examples.endsWith.json,
            Predicate.Examples.endsWith.value
        )
    }

    func testMatches() throws {
        try assertEncode(
            Predicate.Examples.matches.value,
            Predicate.Examples.matches.json
        )
        try assertDecode(
            Predicate.Examples.matches.json,
            Predicate.Examples.matches.value
        )
    }

    func testExists() throws {
        try assertEncode(
            Predicate.Examples.exists.value,
            Predicate.Examples.exists.json
        )
        try assertDecode(
            Predicate.Examples.exists.json,
            Predicate.Examples.exists.value
        )
    }

    func testNot() throws {
        try assertEncode(
            Predicate.Examples.not.value,
            Predicate.Examples.not.json
        )
        try assertDecode(
            Predicate.Examples.not.json,
            Predicate.Examples.not.value
        )
    }

    func testOr() throws {
        try assertEncode(
            Predicate.Examples.or.value,
            Predicate.Examples.or.json
        )
        try assertDecode(
            Predicate.Examples.or.json,
            Predicate.Examples.or.value
        )
    }

    func testAnd() throws {
        try assertEncode(
            Predicate.Examples.and.value,
            Predicate.Examples.and.json
        )
        try assertDecode(
            Predicate.Examples.and.json,
            Predicate.Examples.and.value
        )
    }

    func testInject() throws {
        try assertEncode(
            Predicate.Examples.inject.value,
            Predicate.Examples.inject.json
        )
        try assertDecode(
            Predicate.Examples.inject.json,
            Predicate.Examples.inject.value
        )
    }

    func testWithParameters() throws {
        try assertEncode(
            Predicate.Examples.withParameters.value,
            Predicate.Examples.withParameters.json
        )
        try assertDecode(
            Predicate.Examples.withParameters.json,
            Predicate.Examples.withParameters.value
        )
    }

    func testEqualsRequest() throws {
        XCTAssertEqual(
            Predicate.equals(
                Request(
                    method: .put,
                    path: "/test",
                    query: ["key": ["first", "second"]],
                    headers: ["foo": "bar"],
                    data: ["baz"]
                )
            ),
            .equalsRequest(
                method: .put,
                path: "/test",
                query: ["key": ["first", "second"]],
                headers: ["foo": "bar"],
                data: ["baz"]
            )
        )
    }
}
