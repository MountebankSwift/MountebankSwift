import Foundation

/// Parameters for a imposter
public struct ImposterParameters: EndpointParameters {
    let replayable: Bool?
    let removeProxies: Bool?

    /// - Parameters:
    ///   - replayable: Set to `true` to retrieve the minimum amount of information for creating the imposter in the
    ///     future. This leaves out the requests array and any hypermedia.
    ///   - removeProxies: Set to `true` to remove all proxy responses (and ``Stubs``) from the response. This is useful
    ///     in record-playback scenarios where you want to seed the imposters with proxy information but leave it out on
    ///     subsequent test runs. You can recreate the ``Imposter`` in the future by using the response.
    public init(replayable: Bool? = nil, removeProxies: Bool? = nil) {
        self.replayable = replayable
        self.removeProxies = removeProxies
    }

    public func makeQueryParameters() -> [URLQueryItem] {
        mapQueryParameters(["replayable": replayable, "removeProxies": removeProxies])
    }
}
