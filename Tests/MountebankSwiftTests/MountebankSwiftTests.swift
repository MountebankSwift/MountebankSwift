import XCTest
@testable import MountebankSwift

final class MountebankSwiftTests: XCTestCase {

    func testConnectionWithMounteBank() async throws {
        let mountebank = Mountebank(host: .localhost, port: 2525)

        let result = try await mountebank.postImposter(
            imposter: Imposter.exampleFull
        )

        print(result)

    }
}
