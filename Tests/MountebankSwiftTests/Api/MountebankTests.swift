import Foundation
import XCTest
@testable import MountebankSwift

class MountebankTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    private var sut: Mountebank!
    private var httpClientSpy: HttpClientSpy!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() async throws {
        httpClientSpy = HttpClientSpy()
        sut = Mountebank(host: .localhost, port: 2525, httpClient: httpClientSpy)
    }

    override func tearDown() async throws {
        sut = nil
    }

    func skip_testGetImposter() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data(), statusCode: .accepted)

        _ = try await sut.getAllImposters()

        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }
}
