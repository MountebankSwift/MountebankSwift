import MountebankSwiftModels
import XCTest
@testable import MountebankExampleData

final class PredicateParametersTests: XCTestCase {
    func testCaseSensitive() throws {
        try assertEncode(
            PredicateParameters.Examples.caseSensiteve.value,
            PredicateParameters.Examples.caseSensiteve.json
        )
        try assertDecode(
            PredicateParameters.Examples.caseSensiteve.json,
            PredicateParameters.Examples.caseSensiteve.value
        )
    }

    func testExcept() throws {
        try assertEncode(
            PredicateParameters.Examples.except.value,
            PredicateParameters.Examples.except.json
        )
        try assertDecode(
            PredicateParameters.Examples.except.json,
            PredicateParameters.Examples.except.value
        )
    }

    func testXPath() throws {
        try assertEncode(
            PredicateParameters.Examples.xPath.value,
            PredicateParameters.Examples.xPath.json
        )
        try assertDecode(
            PredicateParameters.Examples.xPath.json,
            PredicateParameters.Examples.xPath.value
        )
    }

    func testJSONPath() throws {
        try assertEncode(
            PredicateParameters.Examples.jsonPath.value,
            PredicateParameters.Examples.jsonPath.json
        )
        try assertDecode(
            PredicateParameters.Examples.jsonPath.json,
            PredicateParameters.Examples.jsonPath.value
        )
    }

    func testFull() throws {
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
