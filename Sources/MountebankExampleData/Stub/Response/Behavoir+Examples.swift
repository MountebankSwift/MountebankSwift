import Foundation
import MountebankSwift
import MountebankSwiftModels

extension Behavior {
    enum Examples {
        static let all = [
            wait,
            waitJavascript,
            copyCode,
            copyHeader,
            copyQuery,
            copyXpath,
            copyJsonPath,
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

        static let copyCode = Example(
            value: Behavior.copy(
                from: "path",
                into: "${code}",
                using: .regex(selector: "\\d+")
            ),
            json: [
                "copy": [
                    "from": "path",
                    "into": "${code}",
                    "using": ["method": "regex", "selector": "\\d+"],
                ],
            ]
        )

        static let copyHeader = Example(
            value: Behavior.copy(
                from: ["headers": "X-Request"],
                into: "${header}",
                using: .regex(selector: ".+")
            ),
            json: [
                "copy": [
                    "from": ["headers": "X-Request"],
                    "into": "${header}",
                    "using": ["method": "regex", "selector": ".+"],
                ],
            ]
        )

        static let copyQuery = Example(
            value: Behavior.copy(
                from: ["query": "name"],
                into: "${name}",
                using: .regex(selector: "MOUNT\\w+$", options: [.ignoreCase])
            ),
            json: [
                "copy": [
                    "from": ["query": "name"],
                    "into": "${name}",
                    "using": [
                        "method": "regex",
                        "selector": "MOUNT\\w+$",
                        "options": ["ignoreCase": true],
                    ],
                ],
            ]
        )

        static let copyXpath = Example(
            value: Behavior.copy(
                from: ["body"],
                into: "BOOK",
                using: .xpath(
                    selector: "//isbn:title",
                    namespace: ["isbn": "http://schemas.isbn.org/ns/1999/basic.dtd"]
                )
            ),
            json: [
                "copy": [
                    "from": ["body"],
                    "into": "BOOK",
                    "using": [
                        "method": "xpath",
                        "selector": "//isbn:title",
                        "ns": ["isbn": "http://schemas.isbn.org/ns/1999/basic.dtd"],
                    ],
                ],
            ]
        )

        static let copyJsonPath = Example(
            value: Behavior.copy(
                from: ["body"],
                into: "BOOK",
                using: .jsonpath(selector: "$..title")
            ),
            json: [
                "copy": [
                    "from": ["body"],
                    "into": "BOOK",
                    "using": [
                        "method": "jsonpath",
                        "selector": "$..title",
                    ],
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
