import Foundation

/// Parameters that can be added to a ``Predicate`` to fine-tune it
public struct PredicateParameters: Equatable, Sendable {
    /// Determines if the match is case sensitive or not.
    /// This includes keys for objects such as query parameters.
    public let caseSensitive: Bool?
    /// Defines a regular expression that is stripped out of the request field before matching.
    public let except: String?
    /// Defines an object containing a selector string and, optionally, an namespace map.
    /// The predicate's scope is limited to the selected value in the request field.
    public let xPath: XPath?
    /// Defines an object containing a selector string.
    /// The predicate's scope is limited to the selected value in the request field.
    public let jsonPath: JSONPath?

    var isEmpty: Bool {
        // A bit overkill, but future proof
        !Mirror(reflecting: self).children.contains(where: { "\($0.value)" != "nil" })
    }

    /// - Parameters:
    ///   - caseSensitive: Determines if the match is case sensitive or not.
    ///       This includes keys for objects such as query parameters.
    ///   - except: Defines a regular expression that is stripped out of the request field before matching.
    ///   - xPath: Narrow down the scope of the predicate value with an xPath selector.
    ///   - jsonPath: Narrow down the scope of the predicate value with an jsonPath selector.
    public init?(
        caseSensitive: Bool? = nil,
        except: String? = nil,
        xPath: XPath? = nil,
        jsonPath: JSONPath? = nil
    ) {
        self.caseSensitive = caseSensitive
        self.except = except
        self.xPath = xPath
        self.jsonPath = jsonPath

        if isEmpty {
            return nil
        }
    }
}

extension PredicateParameters: Recreatable {
    var recreatable: String {
        structSwiftString([
            ("caseSensitive", caseSensitive),
            ("except", except),
            ("xPath", xPath),
            ("jsonPath", jsonPath),
        ])
    }
}
