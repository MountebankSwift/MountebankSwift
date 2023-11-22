import Foundation

extension Stub.Response {
    /// Responses can be parameterized. Right now, only one parameter is supported (repeatCount)
    public struct Parameters: Codable, Equatable {
        /// Repeats the response the given number of times.
        public let repeatCount: Int?

        var isEmpty: Bool {
            // A bit overkill, but future proof
            !Mirror(reflecting: self).children.contains(where: { "\($0.value)" != "nil" })
        }

        public init?(repeatCount: Int? = nil) {
            self.repeatCount = repeatCount

            if isEmpty {
                return nil
            }
        }
    }
}
