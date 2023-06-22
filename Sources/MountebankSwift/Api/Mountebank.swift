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

    // MARK: - Imposter
    
    public func getImposter(port: Int) async throws -> Imposter {
        return try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getImposter(port: port))
    }
    
    public func getAllImposters() async throws -> Imposters {
        return try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getAllImposters(), type: Imposters.self)
    }

    public func postImposter(imposter: Imposter) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposter())
    }

    public func postImposterStub(addStub: AddStub, port: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: addStub)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposterStub(port: port))
    }

    public func deleteImposter(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteImposter(port: port))
    }

    public func deleteAllImposters() async throws -> Imposters {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteAllImposters(), type: Imposters.self)
    }

    // MARK: - Stub

    public func putImposterStubs(imposter: Imposter, port: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.putImposterStubs(port: port))
    }

    public func deleteStub(port: Int, stubIndex: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteStub(port: port, stubIndex: stubIndex))
    }

    public func putImposterStub(stub: Stub, port: Int, stubIndex: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: stub)
        return try await sendDataToEndpoint(
            body: bodyData,
            endpoint: Endpoint.putImposterStub(port: port, stubIndex: stubIndex)
        )
    }

    // MARK: - Delete state

    public func deleteSavedProxyResponses(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedProxyResponses(port: port))
    }

    public func deleteSavedRequests(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedRequests(port: port))
    }

    private func sendDataToEndpoint<T: Decodable>(
        body: Data? = nil,
        endpoint: Endpoint,
        type: T.Type = Imposter.self
    ) async throws -> T {
        let request = makeRequest(body: body, endPoint: endpoint)
        let responseData = try await httpClient.httpRequest(request)
        let imposterResponse = try decodeJson(data: responseData, type: T.self)
        return imposterResponse
    }

    private func makeRequest(body: Data?, endPoint: Endpoint) -> HTTPRequest {
        HTTPRequest(
            url: mountebankURL.appending(path: endPoint.templatePath),
            method: endPoint.method,
            body: body,
            headers: [HTTPHeaders.contentType: MimeType.json.rawValue]
        )
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

}
