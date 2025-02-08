import Foundation
import MountebankSwift
import MountebankSwiftModels

extension Fault {
    enum Examples {
        static let connectionResetByPeer = Example(
            value: Fault.connectionResetByPeer,
            json: "CONNECTION_RESET_BY_PEER"
        )

        static let randomDataThenClose = Example(
            value: Fault.randomDataThenClose,
            json: "RANDOM_DATA_THEN_CLOSE"
        )
    }
}
