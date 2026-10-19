import Foundation
import MountebankSwift
import Testing

@Suite
struct IsInitializersTests {

    @Test
    func initWithTextBody() throws {
        let bodyText = "This is a body text"
        let sut = Is(body: bodyText)

        #expect(sut.body == .text(bodyText))
    }

    @Test
    func initWithJsonBody() throws {
        let bodyJson = JSON.bool(true)
        let sut = Is(body: bodyJson)

        #expect(sut.body == .json(bodyJson))
    }

    @Test
    func initWithDataBody() throws {
        let bodyData = Data("test".utf8)
        let sut = Is(body: bodyData)

        #expect(sut.body == .data(bodyData))
    }

    @Test
    func initWithJsonEncodableBody() throws {
        let bodyJsonEncodable = SomeCodableObject(
            foo: "foo",
            bar: SomeCodableObject.Bar(baz: "baz")
        )
        let sut = Is(body: bodyJsonEncodable)

        #expect(sut.body == .jsonEncodable(bodyJsonEncodable))
    }
}

private struct SomeCodableObject: Equatable, Codable {
    struct Bar: Equatable, Codable {
        let baz: String
    }

    let foo: String
    let bar: Bar
}
