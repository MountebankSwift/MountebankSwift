import Foundation

/// Behavior as documented on:
/// [mbtest.org/docs/api/behaviors](https://www.mbtest.org/docs/api/behaviors)
public enum Behavior: Equatable {

    /// Adds latency to a response by waiting a specified number of milliseconds before sending the response.
    case wait(miliseconds: Int)
    /// Wait with javascript function returning miliseconds
    ///
    /// The `--allowInjection` command line flag must be set to support this behavior.
    case waitJavascript(String)
    /// Copies one or more values from request fields into the response. You can tokenize the response and select
    /// values from request fields using regular expressions, xpath, or jsonpath.
    case copy(Copy)
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
