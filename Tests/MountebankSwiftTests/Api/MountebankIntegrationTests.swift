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

    func testUpdatingStub() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let updatedImposterResult = try await sut.postImposterStub(addStub: AddStub.injectBody, port: port)

        XCTAssertEqual(updatedImposterResult.stubs.count, 2)
        XCTAssertEqual(updatedImposterResult.stubs.first, Imposter.Examples.simple.value.stubs.first)
        XCTAssertEqual(updatedImposterResult.stubs.last, AddStub.injectBody.stub)
    }

    func testUpdatingImposter() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.simple.value)
        let imposter = try await sut.getImposter(port: port)
        XCTAssertEqual(imposter.stubs, Imposter.Examples.simple.value.stubs)

        let updatedImposterResult = try await sut.putImposterStubs(
            imposter: Imposter.Examples.advanced.value,
            port: port
        )
        XCTAssertEqual(updatedImposterResult.stubs, Imposter.Examples.advanced.value.stubs)
    }

    func testGetAllImposters() async throws {
        let port = try await postDefaultImposter(imposter: Imposter.Examples.includingAllStubs.value)
        let allImposters = try await sut.getImposter(port: port)

        XCTAssertEqual(allImposters.stubs.count, Imposter.Examples.includingAllStubs.value.stubs.count)
        XCTAssertEqual(allImposters.port, port)
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
                    responses: [Stub.Response.Examples.proxy.value],
                    predicates: [Stub.Predicate.Examples.equals.value]
                )
            ]
        ))
        guard let port = imposterResult.port else {
            XCTFail("Port should have been set by now.")
            return
        }

        let response = try await sut.deleteSavedProxyResponses(port: port)

        XCTAssertEqual(response.stubs.count, 1)
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
