import Foundation

extension Imposter {
    public func writeStubsToDisk(
        directoryName: StaticString = #file,
        methodName: String = #function
    ) throws {
        let dirURL = URL(fileURLWithPath: "\(directoryName)", isDirectory: false)
        let dirName = dirURL.deletingPathExtension().lastPathComponent
        let directory = dirURL
            .deletingLastPathComponent()
            .appendingPathComponent("__Imposters__")
            .appendingPathComponent(dirName)

        let sansanitisedMethod = sanitizePathComponent(methodName)

        let propertyName = [
            sansanitisedMethod,
            "Stubs",
            name.map { sanitizeName($0).capitalized },
        ]
        .compactMap { $0 }
        .joined()

        increaseRecreatableIndent()
        let stubsString = stubs.recreatable
        decreaseRecreatableIndent()

        let imposters = """
        import Foundation
        import MountebankSwift

        // swiftlint:disable line_length force_unwrapping
        extension \(dirName) {
            static let \(propertyName): [Stub] = \(stubsString)
        }

        // swiftlint:enable line_length force_unwrapping
        """

        try writeToDisk(
            content: imposters,
            directory: directory,
            methodName: methodName
        )
    }

    private func writeToDisk(
        content: String,
        directory: URL,
        methodName: String
    ) throws {
        let fileName = [
            sanitizePathComponent(methodName),
            "stubs",
            name.map(sanitizePathComponent),
            "swift",
        ]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
        .joined(separator: ".")

        let fileURL = directory.appendingPathComponent(fileName)

        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
    }

    private func sanitizePathComponent(_ string: String) -> String {
        string
            .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
            .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
    }

    private func sanitizeName(_ string: String) -> String {
        string.replacingOccurrences(of: "\\W+", with: "_", options: .regularExpression)
    }
}
