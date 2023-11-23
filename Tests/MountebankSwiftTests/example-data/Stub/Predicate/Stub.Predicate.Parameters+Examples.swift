import Foundation
import MountebankSwift

extension Stub.Predicate.Parameters {
    enum Examples {
        static let all = [
            caseSensiteve,
            except,
            xPath,
            jsonPath,
            full,
        ]

        static let caseSensiteve = Example(
            value: Stub.Predicate.Parameters(caseSensitive: true),
            json: ["caseSensitive" : true]
        )

        static let except = Example(
            value: Stub.Predicate.Parameters(except: "^Foo"),
            json: ["except": "^Foo"]
        )

        static let xPath = Example(
            value: Stub.Predicate.Parameters(
                xPath: Stub.Predicate.XPath(
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
            value: Stub.Predicate.Parameters(jsonPath: Stub.Predicate.JSONPath(selector: "$..title")),
            json: ["jsonpath": ["selector": "$..title"]]
        )

        static let full = Example(
            value: Stub.Predicate.Parameters(
                caseSensitive: true,
                except: "^The ",
                xPath: Stub.Predicate.XPath(
                    selector: "//a:title",
                    namespace: ["a": "http://example.com/book"]
                ),
                jsonPath: Stub.Predicate.JSONPath(selector: "$..title")
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
