import Foundation

/// Parameters for a imposter
struct ImposterParameters: EndpointParameters {
    let replayable: Bool
    let removeProxies: Bool

    init(replayable: Bool, removeProxies: Bool) {
        self.replayable = replayable
        self.removeProxies = removeProxies
    }

    func makeQueryParameters() -> [URLQueryItem] {
        mapQueryParameters(["replayable": replayable, "removeProxies": removeProxies])
    }
}
