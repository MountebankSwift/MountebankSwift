import MountebankSwift

import XCTest

class IsInitializersTests: XCTestCase {

    func testInitWithTextBody() throws {
        let bodyText = "This is a body text"
        let sut = Is(body: bodyText)

        XCTAssertEqual(sut.body, .text(bodyText))
    }

    func testInitWithJsonBody() throws {
        let bodyJson = JSON.bool(true)
        let sut = Is(body: bodyJson)

        XCTAssertEqual(sut.body, .json(bodyJson))
    }

    func testInitWithDataBody() throws {
        let bodyData = Data("test".utf8)
        let sut = Is(body: bodyData)

        XCTAssertEqual(sut.body, .data(bodyData))
    }

    func testInitWithJsonEncodableBody() throws {
        struct SomeCodableObject: Codable {
            struct Bar: Codable {
                let baz: String
            }

            let foo: String
            let bar: Bar
        }

        let bodyJsonEncodable = SomeCodableObject(foo: "foo", bar: SomeCodableObject.Bar(baz: "baz"))
        let sut = Is(body: bodyJsonEncodable)

        XCTAssertEqual(sut.body, .jsonEncodable(bodyJsonEncodable))
    }
}
