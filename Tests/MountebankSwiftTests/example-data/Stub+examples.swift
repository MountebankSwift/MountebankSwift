import Foundation
import MountebankSwift

extension Stub {

    static let httpResponse200 = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-is-200"))],
        responses: [
            .is(
                Stub.Response.Is(statusCode: 200, body: "Hello world", mode: .text),
                Stub.Response.Parameters(repeatCount: 3)
            ),
        ]
    )
    
    static let httpResponse404 = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-is-404"))],
        responses: [
            .is(Stub.Response.Is(statusCode: 404), Stub.Response.Parameters(repeatCount: 2)),
        ]
    )

    static let proxy = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-proxy"))],
        responses: [
            .proxy(Stub.Response.Proxy(to: "https://www.somesite.com:3000", mode: "proxyAlways"), nil),
        ]
    )
    
    static let injectBody = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-inject"))],
        responses: [
            .inject("(config) => { return { body: \"hello world\" }; }", nil),
        ]
    )
    
    static let connectionResetByPeer = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-fault"))],
        responses: [
            .fault(.connectionResetByPeer, nil),
        ]
    )
    
}
