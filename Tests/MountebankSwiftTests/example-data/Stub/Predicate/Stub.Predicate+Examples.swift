import Foundation
import MountebankSwift

extension Stub.Predicate {
    enum Examples {
        static let all = [
            equals,
            deepEquals,
            contains,
            startsWith,
            endsWith,
            matches,
            exists,
            not,
            or,
            and,
            inject,
            withParameters
        ]

        static let equals = Example(
            value: Stub.Predicate.equals(
                ["path": "/test-is-200"]
            ),
            json: [
                "equals" : ["path": "/test-is-200"]
            ]
        )

        static let deepEquals = Example(
            value: Stub.Predicate.deepEquals(
                ["query": ["key": ["first", "second"]]]
            ),
            json: [
                "deepEquals": [
                    "query": ["key": ["first", "second"]]
                ]
            ]
        )

        static let contains = Example(
            value: Stub.Predicate.contains(
                ["data": "AgM="]
            ),
            json: [
                "contains": ["data": "AgM="]
            ]
        )

        static let startsWith = Example(
            value: Stub.Predicate.startsWith(
                ["data": "first"]
            ),
            json: [
                "startsWith": ["data": "first"]
            ]
        )

        static let endsWith = Example(
            value: Stub.Predicate.endsWith(
                ["data": "last"]
            ),
            json: [
                "endsWith": ["data": "last"]
            ]
        )

        static let matches = Example(
            value: Stub.Predicate.matches(
                ["data": "^first"]
            ),
            json: [
                "matches": ["data": "^first"]
            ]
        )

        static let exists = Example(
            value: Stub.Predicate.exists(
                ["query": ["q": true, "search": false]]
            ),
            json: [
                "exists": ["query": ["q" : true, "search" : false]]
            ]
        )

        static let not = Example(
            value: Stub.Predicate.not(
                Stub.Predicate.Examples.equals.value
            ),
            json: [
                "not": Stub.Predicate.Examples.equals.json
            ]
        )

        static let or = Example(
            value: Stub.Predicate.or(
                [
                    Stub.Predicate.Examples.equals.value,
                    Stub.Predicate.Examples.contains.value
                ]
            ),
            json: [
                "or": [
                    Stub.Predicate.Examples.equals.json,
                    Stub.Predicate.Examples.contains.json
                ]
            ]
        )

        static let and = Example(
            value: Stub.Predicate.and(
                [
                    Stub.Predicate.Examples.equals.value,
                    Stub.Predicate.Examples.deepEquals.value
                ]
            ),
            json: [
                "and": [
                    Stub.Predicate.Examples.equals.json,
                    Stub.Predicate.Examples.deepEquals.json
                ]
            ]
        )

        static let inject = Example(
            value: Stub.Predicate.inject(
                "(config) => { return config.request.headers['Authorization'] == 'Bearer <my-token>'; }"
            ),
            json: [
                "inject" : "(config) => { return config.request.headers['Authorization'] == 'Bearer <my-token>'; }"
            ]
        )

        static let withParameters = Example(
            value: Stub.Predicate.equals(
                ["path": "/with-parameters"],
                Stub.Predicate.Parameters.Examples.full.value
            ),
            json: JSON(mergingObjects: [
                ["equals" : ["path": "/with-parameters"]],
                Stub.Predicate.Parameters.Examples.full.json
            ])
        )
    }
}

