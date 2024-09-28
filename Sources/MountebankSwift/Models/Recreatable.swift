import Foundation

// MARK: - Protocol

/// Protocol for re-creating swift code from an instance.
/// Use the helper methods below. See extensions on models for examples
protocol Recreatable {
    func recreatable(indent: Int) -> String
}

// MARK: - Public Helpers

private let whitespace = "    "

extension Recreatable {
    /// Helper to create a recreatable string for a struct
    func structSwiftString(_ properties: [(key: String?, label: Recreatable?)], indent: Int) -> String {
        structOrClassSwiftString(properties: properties, indent: indent)
    }

    /// Helper to create a recreatable string for a class
    func classSwiftString(_ properties: [(String?, Recreatable?)], indent: Int) -> String {
        structOrClassSwiftString(properties: properties, indent: indent)
    }

    /// Helper to create a recreatable string for an enum without labeled associated values
    func enumSwiftString(_ properties: [Recreatable?] = [], indent: Int) -> String {
        enumSwiftString(properties.map { (nil, $0) }, indent: indent)
    }

    /// Helper to create a recreatable string for an enum with labeled associated values
    func enumSwiftString(_ properties: [(String?, Recreatable?)], indent: Int) -> String {
        let enumCaseWithoutAssociatedValues = "\(self)".split(separator: "(").first.map(String.init) ?? "\(self)"
        if properties.isEmpty {
            return ".\(enumCaseWithoutAssociatedValues)"
        }

        let newIndent = properties.filter { $0.1?.recreatable(indent: indent).isEmpty == false }.count > 1
            ? indent + 1
            : indent

        let propertyList = properties
            .map { Self.propertySwiftString($0, $1, indent: newIndent) }
            .filter { !$0.isEmpty }

        switch propertyList.count {
        case 0:
            return ".\(enumCaseWithoutAssociatedValues)()"
        case 1:
            return ".\(enumCaseWithoutAssociatedValues)(\(propertyList.joined()))"
        default:
            return """
            .\(enumCaseWithoutAssociatedValues)(
            \(indentedList(propertyList, indent: newIndent, trailingComma: false))
            \(String(repeating: whitespace, count: indent)))
            """
        }
    }
}

// MARK: - Private Helpers

extension Recreatable {
    private func structOrClassSwiftString(properties: [(String?, Recreatable?)], indent: Int) -> String {
        let newIndent = properties.filter { $0.1?.recreatable(indent: indent).isEmpty == false }.count > 1
            ? indent + 1
            : indent

        let propertyList = properties
            .map { Self.propertySwiftString($0, $1, indent: newIndent) }
            .filter { !$0.isEmpty }

        switch propertyList.count {
        case 0:
            return "\(Self.self)()"
        case 1:
            return "\(Self.self)(\(propertyList.joined()))"
        default:
            return """
            \(Self.self)(
            \(indentedList(propertyList, indent: newIndent, trailingComma: false))
            \(String(repeating: whitespace, count: indent)))
            """
        }
    }

    private static func propertySwiftString(_ label: String?, _ value: Recreatable?, indent: Int) -> String {
        guard let value else {
            return ""
        }

        let recreatable = value.recreatable(indent: indent)
        guard !recreatable.isEmpty else {
            return ""
        }

        if let label {
            return "\(label): \(recreatable)"
        } else {
            return "\(recreatable)"
        }
    }
}

// MARK: - Extensions on Swift Types

extension String: Recreatable {
    func recreatable(indent: Int) -> String {
        contains(where: \.isNewline)
            ? multilineRecreatable(indent: indent)
            : debugDescription
    }

    private func multilineRecreatable(indent: Int) -> String {
        let description = description
            .split(separator: "\n")
            .map {
                String(repeating: whitespace, count: indent) + $0
            }
            .joined(separator: "\n")

        return """
        \"\"\"
        \(description)
        \(String(repeating: whitespace, count: indent))\"\"\"
        """
    }
}

extension Int: Recreatable {
    func recreatable(indent: Int) -> String {
        description
    }
}

extension Double: Recreatable {
    func recreatable(indent: Int) -> String {
        debugDescription
    }
}

extension Bool: Recreatable {
    func recreatable(indent: Int) -> String {
        description
    }
}

extension Data: Recreatable {
    func recreatable(indent: Int) -> String {
        """
        Data(
        \(String(repeating: whitespace, count: indent + 1))base64Encoded: \(
            base64EncodedString()
                .recreatable(indent: indent + 1)
        )
        \(String(repeating: whitespace, count: indent)))!
        """
    }
}

extension Dictionary: Recreatable {
    func recreatable(indent: Int) -> String {
        if isEmpty {
            return "[:]"
        }

        let newIndent = filter({ $0.value is Recreatable }).count > 1
            ? indent + 1
            : indent

        let keyValuePairs = map { key, value in
            guard let recreatableKey = key as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: key)) does not conform to Recreatable"
            }
            guard let recreatableValue = value as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: value)) does not conform to Recreatable"
            }

            // swiftlint:disable:next line_length
            return "\(recreatableKey.recreatable(indent: newIndent)): \(recreatableValue.recreatable(indent: newIndent))"
        }.sorted()

        switch keyValuePairs.count {
        case 0:
            return "[:]"
        case 1:
            return "[\(keyValuePairs.joined())]"
        default:
            return """
            [
            \(indentedList(keyValuePairs, indent: newIndent, trailingComma: true))
            \(String(repeating: whitespace, count: indent))]
            """
        }
    }
}

extension Array: Recreatable {
    func recreatable(indent: Int) -> String {
        if isEmpty {
            return "[]"
        }

        let newIndent = filter({ $0 is Recreatable }).count > 1
            ? indent + 1
            : indent

        let elements = compactMap { element in
            guard let recreatable = element as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: element)) does not conform to Recreatable"
            }

            return recreatable.recreatable(indent: newIndent)
        }

        switch elements.count {
        case 0:
            return "[]"
        case 1:
            return "[\(elements.joined())]"
        default:
            return """
            [
            \(indentedList(elements, indent: newIndent, trailingComma: true))
            \(String(repeating: whitespace, count: indent))]
            """
        }
    }
}

private func indentedList(_ list: [String], indent: Int, trailingComma: Bool) -> String {
    let result = list
        .map { String(repeating: whitespace, count: indent) + $0 }
        .joined(separator: ",\n")

    return trailingComma
        ? result + ","
        : result
}
