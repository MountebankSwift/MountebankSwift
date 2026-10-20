import Foundation
import MountebankSwift
import Testing

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
    sourceLocation: SourceLocation = #_sourceLocation
) throws {
    let data = try testEncoder.encode(value)
    guard let valueJSONString = String(bytes: data, encoding: .utf8) else {
        throw DecodeError.unableToCreateUTF8StringFromData
    }
    let jsonData = try testEncoder.encode(expectedResult)
    guard let expectedJSONString = String(bytes: jsonData, encoding: .utf8) else {
        throw DecodeError.unableToCreateUTF8StringFromData
    }
    #expect(valueJSONString == expectedJSONString, sourceLocation: sourceLocation)
}

func assertDecode<CodableEquatableType: Codable & Equatable>(
    _ value: JSON,
    _ expectedResult: CodableEquatableType,
    sourceLocation: SourceLocation = #_sourceLocation
) throws {
    let jsonData = try testEncoder.encode(value)
    let result = try testDecoder.decode(CodableEquatableType.self, from: jsonData)
    #expect(result == expectedResult, sourceLocation: sourceLocation)
}
