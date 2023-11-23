import Foundation

public enum NetworkProtocol: String, Codable, Equatable {
    case http
    case https
    case tcp
    case smtp
}
