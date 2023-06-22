import Foundation

public struct Mountebank {
    private let host: Host
    private let port: Int
    private var mountebankURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    private let httpClient: HttpClient
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    public init(host: Host = .localhost, port: Int = 2525, httpClient: HttpClient = HttpClient()) {
        self.host = host
        self.port = port
        self.httpClient = httpClient
    }

    public func postImposter(imposter: Imposter) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        let request = makeRequest(body: bodyData, endPoint: Endpoint.postImposter)

        let responseData = try await httpClient.httpRequest(request)
        let imposterResponse = try decodeJson(data: responseData, type: Imposter.self)
        return imposterResponse
    }

    private func makeImposter(name: String, stubs: [Stub]) -> Imposter? {
        guard let rawScheme = mountebankURL.scheme, let scheme = Scheme(rawValue: rawScheme) else {
            return nil
        }

        return Imposter(port: port, scheme: scheme, name: name, stubs: stubs)
    }

    private func encodeJson(encodable: Encodable) throws -> Data {
        do {
            return try jsonEncoder.encode(encodable)
        } catch {
            throw MountebankValidationError.invalidRequestData
        }
    }
    
    private func decodeJson<T: Decodable>(data: Data, type: T.Type) throws -> T {
        do {
            return try jsonDecoder.decode(type.self, from: data)
        } catch {
            throw MountebankValidationError.invalidResponseData
        }
    }

    private func makeRequest(body: Data, endPoint: Endpoint) -> HTTPRequest {
        HTTPRequest(
            url: mountebankURL.appending(path: endPoint.templatePath),
            method: endPoint.method,
            body: body,
            headers: [HTTPHeaders.contentType: MimeType.json.rawValue]
        )
    }
}
