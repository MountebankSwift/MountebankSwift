import Foundation

/// Imposters as documented on:
/// [mbtest.org/docs/api/contracts?type=imposters](https://www.mbtest.org/docs/api/contracts?type=imposters)
package struct Imposters: Codable, Equatable {
    package let imposters: [Imposter]
    
    package init(imposters: [Imposter]) {
        self.imposters = imposters
    }
}

extension Imposters: Recreatable {
    func recreatable(indent: Int) -> String {
        structSwiftString([("imposters", imposters)], indent: indent)
    }
}
