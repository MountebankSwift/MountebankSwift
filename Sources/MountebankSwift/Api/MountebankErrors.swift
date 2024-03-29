import Foundation

/// Error that the Mountebank server will return if something did go wrong.
public struct MountebankErrors: Codable, Equatable, Error {
    public struct MountebankError: Codable, Equatable, Sendable {
        public let code: String
        public let message: String?
        public let errno: Int?
        public let syscall: String?
    }

    public let errors: [MountebankError]
}
