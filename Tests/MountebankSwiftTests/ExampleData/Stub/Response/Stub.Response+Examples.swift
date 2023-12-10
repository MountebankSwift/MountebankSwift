import Foundation
import MountebankSwift

extension Stub.Response.Is {
    enum Examples {
        static let allWithoutParameters: [Example] = [
            text,
            html,
            json,
            binary,
            http404
        ]

        static let text = Example(
            value: Stub.Response.Is(statusCode: 200, body: "Hello world"),
            json: ["statusCode": 200, "body": "Hello world"]
        )

        static let html = Example(
            value: Stub.Response.Is(
                statusCode: 200,
                headers: ["Content-Type": "text/html"],
                body: "<html><body><h1>Who needs HTML?</h1></html>"
            ),
            json: [
                "statusCode": 200,
                "headers" : ["Content-Type": "text/html"],
                "body": "<html><body><h1>Who needs HTML?</h1></html>"
            ]
        )

        static let json = Example(
            value: Stub.Response.Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: ["bikeId": 123, "name": "Turbo Bike 4000"]
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": ["bikeId": 123, "name": "Turbo Bike 4000"]
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
            value: Stub.Response.Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: SomeCodableObject(foo: "Foo", bar: SomeCodableObject.Bar(baz: "Baz"))
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": ["foo": "Foo", "bar": ["baz": "Baz"]]
            ]
        )

        static let binary = Example(
            value: Stub.Response.Is(statusCode: 200, body: StubImage.example.value),
            json: [
                "_mode" : "binary",
                "statusCode" : 200,
                "body" : StubImage.example.json
            ]
        )

        static let http404 = Example(
            value: Stub.Response.Is(statusCode: 404),
            json: ["statusCode" : 404]
        )

        static let withResponseParameters = Example(
            value: Stub.Response.Is(
                statusCode: 200,
                body: "Hello world",
                repeatCount: 5,
                behaviors: Stub.Response.Behavior.Examples.all.map(\.value)
            ),
            json: ["statusCode": 200, "body": "Hello world"]
        )
    }
}

extension Stub.Response.Inject {
    enum Examples {
        static let injectBody = Example(
            value: Stub.Response.Inject(
                "(config) => { return { \"body\": \"hello world\" }; }"
            ),
            json: "(config) => { return { \"body\": \"hello world\" }; }"
        )
    }
}

extension Stub.Response.Fault {
    enum Examples {
        static let connectionResetByPeer = Example(
            value: Stub.Response.Fault.connectionResetByPeer,
            json: "CONNECTION_RESET_BY_PEER"
        )

        static let randomDataThenClose = Example(
            value: Stub.Response.Fault.randomDataThenClose,
            json: "RANDOM_DATA_THEN_CLOSE"
        )
    }
}

extension Stub.Response.Proxy {
    enum Examples {
        static let proxy = Example(
            value: Stub.Response.Proxy(to: "https://www.somesite.com:3000", mode: .proxyAlways),
            json: [
                "to": "https://www.somesite.com:3000",
                "mode": "proxyAlways"
            ]
        )
    }
}
