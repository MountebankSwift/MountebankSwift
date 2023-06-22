import XCTest
@testable import MountebankSwift

final class MountebankSwiftTests: XCTestCase {

    func testConnectionWithMounteBank() async throws {
        let mountebank = Mountebank(host: .localhost, port: 2525)

        let result = try await mountebank.postImposter(
            imposter: Imposter(port: 111, scheme: .http, name: "ssdf", stubs: [])
        )

        print(result)

    }
}
