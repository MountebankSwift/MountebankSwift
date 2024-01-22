import Foundation

/// A faulty response to test how the application under test responds to network failures.
///
/// Fault simulation allows us to check how our application behaves when downstream dependencies don't
/// respond as expected due to network failures. Mountebank already has the ability to specify delays
/// via `wait` but we may also want to test when the connection is abruptly reset or garbage data is
/// returned, similar to some of Wiremock's fault simulation functionality
public enum Fault: String, StubResponse, Codable, Equatable { // TODO convert to struct? To add parameters
    /// Close the connection.
    case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
    /// Send garbage then close the connection.
    case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
}
