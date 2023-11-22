import Foundation
import XCTest
import MountebankSwift

enum DecodeError: Error {
    case unableToCreateUTF8StringFromData
}

let testEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
    return encoder
}()

let testDecoder = JSONDecoder()

func assertEncode<CodableEquatableType: Codable & Equatable>(
    _ value: CodableEquatableType,
    _ expectedResult: JSON,
    file: StaticString = #file,
    line: UInt = #line
) throws {
    let data = try testEncoder.encode(value)
    guard let valueJSONString = String(bytes: data, encoding: .utf8) else {
        throw DecodeError.unableToCreateUTF8StringFromData
    }
    let jsonData = try testEncoder.encode(expectedResult)
    guard let expectedJSONString = String(bytes: jsonData, encoding: .utf8) else {
        throw DecodeError.unableToCreateUTF8StringFromData
    }
    XCTAssertEqual(
        valueJSONString,
        expectedJSONString,
        file: file,
        line: line
    )
}

func assertDecode<CodableEquatableType: Codable & Equatable>(
    _ value: JSON,
    _ expectedResult: CodableEquatableType,
    file: StaticString = #file,
    line: UInt = #line
) throws {
    let jsonData = try testEncoder.encode(value)
    let result = try testDecoder.decode(CodableEquatableType.self, from: jsonData)
    XCTAssertEqual(
        result,
        expectedResult,
        file: file,
        line: line
    )
}
