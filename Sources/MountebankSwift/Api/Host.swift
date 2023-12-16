import Foundation

/// The host of Mountebank server
public enum Host {
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
