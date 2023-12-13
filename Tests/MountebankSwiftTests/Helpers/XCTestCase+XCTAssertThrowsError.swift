import Foundation
import XCTest

extension XCTestCase {

    func XCTAssertThrowsError<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail(message())
        } catch {
            errorHandler(error)
        }
    }
}
