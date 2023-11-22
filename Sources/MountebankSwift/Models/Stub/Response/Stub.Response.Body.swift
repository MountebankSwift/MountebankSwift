import Foundation

extension Stub.Response {
    public enum Body: Equatable {
        case text(String)
        case json(JSON)
        case data(Data)
    }
}
