import MountebankSwift

import XCTest

final class StubPredicateTests: XCTestCase {
    func testEquals() throws {
        try assertEncode(
            Stub.Predicate.Examples.equals.value,
            Stub.Predicate.Examples.equals.json
        )
        try assertDecode(
            Stub.Predicate.Examples.equals.json,
            Stub.Predicate.Examples.equals.value
        )
    }
    
    func testDeepEquals() throws {
        try assertEncode(
            Stub.Predicate.Examples.deepEquals.value,
            Stub.Predicate.Examples.deepEquals.json
        )
        try assertDecode(
            Stub.Predicate.Examples.deepEquals.json,
            Stub.Predicate.Examples.deepEquals.value
        )
    }
    
    func testContains() throws {
        try assertEncode(
            Stub.Predicate.Examples.contains.value,
            Stub.Predicate.Examples.contains.json
        )
        try assertDecode(
            Stub.Predicate.Examples.contains.json,
            Stub.Predicate.Examples.contains.value
        )
    }
    
    func testStartsWith() throws {
        try assertEncode(
            Stub.Predicate.Examples.startsWith.value,
            Stub.Predicate.Examples.startsWith.json
        )
        try assertDecode(
            Stub.Predicate.Examples.startsWith.json,
            Stub.Predicate.Examples.startsWith.value
        )
    }
    
    func testEndsWith() throws {
        try assertEncode(
            Stub.Predicate.Examples.endsWith.value,
            Stub.Predicate.Examples.endsWith.json
        )
        try assertDecode(
            Stub.Predicate.Examples.endsWith.json,
            Stub.Predicate.Examples.endsWith.value
        )
    }
    
    func testMatches() throws {
        try assertEncode(
            Stub.Predicate.Examples.matches.value,
            Stub.Predicate.Examples.matches.json
        )
        try assertDecode(
            Stub.Predicate.Examples.matches.json,
            Stub.Predicate.Examples.matches.value
        )
    }
    
    func testExists() throws {
        try assertEncode(
            Stub.Predicate.Examples.exists.value,
            Stub.Predicate.Examples.exists.json
        )
        try assertDecode(
            Stub.Predicate.Examples.exists.json,
            Stub.Predicate.Examples.exists.value
        )
    }
    
    func testNot() throws {
        try assertEncode(
            Stub.Predicate.Examples.not.value,
            Stub.Predicate.Examples.not.json
        )
        try assertDecode(
            Stub.Predicate.Examples.not.json,
            Stub.Predicate.Examples.not.value
        )
    }
    
    func testOr() throws {
        try assertEncode(
            Stub.Predicate.Examples.or.value,
            Stub.Predicate.Examples.or.json
        )
        try assertDecode(
            Stub.Predicate.Examples.or.json,
            Stub.Predicate.Examples.or.value
        )
    }
    
    func testAnd() throws {
        try assertEncode(
            Stub.Predicate.Examples.and.value,
            Stub.Predicate.Examples.and.json
        )
        try assertDecode(
            Stub.Predicate.Examples.and.json,
            Stub.Predicate.Examples.and.value
        )
    }
    
    func testInject() throws {
        try assertEncode(
            Stub.Predicate.Examples.inject.value,
            Stub.Predicate.Examples.inject.json
        )
        try assertDecode(
            Stub.Predicate.Examples.inject.json,
            Stub.Predicate.Examples.inject.value
        )
    }

    func testWithParameters() throws {
        try assertEncode(
            Stub.Predicate.Examples.withParameters.value,
            Stub.Predicate.Examples.withParameters.json
        )
        try assertDecode(
            Stub.Predicate.Examples.withParameters.json,
            Stub.Predicate.Examples.withParameters.value
        )
    }
}
