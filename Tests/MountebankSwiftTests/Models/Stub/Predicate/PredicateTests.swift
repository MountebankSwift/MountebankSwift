import MountebankSwift

import Testing

@Suite
struct PredicateTests {

    @Test
    func equals() throws {
        try assertEncode(
            Predicate.Examples.equals.value,
            Predicate.Examples.equals.json
        )
        try assertDecode(
            Predicate.Examples.equals.json,
            Predicate.Examples.equals.value
        )
    }

    @Test
    func deepEquals() throws {
        try assertEncode(
            Predicate.Examples.deepEquals.value,
            Predicate.Examples.deepEquals.json
        )
        try assertDecode(
            Predicate.Examples.deepEquals.json,
            Predicate.Examples.deepEquals.value
        )
    }

    @Test
    func contains() throws {
        try assertEncode(
            Predicate.Examples.contains.value,
            Predicate.Examples.contains.json
        )
        try assertDecode(
            Predicate.Examples.contains.json,
            Predicate.Examples.contains.value
        )
    }

    @Test
    func startsWith() throws {
        try assertEncode(
            Predicate.Examples.startsWith.value,
            Predicate.Examples.startsWith.json
        )
        try assertDecode(
            Predicate.Examples.startsWith.json,
            Predicate.Examples.startsWith.value
        )
    }

    @Test
    func endsWith() throws {
        try assertEncode(
            Predicate.Examples.endsWith.value,
            Predicate.Examples.endsWith.json
        )
        try assertDecode(
            Predicate.Examples.endsWith.json,
            Predicate.Examples.endsWith.value
        )
    }

    @Test
    func matches() throws {
        try assertEncode(
            Predicate.Examples.matches.value,
            Predicate.Examples.matches.json
        )
        try assertDecode(
            Predicate.Examples.matches.json,
            Predicate.Examples.matches.value
        )
    }

    @Test
    func exists() throws {
        try assertEncode(
            Predicate.Examples.exists.value,
            Predicate.Examples.exists.json
        )
        try assertDecode(
            Predicate.Examples.exists.json,
            Predicate.Examples.exists.value
        )
    }

    @Test
    func not() throws {
        try assertEncode(
            Predicate.Examples.not.value,
            Predicate.Examples.not.json
        )
        try assertDecode(
            Predicate.Examples.not.json,
            Predicate.Examples.not.value
        )
    }

    @Test
    func or() throws {
        try assertEncode(
            Predicate.Examples.or.value,
            Predicate.Examples.or.json
        )
        try assertDecode(
            Predicate.Examples.or.json,
            Predicate.Examples.or.value
        )
    }

    @Test
    func and() throws {
        try assertEncode(
            Predicate.Examples.and.value,
            Predicate.Examples.and.json
        )
        try assertDecode(
            Predicate.Examples.and.json,
            Predicate.Examples.and.value
        )
    }

    @Test
    func inject() throws {
        try assertEncode(
            Predicate.Examples.inject.value,
            Predicate.Examples.inject.json
        )
        try assertDecode(
            Predicate.Examples.inject.json,
            Predicate.Examples.inject.value
        )
    }

    @Test
    func withParameters() throws {
        try assertEncode(
            Predicate.Examples.withParameters.value,
            Predicate.Examples.withParameters.json
        )
        try assertDecode(
            Predicate.Examples.withParameters.json,
            Predicate.Examples.withParameters.value
        )
    }

    @Test
    func equalsRequest() throws {
        #expect(
            Predicate.equals(
                Request(
                    method: .put,
                    path: "/test",
                    query: ["key": ["first", "second"]],
                    headers: ["foo": "bar"],
                    data: ["baz"]
                )
            ) == .equalsRequest(
                method: .put,
                path: "/test",
                query: ["key": ["first", "second"]],
                headers: ["foo": "bar"],
                data: ["baz"]
            )
        )
    }
}
