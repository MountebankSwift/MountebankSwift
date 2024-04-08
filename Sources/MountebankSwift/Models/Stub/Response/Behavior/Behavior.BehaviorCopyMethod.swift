import Foundation

extension Behavior {
    /// The method used to select values from the request.
    public enum BehaviorCopyMethod: Equatable, Codable, Sendable {
        public struct Options: OptionSet, Equatable, Codable, Sendable {
            public let rawValue: UInt

            public init(rawValue: UInt) {
                self.rawValue = rawValue
            }

            /// Uses a case-insensitive regular expression
            public static let ignoreCase = Options(rawValue: 1 << 0)
            /// Uses a multiline regular expression
            public static let multiline = Options(rawValue: 1 << 1)

            public static let none: Options = []
        }

        /// Use a regex to select the object to copy
        /// - Parameters:
        ///    - selector: The selector used to select the value(s) from the request. It should contain a pattern,
        ///    and the replacement value will be the entire match. Match groups using parentheses are supported and can
        ///    be replaced using indexed tokens as described in the copy[].into description.
        ///    - options: The options that should be applied on the regex selector
        case regex(selector: String, options: [Options] = [])

        /// Use a xpath to select the object to copy
        /// - Parameters:
        ///    - selector: The selector used to select the value(s) from the request. Selectors do work on XML and
        ///    JSON documents. If the request value does not match the selector (including through XML or JSON
        ///    parsing errors), nothing is replaced.
        ///    - namespace: The namespace maps aliases to URLs.
        case xpath(selector: String, namespace: [String: String])

        /// Use a jsonpath to select the object to copy
        /// - Parameters:
        ///    - selector: The selector used to select the value(s) from the request. Selectors do work on XML and
        ///    JSON documents. If the request value does not match the selector (including through XML or JSON
        ///    parsing errors), nothing is replaced.
        case jsonpath(selector: String)
    }
}

extension Behavior.BehaviorCopyMethod: Recreatable {
    func recreatable(indent: Int) -> String {
        var properties: [(String, Recreatable?)] = []
        switch self {
        case .regex(let selector, let options):
            properties.append(("selector", selector))
            properties.append(("options", options))
        case .xpath(let selector, let namespace):
            properties.append(("selector", selector))
            properties.append(("namespace", namespace))
        case .jsonpath(let selector):
            properties.append(("selector", selector))
        }

        return enumSwiftString(properties, indent: indent)
    }
}

extension Behavior.BehaviorCopyMethod.Options: Recreatable {
    func recreatable(indent: Int) -> String {
        let values = [
            contains(Self.ignoreCase) ? ".ignoreCase" : nil,
            contains(Self.multiline) ? ".multiline" : nil,
        ].compactMap { $0 }.joined(separator: ", ")
        return "Options([\(values)])"
    }
}
