import MountebankSwift
import XCTest

extension Imposter {
    static let exampleAllvariants = Imposter(
        port: nil,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub.httpResponse200,
            Stub.httpResponse404,
            Stub.proxy,
            Stub.injectBody,
            Stub.connectionResetByPeer,
        ]
    )
    static let exampleSingleStub = Imposter(
        port: nil,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub.httpResponse200
        ]
    )
}
