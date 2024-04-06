import Foundation

/// Host of the Mountebank server
public enum Host: Sendable {
    public typealias RawValue = String
    case localhost
    case custom(String)

    var rawValue: String {
        switch self {
        case .localhost:
            return "127.0.0.1"
        case .custom(let string):
            return string
        }
    }
}
