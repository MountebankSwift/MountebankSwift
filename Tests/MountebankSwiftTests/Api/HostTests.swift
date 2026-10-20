import Testing
@testable import MountebankSwift

@Suite
struct HostTests {

    @Test
    func mapLocalhost() {
        let sut = Host.localhost

        #expect(sut.rawValue == "127.0.0.1")
    }

    @Test
    func map() {
        let customHost = "19.10.01.10"
        let sut = Host.custom(customHost)

        #expect(sut.rawValue == customHost)
    }

}
