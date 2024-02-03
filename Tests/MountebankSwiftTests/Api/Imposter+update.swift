import Foundation
@testable import MountebankSwift

extension Imposter {

    func update(port: Int) -> Imposter {
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

    func update(networkProtocol: Imposter.NetworkProtocol) -> Imposter {
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

    func update(stubs: [Stub]) -> Imposter {
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

    func update(requests: [RecordedRequest]?) -> Imposter {
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

    func update(recordRequests: Bool) -> Imposter {
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

    func update(numberOfRequests: Int?) -> Imposter {
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
