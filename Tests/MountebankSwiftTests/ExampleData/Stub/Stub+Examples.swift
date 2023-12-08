import Foundation
import MountebankSwift

extension Stub {
    enum Examples {
        static let all: [Example] = [
            text,
            json,
            http404,
            textWhenRefresh404,
            multiplePredicatesAndResponses
        ]

        static let text = Example(
            value: Stub(
                responses: [Stub.Response.Is.Examples.text.value],
                predicates: [Stub.Predicate.equals(
                    Stub.Request(path: "/text-200")
                )]
            ),
            json: [
                "responses": [["is": Stub.Response.Is.Examples.text.json]],
                "predicates": [["equals" : ["path": "/text-200"]]]
            ]
        )

        static let json = Example(
            value: Stub(
                responses: [Stub.Response.Is.Examples.json.value],
                predicates: [Stub.Predicate.equals(Stub.Request(path: "/json-200"))]
            ),
            json: [
                "responses": [["is": Stub.Response.Is.Examples.json.json]],
                "predicates": [["equals" : ["path": "/json-200"]]]
            ]
        )

        static let http404 = Example(
            value: Stub(
                responses: [Stub.Response.Is.Examples.http404.value],
                predicates: [Stub.Predicate.equals(Stub.Request(path: "/404"))]
            ),
            json: [
                "responses": [["is": Stub.Response.Is.Examples.http404.json]],
                "predicates": [["equals" : ["path": "/404"]]]
            ]
        )

        // First 404, but 200 upon reload
        static let textWhenRefresh404 = Example(
            value: Stub(
                responses: [
                    Stub.Response.Is.Examples.http404.value,
                    Stub.Response.Is.Examples.text.value,
                ],
                predicates: [
                    Stub.Predicate.equals(["path": "/404-to-200"])
                ]
            ),
            json: [
                "responses": [
                    ["is": Stub.Response.Is.Examples.http404.json],
                    ["is": Stub.Response.Is.Examples.text.json],
                ],
                "predicates": [
                    ["equals" : ["path": "/404-to-200"]]
                ]
            ]
        )

        static let multiplePredicatesAndResponses = Example(
            value: Stub(
                responses: 
                    Stub.Response.Is.Examples.allWithoutParameters.map(\.value) +
                    [
                        Stub.Response.Proxy.Examples.proxy.value,
                        Stub.Response.Fault.Examples.connectionResetByPeer.value,
                        Stub.Response.Inject.Examples.injectBody.value
                    ]
                ,
                predicates: Stub.Predicate.Examples.all.map(\.value)
            ),
            json: [
                "responses": .array(
                    Stub.Response.Is.Examples.allWithoutParameters
                        .map(\.json)
                        .map { ["is" : $0 ] } +
                    [
                        ["proxy": Stub.Response.Proxy.Examples.proxy.json],
                        ["fault": Stub.Response.Fault.Examples.connectionResetByPeer.json],
                        ["inject": Stub.Response.Inject.Examples.injectBody.json]
                    ]
                ),
                "predicates": .array(Stub.Predicate.Examples.all.map(\.json))
            ]
        )

        static let withResponseParameters = Example(
            value: Stub(
                responses: [Stub.Response.Is.Examples.withResponseParameters.value],
                predicates: Stub.Predicate.Examples.all.map(\.value)
            ),
            json: [
                "responses": [
                    [
                        "is": Stub.Response.Is.Examples.withResponseParameters.json,
                        "repeat": 5,
                        "behaviors": .array(Stub.Response.Behavior.Examples.all.map(\.json))
                    ]
                ],
                "predicates": .array(Stub.Predicate.Examples.all.map(\.json))
            ]
        )
    }
}
