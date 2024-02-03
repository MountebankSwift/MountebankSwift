import Foundation
import XCTest
@testable import MountebankSwift

class MountebankTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    private var sut: Mountebank!
    private var httpClientSpy: HttpClientSpy!
    private var jsonEncoder: JSONEncoder!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() async throws {
        httpClientSpy = HttpClientSpy()
        jsonEncoder = JSONEncoder()
        sut = Mountebank(host: .localhost, port: 2525, httpClient: httpClientSpy)
    }

    override func tearDown() async throws {
        httpClientSpy = nil
        sut = nil
        jsonEncoder = nil
    }

    func testGetImposter() async throws {
        let imposter = Imposter.Examples.simple
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.getImposter(port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(
            httpClientSpy.httpRequestReceivedRequest,
            HTTPRequest(
                url: Endpoint.getImposter(port: port, parameters: ImposterParameters())
                    .makeEndpointUrl(baseUrl: sut.mountebankURL),
                method: .get,
                headers: [HTTPHeaders.contentType: MimeType.json.rawValue]
            )
        )
        XCTAssertEqual(imposter.value, result)
    }

    func testGetAllImposter() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.getAllImposters()

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposters.value, result)
    }

    func testGetAllImposterRemoteError() async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .badRequest)

        await XCTAssertThrowsError(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                MountebankValidationError.remoteError(mounteBankErrors.value)
            )
        }
    }

    func testInvalidResponseGetAllImposter() async throws {
        let mounteBankErrors = MountebankErrors.Examples.single
        let mounteBankErrorsData = try makeDataFromJSON(mounteBankErrors.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: mounteBankErrorsData, statusCode: .accepted)

        await XCTAssertThrowsError(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                MountebankValidationError.invalidResponseData
            )
        }
    }

    func testInvalidErrorMapping() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("[]".utf8), statusCode: .internalServerError)

        await XCTAssertThrowsError(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                MountebankValidationError.invalidResponseData
            )
        }
    }

    func testInvalidResponseFromInvalidStringGetAllImposter() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data("invalid".utf8), statusCode: .accepted)

        await XCTAssertThrowsError(try await sut.getAllImposters()) { error in
            XCTAssertEqual(
                error as? MountebankValidationError,
                MountebankValidationError.invalidResponseData
            )
        }
    }

    func testPostImposter() async throws {
        let imposter = Imposter.Examples.simple
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposter(imposter: imposter.value)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testPutImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.putImposters(imposters: imposters.value)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposters.value, result)
    }

    func testPostImposterStub() async throws {
        let stub = Stub.Examples.json
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposterStub(stub: stub.value, port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testDeleteImposter() async throws {
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteImposter(port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testDeleteAllImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.deleteAllImposters()

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposters.value, result)
    }

    func testMakeImposterUrl() async throws {
        let result = sut.makeImposterUrl(port: 1010)
        XCTAssertEqual(result, URL(string: "http://localhost:1010"))
    }

    func testPutImposterStubs() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStubs(stubs: imposter.value.stubs, port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testDeleteStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteStub(port: port, stubIndex: 0)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testPutImposterStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let stub = try XCTUnwrap(imposter.value.stubs.last)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStub(stub: stub, port: port, stubIndex: 0)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testDeleteSavedProxyResponses() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedProxyResponses(port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testDeleteSavedRequests() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedRequests(port: port)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(imposter.value, result)
    }

    func testGetConfig() async throws {
        let config = Config.Examples.simple
        let configData = try makeDataFromJSON(config.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: configData, statusCode: .accepted)

        let result = try await sut.getConfig()

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(config.value, result)
    }

    func testGetLogs() async throws {
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        let result = try await sut.getLogs()

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
        XCTAssertEqual(logs.value, result)
    }

    func testTestConnection() async throws {
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        try await sut.testConnection()
    }

    private func makeDataFromJSON(_ json: JSON) throws -> Data {
        try jsonEncoder.encode(json)
    }
}
