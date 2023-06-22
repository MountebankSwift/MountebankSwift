import Foundation

public enum MountebankValidationError: Error {
    case invalidRequestData
    case invalidResponseData
    case remoteError(MountebankErrors)
}
