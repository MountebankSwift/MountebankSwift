import Foundation

/// Imposters as documented on:
/// [mbtest.dev/docs/api/contracts?type=imposters](https:/www.mbtest.dev/docs/api/contracts?type=imposters)
struct Imposters: Codable, Equatable {
    public let imposters: [Imposter]
}

extension Imposters: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([("imposters", imposters)], indent: indent)
    }
}
