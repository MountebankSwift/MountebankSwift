#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Foundation
import XCTest
@testable import MountebankSwift
import MountebankSwiftModels

class URLAppendingQueryItemsTestsTests: XCTestCase {

    func testNoQueryItem() {
        let sut = URL(string: "http://localhost")?.appending([])

        XCTAssertEqual(sut, URL(string: "http://localhost"))
    }

    func testSingleQueryItem() {
        let sut = URL(string: "http://localhost")?.appending([URLQueryItem(name: "name", value: "value")])

        XCTAssertEqual(sut, URL(string: "http://localhost?name=value"))
    }

    func testMultipleQueryItems() {
        let sut = URL(string: "http://localhost")?.appending([
            URLQueryItem(name: "name1", value: "value1"),
            URLQueryItem(name: "name2", value: "value2"),
        ])

        XCTAssertEqual(sut, URL(string: "http://localhost?name1=value1&name2=value2"))
    }
}
