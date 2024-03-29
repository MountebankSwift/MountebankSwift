import Foundation

/// A body for an ``Is`` response
public enum Body: Equatable {
    case text(String)
    /// A JSON body that will be encoded to a text response
    case json(JSON)
    /// An Encodable body that will be encoded to a text response
    /// Custom encoding strategies are supported by providing a custom JSONEncoder
    case jsonEncodable(Encodable, JSONEncoder? = nil)
    /// A Data response that will be base64 encoded
    case data(Data)

    public static func == (lhs: Body, rhs: Body) -> Bool {
        switch (lhs, rhs) {
        case (.text(let lhs), .text(let rhs)):
            return lhs == rhs
        case (.json(let lhs), .json(let rhs)):
            return lhs == rhs
        case (.data(let lhs), .data(let rhs)):
            return lhs == rhs
        case (.jsonEncodable(let lhs, let lhsEncoder), .jsonEncodable(let rhs, let rhsEncoder)):
            guard lhsEncoder === rhsEncoder else {
                return false
            }
            do {
                return try (lhsEncoder ?? jsonEncoder).encode(lhs) == (rhsEncoder ?? jsonEncoder).encode(rhs)
            } catch {
                print("[Mountebank]: ❌ Failed to encode object: \(error)")
                return false
            }
        case (.text, _), (.json, _), (.jsonEncodable, _), (.data, _):
            return false
        }
    }
}

extension Body: Recreatable {
    var recreatable: String {
        switch self {
        case .text(let string):
            return enumSwiftString([string])
        case .json(let json):
            return enumSwiftString([json])
        case .jsonEncodable(let encodable, let encoder):
            do {
                let data = try (encoder ?? jsonEncoder).encode(encodable)
                let json = try jsonDecoder.decode(JSON.self, from: data)
                return Body.json("").enumSwiftString([json])
            } catch {
                return ">>>> FAILED TO ENCODE ENCODABLE <<<<"
            }
        case .data(let data):
            return enumSwiftString([data])
        }
    }
}
