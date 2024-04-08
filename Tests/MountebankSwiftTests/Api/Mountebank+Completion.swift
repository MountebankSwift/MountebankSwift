import Foundation
import XCTest
@testable import MountebankSwift

extension MountebankTests {

    func testGetImposterCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.simple
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.getImposter(port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }
            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(
            httpClientSpy.httpRequestReceivedRequest,
            HTTPRequest(
                url: Endpoint
                    .getImposter(
                        port: port,
                        parameters: ImposterParameters(replayable: false, removeProxies: false)
                    )
                    .makeEndpointUrl(baseUrl: sut.mountebankURL),
                method: .get,
                headers: [HTTPHeaders.contentType: MimeType.json.rawValue]
            )
        )
    }

    func testGetAllImposterCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        sut.getAllImposters { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposters.value.imposters, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }
            completionExpectation.fulfill()

        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testGetAllImposterRemoteErrorCompletion() throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .badRequest)

        sut.getAllImposters { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertEqual(
                    error as? MountebankValidationError,
                    MountebankValidationError.remoteError(mounteBankErrors.value)
                )
            }
        }
    }

    func testPostImposterCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.simple
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.postImposter(imposter: imposter.value) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }
        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImpostersCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        sut.putImposters(imposters: imposters.value.imposters) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposters.value.imposters, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }
            completionExpectation.fulfill()
        }
        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPostImposterStubCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let stub = Stub.Examples.json
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.postImposterStub(stub: stub.value, port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteImposterCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.deleteImposter(port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }
            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteAllImpostersCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        sut.deleteAllImposters { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposters.value.imposters, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImposterStubsCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.putImposterStubs(stubs: imposter.value.stubs, port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }
            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteStubCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.deleteStub(port: port, stubIndex: 0) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImposterStubCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let stub = try XCTUnwrap(imposter.value.stubs.last)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.putImposterStub(stub: stub, port: port, stubIndex: 0) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteSavedProxyResponsesCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.deleteSavedProxyResponses(port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteSavedRequestsCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        sut.deleteSavedRequests(port: port) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(imposter.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testGetConfigCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let config = Config.Examples.simple
        let configData = try makeDataFromJSON(config.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: configData, statusCode: .accepted)

        sut.getConfig { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(config.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }

        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testGetLogsCompletion() throws {
        let completionExpectation = expectation(description: "Expects completion")
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        sut.getLogs { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(logs.value, success)
            case .failure(let error):
                XCTFail("Did expect success but recieved \(error.localizedDescription)")
            }

            completionExpectation.fulfill()
        }
        wait(for: [completionExpectation], timeout: 1)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    private func makeDataFromJSON(_ json: JSON) throws -> Data {
        try testEncoder.encode(json)
    }
}
