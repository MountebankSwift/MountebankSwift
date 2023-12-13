import Foundation
import MountebankSwift

extension PredicateParameters {
    enum Examples {
        static let all = [
            caseSensiteve,
            except,
            xPath,
            jsonPath,
            full,
        ]

        static let caseSensiteve = Example(
            value: PredicateParameters(caseSensitive: true),
            json: ["caseSensitive" : true]
        )

        static let except = Example(
            value: PredicateParameters(except: "^Foo"),
            json: ["except": "^Foo"]
        )

        static let xPath = Example(
            value: PredicateParameters(
                xPath: XPath(
                    selector: "//a:title",
                    namespace: ["a": "http://example.com/book"]
                )
            ),
            json: [
                "xpath": [
                    "selector": "//a:title",
                    "ns": ["a": "http://example.com/book"]
                ]
            ]
        )

        static let jsonPath = Example(
            value: PredicateParameters(jsonPath: JSONPath(selector: "$..title")),
            json: ["jsonpath": ["selector": "$..title"]]
        )

        static let full = Example(
            value: PredicateParameters(
                caseSensitive: true,
                except: "^The ",
                xPath: XPath(
                    selector: "//a:title",
                    namespace: ["a": "http://example.com/book"]
                ),
                jsonPath: JSONPath(selector: "$..title")
            ),
            json: [
                "except": "^The ",
                "caseSensitive": true,
                "xpath": [
                    "selector": "//a:title",
                    "ns": ["a": "http://example.com/book"]
                ],
                "jsonpath": ["selector": "$..title"]
            ]
        )
    }
}
