import Foundation
import MountebankSwift

extension Stub {
    enum Examples {
        static let text = Example(
            value: Stub(
                responses: [Stub.Response.Examples.text.value],
                predicates: [Stub.Predicate.equals(["path": "/text-200"])]
            ),
            json: [
                "responses": [Stub.Response.Examples.text.json],
                "predicates": [["equals" : ["path": "/text-200"]]]
            ]
        )

        static let json = Example(
            value: Stub(
                responses: [Stub.Response.Examples.json.value],
                predicates: [Stub.Predicate.equals(["path": "/json-200"])]
            ),
            json: [
                "responses": [Stub.Response.Examples.json.json],
                "predicates": [["equals" : ["path": "/json-200"]]]
            ]
        )

        static let http404 = Example(
            value: Stub(
                responses: [Stub.Response.Examples.http404.value],
                predicates: [Stub.Predicate.equals(["path": "/404"])]
            ),
            json: [
                "responses": [Stub.Response.Examples.http404.json],
                "predicates": [["equals" : ["path": "/404"]]]
            ]
        )

        // First 404, but 200 upon reload
        static let textWhenRefresh404 = Example(
            value: Stub(
                responses: [
                    Stub.Response.Examples.http404.value,
                    Stub.Response.Examples.text.value,
                ],
                predicates: [
                    Stub.Predicate.equals(["path": "/404-to-200"])
                ]
            ),
            json: [
                "responses": [
                    Stub.Response.Examples.http404.json,
                    Stub.Response.Examples.text.json,
                ],
                "predicates": [
                    ["equals" : ["path": "/404-to-200"]]
                ]
            ]
        )

        static let multiplePredicates = Example(
            value: Stub(
                responses: [Stub.Response.Examples.json.value],
                predicates: [
                    Stub.Predicate.Examples.equals.value,
                    Stub.Predicate.Examples.deepEquals.value,
                ]
            ),
            json: [
                "responses": [Stub.Response.Examples.json.json],
                "predicates": [
                    Stub.Predicate.Examples.equals.json,
                    Stub.Predicate.Examples.deepEquals.json,
                ]
            ]
        )
    }
}
