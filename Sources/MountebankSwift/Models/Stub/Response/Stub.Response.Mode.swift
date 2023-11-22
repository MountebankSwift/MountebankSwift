import Foundation

extension Stub.Response {
    public enum Mode: String, Codable, Equatable {
        case text
        case binary
    }
}
