import XCTest
@testable import MountebankSwift

final class EndpointTests: XCTestCase {

    // swiftlint:disable:next force_unwrapping
    private static let exampleBaseUrl = URL(string: "https://localhost")!

    func testGetAllImposters() {
        [
            makeUrlFromEndpoint(.getAllImposters(
                parameters: ImposterParameters(replayable: false, removeProxies: false)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters?removeProxies=false&replayable=false",
            makeUrlFromEndpoint(.getAllImposters(
                parameters: ImposterParameters(replayable: true, removeProxies: true)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters?removeProxies=true&replayable=true",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }

    func testGetImposter() {
        [
            makeUrlFromEndpoint(.getImposter(
                port: 10,
                parameters: ImposterParameters(replayable: false, removeProxies: false)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters/10?removeProxies=false&replayable=false",
            makeUrlFromEndpoint(.getImposter(
                port: 123,
                parameters: ImposterParameters(replayable: true, removeProxies: true)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters/123?removeProxies=true&replayable=true",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }

    func testGetLogs() {
        [
            makeUrlFromEndpoint(.getLogs(parameters: LogParameters())): "\(Self.exampleBaseUrl.absoluteString)/logs",
            makeUrlFromEndpoint(.getLogs(
                parameters: LogParameters(startIndex: 100)
            )): "\(Self.exampleBaseUrl.absoluteString)/logs?startIndex=100",
            makeUrlFromEndpoint(.getLogs(
                parameters: LogParameters(endIndex: 203)
            )): "\(Self.exampleBaseUrl.absoluteString)/logs?endIndex=203",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }

    private func makeUrlFromEndpoint(_ endPoint: Endpoint) -> URL {
        endPoint.makeEndpointUrl(baseUrl: Self.exampleBaseUrl)
    }
}
