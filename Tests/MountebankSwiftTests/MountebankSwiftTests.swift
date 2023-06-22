import XCTest
@testable import MountebankSwift

final class MountebankSwiftTests: XCTestCase {

    func testConnectionWithMounteBank() async throws {
        let mountebank = Mountebank(host: .localhost, port: 2525)

        let result = try await mountebank.postImposter(imposter: Imposter.exampleFull)
        guard let port = result.port else {
            XCTFail("Port should be set by now")
            return
        }
        let deleteResult = try await mountebank.deleteImposter(port: port)
        
        print(deleteResult)

    }
}
