import Foundation
@testable import MountebankSwift

extension AddStub {
    enum Examples {
        static let addInjectStubFirstIndex = Example(
            value: AddStub(
                index: 1,
                stub: Stub(
                    responses: [Inject.Examples.injectBodySingleLine.value],
                    predicates: [Predicate.Examples.equals.value]
                )
            ),
            json: [
                "index": 1,
                "stub": [
                    "responses": [
                        ["inject": Inject.Examples.injectBodySingleLine.json],
                    ],
                    "predicates": [Predicate.Examples.equals.json],
                ],
            ]
        )
    }
}
