import Foundation
import Testing
@testable import MountebankSwift

@Suite
struct DateFormatterTests {

    @Test
    func fromAndToDate() throws {
        let sut = MountebankSwift.DateFormatter()

        let dateString = "2023-12-08T20:09:06.263Z"
        let dateObject = Date(timeIntervalSince1970: 1702066146.263)

        #expect(try sut.formatToDate(dateString) == dateObject)
        #expect(sut.formatFromDate(dateObject) == dateString)
    }
}
