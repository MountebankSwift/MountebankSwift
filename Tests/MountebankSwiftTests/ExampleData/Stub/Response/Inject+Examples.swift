import Foundation
import MountebankSwift

extension Inject {
    enum Examples {
        static let injectBody = Example(
            value: Inject(
                "(config) => { return { \"body\": \"hello world\" }; }"
            ),
            json: "(config) => { return { \"body\": \"hello world\" }; }"
        )
    }
}
