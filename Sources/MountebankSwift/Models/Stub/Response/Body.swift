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
                print("Failed to encode object: \(error)")
                return false
            }
        case (.text, _), (.json, _), (.jsonEncodable, _), (.data, _):
            return false
        }
    }
}

extension Body: Recreatable {
    public func swiftString(depth: Int) -> String {
        switch self {
        case .text(let string):
            return enumSwiftString(depth: depth, [string])
        case .json(let json):
            return enumSwiftString(depth: depth, [json])
        case .jsonEncodable(let encodable, let encoder):
            do {
                let data = try (encoder ?? jsonEncoder).encode(encodable)
                guard let string = String(bytes: data, encoding: .utf8) else {
                    return ">>>> FAILED TO ENCODE ENCODABLE <<<<"
                }
                return Body.json("").enumSwiftString(depth: depth, [string.swiftString(depth: depth)])
            } catch {
                return ">>>> FAILED TO ENCODE ENCODABLE <<<<"
            }
        case .data(let data):
            return enumSwiftString(depth: depth, [data])
        }
    }
}
