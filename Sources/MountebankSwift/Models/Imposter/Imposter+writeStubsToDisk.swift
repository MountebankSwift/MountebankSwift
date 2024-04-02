import Foundation

extension Imposter {
    public func writeStubsToDisk(
        directoryName: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let imposters = """
        import Foundation
        import MountebankSwift

        let stubsFor\(name.map(sanitizeName)?.capitalized ?? ""): [Stub] = \(stubs.recreatable)
        """

        let dirURL = URL(fileURLWithPath: "\(directoryName)", isDirectory: false)
        let dirName = dirURL.deletingPathExtension().lastPathComponent
        let directory = dirURL
            .deletingLastPathComponent()
            .appendingPathComponent("Imposters")
            .appendingPathComponent(dirName)

        let fileName = [
            sanitizePathComponent(testName),
            name.map(sanitizePathComponent),
            "swift",
        ]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: ".")

        let fileURL = directory.appendingPathComponent(fileName)

        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
            try imposters.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("[Mountebank]: ❌ Failed to write stubs to \(fileURL): \(error)")
        }
    }

    private func sanitizePathComponent(_ string: String) -> String {
        string
            .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
            .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
    }

    private func sanitizeName(_ string: String) -> String {
        string.replacingOccurrences(of: "\\W+", with: "", options: .regularExpression)
    }
}
