import Foundation
import XCTest
@testable import MountebankSwift
@testable import MountebankSwiftModels

class DateFormatterTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var sut: MountebankSwiftModels.DateFormatter!

    override func setUp() async throws {
        sut = DateFormatter()
    }

    func testFromAndToDate() throws {
        let dateString = "2023-12-08T20:09:06.263Z"
        let dateObject = Date(timeIntervalSince1970: 1702066146.263)

        XCTAssertEqual(try sut.formatToDate(dateString), dateObject)
        XCTAssertEqual(sut.formatFromDate(dateObject), dateString)
    }
}
