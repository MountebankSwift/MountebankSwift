import Foundation
import MountebankSwift

extension MountebankSwift.Predicate {
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
            withParameters,
        ]

        static let equals = Example(
            value: Predicate.equals(
                Request(
                    method: .put,
                    path: "/test-is-200",
                    query: ["key": ["first", "second"]],
                    headers: ["foo": "bar"],
                    data: ["baz"]
                )
            ),
            json: [
                "equals" : [
                    "method": "PUT",
                    "path": "/test-is-200",
                    "query": ["key": ["first", "second"]],
                    "headers": ["foo": "bar"],
                    "data": ["baz"]
                ],
            ]
        )

        static let deepEquals = Example(
            value: Predicate.deepEquals(
                Request(query: ["key": ["first", "second"]])
            ),
            json: [
                "deepEquals": [
                    "query": ["key": ["first", "second"]],
                ],
            ]
        )

        static let contains = Example(
            value: Predicate.contains(
                Request(data: "AgM=")
            ),
            json: [
                "contains": ["data": "AgM="],
            ]
        )

        static let startsWith = Example(
            value: Predicate.startsWith(
                Request(data: "first")
            ),
            json: [
                "startsWith": ["data": "first"],
            ]
        )

        static let endsWith = Example(
            value: Predicate.endsWith(
                Request(data: "last")
            ),
            json: [
                "endsWith": ["data": "last"],
            ]
        )

        static let matches = Example(
            value: Predicate.matches(
                Request(data: "^first")
            ),
            json: [
                "matches": ["data": "^first"],
            ]
        )

        static let exists = Example(
            value: Predicate.exists(
                Request(query: ["q": true, "search": false])
            ),
            json: [
                "exists": ["query": ["q" : true, "search" : false]],
            ]
        )

        static let not = Example(
            value: Predicate.not(
                Predicate.Examples.equals.value
            ),
            json: [
                "not": Predicate.Examples.equals.json,
            ]
        )

        static let or = Example(
            value: Predicate.or(
                [
                    Predicate.Examples.equals.value,
                    Predicate.Examples.contains.value,
                ]
            ),
            json: [
                "or": [
                    Predicate.Examples.equals.json,
                    Predicate.Examples.contains.json,
                ],
            ]
        )

        static let and = Example(
            value: Predicate.and(
                [
                    Predicate.Examples.equals.value,
                    Predicate.Examples.deepEquals.value,
                ]
            ),
            json: [
                "and": [
                    Predicate.Examples.equals.json,
                    Predicate.Examples.deepEquals.json,
                ],
            ]
        )

        static let inject = Example(
            value: Predicate.inject(
                "(config) => { return config.request.headers['Authorization'] == 'Bearer <my-token>'; }"
            ),
            json: [
                "inject" : "(config) => { return config.request.headers['Authorization'] == 'Bearer <my-token>'; }",
            ]
        )

        static let withParameters = Example(
            value: Predicate.equals(
                Request(path: "/with-parameters"),
                PredicateParameters.Examples.full.value
            ),
            json: (["equals" : ["path": "/with-parameters"]] as JSON)
                .merging(with: PredicateParameters.Examples.full.json)
        )
    }
}
