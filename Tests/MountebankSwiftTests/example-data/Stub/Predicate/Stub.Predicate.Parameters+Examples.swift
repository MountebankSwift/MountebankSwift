import Foundation
import MountebankSwift

extension Stub.Predicate.Parameters {
    enum Examples {
        static let caseSensiteve = Example(
            value: Stub.Predicate.Parameters(caseSensitive: true),
            json: ["caseSensitive" : true]
        )

        static let except = Example(
            value: Stub.Predicate.Parameters(except: "^Foo"),
            json: ["except": "^Foo"]
        )

        static let all = Example(
            value: Stub.Predicate.Parameters(caseSensitive: true, except: "^Foo"),
            json: ["caseSensitive" : true, "except": "^Foo"]
        )
    }
}
