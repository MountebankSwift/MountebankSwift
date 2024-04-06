import Foundation
import MountebankSwift

// swiftlint:disable line_length force_unwrapping
extension ImposterTests {
    static let testWriteToDiskStubsAll: [Stub] = [
        Stub(
            response: Is(
                statusCode: 200,
                body: .text("Hello world")
            ),
            predicate: .equals(Request(path: "/text-200"))
        ),
        Stub(
            response: Is(
                statusCode: 200,
                headers: ["Content-Type": "application/json"],
                body: .json([
                    "bikeId": 123.0,
                    "name": "Turbo Bike 4000",
                ])
            ),
            predicate: .equals(Request(path: "/json-200"))
        ),
        Stub(
            response: Proxy(
                to: "https://www.somesite.com:3000",
                mode: .proxyAlways
            ),
            predicates: []
        ),
        Stub(
            response: Proxy(
                to: "https://www.somesite.com:3000",
                mode: .proxyAlways,
                addWaitBehavior: true,
                addDecorateBehavior: "(config) => { config.response.headers[\'X-Test-token\'] = Math.random() * 42; }"
            ),
            predicates: []
        ),
        Stub(
            response: Proxy(
                to: "https://www.somesite.com:3000",
                predicateGenerators: [
                    .matches(
                        fields: [
                            "method": true,
                            "path": true,
                        ],
                        caseSensitive: true
                    ),
                    .matches(fields: ["query": [
                        "category": true,
                        "productId": true,
                    ]]),
                    .matches(
                        fields: [
                            "method": true,
                            "path": true,
                            "query": true,
                        ],
                        predicateOperator: .deepEquals,
                        caseSensitive: true,
                        except: "!$",
                        ignore: ["query": "startDate"]
                    ),
                    .matches(
                        fields: ["body": true],
                        jsonPath: JSONPath(selector: "$..number")
                    ),
                    .matches(
                        fields: ["body": true],
                        xPath: XPath(selector: "//number")
                    ),
                    .inject("""
                        function (config) {
                            const predicate = {
                                exists: {
                                    headers: {
                                        'X-Transaction-Id': false
                                    }
                                }
                            };
                            if (config.request.headers['X-Transaction-Id']) {
                                config.logger.debug('Requiring X-Transaction-Id header to exist in predicate');
                                predicate.exists.headers['X-Transaction-Id'] = true;
                            }
                            return [predicate];
                        }
                    """),
                ]
            ),
            predicates: []
        ),
        Stub(
            response: Is(
                statusCode: 200,
                body: .text("Hello world")
            ),
            predicates: []
        ),
        Stub(
            response: Is(statusCode: 404),
            predicate: .equals(Request(path: "/404"))
        ),
        Stub(
            responses: [
                Inject("(config) => { return { \"body\": \"hello world\" }; }"),
                Inject("""
                (config) => {
                    return { "body": "hello world" };
                }
                """),
            ],
            predicate: .equals(Request(path: "/injection"))
        ),
        Stub(
            responses: [
                Is(statusCode: 404),
                Is(
                    statusCode: 200,
                    body: .text("Hello world")
                ),
            ],
            predicate: .equals(Request(path: "/404-to-200"))
        ),
        Stub(
            responses: [
                Is(
                    statusCode: 200,
                    body: .text("Hello world")
                ),
                Is(
                    statusCode: 200,
                    headers: ["Content-Type": "text/html"],
                    body: .text("<html><body><h1>Who needs HTML?</h1></html>")
                ),
                Is(
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"],
                    body: .json([
                        "bikeId": 123.0,
                        "name": "Turbo Bike 4000",
                    ])
                ),
                Is(
                    statusCode: 200,
                    body: .data(Data(
                        base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAABaADAAQAAAABAAAABQAAAAB/qhzxAAAAKUlEQVQIHWP8//8/AwMjI5CAgv//wTyEAFScCaYAmcYhCDQDWRUDkA8AEGsMAtJaFngAAAAASUVORK5CYII="
                    )!)
                ),
                Is(statusCode: 404),
                Proxy(
                    to: "https://www.somesite.com:3000",
                    mode: .proxyAlways
                ),
                Fault.connectionResetByPeer,
                Inject("(config) => { return { \"body\": \"hello world\" }; }"),
            ],
            predicates: [
                .equals(Request(
                    method: .put,
                    path: "/test-is-200",
                    query: ["key": [
                        "first",
                        "second",
                    ]],
                    headers: ["foo": "bar"],
                    data: ["baz"]
                )),
                .deepEquals(Request(query: ["key": [
                    "first",
                    "second",
                ]])),
                .contains(Request(data: "AgM=")),
                .startsWith(Request(data: "first")),
                .endsWith(Request(data: "last")),
                .matches(Request(data: "^first")),
                .exists(Request(query: [
                    "q": true,
                    "search": false,
                ])),
                .not(.equals(Request(
                    method: .put,
                    path: "/test-is-200",
                    query: ["key": [
                        "first",
                        "second",
                    ]],
                    headers: ["foo": "bar"],
                    data: ["baz"]
                ))),
                .or([
                    .equals(Request(
                        method: .put,
                        path: "/test-is-200",
                        query: ["key": [
                            "first",
                            "second",
                        ]],
                        headers: ["foo": "bar"],
                        data: ["baz"]
                    )),
                    .contains(Request(data: "AgM=")),
                ]),
                .and([
                    .equals(Request(
                        method: .put,
                        path: "/test-is-200",
                        query: ["key": [
                            "first",
                            "second",
                        ]],
                        headers: ["foo": "bar"],
                        data: ["baz"]
                    )),
                    .deepEquals(Request(query: ["key": [
                        "first",
                        "second",
                    ]])),
                ]),
                .inject("(config) => { return config.request.headers[\'Authorization\'] == \'Bearer <my-token>\'; }"),
                .equals(
                    Request(path: "/with-parameters"),
                    PredicateParameters(
                        caseSensitive: true,
                        except: "^The ",
                        xPath: XPath(
                            selector: "//a:title",
                            namespace: ["a": "http://example.com/book"]
                        ),
                        jsonPath: JSONPath(selector: "$..title")
                    )
                ),
            ]
        ),
    ]
}

// swiftlint:enable line_length force_unwrapping