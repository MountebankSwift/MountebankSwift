import Foundation

// TODO convert to struct? To add parameters
public enum Fault: String, StubResponse, Codable, Equatable {
    case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
    case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
}
