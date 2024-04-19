import Foundation
import XCTest
@testable import MountebankSwift

class MountebankTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    var sut: Mountebank!
    var httpClientSpy: HttpClientSpy!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() async throws {
        httpClientSpy = HttpClientSpy()
        sut = Mountebank(host: .localhost, port: 2525, httpClient: httpClientSpy)
    }

    override func tearDown() async throws {
        httpClientSpy = nil
        sut = nil
    }

    func testGetImposterAsync() async throws {
        try await testGetImposter(runAsync: true)
    }

    func testGetImposterCompletion() async throws {
        try await testGetImposter(runAsync: false)
    }

    func testGetImposter(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.simple
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result, file: file, line: line)
        }

        if runAsync {
            assertResult(try await sut.getImposter(port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.getImposter(port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

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

    func testGetAllImposterAsync() async throws {
        try await testGetAllImposter(runAsync: true)
    }

    func testGetAllImposterCompletion() async throws {
        try await testGetAllImposter(runAsync: false)
    }

    func testGetAllImposter(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let assertResult = { (result: [Imposter]) in
            XCTAssertEqual(imposters.value.imposters, result, file: file, line: line)
        }

        if runAsync {
            assertResult(try await sut.getAllImposters())
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.getAllImposters { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testPostImposterAsync() async throws {
        try await testPostImposter(runAsync: true)
    }

    func testPostImposterCompletion() async throws {
        try await testPostImposter(runAsync: false)
    }

    func testPostImposter(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.simple
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.postImposter(imposter: imposter.value))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.postImposter(imposter: imposter.value) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImpostersAsync() async throws {
        try await testPutImposters(runAsync: true)
    }

    func testPutImpostersCompletion() async throws {
        try await testPutImposters(runAsync: false)
    }

    func testPutImposters(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let assertResult = { (result: [Imposter]) in
            XCTAssertEqual(imposters.value.imposters, result)
        }

        if runAsync {
            assertResult(try await sut.putImposters(imposters: imposters.value.imposters))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.putImposters(imposters: imposters.value.imposters) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPostImposterStubAsync() async throws {
        try await testPostImposterStub(runAsync: true)
    }

    func testPostImposterStubCompletion() async throws {
        try await testPostImposterStub(runAsync: false)
    }

    func testPostImposterStub(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let stub = Stub.Examples.json
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.postImposterStub(stub: stub.value, port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.postImposterStub(stub: stub.value, port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteImposterAsync() async throws {
        try await testDeleteImposter(runAsync: true)
    }

    func testDeleteImposterCompletion() async throws {
        try await testDeleteImposter(runAsync: false)
    }

    func testDeleteImposter(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.deleteImposter(port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.deleteImposter(port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteAllImpostersAsync() async throws {
        try await testDeleteAllImposters(runAsync: true)
    }

    func testDeleteAllImpostersCompletion() async throws {
        try await testDeleteAllImposters(runAsync: false)
    }

    func testDeleteAllImposters(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let assertResult = { (result: [Imposter]) in
            XCTAssertEqual(imposters.value.imposters, result)
        }

        if runAsync {
            assertResult(try await sut.deleteAllImposters())
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.deleteAllImposters { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testMakeImposterUrl() {
        let result = sut.makeImposterUrl(port: 1010)
        XCTAssertEqual(result, URL(string: "http://localhost:1010"))
    }

    func testPutImposterStubsAsync() async throws {
        try await testPutImposterStubs(runAsync: true)
    }

    func testPutImposterStubsCompletion() async throws {
        try await testPutImposterStubs(runAsync: false)
    }

    func testPutImposterStubs(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.putImposterStubs(stubs: imposter.value.stubs, port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.putImposterStubs(stubs: imposter.value.stubs, port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteStubAsync() async throws {
        try await testDeleteStub(runAsync: true)
    }

    func testDeleteStubCompletion() async throws {
        try await testDeleteStub(runAsync: false)
    }

    func testDeleteStub(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.deleteStub(port: port, stubIndex: 0))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.deleteStub(port: port, stubIndex: 0) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImposterStubAsync() async throws {
        try await testPutImposterStub(runAsync: true)
    }

    func testPutImposterStubCompletion() async throws {
        try await testPutImposterStub(runAsync: false)
    }

    func testPutImposterStub(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let stub = try XCTUnwrap(imposter.value.stubs.last)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.putImposterStub(stub: stub, port: port, stubIndex: 0))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.putImposterStub(stub: stub, port: port, stubIndex: 0) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteSavedProxyResponsesAsync() async throws {
        try await testDeleteSavedProxyResponses(runAsync: true)
    }

    func testDeleteSavedProxyResponsesCompletion() async throws {
        try await testDeleteSavedProxyResponses(runAsync: false)
    }

    func testDeleteSavedProxyResponses(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.deleteSavedProxyResponses(port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.deleteSavedProxyResponses(port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteSavedRequestsAsync() async throws {
        try await testDeleteSavedRequests(runAsync: true)
    }

    func testDeleteSavedRequestsCompletion() async throws {
        try await testDeleteSavedRequests(runAsync: false)
    }

    func testDeleteSavedRequests(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let assertResult = { (result: Imposter) in
            XCTAssertEqual(imposter.value, result)
        }

        if runAsync {
            assertResult(try await sut.deleteSavedRequests(port: port))
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.deleteSavedRequests(port: port) { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testGetConfigAsync() async throws {
        try await testGetConfig(runAsync: true)
    }

    func testGetConfigCompletion() async throws {
        try await testGetConfig(runAsync: false)
    }

    func testGetConfig(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let config = Config.Examples.simple
        let configData = try makeDataFromJSON(config.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: configData, statusCode: .accepted)

        let assertResult = { (result: Config) in
            XCTAssertEqual(config.value, result)
        }

        if runAsync {
            assertResult(try await sut.getConfig())
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.getConfig { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testGetLogsAsync() async throws {
        try await testGetLogs(runAsync: true)
    }

    func testGetLogsCompletion() async throws {
        try await testGetLogs(runAsync: false)
    }

    func testGetLogs(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        let assertResult = { (result: Logs) in
            XCTAssertEqual(logs.value, result)
        }

        if runAsync {
            assertResult(try await sut.getLogs())
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.getLogs { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testTestConnectionAsync() async throws {
        try await testTestConnection(runAsync: true)
    }

    func testTestConnectionCompletion() async throws {
        try await testTestConnection(runAsync: false)
    }

    func testTestConnection(runAsync: Bool, line: UInt = #line, file: StaticString = #file) async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data(), statusCode: .accepted)
        
        let assertResult = { (result: Void) in
            XCTAssertNotNil(result)
        }
        
        if runAsync {
            assertResult(try await sut.testConnection())
        } else {
            let completionExpectation = expectation(description: "Expects completion")
            sut.testConnection { result in
                switch result {
                case .success(let success):
                    assertResult(success)
                case .failure(let error):
                    XCTFail("Did expect success but received \(error.localizedDescription)")
                }
                completionExpectation.fulfill()
            }

            wait(for: [completionExpectation], timeout: 1)
        }
    }

    func makeDataFromJSON(_ json: JSON) throws -> Data {
        try testEncoder.encode(json)
    }
}
