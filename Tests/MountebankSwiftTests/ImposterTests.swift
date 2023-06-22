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
            Stub.html200
        ]
    )

    func testEncode() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try encoder.encode(imposter)

        let json = String(data: jsonData, encoding: .utf8)!
        print(json)
    }

    func testEncodeDecodeDataStub() throws {
        try encodeDecode(value: Stub.binary.responses[0])
    }


    func testDecode() throws {
        let data = exampleJSON.data(using: .utf8)
        let decodedImposters = try JSONDecoder().decode(Imposter.self, from: data!)
        XCTAssertEqual(decodedImposters.stubs.count, imposter.stubs.count)
        XCTAssertEqual(decodedImposters.stubs[0].predicates, imposter.stubs[0].predicates)
        XCTAssertEqual(decodedImposters.stubs[0].responses[0], imposter.stubs[0].responses[0])
        XCTAssertEqual(decodedImposters.stubs[0].responses[0], imposter.stubs[0].responses[0])

        XCTAssertEqual(decodedImposters.stubs[1].predicates, imposter.stubs[1].predicates)
        XCTAssertEqual(decodedImposters.stubs[1].responses[0], imposter.stubs[1].responses[0])

        XCTAssertEqual(decodedImposters.stubs[2].predicates, imposter.stubs[2].predicates)
        XCTAssertEqual(decodedImposters.stubs[2].responses[0], imposter.stubs[2].responses[0])

        XCTAssertEqual(decodedImposters.stubs[3].predicates, imposter.stubs[3].predicates)
        XCTAssertEqual(decodedImposters.stubs[3].responses[0], imposter.stubs[3].responses[0])

        XCTAssertEqual(decodedImposters.stubs[4].predicates, imposter.stubs[4].predicates)
        XCTAssertEqual(decodedImposters.stubs[4].responses[0], imposter.stubs[4].responses[0])

        XCTAssertEqual(decodedImposters.stubs[5].predicates, imposter.stubs[5].predicates)
        XCTAssertEqual(decodedImposters.stubs[5].responses[0], imposter.stubs[5].responses[0])

        XCTAssertEqual(decodedImposters.stubs[6].predicates, imposter.stubs[6].predicates)
        XCTAssertEqual(decodedImposters.stubs[6].responses[0], imposter.stubs[6].responses[0])

        XCTAssertEqual(imposter, decodedImposters)
    }

    func testEncodeDecode() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(imposter)

        let decodedImposters = try JSONDecoder().decode(Imposter.self, from: jsonData)

        XCTAssertEqual(decodedImposters.port, imposter.port)
        XCTAssertEqual(decodedImposters.scheme, imposter.scheme)
        XCTAssertEqual(decodedImposters.name, imposter.name)
        XCTAssertEqual(decodedImposters.stubs.count, imposter.stubs.count)
        XCTAssertEqual(decodedImposters.stubs[0].predicates, imposter.stubs[0].predicates)
        XCTAssertEqual(decodedImposters.stubs[0].responses[0], imposter.stubs[0].responses[0])
        XCTAssertEqual(decodedImposters.stubs[0].responses[0], imposter.stubs[0].responses[0])

        XCTAssertEqual(decodedImposters.stubs[1].predicates, imposter.stubs[1].predicates)
        XCTAssertEqual(decodedImposters.stubs[1].responses[0], imposter.stubs[1].responses[0])

        XCTAssertEqual(decodedImposters.stubs[2].predicates, imposter.stubs[2].predicates)
        XCTAssertEqual(decodedImposters.stubs[2].responses[0], imposter.stubs[2].responses[0])

        XCTAssertEqual(decodedImposters.stubs[3].predicates, imposter.stubs[3].predicates)
        XCTAssertEqual(decodedImposters.stubs[3].responses[0], imposter.stubs[3].responses[0])

        XCTAssertEqual(decodedImposters.stubs[4].predicates, imposter.stubs[4].predicates)
        XCTAssertEqual(decodedImposters.stubs[4].responses[0], imposter.stubs[4].responses[0])

        XCTAssertEqual(decodedImposters.stubs[5].predicates, imposter.stubs[5].predicates)
        XCTAssertEqual(decodedImposters.stubs[5].responses[0], imposter.stubs[5].responses[0])

        XCTAssertEqual(decodedImposters.stubs[6].predicates, imposter.stubs[6].predicates)
        XCTAssertEqual(decodedImposters.stubs[6].responses[0], imposter.stubs[6].responses[0])

        XCTAssertEqual(imposter, decodedImposters)
    }

    func encodeDecode<SomeType: Codable & Equatable>(value: SomeType, line: UInt = #line) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(value)
        let decoded = try JSONDecoder().decode(SomeType.self, from: data)
        XCTAssertEqual(value, decoded, line: line)
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
            "responses" : [{"is" : {"statusCode" : 200, "body" : "<html><body><marquee>Who needs html 5?</marquee></html>"}}]
        }
    ]
}
"""
