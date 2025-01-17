import Foundation
@testable import MountebankSwift

public final class HttpClientSpy: HttpClientProtocol, @unchecked Sendable {

    public init(
        httpRequestReturnValue: HTTPResponse? = nil
    ) {
        self.httpRequestReturnValue = httpRequestReturnValue
    }

    // MARK: - httpRequest

    public var httpRequestThrowableError: Error?
    public var httpRequestCallsCount = 0
    public var httpRequestCalled: Bool {
        httpRequestCallsCount > 0
    }

    public var httpRequestReceivedRequest: HTTPRequest?
    public var httpRequestReceivedInvocations: [HTTPRequest] = []
    // swiftlint:disable:next implicitly_unwrapped_optional
    public var httpRequestReturnValue: HTTPResponse!
    public var httpRequestClosure: ((HTTPRequest) async throws -> HTTPResponse)?

    public func httpRequest(_ request: HTTPRequest) async throws -> HTTPResponse {
        if let error = httpRequestThrowableError {
            throw error
        }
        httpRequestCallsCount += 1
        httpRequestReceivedRequest = request
        httpRequestReceivedInvocations.append(request)
        if let httpRequestClosure {
            return try await httpRequestClosure(request)
        } else {
            return httpRequestReturnValue
        }
    }
}
