import Foundation

/// Imposters as documented on:
/// [mbtest.org/docs/api/contracts?type=imposters](https://www.mbtest.org/docs/api/contracts?type=imposters)
public struct Imposters: Codable, Equatable {
    public let imposters: [Imposter]
}
