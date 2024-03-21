import Foundation

// MARK: - Protocol

public protocol Recreatable {
    func swiftString(depth: Int) -> String
}

extension Recreatable {
    public var debugSwiftString: String {
        swiftString(depth: 0)
    }
}

let DELIMITER = ",\n"
let INDENTATION = "    "

// MARK: - Helpers

extension Recreatable {
    func structSwiftString(depth: Int, _ properties: [(key: String?, label: Recreatable?)]) -> String {
        structOrClassSwiftString(depth: depth, properties: properties)
    }

    func classSwiftString(depth: Int, _ properties: [(String?, Recreatable?)]) -> String {
        structOrClassSwiftString(depth: depth, properties: properties)
    }

    private func structOrClassSwiftString(depth: Int, properties: [(String?, Recreatable?)]) -> String {
        let newDepth = depth + 1
        return """
        \(Self.self)(\n\(Self.propertyListSwiftString(depth: newDepth, properties: properties))
        \(String(repeating: INDENTATION, count: depth)))
        """
    }

    func enumSwiftString(depth: Int, _ properties: [(Recreatable?)] = []) -> String {
        enumSwiftString(depth: depth, properties.map { (nil, $0) })
    }

    func enumSwiftString(depth: Int, _ properties: [(String?, Recreatable?)]) -> String {
        let enumCaseWithoutAssociatedValues = "\(self)".split(separator: "(").first.map(String.init) ?? "\(self)"

        if properties.isEmpty {
            return ".\(enumCaseWithoutAssociatedValues)"
        }

        let newDepth = depth + 1
        let propertiesSwiftString = Self.propertyListSwiftString(depth: newDepth, properties: properties)
        if propertiesSwiftString.isEmpty {
            return ".\(enumCaseWithoutAssociatedValues)()"
        } else {
            return """
            .\(enumCaseWithoutAssociatedValues)(\n\(propertiesSwiftString)
            \(String(repeating: INDENTATION, count: depth)))
            """
        }
    }

    fileprivate static func propertyListSwiftString(depth: Int, properties: [(String?, Recreatable?)]) -> String {
        properties.map { propertySwiftString(depth: depth, $0, $1) }
            .filter{ !$0.isEmpty }
            .joined(separator: DELIMITER)
    }

    fileprivate static func propertySwiftString(depth: Int, _ label: String?, _ value: Recreatable?) -> String {
        guard let value else {
            return ""
        }

        let swiftString = value.swiftString(depth: depth)
        guard !swiftString.isEmpty else {
            return ""
        }

        if let label {
            return "\(String(repeating: INDENTATION, count: depth))\(label): \(swiftString)"
        } else {
            return "\(String(repeating: INDENTATION, count: depth))\(swiftString)"
        }
    }
}

// MARK: - Extensions

extension String: Recreatable {
    public func swiftString(depth: Int) -> String {
        debugDescription
    }
}

extension Int: Recreatable {
    public func swiftString(depth: Int) -> String {
        description
    }
}

extension Double: Recreatable {
    public func swiftString(depth: Int) -> String {
        debugDescription
    }
}

extension Bool: Recreatable {
    public func swiftString(depth: Int) -> String {
        description
    }
}

extension Data: Recreatable {
    public func swiftString(depth: Int) -> String {
        "Data(base64Encoded: \(base64EncodedString().debugDescription))!)"
    }
}

extension Dictionary: Recreatable {
    public func swiftString(depth: Int) -> String {
        if isEmpty {
            return ""
        }

        let newDepth = depth + 1
        let keyValuePairs = map { (key, value) in
            guard let recreatableKey = key as? Recreatable else {
                return "ERR: \(type(of: key)) does not conform to Recreatable"
            }
            guard let recreatableValue = value as? Recreatable else {
                return "ERR: \(type(of: value)) does not conform to Recreatable"
            }

            return String(repeating: INDENTATION, count: newDepth) +
                "\(recreatableKey.swiftString(depth: newDepth)): \(recreatableValue.swiftString(depth: newDepth))"
        }.sorted()

        switch keyValuePairs.count {
        case 0:
            return "[]"
        //case 1:
             //return "[\(keyValuePairs.joined(separator: DELIMITER))]"
        default:
            return """
            [\n\(keyValuePairs.joined(separator: DELIMITER))
            \(String(repeating: INDENTATION, count: depth))]
            """
        }
    }
}

extension Array: Recreatable {
    public func swiftString(depth: Int) -> String {
        let newDepth = depth + 1
        let elements = compactMap { element in
            guard let recreatable = element as? Recreatable else {
                return "ERR: \(type(of: element)) does not conform to Recreatable"
            }


            let swiftString = recreatable.swiftString(depth: newDepth)

            // IS returning nil here OK?
            return swiftString.isEmpty ? nil : String(repeating: INDENTATION, count: newDepth) + swiftString
        }

        switch elements.count {
        case 0:
            return "[]"
        //case 1:
            //return "[\(elements.joined(separator: DELIMITER))]"
        default:
            return """
            [\n\(elements.joined(separator: DELIMITER))
            \(String(repeating: INDENTATION, count: depth))]
            """
        }
    }
}
