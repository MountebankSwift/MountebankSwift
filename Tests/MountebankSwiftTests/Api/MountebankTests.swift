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

    func testGetImposter() async throws {
        let imposter = Imposter.Examples.simple
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.getImposter(port: port)
        XCTAssertEqual(imposter.value, result)

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

    func testGetAllImposter() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.getAllImposters()
        XCTAssertEqual(imposters.value.imposters, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testPostImposter() async throws {
        let imposter = Imposter.Examples.simple
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposter(imposter: imposter.value)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPutImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.putImposters(imposters: imposters.value.imposters)
        XCTAssertEqual(imposters.value.imposters, result)
        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testPostImposterStub() async throws {
        let stub = Stub.Examples.json
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposterStub(stub: stub.value, port: port)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteImposterAsync() async throws {
        let imposter = Imposter.Examples.json
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteImposter(port: port)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)

    }

    func testDeleteAllImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.deleteAllImposters()
        XCTAssertEqual(imposters.value.imposters, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testMakeImposterUrl() {
        let result = sut.makeImposterUrl(port: 1010)
        XCTAssertEqual(result, URL(string: "http://localhost:1010"))
    }

    func testPutImposterStubs() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStubs(stubs: imposter.value.stubs, port: port)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteStub(port: port, stubIndex: 0)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testPutImposterStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let stub = try XCTUnwrap(imposter.value.stubs.last)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStub(stub: stub, port: port, stubIndex: 0)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteSavedProxyResponses() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedProxyResponses(port: port)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testDeleteSavedRequests() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try XCTUnwrap(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedRequests(port: port)
        XCTAssertEqual(imposter.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testGetConfig() async throws {
        let config = Config.Examples.simple
        let configData = try makeDataFromJSON(config.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: configData, statusCode: .accepted)

        let result = try await sut.getConfig()
        XCTAssertEqual(config.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testGetLogs() async throws {
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        let result = try await sut.getLogs()
        XCTAssertEqual(logs.value, result)

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }

    func testTestConnection() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data(), statusCode: .accepted)

        try await sut.testConnection()
    }

    func makeDataFromJSON(_ json: JSON) throws -> Data {
        try testEncoder.encode(json)
    }
}
