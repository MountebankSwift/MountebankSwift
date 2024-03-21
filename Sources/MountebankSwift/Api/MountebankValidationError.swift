import Foundation

/// Error thrown if something did go wrong with the Mountebank client or server.
public enum MountebankValidationError: Error, Equatable {
    /// The request to make is invalid
    case invalidRequestData

    /// The response from the Mountebank server is invalid
    case invalidResponseData

    /// The response from the Mountebank server is invalid
    case jsonDecodeError(Error)

    /// An error occurred in the Mountebank server that is running
    case remoteError(MountebankErrors)

    public static func == (lhs: MountebankValidationError, rhs: MountebankValidationError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequestData, .invalidRequestData),
            (.invalidResponseData, .invalidResponseData):
            return true
        case (.remoteError(let lhs), .remoteError(let rhs)):
            return lhs == rhs
        case (.jsonDecodeError(let lhs), .jsonDecodeError(let rhs)):
            return lhs.localizedDescription != rhs.localizedDescription
        default:
            return false
        }
    }
}
