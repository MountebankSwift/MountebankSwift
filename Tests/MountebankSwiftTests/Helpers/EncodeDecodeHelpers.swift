import Foundation
import XCTest

enum DecodeError: Error {
    case unableToDecodeStringToData
}

let testEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
    return encoder
}()

let testDecoder = JSONDecoder()

func assertEncodeDecode<CodableEquatableType: Codable & Equatable>(
    _ value: CodableEquatableType,
    file: StaticString = #file,
    line: UInt = #line
) throws {
    let data = try testEncoder.encode(value)
    XCTAssertNotNil(data, file: file, line: line)
    let decoded = try testDecoder.decode(CodableEquatableType.self, from: data)
    XCTAssertEqual(value, decoded, file: file, line: line)
}

func assertDecodeEncode<CodableEquatableType: Codable & Equatable>(
    _ value: String,
    as type: CodableEquatableType.Type,
    file: StaticString = #file,
    line: UInt = #line
) throws {
    guard let stringData = value.data(using: .utf8) else {
        XCTFail("Could not encode string to Data")
        return
    }

    let decoded = try testDecoder.decode(type, from: stringData)
    XCTAssertNotNil(decoded, file: file, line: line)
    let data = try testEncoder.encode(value)
    let string = String(data: data, encoding: .utf8)
    XCTAssertEqual(string, value, file: file, line: line)
}
