import Foundation
import MountebankSwift

extension AddStub {
    static let injectBody = AddStub(
        index: 1,
        stub: Stub(
            responses: [Stub.Response.Examples.injectBody.value],
            predicates: [Stub.Predicate.Examples.equals.value]
        )
    )
}
