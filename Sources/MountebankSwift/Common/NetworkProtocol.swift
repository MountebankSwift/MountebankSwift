import Foundation

/// List of netwerk protocol's MountebankSwift does support.
///
/// Mountebank itself does also support `tcp`, `smtp` and custom protocols
/// implemented in community plugins.
public enum NetworkProtocol: String, Codable, Equatable {
    case http
    case https
}
