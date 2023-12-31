import Foundation

/// Mountebank does also support `tcp`, `smtp` and custom protocols
/// implemented in community plugins.
///
/// Please submit a feature request issue on Github for support if you need other protocols
public enum NetworkProtocol: String, Codable, Equatable {
    case http
    case https
}
