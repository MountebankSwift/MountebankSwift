import Foundation
import XCTest
@testable import MountebankSwift

extension MountebankTests {
    func testGetAllImposterRemoteError() async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .badRequest)

        try await assertErrorOnGetAllImposters(
            mounteBankError: MountebankValidationError.remoteError(mounteBankErrors.value)
        )
    }

    func testInvalidResponseGetAllImposter() async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidErrorMapping() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("[]".utf8), statusCode: .internalServerError)

        try await assertErrorOnGetAllImposters(
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidResponseFromInvalidStringGetAllImposter() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("invalid".utf8), statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    // MARK: - Helper functions

    private func assertErrorOnGetAllImposters(
        mounteBankError: MountebankValidationError,
        line: UInt = #line,
        file: StaticString = #filePath
    ) async throws {
        await XCTAssertThrowsErrorAsync(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                mounteBankError,
                file: file,
                line: line
            )
        }
    }
}
