import Foundation

public struct HttpClient {

    private let requestTimeOut: Int
    private let session: URLSession

    public init(requestTimeOut: Int = 30, session: URLSession = URLSession(configuration: .default)) {
        self.requestTimeOut = requestTimeOut
        self.session = session
    }

    public func httpRequest(_ request: HTTPRequest) async throws -> Data {
        let urlRequest = makeRequest(request: request)

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
              statusCode.responseType == .success else
        {
            throw HttpError.requestFailed
        }

        return data
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
