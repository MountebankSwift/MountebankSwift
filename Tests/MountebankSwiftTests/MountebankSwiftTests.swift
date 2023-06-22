import XCTest
@testable import MountebankSwift

final class MountebankSwiftTests: XCTestCase {

    func testConnectionWithMounteBank() async throws {
        let mountebank = Mountebank(host: .localhost, port: 2525)

        let imposterResult = try await mountebank.postImposter(imposter: Imposter.exampleSingleStub)
        guard let port = imposterResult.port else {
            XCTFail("Port should be set by now")
            return
        }

        _ = try await mountebank.postImposterStub(addStub: AddStub.injectBody, port: port)
        _ = try await mountebank.getImposter(port: port)
        _ = try await mountebank.getAllImposters()
        _ = try await mountebank.postImposterStub(addStub: AddStub(index: 2, stub: .connectionResetByPeer), port: port)
        _ = try await mountebank.putImposterStubs(imposter: Imposter.exampleSingleStub, port: port)
        _ = try await mountebank.deleteSavedProxyResponses(port: port)
        let deleteResult = try await mountebank.deleteAllImposters()

        print(deleteResult)

    }
}
