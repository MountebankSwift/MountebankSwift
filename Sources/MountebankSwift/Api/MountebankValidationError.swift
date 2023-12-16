import Foundation

public enum MountebankValidationError: Error, Equatable {

    /// The request to make is invalid
    case invalidRequestData

    /// The response from the Moutebank server is invalid
    case invalidResponseData

    /// An error occured in the Moutebank server that is running
    case remoteError(MountebankErrors)
}
