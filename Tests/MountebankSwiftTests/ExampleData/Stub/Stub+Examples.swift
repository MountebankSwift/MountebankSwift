import Foundation
import MountebankSwift

extension Stub {
    enum Examples {
        static let all: [Example] = [
            text,
            json,
            http404,
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

        static let multiplePredicatesAndResponses = Example(
            value: Stub(
                responses:
                Is.Examples.allWithoutParameters.map(\.value) +
                    [
                        Proxy.Examples.proxy.value,
                        Fault.Examples.connectionResetByPeer.value,
                        Inject.Examples.injectBody.value,
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
                            ["proxy": Proxy.Examples.proxy.json],
                            ["fault": Fault.Examples.connectionResetByPeer.json],
                            ["inject": Inject.Examples.injectBody.json],
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
    }
}
