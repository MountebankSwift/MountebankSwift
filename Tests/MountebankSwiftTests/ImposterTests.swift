import XCTest
@testable import MountebankSwift

final class ImposterTests: XCTestCase {
    let imposter = Imposter(
        port: 4545,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub(
                predicates: [.equals],
                responses: [
                    .is(Response.Is(statusCode: 200, body: "hello world"), nil)
                ])
        ]
    )

    func testEncode() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(imposter)
        let json = String(data: jsonData, encoding: .utf8)!
        print(json)
    }

    func testDecode() throws {
        let data = exampleJSON.data(using: .utf8)
        let imposter = try JSONDecoder().decode(Imposter.self, from: data!)
        print(imposter)
    }
}

fileprivate let exampleJSON = """
{
    "port": 4545,
    "protocol": "https",
    "name": "imposter contract service",
    "recordRequests": "true",
    "numberOfRequests": "1",
    "defaultResponse": {
        "statusCode": 400,
        "body": "Bad Request",
        "headers": {}
    },
    "stubs": [
        {
            "responses": [
                {
                    "is": {
                        "statusCode": 201,
                        "headers": {
                            "Location": "http://example.com/resource"
                        },
                        "body": "The time is ${TIME}",
                        "_mode": "text"
                    },
                    "repeat": 3,
                    "behaviors": [
                        {
                            "wait": 500
                        },
                        {
                            "decorate": "config => { config.response.body = config.response.body.replace('${TIME}', 'now'); }"
                        },
                        {
                            "shellTransform": "transformResponse"
                        },
                        {
                            "copy": {
                                "from": "body",
                                "into": "${NAME}",
                                "using": {
                                    "method": "xpath",
                                    "selector": "//test:name",
                                    "ns": {
                                        "test": "http://example.com/test"
                                    }
                                }
                            }
                        }
                    ]
                }
            ],
            "predicates": [
                {
                    "equals": {
                        "body": "value"
                    },
                    "caseSensitive": true,
                    "except": "^The ",
                    "jsonpath": {
                        "selector": "$..book"
                    },
                    "xpath": {
                        "selector": "//book/@title",
                        "ns": {
                            "isbn": "http://schemas.isbn.org/ns/1999/basic.dtd"
                        }
                    }
                }
            ]
        }
    ]
}
"""
