import Foundation

extension Stub.Response {
    /// See [mbtest.org/docs/api/behaviors](https://www.mbtest.org/docs/api/behaviors)
    public enum Behavior: Codable, Equatable {
        case wait(miliseconds: Int)
        /// wait with javascript function returning miliseconds
        case waitJavascript(String)
        case copy(JSON) // TODO: create Copy struct to improve type safety
        case lookup(JSON)
        case decorate(String)
        case shellTransform(String)
    }
}
