import XCTest
@testable import MountebankSwift

final class HTTPStatusCodeTests: XCTestCase {

    func testInformationalStatus() throws {
        [
            HTTPStatusCode.continue,
        ].forEach { item in
            XCTAssertEqual(item.responseType, .informational)
        }
    }

    func testSuccessStatus() throws {
        [
            HTTPStatusCode.ok,
            HTTPStatusCode.created,
            HTTPStatusCode.accepted,
            HTTPStatusCode.nonAuthoritativeInformation,
            HTTPStatusCode.noContent,
        ].forEach { item in
            XCTAssertEqual(item.responseType, .success)
        }
    }

    func testRedirectionStatus() throws {
        [
            HTTPStatusCode.multipleChoices,
            HTTPStatusCode.movedPermanently,
        ].forEach { item in
            XCTAssertEqual(item.responseType, .redirection)
        }
    }

    func testClientErrorStatus() throws {
        [
            HTTPStatusCode.badRequest,
            HTTPStatusCode.unauthorized,
            HTTPStatusCode.paymentRequired,
            HTTPStatusCode.forbidden,
            HTTPStatusCode.notFound,
            HTTPStatusCode.methodNotAllowed,
            HTTPStatusCode.unprocessableEntity,
        ].forEach { item in
            XCTAssertEqual(item.responseType, .clientError)
        }
    }

    func testServerErrorStatus() throws {
        [
            HTTPStatusCode.internalServerError,
            HTTPStatusCode.badGateway,
            HTTPStatusCode.serviceUnavailable,
        ].forEach { item in
            XCTAssertEqual(item.responseType, .serverError)
        }
    }

}
