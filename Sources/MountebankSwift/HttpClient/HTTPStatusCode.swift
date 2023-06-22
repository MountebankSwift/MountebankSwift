import Foundation

enum HTTPStatusCode: Int {

    enum ResponseType {
        case informational
        case success
        case redirection
        case clientError
        case serverError
        case undefined
    }

    case `continue` = 100

    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204

    case multipleChoices = 300
    case movedPermanently = 301

    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405

    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case unprocessableEntity = 422

    var responseType: ResponseType {
        switch rawValue {
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .undefined
        }
    }
}
