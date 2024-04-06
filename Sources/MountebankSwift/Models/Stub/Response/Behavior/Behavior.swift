import Foundation

/// Behaviors act as a middleware pipeline of transformations to alter the created response of a stub.
///
/// [mbtest.org/docs/api/behaviors](https://www.mbtest.org/docs/api/behaviors)
public enum Behavior: Equatable, Sendable {

    /// Adds latency to a response by waiting a specified number of milliseconds before sending the response.
    case wait(miliseconds: Int)
    /// Wait with javascript function returning miliseconds
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    case waitJavascript(String)
    /// Copies one or more values from request fields into the response. You can tokenize the response and select
    /// values from request fields using regular expressions, xpath, or jsonpath.
    /// - Parameters:
    ///    - from: The name of the request field to copy from, or, if the request field is an object, then an object
    ///      specifying the path to the request field.
    ///    - into: The token to replace in the response with the selected request value. There is no need to specify
    ///      which field in the response the token will be in; all response tokens will be replaced in all response
    ///      fields. Sometimes, the request selection returns multiple values. In those cases, you can add an index
    ///      to the token, while the unindexed token represents the first match.
    ///    - using: The configuration method to select values from the request.
    case copy(from: JSON, into: String, using: BehaviorCopyMethod)
    /// Queries an external data source for data based on a key selected from the request. Like the copy behavior,
    /// you can tokenize the response and select the key from the request using regular expressions, xpath,
    /// or jsonpath.
    case lookup(JSON)
    /// Post-processes the response using JavaScript injection before sending it. You can use a decorate behavior to
    /// add data to a proxied response or substitute data from the request into the response, for example. The value
    /// passed into the decorate behavior is a JavaScript function that can take up to three values: the request,
    /// the response, and a logger. You can either mutate the response passed in (and return nothing), or return an
    /// altogether new response.
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    case decorate(String)
    /// Like decorate, a shellTransform post-processes the response, but instead of using JavaScript injection,
    /// it shells out to another application. That application will get two command line parameters representing
    /// the request JSON and the response JSON, and should print to stdout the transformed response JSON.
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    case shellTransform(String)
}

extension Behavior: Recreatable {
    var recreatable: String {
        switch self {
        case .wait(let miliseconds):
            return enumSwiftString([("miliseconds", miliseconds)])
        case .copy(let from, let into, let using):
            return enumSwiftString([
                ("from", from),
                ("into", into),
                ("using", using),
            ])
        case .lookup(let json):
            return enumSwiftString([json])
        case .waitJavascript(let string),
             .decorate(let string),
             .shellTransform(let string):
            return enumSwiftString([string])
        }
    }
}
