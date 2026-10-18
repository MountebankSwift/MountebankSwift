import Foundation
import Testing
@testable import MountebankSwift

@Suite
struct MountebankTests {

    let sut: Mountebank
    let httpClientSpy: HttpClientSpy

    init() {
        httpClientSpy = HttpClientSpy()
        sut = Mountebank(host: .localhost, port: 2525, httpClient: httpClientSpy)
    }

    @Test
    func getImposter() async throws {
        let imposter = Imposter.Examples.simple
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.getImposter(port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
        #expect(
            httpClientSpy.httpRequestReceivedRequest == HTTPRequest(
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

    @Test
    func getAllImposter() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.getAllImposters()
        #expect(imposters.value.imposters == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func postImposter() async throws {
        let imposter = Imposter.Examples.simple
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposter(imposter: imposter.value)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)

    }

    @Test
    func putImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.putImposters(imposters: imposters.value.imposters)
        #expect(imposters.value.imposters == result)
        #expect(httpClientSpy.httpRequestCalled)

    }

    @Test
    func postImposterStub() async throws {
        let stub = Stub.Examples.json
        let imposter = Imposter.Examples.json
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.postImposterStub(stub: stub.value, port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)

    }

    @Test
    func deleteImposterAsync() async throws {
        let imposter = Imposter.Examples.json
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteImposter(port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)

    }

    @Test
    func deleteAllImposters() async throws {
        let imposters = Imposters.Examples.single
        let impostersData = try makeDataFromJSON(imposters.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: impostersData, statusCode: .accepted)

        let result = try await sut.deleteAllImposters()
        #expect(imposters.value.imposters == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func makeImposterUrl() {
        let result = sut.makeImposterUrl(port: 1010)
        #expect(result == URL(string: "http://localhost:1010"))
    }

    @Test
    func putImposterStubs() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStubs(stubs: imposter.value.stubs, port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func deleteStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteStub(port: port, stubIndex: 0)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func putImposterStub() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try #require(imposter.value.port)
        let stub = try #require(imposter.value.stubs.last)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.putImposterStub(stub: stub, port: port, stubIndex: 0)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func deleteSavedProxyResponses() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedProxyResponses(port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func deleteSavedRequests() async throws {
        let imposter = Imposter.Examples.advanced
        let port = try #require(imposter.value.port)
        let imposterData = try makeDataFromJSON(imposter.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: imposterData, statusCode: .accepted)

        let result = try await sut.deleteSavedRequests(port: port)
        #expect(imposter.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func getConfig() async throws {
        let config = Config.Examples.simple
        let configData = try makeDataFromJSON(config.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: configData, statusCode: .accepted)

        let result = try await sut.getConfig()
        #expect(config.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func getLogs() async throws {
        let logs = Logs.Examples.simple
        let logsData = try makeDataFromJSON(logs.json)
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: logsData, statusCode: .accepted)

        let result = try await sut.getLogs()
        #expect(logs.value == result)

        #expect(httpClientSpy.httpRequestCalled)
    }

    @Test
    func testConnection() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data(), statusCode: .accepted)

        try await sut.testConnection()
    }

    func makeDataFromJSON(_ json: JSON) throws -> Data {
        try testEncoder.encode(json)
    }
}
