import XCTest
@testable import MountebankSwift

final class ImposterTests: XCTestCase {
    let imposter = Imposter(
        port: 4545,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub.httpResponse200,
            Stub.httpResponse404,
            Stub.proxy,
            Stub.injectBody,
            Stub.connectionResetByPeer,
            Stub.json,
            Stub.binary,
            Stub.html200,
        ],
        defaultResponse: Stub.Response.Is(
            statusCode: 400,
            headers: ["default-header": "set-by-mountebank"],
            body: "Bad Request - 400"
        )
    )

    func testEncode() throws {
        let jsonData = try testEncoder.encode(imposter)
        let json = String(data: jsonData, encoding: .utf8)!
        print(json)
    }

    func testEncodeDecodeDataStub() throws {
        try assertEncodeDecode(Stub.httpResponse200)
        try assertEncodeDecode(Stub.html200)
        try assertEncodeDecode(Stub.json)
        try assertEncodeDecode(Stub.binary)
        try assertEncodeDecode(Stub.httpResponse404)
        try assertEncodeDecode(Stub.proxy)
        try assertEncodeDecode(Stub.injectBody)
        try assertEncodeDecode(Stub.connectionResetByPeer)
    }

    func testEncodeDecodeParameters() throws {
        try assertEncodeDecode(
            Stub.Response.is(
                Stub.Response.Is(statusCode: 200),
                Stub.Response.Parameters(repeatCount: nil)
            )
        )

        try assertEncodeDecode(
            Stub.Response.is(
                Stub.Response.Is(statusCode: 200),
                Stub.Response.Parameters(repeatCount: 5)
            )
        )
    }

    func testDecode() throws {
        let data = exampleJSON.data(using: .utf8)
        let decodedImposters = try testDecoder.decode(Imposter.self, from: data!)
        XCTAssertEqual(decodedImposters.stubs.count, imposter.stubs.count)
        XCTAssertEqual(imposter, decodedImposters)
    }

    func testEncodeDecode() throws {
        try assertEncodeDecode(imposter)
    }

//    func skip_testDecodeEncode() throws {
//        try assertDecodeEncode(exampleJSON, as: Imposter.self)
//    }
}

private let exampleJSON = """
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
            "responses": [{ "inject": "(config) => { return { body: \\"hello world\\" }; }" }]
        },
        {
            "predicates": [{"equals": {"path": "/test-fault"}}],
            "responses": [{ "fault": "CONNECTION_RESET_BY_PEER" }]
        },
        {
            "predicates" : [{"equals" : {"path" : "/test-json"}}],
            "responses" : [{"is" : {"statusCode" : 200, "body" : {"name" : "Turbo Bike 4000", "bikeId" : 123 }}}]
        },
        {
            "predicates" : [{"equals" : {"path" : "/test-binary"}}],
            "responses" : [{
                "is" : {
                    "_mode" : "binary",
                    "statusCode" : 200,
                    "body" : "\(StubImage.exampleBase64String)"
                }
            }]
        },
        {
            "predicates" : [{"equals" : {"path" : "/test-html-200"}}],
            "responses" : [{"is" : {"statusCode" : 200, "body" : "<html><body><h1>Who needs HTML?</h1></html>"}}]
        }
    ],
    "defaultResponse" : {
        "statusCode": 400,
        "headers": {"default-header": "set-by-mountebank"},
        "body": "Bad Request - 400"
    }
}
"""
