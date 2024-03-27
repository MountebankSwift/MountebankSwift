import MountebankSwift

import XCTest

final class ProxyTests: XCTestCase {
    func testSimpleProxy() throws {
        try assertEncode(
            Proxy.Examples.simple.value,
            Proxy.Examples.simple.json
        )
        try assertDecode(
            Proxy.Examples.simple.json,
            Proxy.Examples.simple.value
        )
    }

    func testAdvancedProxy() throws {
        try assertEncode(
            Proxy.Examples.advanced.value,
            Proxy.Examples.advanced.json
        )
        try assertDecode(
            Proxy.Examples.advanced.json,
            Proxy.Examples.advanced.value
        )
    }


    func testPredicateGeneratorsProxy() throws {
        try assertEncode(
            Proxy.Examples.predicateGenerators.value,
            Proxy.Examples.predicateGenerators.json
        )
        try assertDecode(
            Proxy.Examples.predicateGenerators.json,
            Proxy.Examples.predicateGenerators.value
        )
    } 
}
