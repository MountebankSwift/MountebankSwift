import Foundation
@testable import MountebankSwift

extension AddStub {
    enum Examples {
        static let addInjectStubFirstIndex = Example(
            value: AddStub(
                index: 1,
                stub: Stub(
                    responses: [Stub.Response.Examples.injectBody.value],
                    predicates: [Stub.Predicate.Examples.equals.value]
                )
            ),
            json: [
                "index": 1,
                "stub": [
                    "responses": [Stub.Response.Examples.injectBody.json],
                    "predicates": [Stub.Predicate.Examples.equals.json],
                ]
            ]
        )
    }
}
