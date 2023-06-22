import Foundation
import XCTest
@testable import MountebankSwift

class MountebankTests: XCTestCase {

    private var sut: Mountebank!
    private var httpClientSpy: HttpClientSpy!

    override func setUp() async throws {
        httpClientSpy = HttpClientSpy()
        sut = Mountebank(host: .localhost, port: 2525, httpClient: httpClientSpy)
    }

    override func tearDown() async throws {
        sut = nil
    }

    func testGetImposter() async throws {
        httpClientSpy.httpRequestReturnValue = HTTPResponse(body: Data(), statusCode: .accepted)
        
        try await sut.getAllImposters()
        
        XCTAssertTrue(httpClientSpy.httpRequestCalled)
    }
}
