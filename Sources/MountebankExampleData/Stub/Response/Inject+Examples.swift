import Foundation
import MountebankSwift
import MountebankSwiftModels

extension Inject {
    enum Examples {
        static let injectBodySingleLine = Example(
            value: Inject("(config) => { return { \"body\": \"hello world\" }; }"),
            json: "(config) => { return { \"body\": \"hello world\" }; }"
        )

        static let injectBodyMultiline = Example(
            value: Inject("""
            (config) => {
                return { \"body\": \"hello world\" };
            }
            """),
            json: "(config) => {\n    return { \"body\": \"hello world\" };\n}"
        )
    }
}
