import Foundation

public struct MountebankErrors: Codable, Equatable, Error {
    struct MountebankError: Codable, Equatable {
        let code: String
        let message: String?
        let errno: Int?
        let syscall: String?
    }

    let errors: [MountebankError]
}
