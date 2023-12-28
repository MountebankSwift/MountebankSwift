import Foundation

extension Behavior {
    public struct Copy: Equatable, Codable {
        public struct Using: Equatable, Codable {
            public enum Method: String, Equatable, Codable {
                case regex
                case xpath
                case jsonpath
            }

            public struct Options: Equatable, Codable {
                /// Uses a case-insensitive regular expression
                public let ignoreCase: Bool
                /// Uses a multiline regular expression
                public let multiline: Bool
            }

            /// The method used to select the value(s) from the request.
            public let method: Method
            /// The selector used to select the value(s) from the request. For a regex, this would be the pattern,
            /// and the replacement value will be the entire match. Match groups using parentheses are supported and
            /// can be replaced using indexed tokens as described in the copy[].into description. xpath and jsonpath
            /// selectors work on XML and JSON documents. If the request value does not match the selector (including
            /// through XML or JSON parsing errors), nothing is replaced.
            public let selector: String
            /// For xpath selectors, the ns object maps namespace aliases to URLs.
            public let ns: JSON?
            /// For regex selectors, the options object describes the regular expression options
            public let options: Options?

            public init(method: Method, selector: String, ns: JSON? = nil, options: Options? = nil) {
                self.method = method
                self.selector = selector
                self.ns = ns
                self.options = options
            }
        }

        /// The name of the request field to copy from, or, if the request field is an object, then an object
        /// specifying the path to the request field. For example,
        /// `{ "from": "body" }`
        /// and
        /// `{ "from": { "query": "q" } }`
        /// are both valid.
        public let from: String
        /// The token to replace in the response with the selected request value. There is no need to specify
        /// which field in the response the token will be in; all response tokens will be replaced in all response
        /// fields. Sometimes, the request selection returns multiple values. In those cases, you can add an index
        /// to the token, while the unindexed token represents the first match. For example, if you specify
        /// `{ "into": "${NAME}" }`
        ///  as your token configuration, then both ${NAME} and ${NAME}[0] will be replaced by the first match,
        ///  ${NAME}[1] will be replaced by the second match, and so on.
        public let into: String
        /// The configuration needed to select values from the response
        public let using: Using

        public init(from: String, into: String, using: Using) {
            self.from = from
            self.into = into
            self.using = using
        }
    }
}
