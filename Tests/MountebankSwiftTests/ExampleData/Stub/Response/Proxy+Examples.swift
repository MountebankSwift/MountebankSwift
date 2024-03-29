import Foundation
import MountebankSwift

extension Proxy {
    enum Examples {
        static let all: [Example] = [
            simple,
            advanced,
            predicateGenerators,
        ]

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

        static let advanced = Example(
            value: Proxy(
                to: "https://www.somesite.com:3000",
                networkProtocolParameters: .http(injectHeaders: ["Custom-Header-X": "Custom value"]),
                mode: .proxyAlways,
                addWaitBehavior: true,
                addDecorateBehavior: "(config) => { config.response.headers['X-Test-token'] = Math.random() * 42; }"
            ),
            json: [
                "to": "https://www.somesite.com:3000",
                "mode": "proxyAlways",
                "addDecorateBehavior" : "(config) => { config.response.headers['X-Test-token'] = Math.random() * 42; }",
                "addWaitBehavior" : true,
                "injectHeaders" : ["Custom-Header-X" : "Custom value"],
            ]
        )

        static let predicateGenerators = Example(
            value: Proxy(
                to: "https://www.somesite.com:3000",
                predicateGenerators: PredicateGenerator.Examples.all.map(\.value)
            ),
            json: [
                "to": "https://www.somesite.com:3000",
                "predicateGenerators": .array(PredicateGenerator.Examples.all.map(\.json)),
            ]
        )
    }
}
