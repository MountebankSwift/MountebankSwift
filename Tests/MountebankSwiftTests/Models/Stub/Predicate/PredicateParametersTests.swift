import MountebankSwift

import Testing

@Suite
struct PredicateParametersTests {

    @Test
    func caseSensitive() throws {
        try assertEncode(
            PredicateParameters.Examples.caseSensiteve.value,
            PredicateParameters.Examples.caseSensiteve.json
        )
        try assertDecode(
            PredicateParameters.Examples.caseSensiteve.json,
            PredicateParameters.Examples.caseSensiteve.value
        )
    }

    @Test
    func except() throws {
        try assertEncode(
            PredicateParameters.Examples.except.value,
            PredicateParameters.Examples.except.json
        )
        try assertDecode(
            PredicateParameters.Examples.except.json,
            PredicateParameters.Examples.except.value
        )
    }

    @Test
    func xPath() throws {
        try assertEncode(
            PredicateParameters.Examples.xPath.value,
            PredicateParameters.Examples.xPath.json
        )
        try assertDecode(
            PredicateParameters.Examples.xPath.json,
            PredicateParameters.Examples.xPath.value
        )
    }

    @Test
    func jsonPath() throws {
        try assertEncode(
            PredicateParameters.Examples.jsonPath.value,
            PredicateParameters.Examples.jsonPath.json
        )
        try assertDecode(
            PredicateParameters.Examples.jsonPath.json,
            PredicateParameters.Examples.jsonPath.value
        )
    }

    @Test
    func full() throws {
        try assertEncode(
            PredicateParameters.Examples.full.value,
            PredicateParameters.Examples.full.json
        )
        try assertDecode(
            PredicateParameters.Examples.full.json,
            PredicateParameters.Examples.full.value
        )
    }
}
