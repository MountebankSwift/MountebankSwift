import Foundation

extension Stub.Response {
    public enum Fault: String, Codable, Equatable {
        case connectionResetByPeer = "CONNECTION_RESET_BY_PEER"
        case randomDataThenClose = "RANDOM_DATA_THEN_CLOSE"
    }
}
