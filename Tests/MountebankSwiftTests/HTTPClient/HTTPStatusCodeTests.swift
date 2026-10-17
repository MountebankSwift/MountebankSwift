import Testing
@testable import MountebankSwift

@Suite
struct HTTPStatusCodeTests {

    @Test
    func informationalStatus() throws {
        [
            HTTPStatusCode.continue,
        ].forEach { item in
            #expect(item.responseType == .informational)
        }
    }

    @Test
    func successStatus() throws {
        [
            HTTPStatusCode.ok,
            HTTPStatusCode.created,
            HTTPStatusCode.accepted,
            HTTPStatusCode.nonAuthoritativeInformation,
            HTTPStatusCode.noContent,
        ].forEach { item in
            #expect(item.responseType == .success)
        }
    }

    @Test
    func redirectionStatus() throws {
        [
            HTTPStatusCode.multipleChoices,
            HTTPStatusCode.movedPermanently,
        ].forEach { item in
            #expect(item.responseType == .redirection)
        }
    }

    @Test
    func clientErrorStatus() throws {
        [
            HTTPStatusCode.badRequest,
            HTTPStatusCode.unauthorized,
            HTTPStatusCode.paymentRequired,
            HTTPStatusCode.forbidden,
            HTTPStatusCode.notFound,
            HTTPStatusCode.methodNotAllowed,
            HTTPStatusCode.unprocessableEntity,
        ].forEach { item in
            #expect(item.responseType == .clientError)
        }
    }

    @Test
    func serverErrorStatus() throws {
        [
            HTTPStatusCode.internalServerError,
            HTTPStatusCode.badGateway,
            HTTPStatusCode.serviceUnavailable,
        ].forEach { item in
            #expect(item.responseType == .serverError)
        }
    }

}
