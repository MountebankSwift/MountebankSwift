import Foundation

protocol HttpClientProtocol {
    func httpRequest(_ request: HTTPRequest) async throws -> HTTPResponse
}

struct HttpClient: HttpClientProtocol {

    private let requestTimeOut: Int
    private let session: URLSession

    init(requestTimeOut: Int = 30, session: URLSession = URLSession(configuration: .default)) {
        self.requestTimeOut = requestTimeOut
        self.session = session
    }

    func httpRequest(_ request: HTTPRequest) async throws -> HTTPResponse {
        let urlRequest = makeRequest(request: request)

        let (data, response) = try await session.data(for: urlRequest)

        guard
            let httpResponse = response as? HTTPURLResponse,
            let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) else
        {
            throw HttpError.requestFailed
        }

        return HTTPResponse(body: data, statusCode: statusCode)
    }

    private func makeRequest(request: HTTPRequest) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = TimeInterval(requestTimeOut)

        request.headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key.rawValue)
        }
        return urlRequest
    }

}
