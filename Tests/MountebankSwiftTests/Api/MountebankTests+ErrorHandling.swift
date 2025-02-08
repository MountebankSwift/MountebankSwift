import Foundation
import XCTest
@testable import MountebankSwift
import MountebankSwiftModels
@testable import MountebankExampleData

extension MountebankTests {
    func testGetAllImposterRemoteError() async throws {
        let mountebankErrors = MountebankErrors.Examples.single
        let mountebankErrorsData = try makeDataFromJSON(mountebankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mountebankErrorsData, statusCode: .badRequest)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.remoteError(mountebankErrors.value)
        )
    }

    func testInvalidResponseGetAllImposter() async throws {
        let mountebankErrors = MountebankErrors.Examples.single
        let mountebankErrorsData = try makeDataFromJSON(mountebankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mountebankErrorsData, statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidErrorMapping() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("[]".utf8), statusCode: .internalServerError)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidResponseFromInvalidStringGetAllImposter() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("invalid".utf8), statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.invalidResponseData
        )
    }

    // MARK: - Helper functions

    private func assertErrorOnGetAllImposters(
        mountebankError: MountebankValidationError,
        line: UInt = #line,
        file: StaticString = #filePath
    ) async throws {
        await XCTAssertThrowsErrorAsync(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                mountebankError,
                file: file,
                line: line
            )
        }
    }
}
