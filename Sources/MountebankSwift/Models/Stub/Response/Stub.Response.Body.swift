import Foundation

private var jsonEncoder = JSONEncoder()

extension Stub.Response {
    public enum Body: Equatable {
        case text(String)
        // case textAsData(Data)
        case json(JSON)
        case codable(Codable) // TODO not tested yet!
        case data(Data)

        public static func == (lhs: Stub.Response.Body, rhs: Stub.Response.Body) -> Bool {
            switch (lhs, rhs) {
            case (.text(let lhs), .text(let rhs)):
                return lhs == rhs
            case (.json(let lhs), .json(let rhs)):
                return lhs == rhs
            case (.data(let lhs), .data(let rhs)):
                return lhs == rhs
            case (.codable(let lhs), .codable(let rhs)):
                do {
                    return try jsonEncoder.encode(lhs) == jsonEncoder.encode(rhs)
                } catch {
                    print("Failed to decode object \(error)")
                }
                return false
            case (.text, _), (.json, _), (.codable, _), (.data, _):
                return false
            }
        }
    }
}
