import Foundation
import MountebankSwift

extension PredicateGenerator {
    enum Examples {
        static let simple = Example(
            value: PredicateGenerator(
                matches: [
                    "path": true,
                    "method": true
                ],
                caseSensitive: true
            ),
            json: [
                "matches": [
                    "path": true,
                    "method": true
                ],
                "caseSensitive": true,
            ]
        )

        // TODO: Add more examples, see for all options 
        // https://www.mbtest.org/docs/api/proxies#proxy-predicate-generators
    }
}
