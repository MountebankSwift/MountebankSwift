import Foundation

private var jsonEncoder = JSONEncoder()

extension Stub.Response {
    public enum Body: Equatable {
        case text(String)
        // case textAsData(Data)
        case json(JSON)
        case jsonEncodable(Encodable)
        case data(Data)
    }
}

extension Stub.Response.Body {
    public static func == (lhs: Stub.Response.Body, rhs: Stub.Response.Body) -> Bool {
        switch (lhs, rhs) {
        case (.text(let lhs), .text(let rhs)):
            return lhs == rhs
        case (.json(let lhs), .json(let rhs)):
            return lhs == rhs
        case (.data(let lhs), .data(let rhs)):
            return lhs == rhs
        case (.jsonEncodable(let lhs), .jsonEncodable(let rhs)):
            do {
                return try jsonEncoder.encode(lhs) == jsonEncoder.encode(rhs)
            } catch {
                print("Failed to decode object \(error)")
            }
            return false
        case (.text, _), (.json, _), (.jsonEncodable, _), (.data, _):
            return false
        }
    }
}
