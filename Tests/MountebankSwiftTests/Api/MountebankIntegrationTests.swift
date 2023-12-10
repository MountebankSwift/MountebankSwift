import XCTest
@testable import MountebankSwift

final class MountebankIntegrationTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    private var sut: Mountebank!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() async throws {
        sut = Mountebank(host: .localhost, port: 2525)

        do {
            try await sut.testConnection()
        } catch {
            XCTFail("Mountebank needs to be running to run the tests. Start with `mb start`")
        }
    }

    override func tearDown() async throws {
        _ = try await sut.deleteAllImposters()

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
        let imposterResult = try await sut.postImposter(imposter: Imposter.Examples.includingAllStubs.value)
        guard imposterResult.port != nil else {
            XCTFail("Port should have been set by now.")
            return
        }

        XCTAssertEqual(imposterResult, Imposter.Examples.includingAllStubs.value)
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
        let updatedImpostersResult = try await sut.putImposters(imposters: Imposters.Examples.single.value)

        XCTAssertEqual(updatedImpostersResult.imposters.count, 1)
        XCTAssertEqual(updatedImpostersResult.imposters.first, Imposters.Examples.single.value.imposters.first)
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
        guard let port1 = imposter1.port, let port2 = imposter2.port else {
            XCTFail("Ports should have been set by now.")
            return
        }

        let allImposters = try await sut.getAllImposters()
        XCTAssertEqual(
            allImposters,
            Imposters(imposters: [
                Imposters.ImposterRef(networkProtocol: .https, port: port1),
                Imposters.ImposterRef(networkProtocol: .https, port: port2),
            ])
        )
    }

    func testDeleteAllImposters() async throws {
        _ = try await sut.postImposter(imposter: Imposter.Examples.advanced.value)
        _ = try await sut.postImposter(imposter: Imposter.Examples.simple.value)
        _ = try await sut.deleteAllImposters()
        let allImposters = try await sut.getAllImposters()
        XCTAssertEqual(allImposters.imposters.count, 0)
    }

    func testDeleteSavedProxyResponses() async throws {
        let imposterResult = try await sut.postImposter(imposter: Imposter(
            port: nil,
            networkProtocol: .https,
            name: "Imposter with proxy",
            stubs: [
                Stub(
                    responses: [Stub.Response.Proxy.Examples.proxy.value],
                    predicates: [Stub.Predicate.Examples.equals.value]
                ),
            ]
        ))
        guard let port = imposterResult.port else {
            XCTFail("Port should have been set by now.")
            return
        }

        let response = try await sut.deleteSavedProxyResponses(port: port)

        XCTAssertEqual(response.stubs.count, 1)
    }

    // Added test is encoding of all these types goes well
    func testDiffentResponseBodyTypes() async throws {
        let imposter = Imposter(
            port: 1234,
            networkProtocol: .http,
            name: "Imposter with various body Types",
            stubs: [
                SampleFile.png,
                SampleFile.jpg,
                SampleFile.json,
                SampleFile.pdf,
                SampleFile.txt,
                SampleFile.mp4,
                SampleFile.html
            ].map { file in
                Stub(
                    response: Stub.Response.Is(
                        headers: [HTTPHeaders.contentType.rawValue : file.mimeType],
                        body: file.body
                    ),
                    predicate: .equals(Stub.Request(path: "/\(file.rawValue)"))
                )
            },
            recordRequests: true
        )

        let result = try await sut.postImposter(imposter: imposter)
        print(result)
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
