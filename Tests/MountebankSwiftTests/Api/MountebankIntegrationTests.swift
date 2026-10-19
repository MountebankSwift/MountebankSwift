#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import Foundation
import Testing
@testable import MountebankSwift

@Suite(.serialized)
struct MountebankIntegrationTests {

    private let sut = Mountebank(host: .localhost, port: 2525)

    init() async throws {
        do {
            try await sut.testConnection()
        } catch {
            Issue.record("Mountebank needs to be running to run the tests. Start with `mb start`")
        }

        // Clean up before instead of after each test, so a test that failed halfway can't affect the next one
        try await sut.deleteAllImposters()
    }

    @Test
    func gettingLogs() async throws {
        let logsResponse = try await sut.getLogs()

        #expect(logsResponse.logs.count > 0)
    }

    @Test
    func gettingConfig() async throws {
        let config = try await sut.getConfig()

        #expect(config.version.count > 0)
    }

    @Test
    func postImposter() async throws {
        let imposterToPost = Imposter.Examples.includingAllStubs.value
        let imposterResult = try await sut.postImposter(imposter: imposterToPost)
        guard imposterResult.port != nil else {
            Issue.record("Port should have been set by now.")
            return
        }

        let expectedResult = imposterToPost
            .with(numberOfRequests: 0)
            .with(requests: [])

        #expect(imposterResult == expectedResult)
    }

    @Test
    func postImposterWithExtraOptions() async throws {
        let imposterToPost = Imposter.Examples.withExtraOptionsHttps.value
        let imposterResult = try await sut.postImposter(imposter: imposterToPost)
        guard imposterResult.port != nil else {
            Issue.record("Port should have been set by now.")
            return
        }

        let expectedResult = imposterToPost
            .with(networkProtocol: .https(
                allowCORS: true,
                rejectUnauthorized: true,
                certificateAuthority: ExampleCert.certificateAuthority,
                key: ExampleCert.privateKey,
                certificate: ExampleCert.certificate,
                mutualAuth: false,
                ciphers: "TLS_AES_256_GCM_SHA384"
            ))
            .with(numberOfRequests: 0)
            .with(requests: [])

        #expect(imposterResult == expectedResult)
    }

    @Test
    func getImposter() async throws {
        guard #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) else {
            try Test.cancel("Test uses api's that are not supported for your platfrom.")
        }

        let imposterPort = try await postDefaultImposter(imposter: Imposter.Examples.simpleRecordRequests.value)
        let httpClient = HttpClient()

        let path = "/text-200"
        let url = try #require(
            sut.makeImposterUrl(port: imposterPort)
                .appendingPathComponent(path)
                .appending([URLQueryItem(name: "search", value: "test")])
        )
        let request = HTTPRequest(url: url, method: .get)

        _ = try await httpClient.httpRequest(request)
        _ = try await httpClient.httpRequest(request)

        let imposter = try await sut.getImposter(port: imposterPort)

        #expect(imposter.requests?.count == 2)

        let firstRequest = try #require(imposter.requests?.first)

        // Can not check full request, because client the runner will
        // run on will impact the RecordedRequest contents.
        #expect(firstRequest.path == path)
        #expect(firstRequest.form == nil)
        #expect(firstRequest.query == ["search": "test"])
        #expect(firstRequest.method == .get)
        #expect(!firstRequest.ip.isEmpty)
        #expect(!firstRequest.requestFrom.isEmpty)
    }

    @Test
    func getImposterReplayable() async throws {
        guard #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) else {
            try Test.cancel("Test uses api's that are not supported for your platfrom.")
        }

        let imposterPort = try await postDefaultImposter(imposter: Imposter.Examples.simpleRecordRequests.value)
        let httpClient = HttpClient()

        let path = "/text-200"
        let url = try #require(
            sut.makeImposterUrl(port: imposterPort)
                .appendingPathComponent(path)
                .appending([URLQueryItem(name: "search", value: "test")])
        )
        let request = HTTPRequest(url: url, method: .get)

        _ = try await httpClient.httpRequest(request)
        _ = try await httpClient.httpRequest(request)

        let imposter = try await sut.getImposter(port: imposterPort, replayable: true)

        #expect(imposter.requests == nil)
        #expect(imposter == Imposter.Examples.simpleRecordRequests.value)
    }

    @Test
    func updatingStub() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let updatedImposterResult = try await sut.postImposterStub(
            stub: AddStub.Examples.addInjectStubFirstIndex.value.stub,
            index: AddStub.Examples.addInjectStubFirstIndex.value.index,
            port: port
        )

        #expect(updatedImposterResult.stubs.count == 2)
        #expect(updatedImposterResult.stubs.first == Imposter.Examples.simple.value.stubs.first)
        #expect(updatedImposterResult.stubs.last == AddStub.Examples.addInjectStubFirstIndex.value.stub)
    }

    @Test
    func putImposters() async throws {
        _ = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let updatedImpostersResult = try await sut.putImposters(imposters: Imposters.Examples.single.value.imposters)

        let postedFirstImposter = try #require(Imposters.Examples.single.value.imposters.first)
        let expectedResult = postedFirstImposter
            .with(numberOfRequests: 0)
            .with(requests: nil)

        #expect(updatedImpostersResult.count == 1)
        #expect(updatedImpostersResult.first == expectedResult)
    }

    @Test
    func updatingImposter() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let imposter = try await sut.getImposter(port: port)
        #expect(imposter.stubs == Imposter.Examples.simple.value.stubs)

        let updatedImposterResult = try await sut.putImposterStubs(
            stubs: Imposter.Examples.advanced.value.stubs,
            port: port
        )
        #expect(updatedImposterResult.stubs == Imposter.Examples.advanced.value.stubs)
    }

    @Test
    func getAllImposters() async throws {
        let imposter1 = try await sut.postImposter(imposter: Imposter.Examples.advanced.value)
        let imposter2 = try await sut.postImposter(imposter: Imposter.Examples.simple.value)
        let allImposters = try await sut.getAllImposters(replayable: true)

        let expectedResult = [
            imposter1.with(numberOfRequests: nil).with(requests: nil),
            imposter2.with(numberOfRequests: nil).with(requests: nil),
        ]

        #expect(allImposters == expectedResult)
    }

    @Test
    func deleteAllImposters() async throws {
        try await sut.postImposter(imposter: Imposter.Examples.advanced.value)
        try await sut.postImposter(imposter: Imposter.Examples.simple.value)
        try await sut.deleteAllImposters()

        let allImposters = try await sut.getAllImposters()

        #expect(allImposters.count == 0)
    }

    @Test
    func deleteSavedProxyResponses() async throws {
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
            Issue.record("Port should have been set by now.")
            return
        }

        let response = try await sut.deleteSavedProxyResponses(port: port)

        #expect(response.stubs.count == 1)
    }

    // Use this test to verify in your browser that all these content types are encoded properly
    // Put a breakpoint after the `postImposter` call and check for example http://localhost:1234/sample.png
    @Test
    func differentResponseBodyTypes() async throws {
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

        #expect(sampleFiles.map(\.body) == stubBodies)
    }

    private func postDefaultImposter(imposter: Imposter) async throws -> Int {
        let imposterResult = try await sut.postImposter(imposter: imposter)
        guard let port = imposterResult.port else {
            Issue.record("Port should have been set by now.")
            return 0
        }

        return port
    }
}
