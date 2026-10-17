import Foundation
import Testing
@testable import MountebankSwift

@Suite
struct EndpointTests {

    // swiftlint:disable:next force_unwrapping
    private static let exampleBaseUrl = URL(string: "https://localhost")!

    @Test
    func getAllImposters() {
        [
            makeUrlFromEndpoint(.getAllImposters(
                parameters: ImposterParameters(replayable: false, removeProxies: false)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters?removeProxies=false&replayable=false",
            makeUrlFromEndpoint(.getAllImposters(
                parameters: ImposterParameters(replayable: true, removeProxies: true)
            )): "\(Self.exampleBaseUrl.absoluteString)/imposters?removeProxies=true&replayable=true",
        ].forEach { endpoint, expectedResult in
            #expect(endpoint == URL(string: expectedResult))
        }
    }

    @Test
    func getImposter() {
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
            #expect(endpoint == URL(string: expectedResult))
        }
    }

    @Test
    func getLogs() {
        [
            makeUrlFromEndpoint(.getLogs(parameters: LogParameters())): "\(Self.exampleBaseUrl.absoluteString)/logs",
            makeUrlFromEndpoint(.getLogs(
                parameters: LogParameters(startIndex: 100)
            )): "\(Self.exampleBaseUrl.absoluteString)/logs?startIndex=100",
            makeUrlFromEndpoint(.getLogs(
                parameters: LogParameters(endIndex: 203)
            )): "\(Self.exampleBaseUrl.absoluteString)/logs?endIndex=203",
        ].forEach { endpoint, expectedResult in
            #expect(endpoint == URL(string: expectedResult))
        }
    }

    private func makeUrlFromEndpoint(_ endPoint: Endpoint) -> URL {
        endPoint.makeEndpointUrl(baseUrl: Self.exampleBaseUrl)
    }
}
