import Foundation

/// Imposters as documented on:
/// [mbtest.org/docs/api/contracts?type=imposters](https://www.mbtest.org/docs/api/contracts?type=imposters)
public struct Imposters: Codable, Equatable {

    /// A single ``Imposter`` object.
    /// By default, the fields shown are the only ones returned. Use additional query parameters to return
    /// the full imposter definition, and optionally remove proxies for subsequent replays
    public struct ImposterRef: Codable, Equatable {
        public enum ImpostersNetworkProtocol: String, Codable {
            case http
            case https
        }

        public let networkProtocol: ImpostersNetworkProtocol
        public let port: Int

        enum CodingKeys: String, CodingKey {
            case networkProtocol = "protocol"
            case port
        }
    }

    public let imposters: [ImposterRef]
}
