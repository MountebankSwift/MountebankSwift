import Foundation
import MountebankSwift

extension Stub.Response {
    enum Examples {
        static let all: [Example] = [
            text,
            html,
            json,
            binary,
            http404,
            proxy,
            injectBody,
            connectionResetByPeer,
            randomDataThenClose,
            responseParameters
        ]

        static let text = Example(
            value: Stub.Response.is(
                Is(statusCode: 200, body: "Hello world")
            ),
            json: [
                "is": ["statusCode": 200, "body": "Hello world"]
            ]
        )

        static let html = Example(
            value: Stub.Response.is(
                Is(
                    statusCode: 200,
                    headers: ["Content-Type": "text/html"],
                    body: "<html><body><h1>Who needs HTML?</h1></html>"
                )
            ),
            json: [
                "is": [
                    "statusCode": 200,
                    "headers" : ["Content-Type": "text/html"],
                    "body": "<html><body><h1>Who needs HTML?</h1></html>"
                ]
            ]
        )

        static let json = Example(
            value: Stub.Response.is(
                Is(
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"],
                    body: ["bikeId": 123, "name": "Turbo Bike 4000"]
                )
            ),
            json: [
                "is": [
                    "statusCode": 200,
                    "headers": ["Content-Type": "application/json"],
                    "body": ["bikeId": 123, "name": "Turbo Bike 4000"]
                ]
            ]
        )

        static let binary = Example(
            value: Stub.Response.is(
                Is(statusCode: 200, body: StubImage.example.value)
            ),
            json: [
                "is" : [
                    "_mode" : "binary",
                    "statusCode" : 200,
                    "body" : StubImage.example.json
                ]
            ]
        )

        static let http404 = Example(
            value: Stub.Response.is(
                Is(statusCode: 404)
            ),
            json: [
                "is" : ["statusCode" : 404]
            ]
        )

        static let proxy = Example(
            value: Stub.Response.proxy(
                Proxy(to: "https://www.somesite.com:3000", mode: .proxyAlways)
            ),
            json: [
                "proxy": [
                    "to": "https://www.somesite.com:3000",
                    "mode": "proxyAlways"
                ]
            ]
        )

        static let injectBody = Example(
            value: Stub.Response.inject(
                "(config) => { return { \"body\": \"hello world\" }; }"
            ),
            json: [
                "inject": "(config) => { return { \"body\": \"hello world\" }; }"
            ]
        )

        static let connectionResetByPeer = Example(
            value: Stub.Response.fault(.connectionResetByPeer),
            json: ["fault": "CONNECTION_RESET_BY_PEER"]
        )

        static let randomDataThenClose = Example(
            value: Stub.Response.fault(.randomDataThenClose),
            json: ["fault": "RANDOM_DATA_THEN_CLOSE"]
        )

        static let responseParameters = Example(
            value: Stub.Response.is(
                Stub.Response.Is(statusCode: 200, body: "Hello world"),
                Stub.Response.Parameters.Examples.full.value
            ),
            json: JSON(mergingObjects: [
                ["is": ["statusCode": 200, "body": "Hello world"]],
                Stub.Response.Parameters.Examples.full.json
            ])
        )

    }
}
