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
                let dateOfBirth: Date
            }

            let foo: String
            let bar: Bar
        }

        static let jsonEncodable = Example(
            value: Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: SomeCodableObject(
                    foo: "Foo",
                    bar: SomeCodableObject.Bar(
                        dateOfBirth: Date(timeIntervalSinceReferenceDate: 10_000_00)
                    )
                )
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": [
                    "foo": "Foo",
                    "bar": [
                        "dateOfBirth": 1000000
                    ]
                ],
            ]
        )

        static let customJSONEncoder: JSONEncoder = {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return encoder
        }()

        static let jsonEncodableCustomDateFormatAndKeyEncodingStrategy = Example(
            value: Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: SomeCodableObject(
                    foo: "Foo",
                    bar: SomeCodableObject.Bar(
                        dateOfBirth: Date(timeIntervalSinceReferenceDate: 0)
                    )
                ),
                encoder: customJSONEncoder
            ),
            json: [
                "statusCode": 200,
                "headers": ["Content-Type": "application/json"],
                "body": [
                    "foo": "Foo",
                    "bar": [
                        "date_of_birth": "2001-01-01T00:00:00Z"
                    ]
                ],
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
            // Parameters should not be encoded inside the Is
            json: [
                "statusCode": 200,
                "body": "Hello world",
            ]
        )
    }
}
