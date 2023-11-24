import Foundation

extension Stub.Predicate {
    public struct Parameters: Codable, Equatable {
        /// Determines if the match is case sensitive or not. This includes keys for objects such as query parameters.
        let caseSensitive: Bool?
        /// Defines a regular expression that is stripped out of the request field before matching.
        let except: String?
        /// Defines an object containing a selector string and, optionally, an namespace map. The predicate's scope is limited to the selected value in the request field.
        let xPath: XPath?
        /// Defines an object containing a selector string. The predicate's scope is limited to the selected value in the request field.
        let jsonPath: JSONPath?

        var isEmpty: Bool {
            // A bit overkill, but future proof
            !Mirror(reflecting: self).children.contains(where: { "\($0.value)" != "nil" })
        }

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

    public struct XPath: Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case selector
            case namespace = "ns"
        }

        /// The XPath selector
        let selector: String

        /// The XPath namespace map, aliasing a prefix to a URL, which allows you to use the prefix in the selector.
        let namespace: [String: String]?

        public init(selector: String, namespace: [String: String]?) {
            self.selector = selector
            self.namespace = namespace
        }
    }

    public struct JSONPath: Codable, Equatable {
        /// The JSONPath selector
        let selector: String

        public init(selector: String) {
            self.selector = selector
        }
    }
}
