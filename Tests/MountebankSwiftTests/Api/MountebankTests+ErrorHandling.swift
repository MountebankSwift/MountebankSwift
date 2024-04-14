import Foundation
import XCTest
@testable import MountebankSwift

extension MountebankTests {
    func testGetAllImposterRemoteErrorAsync() async throws {
        try await testGetAllImposterRemoteError(runAsync: true)
    }

    func testGetAllImposterRemoteErrorCompletion() async throws {
        try await testGetAllImposterRemoteError(runAsync: false)
    }

    func testGetAllImposterRemoteError(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .badRequest)

        try await assertErrorOnGetAllImposters(
            runAsync: runAsync,
            mounteBankError: MountebankValidationError.remoteError(mounteBankErrors.value)
        )
    }

    func testInvalidResponseGetAllImposterAsync() async throws {
        try await testInvalidResponseGetAllImposter(runAsync: true)
    }

    func testInvalidResponseGetAllImposterCompletion() async throws {
        try await testInvalidResponseGetAllImposter(runAsync: false)
    }

    func testInvalidResponseGetAllImposter(
        runAsync: Bool,
        line: UInt = #line,
        file: StaticString = #file
    ) async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            runAsync: runAsync,
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidErrorMappingAsync() async throws {
        try await testInvalidErrorMapping(runAsync: true)
    }

    func testInvalidErrorMappingCompletion() async throws {
        try await testInvalidErrorMapping(runAsync: false)
    }

    func testInvalidErrorMapping(
        runAsync: Bool,
        line: UInt = #line,
        file: StaticString = #file
    ) async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("[]".utf8), statusCode: .internalServerError)

        try await assertErrorOnGetAllImposters(
            runAsync: runAsync,
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    func testInvalidResponseFromInvalidStringGetAllImposterAsync() async throws {
        try await testInvalidResponseFromInvalidStringGetAllImposter(runAsync: true)
    }

    func testInvalidResponseFromInvalidStringGetAllImposterCompletion() async throws {
        try await testInvalidResponseFromInvalidStringGetAllImposter(runAsync: false)
    }

    func testInvalidResponseFromInvalidStringGetAllImposter(
        runAsync: Bool,
        line: UInt = #line,
        file: StaticString = #file
    ) async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("invalid".utf8), statusCode: .accepted)

        try await assertErrorOnGetAllImposters(
            runAsync: runAsync,
            mounteBankError: MountebankValidationError.invalidResponseData
        )
    }

    // MARK: - Helper functions

    private func assertErrorOnGetAllImposters(
        runAsync: Bool,
        mounteBankError: MountebankValidationError,
        line: UInt = #line,
        file: StaticString = #file
    ) async throws {
        let assertResult = { (error: Error) in
            XCTAssertEqual(
                error as? MountebankValidationError,
                mounteBankError,
                file: file,
                line: line
            )
        }

        if runAsync {
            await XCTAssertThrowsErrorAsync(try await sut.getAllImposters()) { error in
                assertResult(error)
            }
        } else {
            let completionExpectation = expectation(description: "Expects completion fulfillmemt")
            sut.getAllImposters { result in
                switch result {
                case .success(let success):
                    XCTFail("Did expect failure but recieved success: \(success)")
                case .failure(let error):
                    assertResult(error)
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }
    }
}
