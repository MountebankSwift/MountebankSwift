import Foundation

// https://www.mbtest.org/docs/api/contracts
extension Stub.Response {
    public enum Body: Equatable {
        case text(String)
        case json(JSON)
        case data(Data)
    }

    public enum Mode: String, Codable, Equatable {
        case text
        case binary
    }
}
