import Foundation

extension Stub.Response {
    public struct Proxy: Codable, Equatable {
        let to: String
        let mode: String

        public init(to: String, mode: String) {
            self.to = to
            self.mode = mode
        }
    }
}
