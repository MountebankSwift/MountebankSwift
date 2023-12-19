import MountebankSwift

import XCTest

final class ImposterRecordedRequestTests: XCTestCase {
    func testSimpleText() throws {
        try assertEncode(
            Imposter.RecordedRequest.Examples.simple.value,
            Imposter.RecordedRequest.Examples.simple.json
        )
        try assertDecode(
            Imposter.RecordedRequest.Examples.simple.json,
            Imposter.RecordedRequest.Examples.simple.value
        )
    }

    func testAdvancedText() throws {
        try assertEncode(
            Imposter.RecordedRequest.Examples.advanced.value,
            Imposter.RecordedRequest.Examples.advanced.json
        )
        try assertDecode(
            Imposter.RecordedRequest.Examples.advanced.json,
            Imposter.RecordedRequest.Examples.advanced.value
        )
    }

}
