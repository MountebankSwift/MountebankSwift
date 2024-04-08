import Foundation

// MARK: - Protocol

/// Protocol for re-creating swift code from an instance.
/// Use the helper methods below. See extensions on models for examples
protocol Recreatable {
    var recreatable: String { get }
}

// MARK: - Public Helpers

private let whitespace = "    "
private var indent = 0
func increaseRecreatableIndent() { indent += 1 }
func decreaseRecreatableIndent() { indent -= 1 }

extension Recreatable {
    /// Helper to create a recreatable string for a struct
    func structSwiftString(_ properties: [(key: String?, label: Recreatable?)]) -> String {
        structOrClassSwiftString(properties: properties)
    }

    /// Helper to create a recreatable string for a class
    func classSwiftString(_ properties: [(String?, Recreatable?)]) -> String {
        structOrClassSwiftString(properties: properties)
    }

    /// Helper to create a recreatable string for an enum without labeled associated values
    func enumSwiftString(_ properties: [Recreatable?] = []) -> String {
        enumSwiftString(properties.map { (nil, $0) })
    }

    /// Helper to create a recreatable string for an enum with labeled associated values
    func enumSwiftString(_ properties: [(String?, Recreatable?)]) -> String {
        let enumCaseWithoutAssociatedValues = "\(self)".split(separator: "(").first.map(String.init) ?? "\(self)"
        if properties.isEmpty {
            return ".\(enumCaseWithoutAssociatedValues)"
        }

        let increaseindent = properties.filter { $0.1?.recreatable.isEmpty == false }.count > 1 ? 1 : 0
        indent += increaseindent
        defer {
            indent -= increaseindent
        }

        let propertyList = properties
            .map { Self.propertySwiftString($0, $1) }
            .filter { !$0.isEmpty }

        switch propertyList.count {
        case 0:
            return ".\(enumCaseWithoutAssociatedValues)()"
        case 1:
            return ".\(enumCaseWithoutAssociatedValues)(\(propertyList.joined()))"
        default:
            return """
            .\(enumCaseWithoutAssociatedValues)(
            \(indentedList(propertyList, trailingComma: false))
            \(String(repeating: whitespace, count: indent - 1)))
            """
        }
    }
}

// MARK: - Private Helpers

extension Recreatable {
    private func structOrClassSwiftString(properties: [(String?, Recreatable?)]) -> String {
        let increaseindent = properties.filter { $0.1?.recreatable.isEmpty == false }.count > 1 ? 1 : 0
        indent += increaseindent
        defer {
            indent -= increaseindent
        }

        let propertyList = properties
            .map { Self.propertySwiftString($0, $1) }
            .filter { !$0.isEmpty }

        switch propertyList.count {
        case 0:
            return "\(Self.self)()"
        case 1:
            return "\(Self.self)(\(propertyList.joined()))"
        default:
            return """
            \(Self.self)(
            \(indentedList(propertyList, trailingComma: false))
            \(String(repeating: whitespace, count: indent - 1)))
            """
        }
    }

    private static func propertySwiftString(_ label: String?, _ value: Recreatable?) -> String {
        guard let value else {
            return ""
        }

        let recreatable = value.recreatable
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
    var recreatable: String {
        contains(where: \.isNewline)
            ? multilineRecreatable
            : debugDescription
    }

    private var multilineRecreatable: String {
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
    var recreatable: String {
        description
    }
}

extension Double: Recreatable {
    var recreatable: String {
        debugDescription
    }
}

extension Bool: Recreatable {
    var recreatable: String {
        description
    }
}

extension Data: Recreatable {
    var recreatable: String {
        indent += 1
        defer {
            indent -= 1
        }
        return """
        Data(
        \(String(repeating: whitespace, count: indent))base64Encoded: \(base64EncodedString().recreatable)
        \(String(repeating: whitespace, count: indent - 1)))!
        """
    }
}

extension Dictionary: Recreatable {
    var recreatable: String {
        if isEmpty {
            return "[:]"
        }

        let increaseindent = filter({ $0.value is Recreatable }).count > 1 ? 1 : 0
        indent += increaseindent
        defer {
            indent -= increaseindent
        }

        let keyValuePairs = map { key, value in
            guard let recreatableKey = key as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: key)) does not conform to Recreatable"
            }
            guard let recreatableValue = value as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: value)) does not conform to Recreatable"
            }

            return "\(recreatableKey.recreatable): \(recreatableValue.recreatable)"
        }.sorted()

        switch keyValuePairs.count {
        case 0:
            return "[:]"
        case 1:
            return "[\(keyValuePairs.joined())]"
        default:
            return """
            [
            \(indentedList(keyValuePairs, trailingComma: true))
            \(String(repeating: whitespace, count: indent - 1))]
            """
        }
    }
}

extension Array: Recreatable {
    var recreatable: String {
        if isEmpty {
            return "[]"
        }

        let increaseindent = filter({ $0 is Recreatable }).count > 1 ? 1 : 0
        indent += increaseindent
        defer {
            indent -= increaseindent
        }

        let elements = compactMap { element in
            guard let recreatable = element as? Recreatable else {
                return "[Mountebank.Recreatable]: ❌ \(type(of: element)) does not conform to Recreatable"
            }

            return recreatable.recreatable
        }

        switch elements.count {
        case 0:
            return "[]"
        case 1:
            return "[\(elements.joined())]"
        default:
            return """
            [
            \(indentedList(elements, trailingComma: true))
            \(String(repeating: whitespace, count: indent - 1))]
            """
        }
    }
}

private func indentedList(_ list: [String], trailingComma: Bool) -> String {
    let result = list
        .map { String(repeating: whitespace, count: indent) + $0 }
        .joined(separator: ",\n")

    return trailingComma
        ? result + ","
        : result
}
