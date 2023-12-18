import Foundation
import MountebankSwift

extension Behavior {
    enum Examples {
        static let all = [
            wait,
            waitJavascript,
            copy,
            lookup,
            decorate,
            shellTransform,
        ]

        static let wait = Example(
            value: Behavior.wait(miliseconds: 500),
            json: ["wait": 500]
        )

        static let waitJavascript = Example(
            value: Behavior.waitJavascript("() => { return Math.floor(Math.random() * 91) + 10; }"),
            json: ["wait": "() => { return Math.floor(Math.random() * 91) + 10; }"]
        )

        static let copy = Example(
            value: Behavior.copy([
                "from": "path",
                "into": "${code}",
                "using": ["method": "regex", "selector": "\\d+"],
            ]),
            json: [
                "copy": [
                    "from": "path",
                    "into": "${code}",
                    "using": ["method": "regex", "selector": "\\d+"],
                ],
            ]
        )

        static let lookup = Example(
            value: Behavior.lookup([
                "key": [
                    "from": "path",
                    "using": ["method": "regex", "selector": "/(.*)$"],
                    "index": 1,
                ],
                "fromDataSource": [
                    "csv": [
                        "path": "/app/values.csv",
                        "keyColumn": "Name",
                        "delimiter": ",",
                    ],
                ],
                "into": "${row}",
            ]),
            json: [
                "lookup": [
                    "key": [
                        "from": "path",
                        "using": ["method": "regex", "selector": "/(.*)$"],
                        "index": 1,
                    ],
                    "fromDataSource": [
                        "csv": [
                            "path": "/app/values.csv",
                            "keyColumn": "Name",
                            "delimiter": ",",
                        ],
                    ],
                    "into": "${row}",
                ],
            ]
        )

        static let decorate = Example(
            value: Behavior.decorate(
                "(config) => { config.response.headers['X-Test-token'] = Math.random() * 100; }"
            ),
            json: ["decorate": "(config) => { config.response.headers['X-Test-token'] = Math.random() * 100; }"]
        )

        static let shellTransform = Example(
            value: Behavior.shellTransform("node /app/addName.js"),
            json: ["shellTransform": "node /app/addName.js"]
        )
    }
}
