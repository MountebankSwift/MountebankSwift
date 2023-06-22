import XCTest
@testable import MountebankSwift

final class ImposterTests: XCTestCase {
    let imposter = Imposter(
        port: 4545,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-is-200"))],
                responses: [
                    .is(Stub.Response.Is(statusCode: 200, body: "hello world", mode: .text), Stub.Response.Parameters(repeatCount: 3)),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-is-404"))],
                responses: [
                    .is(Stub.Response.Is(statusCode: 404), Stub.Response.Parameters(repeatCount: 2)),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-proxy"))],
                responses: [
                    .proxy(Stub.Response.Proxy(to: "https://www.somesite.com:3000", mode: "proxyAlways"), nil),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-injection"))],
                responses: [
                    .inject(injection: "(config) => { return { body: \"hello world\" }; }", nil),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-fault"))],
                responses: [
                    .fault(.connectionResetByPeer, nil),
                ]
            ),
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
    "stubs": [
        {
            "predicates": [{"equals": {"path": "/test-is-200"}}],
            "responses": [{ "is": { "statusCode": 200, "body": "Hello world", "_mode": "text" }, "repeat": 3 }]
        },
        {
            "predicates": [{"equals": {"path": "/test-is-404"}}],
            "responses": [{ "is": { "statusCode": 404 }, "repeat": 2 }]
        },
        {
            "predicates": [{"equals": {"path": "/test-proxy"}}],
            "responses": [{ "proxy": {"to": "https://www.somesite.com:3000", "mode": "proxyAlways"} }]
        },
        {
            "predicates": [{"equals": {"path": "/test-inject"}}],
            "responses": [{ "inject": "(config) => { return { body: \"hello world\" }; }" }]
        }
    ]
}
"""
