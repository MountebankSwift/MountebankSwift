import Foundation
import MountebankSwift

extension Proxy {
    enum Examples {
        static let simple = Example(
            value: Proxy(
                to: "https://www.somesite.com:3000",
                mode: .proxyAlways
            ),
            json: [
                "to": "https://www.somesite.com:3000",
                "mode": "proxyAlways",
            ]
        )
    }
}
