import Foundation
@testable import MountebankSwift

extension Config {
    enum Examples {
        static let simple = Example(
            value: Config(
                version: "1.0.42",
                options: Config.Options.Examples.simple.value,
                process: Config.Process.Examples.simple.value),
            json: [
                "options": Config.Options.Examples.simple.json,
                "process": Config.Process.Examples.simple.json,
                "version": "1.0.42",
            ])
    }
}
