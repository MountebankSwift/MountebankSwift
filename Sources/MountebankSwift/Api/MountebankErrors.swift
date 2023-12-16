import Foundation

public struct MountebankErrors: Codable, Equatable, Error {
    public struct MountebankError: Codable, Equatable {
        public let code: String
        public let message: String?
        public let errno: Int?
        public let syscall: String?
    }

    public let errors: [MountebankError]
}
