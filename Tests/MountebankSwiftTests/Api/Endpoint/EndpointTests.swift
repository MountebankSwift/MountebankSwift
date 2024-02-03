import XCTest
@testable import MountebankSwift

final class EndpointTests: XCTestCase {

    private static let exampleBaseUrl = URL(string: "https://localhost")!

    func testGetAllImposters() {
        [
            makeUrlFromEndpoint(.getAllImposters(parameters: ImposterParameters())): "\(Self.exampleBaseUrl.absoluteString)/imposters",
            makeUrlFromEndpoint(.getAllImposters(parameters: ImposterParameters(replayable: true))): "\(Self.exampleBaseUrl.absoluteString)/imposters?replayable=true",
            makeUrlFromEndpoint(.getAllImposters(parameters: ImposterParameters(removeProxies: false))): "\(Self.exampleBaseUrl.absoluteString)/imposters?removeProxies=false",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }
    
    func testGetImposter() {
        [
            makeUrlFromEndpoint(.getImposter(port: 10, parameters: ImposterParameters())): "\(Self.exampleBaseUrl.absoluteString)/imposters/10",
            makeUrlFromEndpoint(.getImposter(port: 123, parameters: ImposterParameters(replayable: true))): "\(Self.exampleBaseUrl.absoluteString)/imposters/123?replayable=true",
            makeUrlFromEndpoint(.getImposter(port: 1111, parameters: ImposterParameters(replayable: true, removeProxies: false))): "\(Self.exampleBaseUrl.absoluteString)/imposters/1111?replayable=true&removeProxies=false",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }
    
    func testGetLogs() {
        [
            makeUrlFromEndpoint(.getLogs(parameters: LogParameters())): "\(Self.exampleBaseUrl.absoluteString)/logs",
            makeUrlFromEndpoint(.getLogs(parameters: LogParameters(startIndex: 100))): "\(Self.exampleBaseUrl.absoluteString)/logs?startIndex=100",
            makeUrlFromEndpoint(.getLogs(parameters: LogParameters(endIndex: 203))): "\(Self.exampleBaseUrl.absoluteString)/logs?endIndex=203",
        ].forEach { endpoint, expectedResult in
            XCTAssertEqual(endpoint, URL(string: expectedResult))
        }
    }

    private func makeUrlFromEndpoint(_ endPoint: Endpoint) -> URL {
        endPoint.makeEndpointUrl(baseUrl: Self.exampleBaseUrl)
    }
}
