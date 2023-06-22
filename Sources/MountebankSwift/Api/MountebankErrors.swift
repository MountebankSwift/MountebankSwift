import Foundation

struct MountebankErrors: Decodable {
    let errors: [MountebankError]
}

struct MountebankError: Decodable, LocalizedError {
    let code: String
    let message: String

    var errorDescription: String? {
        message
    }
}
