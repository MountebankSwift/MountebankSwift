import Foundation

/// See https://www.mbtest.org/docs/api/behaviors
public enum Behavior: Equatable {
    /// Adds latency to a response by waiting a specified number of milliseconds before sending the response.
    case wait(miliseconds: Int)
    /// wait with javascript function returning miliseconds
    case waitJavascript(String)
    case copy(JSON) // TODO: create Copy struct to improve type safety
    case lookup(JSON)
    case decorate(String)
    case shellTransform(String)
}
