#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Foundation
import Testing
@testable import MountebankSwift

@Suite

struct URLAppendingQueryItemsTestsTests {

    @Test
    func noQueryItem() {
        let sut = URL(string: "http://localhost")?.appending([])

        #expect(sut == URL(string: "http://localhost"))
    }

    @Test
    func singleQueryItem() {
        let sut = URL(string: "http://localhost")?.appending([URLQueryItem(name: "name", value: "value")])

        #expect(sut == URL(string: "http://localhost?name=value"))
    }

    @Test
    func multipleQueryItems() {
        let sut = URL(string: "http://localhost")?.appending([
            URLQueryItem(name: "name1", value: "value1"),
            URLQueryItem(name: "name2", value: "value2"),
        ])

        #expect(sut == URL(string: "http://localhost?name1=value1&name2=value2"))
    }
}
