import Foundation
import MountebankSwift

extension Stub {
    static let httpResponse200 = Stub(
        responses: [
            .is(
                Stub.Response.Is(statusCode: 200, body: "Hello world"),
                Stub.Response.Parameters(repeatCount: 3)
            ),
        ],
        predicates: [.equals(["path": "/test-is-200"])]
    )

    static let html200 = Stub(
        responses: [
            .is(
                Stub.Response.Is(
                    statusCode: 200,
                    body: "<html><body><h1>Who needs HTML?</h1></html>"
                )
            ),
        ],
        predicates: [.equals(["path": "/test-html-200"])]
    )

    static let json = Stub(
        responses: [
            .is(
                Stub.Response.Is(
                    statusCode: 200,
                    body: ["bikeId": 123, "name": "Turbo Bike 4000"]
                )
            ),
        ],
        predicates: [.equals(["path": "/test-json"])]
    )

    static let binary = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 200, body: StubImage.exampleData)),
        ],
        predicates: [.equals(["path": "/test-binary"])]
    )

    static let httpResponse404 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 404), Stub.Response.Parameters(repeatCount: 2)),
        ],
        predicates: [.equals(["path": "/test-is-404"])]
    )

    static let proxy = Stub(
        responses: [
            .proxy(Stub.Response.Proxy(to: "https://www.somesite.com:3000", mode: "proxyAlways")),
        ],
        predicates: [.equals(["path": "/test-proxy"])]
    )

    static let injectBody = Stub(
        responses: [
            .inject("(config) => { return { body: \"hello world\" }; }"),
        ],
        predicates: [.equals(["path": "/test-inject"])]
    )

    static let connectionResetByPeer = Stub(
        responses: [
            .fault(.connectionResetByPeer),
        ],
        predicates: [.equals(["path": "/test-fault"])]
    )

    static let predicateEquals1 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 404))
        ],
        predicates: [
            .equals([
                "method": "POST",
                "path": "/test",
                "query": ["first": "1", "second": "2"],
                "headers": ["Accept": "text/plain"]
            ]),
            .equals(
                ["body": "hello, world"],
                Stub.Predicate.Parameters(caseSensitive: true, except: "!$")
            )
        ]
    )

    static let predicateEquals2 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 406))
        ],
        predicates: [
            .equals(
                ["headers": [ "Accept": "application/xml"]],
                Stub.Predicate.Parameters(caseSensitive: true, except: "!$")
            )
        ]
    )

    static let predicateEquals3 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 405))
        ],
        predicates: [
            .equals(
                ["method": "PUT"],
                Stub.Predicate.Parameters(caseSensitive: true, except: "!$")
            )
        ]
    )

    static let predicateEquals4 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 500))
        ],
        predicates: [.equals(["method": "PUT"])]
    )

    static let predicateDeepEquals1 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 200, body: ["body": "first"]))
        ],
        predicates: [.deepEquals(["query": [:]])]
    )

    static let predicateDeepEquals2 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 200, body: ["body": "second"]))
        ],
        predicates: [.deepEquals(["query": ["first": "1"]])]
    )

    static let predicateDeepEquals3 = Stub(
        responses: [
            .is(Stub.Response.Is(statusCode: 200, body: ["body": "third"]))
        ],
        predicates: [.deepEquals(["query": ["first": "1", "second": "2"]])]
    )
}
