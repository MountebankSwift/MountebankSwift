import MountebankSwift

import Testing

@Suite
struct PredicateGeneratorTests {

    @Test
    func simple() throws {
        try assertEncode(
            PredicateGenerator.Examples.simple.value,
            PredicateGenerator.Examples.simple.json
        )
        try assertDecode(
            PredicateGenerator.Examples.simple.json,
            PredicateGenerator.Examples.simple.value
        )
    }

    @Test
    func nestedFields() throws {
        try assertEncode(
            PredicateGenerator.Examples.nestedFields.value,
            PredicateGenerator.Examples.nestedFields.json
        )
        try assertDecode(
            PredicateGenerator.Examples.nestedFields.json,
            PredicateGenerator.Examples.nestedFields.value
        )
    }

    @Test
    func advanced() throws {
        try assertEncode(
            PredicateGenerator.Examples.advanced.value,
            PredicateGenerator.Examples.advanced.json
        )
        try assertDecode(
            PredicateGenerator.Examples.advanced.json,
            PredicateGenerator.Examples.advanced.value
        )
    }

    @Test
    func jsonPath() throws {
        try assertEncode(
            PredicateGenerator.Examples.jsonPath.value,
            PredicateGenerator.Examples.jsonPath.json
        )
        try assertDecode(
            PredicateGenerator.Examples.jsonPath.json,
            PredicateGenerator.Examples.jsonPath.value
        )
    }

    @Test
    func xPath() throws {
        try assertEncode(
            PredicateGenerator.Examples.xPath.value,
            PredicateGenerator.Examples.xPath.json
        )
        try assertDecode(
            PredicateGenerator.Examples.xPath.json,
            PredicateGenerator.Examples.xPath.value
        )
    }

    @Test
    func inject() throws {
        try assertEncode(
            PredicateGenerator.Examples.inject.value,
            PredicateGenerator.Examples.inject.json
        )
        try assertDecode(
            PredicateGenerator.Examples.inject.json,
            PredicateGenerator.Examples.inject.value
        )
    }

    @Test
    func advancedProxy() throws {
        try assertEncode(
            Proxy.Examples.advanced.value,
            Proxy.Examples.advanced.json
        )
        try assertDecode(
            Proxy.Examples.advanced.json,
            Proxy.Examples.advanced.value
        )
    }
}
