import Foundation
import MountebankSwift

extension Is {
    enum Examples {
        static let allWithoutParameters: [Example] = [
            text,
            html,
            json,
            binary,
            http404,
        ]

        static let text = Example(
            value: Is(statusCode: 200, body: "Hello world"),
            json: ["statusCode": 200, "body": "Hello world"]
        )

        static let html = Example(
            value: Is(
                statusCode: 200,
                headers: ["Content-Type": "text/html"],
                body: "<html><body><h1>Who needs HTML?</h1></html>"
            ),
            json: [
                "statusCode": 200,
                "headers" : ["Content-Type": "text/html"],
                "body": "<html><body><h1>Who needs HTML?</h1></html>",
            ]
        )

        static let json = Example(
            value: Is(
                statusCode: 200,
                body: ["bikeId": 123, "name": "Turbo Bike 4000"]
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": ["bikeId": 123, "name": "Turbo Bike 4000"],
            ]
        )

        struct SomeCodableObject: Codable {
            struct Bar: Codable {
                let baz: String
            }

            let foo: String
            let bar: Bar
        }

        static let jsonEncodable = Example(
            value: Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: SomeCodableObject(foo: "Foo", bar: SomeCodableObject.Bar(baz: "Baz"))
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": ["foo": "Foo", "bar": ["baz": "Baz"]],
            ]
        )

        static let binary = Example(
            value: Is(statusCode: 200, body: StubImage.example.value),
            json: [
                "_mode" : "binary",
                "statusCode" : 200,
                "body" : StubImage.example.json,
            ]
        )

        static let http404 = Example(
            value: Is(statusCode: 404),
            json: ["statusCode" : 404]
        )

        static let withResponseParameters = Example(
            value: Is(
                statusCode: 200,
                body: "Hello world",
                parameters: ResponseParameters(
                    repeatCount: 5,
                    behaviors: Behavior.Examples.all.map(\.value)
                )
            ),
            // Parameters should not encoded inside the Is
            json: [
                "statusCode": 200,
                "body": "Hello world",
            ]
        )
    }
}

extension Inject {
    enum Examples {
        static let injectBody = Example(
            value: Inject(
                "(config) => { return { \"body\": \"hello world\" }; }"
            ),
            json: "(config) => { return { \"body\": \"hello world\" }; }"
        )
    }
}

extension Fault {
    enum Examples {
        static let connectionResetByPeer = Example(
            value: Fault.connectionResetByPeer,
            json: "CONNECTION_RESET_BY_PEER"
        )

        static let randomDataThenClose = Example(
            value: Fault.randomDataThenClose,
            json: "RANDOM_DATA_THEN_CLOSE"
        )
    }
}

extension Proxy {
    enum Examples {
        static let proxy = Example(
            value: Proxy(to: "https://www.somesite.com:3000", mode: .proxyAlways),
            json: [
                "to": "https://www.somesite.com:3000",
                "mode": "proxyAlways",
            ]
        )
    }
}
