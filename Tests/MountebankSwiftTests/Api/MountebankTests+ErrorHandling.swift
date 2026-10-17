import Foundation
import Testing
@testable import MountebankSwift

extension MountebankTests {

    @Test
    func getAllImposterRemoteError() async throws {
        let mountebankErrors = MountebankErrors.Examples.single
        let mountebankErrorsData = try makeDataFromJSON(mountebankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mountebankErrorsData, statusCode: .badRequest)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.remoteError(mountebankErrors.value)
        )
    }

    @Test
    func invalidResponseGetAllImposter() async throws {
        let mountebankErrors = MountebankErrors.Examples.single
        let mountebankErrorsData = try makeDataFromJSON(mountebankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mountebankErrorsData, statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.invalidResponseData
        )
    }

    @Test
    func invalidErrorMapping() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("[]".utf8), statusCode: .internalServerError)

        try await assertErrorOnGetAllImposters(
            mountebankError: MountebankValidationError.invalidResponseData
        )
    }

    @Test
    func invalidResponseFromInvalidStringGetAllImposter() async throws {
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
        await #expect(throws: mountebankError, performing: {
            try await sut.getAllImposters()
        })
    }
}
