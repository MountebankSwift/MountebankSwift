import Foundation

public enum MountebankValidationError: Error, Equatable {
    case invalidRequestData
    case invalidResponseData
    case remoteError(MountebankErrors)
}
