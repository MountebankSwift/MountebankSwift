import Foundation
import MountebankSwift
import MountebankSwiftModels

extension Stub {
    enum Examples {
        static let all: [Example] = [
            text,
            json,
            simpleProxy,
            advancedProxy,
            predicateGeneratorsProxy,
            noPredicates,
            http404,
            injections,
            textWhenRefresh404,
            multiplePredicatesAndResponses,
        ]

        static let text = Example(
            value: Stub(
                responses: [Is.Examples.text.value],
                predicates: [Predicate.equals(
                    Request(path: "/text-200")
                )]
            ),
            json: [
                "responses": [["is": Is.Examples.text.json]],
                "predicates": [["equals" : ["path": "/text-200"]]],
            ]
        )

        static let json = Example(
            value: Stub(
                response: Is.Examples.json.value,
                predicates: [Predicate.equals(Request(path: "/json-200"))]
            ),
            json: [
                "responses": [["is": Is.Examples.json.json]],
                "predicates": [["equals" : ["path": "/json-200"]]],
            ]
        )

        static let http404 = Example(
            value: Stub(
                response: Is.Examples.http404.value,
                predicate: Predicate.equals(Request(path: "/404"))
            ),
            json: [
                "responses": [["is": Is.Examples.http404.json]],
                "predicates": [["equals" : ["path": "/404"]]],
            ]
        )

        // First 404, but 200 upon reload
        static let textWhenRefresh404 = Example(
            value: Stub(
                responses: [
                    Is.Examples.http404.value,
                    Is.Examples.text.value,
                ],
                predicate: Predicate.equals(Request(path: "/404-to-200"))
            ),
            json: [
                "responses": [
                    ["is": Is.Examples.http404.json],
                    ["is": Is.Examples.text.json],
                ],
                "predicates": [
                    ["equals" : ["path": "/404-to-200"]],
                ],
            ]
        )

        static let injections = Example(
            value: Stub(
                responses: [
                    Inject.Examples.injectBodySingleLine.value,
                    Inject.Examples.injectBodyMultiline.value,
                ],
                predicate: Predicate.equals(Request(path: "/injection"))
            ),
            json: [
                "responses": [
                    ["inject": Inject.Examples.injectBodySingleLine.json],
                    ["inject": Inject.Examples.injectBodyMultiline.json],
                ],
                "predicates": [
                    ["equals" : ["path": "/injection"]],
                ],
            ]
        )

        static let simpleProxy = Example(
            value: Stub(
                response: Proxy.Examples.simple.value
            ),
            json: [
                "responses": [["proxy": Proxy.Examples.simple.json]],
            ]
        )

        static let advancedProxy = Example(
            value: Stub(
                response: Proxy.Examples.advanced.value
            ),
            json: [
                "responses": [["proxy": Proxy.Examples.advanced.json]],
            ]
        )

        static let predicateGeneratorsProxy = Example(
            value: Stub(
                response: Proxy.Examples.predicateGenerators.value
            ),
            json: [
                "responses": [["proxy": Proxy.Examples.predicateGenerators.json]],
            ]
        )

        static let multiplePredicatesAndResponses = Example(
            value: Stub(
                responses:
                Is.Examples.allWithoutParameters.map(\.value) +
                    [
                        Proxy.Examples.simple.value,
                        Fault.Examples.connectionResetByPeer.value,
                        Inject.Examples.injectBodySingleLine.value,
                    ]
                ,
                predicates: Predicate.Examples.all.map(\.value)
            ),
            json: [
                "responses": .array(
                    Is.Examples.allWithoutParameters
                        .map(\.json)
                        .map { ["is" : $0] } +
                        [
                            ["proxy": Proxy.Examples.simple.json],
                            ["fault": Fault.Examples.connectionResetByPeer.json],
                            ["inject": Inject.Examples.injectBodySingleLine.json],
                        ]
                ),
                "predicates": .array(Predicate.Examples.all.map(\.json)),
            ]
        )

        static let withResponseParameters = Example(
            value: Stub(
                responses: [Is.Examples.withResponseParameters.value],
                predicates: Predicate.Examples.all.map(\.value)
            ),
            json: [
                "responses": [
                    (["is": Is.Examples.withResponseParameters.json] as JSON)
                        .merging(with: ResponseParameters.Examples.full.json),
                ],
                "predicates": .array(Predicate.Examples.all.map(\.json)),
            ]
        )

        static let noPredicates = Example(
            value: Stub(
                response: Is.Examples.text.value
            ),
            json: [
                "responses": [
                    ["is": Is.Examples.text.json],
                ],
            ]
        )
    }
}
