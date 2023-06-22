import Foundation

public struct MountebankErrors: Decodable, Error {
    struct MountebankError: Decodable {
        let code: String
        let message: String
    }
    
    let errors: [MountebankError]
}
