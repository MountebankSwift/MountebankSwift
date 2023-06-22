//
//  ExampleData.swift
//
//
//  Created by Tieme van Veen on 22/06/2023.
//

import MountebankSwift
import XCTest

extension Imposter {
    static let exampleFull = Imposter(
        port: nil,
        scheme: .https,
        name: "imposter contract service",
        stubs: [
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-is-200"))],
                responses: [
                    .is(
                        Stub.Response.Is(statusCode: 200, body: "Hello world", mode: .text),
                        Stub.Response.Parameters(repeatCount: 3)
                    ),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-is-404"))],
                responses: [
                    .is(Stub.Response.Is(statusCode: 404), Stub.Response.Parameters(repeatCount: 2)),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-proxy"))],
                responses: [
                    .proxy(Stub.Response.Proxy(to: "https://www.somesite.com:3000", mode: "proxyAlways"), nil),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-inject"))],
                responses: [
                    .inject("(config) => { return { body: \"hello world\" }; }", nil),
                ]
            ),
            Stub(
                predicates: [.equals(PredicateEquals(path: "/test-fault"))],
                responses: [
                    .fault(.connectionResetByPeer, nil),
                ]
            ),
        ]
    )
}
