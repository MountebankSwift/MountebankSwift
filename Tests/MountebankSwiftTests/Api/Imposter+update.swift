import Foundation
@testable import MountebankSwift
@testable import MountebankSwiftModels

extension Imposter {

    func with(port: Int) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }

    func with(networkProtocol: Imposter.NetworkProtocol) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }

    func with(stubs: [Stub]) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }

    func with(requests: [RecordedRequest]?) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }

    func with(recordRequests: Bool?) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }

    func with(numberOfRequests: Int?) -> Imposter {
        Imposter(
            port: port,
            networkProtocol: networkProtocol,
            name: name,
            stubs: stubs,
            defaultResponse: defaultResponse,
            recordRequests: recordRequests,
            numberOfRequests: numberOfRequests,
            requests: requests
        )
    }
}
