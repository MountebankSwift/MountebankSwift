import MountebankSwift
import XCTest

extension Imposter {
    static let exampleAllvariants = Imposter(
        port: nil,
        networkProtocol: .https,
        name: "imposter contract service",
        stubs: [
            Stub.httpResponse200,
            Stub.httpResponse404,
            Stub.proxy,
            Stub.injectBody,
            Stub.predicateEquals1,
            Stub.predicateEquals2,
            Stub.predicateEquals3,
            Stub.predicateEquals4,
            Stub.predicateDeepEquals1,
            Stub.predicateDeepEquals2,
            Stub.predicateDeepEquals3,
            Stub.connectionResetByPeer
        ]
    )
    static let exampleSingleStub = Imposter(
        port: nil,
        networkProtocol: .https,
        name: "imposter contract service",
        stubs: [
            Stub.httpResponse200,
        ]
    )

    static let examplePredicateEquals = Imposter(
        port: nil,
        networkProtocol: .https,
        name: "example predicate equals",
        stubs: [
            Stub.predicateEquals1,
            Stub.predicateEquals2,
            Stub.predicateEquals3,
            Stub.predicateEquals4
        ]
    )

    static let examplePredicateDeepEquals = Imposter(
        port: nil,
        networkProtocol: .https,
        name: "example predicate deep-equals",
        stubs: [
            Stub.predicateDeepEquals1,
            Stub.predicateDeepEquals2,
            Stub.predicateDeepEquals3
        ]
    )
}
