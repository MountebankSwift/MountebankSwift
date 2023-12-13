import XCTest
@testable import MountebankSwift

final class HostTests: XCTestCase {

    func testMapLocalhost() {
        let sut = Host.localhost

        XCTAssertEqual(sut.rawValue, "127.0.0.1")
    }

    func testMap() {
        let customHost = "19.10.01.10"
        let sut = Host.custom(customHost)

        XCTAssertEqual(sut.rawValue, customHost)
    }

}
