import MountebankSwiftModels
@testable import MountebankExampleData
import XCTest

final class PredicateGeneratorTests: XCTestCase {
    func testSimple() throws {
        try assertEncode(
            PredicateGenerator.Examples.simple.value,
            PredicateGenerator.Examples.simple.json
        )
        try assertDecode(
            PredicateGenerator.Examples.simple.json,
            PredicateGenerator.Examples.simple.value
        )
    }

    func testNestedFields() throws {
        try assertEncode(
            PredicateGenerator.Examples.nestedFields.value,
            PredicateGenerator.Examples.nestedFields.json
        )
        try assertDecode(
            PredicateGenerator.Examples.nestedFields.json,
            PredicateGenerator.Examples.nestedFields.value
        )
    }

    func testAdvanced() throws {
        try assertEncode(
            PredicateGenerator.Examples.advanced.value,
            PredicateGenerator.Examples.advanced.json
        )
        try assertDecode(
            PredicateGenerator.Examples.advanced.json,
            PredicateGenerator.Examples.advanced.value
        )
    }

    func testJsonPath() throws {
        try assertEncode(
            PredicateGenerator.Examples.jsonPath.value,
            PredicateGenerator.Examples.jsonPath.json
        )
        try assertDecode(
            PredicateGenerator.Examples.jsonPath.json,
            PredicateGenerator.Examples.jsonPath.value
        )
    }

    func testXPath() throws {
        try assertEncode(
            PredicateGenerator.Examples.xPath.value,
            PredicateGenerator.Examples.xPath.json
        )
        try assertDecode(
            PredicateGenerator.Examples.xPath.json,
            PredicateGenerator.Examples.xPath.value
        )
    }

    func testInject() throws {
        try assertEncode(
            PredicateGenerator.Examples.inject.value,
            PredicateGenerator.Examples.inject.json
        )
        try assertDecode(
            PredicateGenerator.Examples.inject.json,
            PredicateGenerator.Examples.inject.value
        )
    }

    func testAdvancedProxy() throws {
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
