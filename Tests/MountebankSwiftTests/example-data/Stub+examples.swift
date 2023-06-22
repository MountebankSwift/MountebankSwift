import Foundation
import MountebankSwift

extension Stub {
    static let httpResponse200 = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-is-200"))],
        responses: [
            .is(
                Stub.Response.Is(statusCode: 200, body: "Hello world"),
                Stub.Response.Parameters(repeatCount: 3)
            ),
        ]
    )

    static let html200 = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-html-200"))],
        responses: [
            .is(
                Stub.Response.Is(
                    statusCode: 200,
                    body: "<html><body><h1>Who needs HTML?</h1></html>"
                ),
                nil
            ),
        ]
    )

    static let json = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-json"))],
        responses: [
            .is(
                Stub.Response.Is(
                    statusCode: 200,
                    body: ["bikeId": 123, "name": "Turbo Bike 4000"]
                ), nil
            ),
        ]
    )

    static let binary = Stub(
        predicates: [.equals(PredicateEquals(path: "/test-binary"))],
        responses: [
            .is(Stub.Response.Is(statusCode: 200, body: StubImage.exampleData), nil),
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
