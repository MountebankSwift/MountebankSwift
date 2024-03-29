#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import XCTest
@testable import MountebankSwift

final class MountebankIntegrationTests: XCTestCase {

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var sut: Mountebank!

    override func setUp() async throws {
        sut = Mountebank(host: .localhost, port: 2525)

        do {
            try await sut.testConnection()
        } catch {
            XCTFail("Mountebank needs to be running to run the tests. Start with `mb start`")
        }
    }

    override func tearDown() async throws {
        try await sut.deleteAllImposters()

        sut = nil
    }

    func testGettingLogs() async throws {
        let logsResponse = try await sut.getLogs()

        XCTAssertGreaterThan(logsResponse.logs.count, 0)
    }

    func testGettingConfig() async throws {
        let config = try await sut.getConfig()

        XCTAssertGreaterThan(config.version.count, 0)
    }

    func testPostImposter() async throws {
        let imposterToPost = Imposter.Examples.includingAllStubs.value
        let imposterResult = try await sut.postImposter(imposter: imposterToPost)
        guard imposterResult.port != nil else {
            XCTFail("Port should have been set by now.")
            return
        }

        let expectedResult = imposterToPost
            .with(numberOfRequests: 0)
            .with(requests: [])

        XCTAssertEqual(imposterResult, expectedResult)
    }

    func testPostImposterWithExtraOptions() async throws {
        let imposterToPost = Imposter.Examples.withExtraOptionsHttps.value
        let imposterResult = try await sut.postImposter(imposter: imposterToPost)
        guard imposterResult.port != nil else {
            XCTFail("Port should have been set by now.")
            return
        }

        let expectedResult = imposterToPost
            .with(networkProtocol: .https(
                allowCORS: nil,
                rejectUnauthorized: true,
                certificateAuthority: ExampleCert.certificateAuthority,
                key: ExampleCert.privateKey,
                certificate: ExampleCert.certificate,
                mutualAuth: false,
                ciphers: "TLS_AES_256_GCM_SHA384"
            ))
            .with(numberOfRequests: 0)
            .with(requests: [])

        XCTAssertEqual(imposterResult, expectedResult)
    }

    func testGetImposter() async throws {
        guard #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) else {
            throw XCTSkip("Test uses api's that are not supported for your platfrom.")
        }

        let imposterPort = try await postDefaultImposter(imposter: Imposter.Examples.simpleRecordRequests.value)
        let httpClient = HttpClient()

        let path = "/text-200"
        let url = try XCTUnwrap(
            sut.makeImposterUrl(port: imposterPort)
                .appendingPathComponent(path)
                .appending([URLQueryItem(name: "search", value: "test")])
        )
        let request = HTTPRequest(url: url, method: .get)

        _ = try await httpClient.httpRequest(request)
        _ = try await httpClient.httpRequest(request)

        let imposter = try await sut.getImposter(port: imposterPort)

        XCTAssertEqual(imposter.requests?.count, 2)

        let firstRequest = try XCTUnwrap(imposter.requests?.first)

        // Can not check full request, because client the runner will
        // run on will impact the RecordedRequest contents.
        XCTAssertEqual(firstRequest.path, path)
        XCTAssertNil(firstRequest.form)
        XCTAssertEqual(firstRequest.query, ["search": "test"])
        XCTAssertEqual(firstRequest.method, .get)
        XCTAssertFalse(firstRequest.ip.isEmpty)
        XCTAssertFalse(firstRequest.requestFrom.isEmpty)
    }

    func testGetImposterReplayable() async throws {
        guard #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) else {
            throw XCTSkip("Test uses api's that are not supported for your platfrom.")
        }

        let imposterPort = try await postDefaultImposter(imposter: Imposter.Examples.simpleRecordRequests.value)
        let httpClient = HttpClient()

        let path = "/text-200"
        let url = try XCTUnwrap(
            sut.makeImposterUrl(port: imposterPort)
                .appendingPathComponent(path)
                .appending([URLQueryItem(name: "search", value: "test")])
        )
        let request = HTTPRequest(url: url, method: .get)

        _ = try await httpClient.httpRequest(request)
        _ = try await httpClient.httpRequest(request)

        let imposter = try await sut.getImposter(port: imposterPort, replayable: true)

        XCTAssertNil(imposter.requests)
        XCTAssertEqual(
            imposter,
            Imposter.Examples.simpleRecordRequests.value
        )
    }

    func testUpdatingStub() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let updatedImposterResult = try await sut.postImposterStub(
            stub: AddStub.Examples.addInjectStubFirstIndex.value.stub,
            index: AddStub.Examples.addInjectStubFirstIndex.value.index,
            port: port
        )

        XCTAssertEqual(updatedImposterResult.stubs.count, 2)
        XCTAssertEqual(updatedImposterResult.stubs.first, Imposter.Examples.simple.value.stubs.first)
        XCTAssertEqual(updatedImposterResult.stubs.last, AddStub.Examples.addInjectStubFirstIndex.value.stub)
    }

    func testPutImposters() async throws {
        _ = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let updatedImpostersResult = try await sut.putImposters(imposters: Imposters.Examples.single.value.imposters)

        let postedFirstImposter = try XCTUnwrap(Imposters.Examples.single.value.imposters.first)
        let expectedResult = postedFirstImposter
            .with(numberOfRequests: 0)
            .with(requests: nil)

        XCTAssertEqual(updatedImpostersResult.count, 1)
        XCTAssertEqual(updatedImpostersResult.first, expectedResult)
    }

    func testUpdatingImposter() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let imposter = try await sut.getImposter(port: port)
        XCTAssertEqual(imposter.stubs, Imposter.Examples.simple.value.stubs)

        let updatedImposterResult = try await sut.putImposterStubs(
            stubs: Imposter.Examples.advanced.value.stubs,
            port: port
        )
        XCTAssertEqual(updatedImposterResult.stubs, Imposter.Examples.advanced.value.stubs)
    }

    func testGetAllImposters() async throws {
        let imposter1 = try await sut.postImposter(imposter: Imposter.Examples.advanced.value)
        let imposter2 = try await sut.postImposter(imposter: Imposter.Examples.simple.value)
        let allImposters = try await sut.getAllImposters(replayable: true)

        let expectedResult = [
            imposter1.with(numberOfRequests: nil).with(requests: nil),
            imposter2.with(numberOfRequests: nil).with(requests: nil),
        ]

        XCTAssertEqual(allImposters, expectedResult)
        XCTAssertEqual(allImposters, expectedResult)
    }

    func testDeleteAllImposters() async throws {
        try await sut.postImposter(imposter: Imposter.Examples.advanced.value)
        try await sut.postImposter(imposter: Imposter.Examples.simple.value)
        try await sut.deleteAllImposters()

        let allImposters = try await sut.getAllImposters()

        XCTAssertEqual(allImposters.count, 0)
    }

    func testDeleteSavedProxyResponses() async throws {
        let imposterResult = try await sut.postImposter(imposter: Imposter(
            port: nil,
            networkProtocol: .https(),
            name: "Imposter with proxy",
            stubs: [Stub(
                responses: [Proxy.Examples.simple.value],
                predicates: [Predicate.Examples.equals.value]
            )]
        ))
        guard let port = imposterResult.port else {
            XCTFail("Port should have been set by now.")
            return
        }

        let response = try await sut.deleteSavedProxyResponses(port: port)

        XCTAssertEqual(response.stubs.count, 1)
    }

    // Use this test to verify in your browser that all these content types are encoded properly
    // Put a breakpoint after the `postImposter` call and check for example http://localhost:1234/sample.png
    func testDiffentResponseBodyTypes() async throws {
        let sampleFiles = [
            SampleFile.png,
            SampleFile.jpg,
            SampleFile.json,
            SampleFile.pdf,
            SampleFile.txt,
            SampleFile.mp4,
            SampleFile.html,
        ]

        let imposter = Imposter(
            port: 1234,
            networkProtocol: .http(),
            name: "Imposter with various body Types",
            stubs: sampleFiles.map { file in
                Stub(
                    response: Is(
                        headers: [HTTPHeaders.contentType.rawValue: file.mimeType],
                        body: file.body
                    ),
                    predicate: .equals(Request(path: "/\(file.rawValue)"))
                )
            },
            recordRequests: true
        )

        let result = try await sut.postImposter(imposter: imposter)

        let stubBodies = result.stubs.compactMap { stub in
            (stub.responses.first as? Is)?.body
        }

        XCTAssertEqual(sampleFiles.map(\.body), stubBodies)
    }

    private func postDefaultImposter(imposter: Imposter) async throws -> Int {
        let imposterResult = try await sut.postImposter(imposter: imposter)
        guard let port = imposterResult.port else {
            XCTFail("Port should have been set by now.")
            return 0
        }

        return port
    }
}
