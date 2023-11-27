import Foundation

public struct Mountebank {
    private let host: Host
    private let port: Int
    private var mountebankURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    private let httpClient: HttpClientProtocol
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    public init(host: Host = .localhost, port: Int = 2525) {
        self.host = host
        self.port = port
        httpClient = HttpClient()
    }

    init(host: Host = .localhost, port: Int = 2525, httpClient: HttpClientProtocol) {
        self.host = host
        self.port = port
        self.httpClient = httpClient
    }

    // MARK: - Imposter

    @discardableResult
    public func getImposter(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getImposter(port: port))
    }

    @discardableResult
    public func getAllImposters() async throws -> Imposters {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getAllImposters(), type: Imposters.self)
    }

    @discardableResult
    public func postImposter(imposter: Imposter) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposter())
    }

    @discardableResult
    public func postImposterStub(stub: Stub, index: Int, port: Int) async throws -> Imposter {
        let addStub = AddStub(index: index, stub: stub)
        let bodyData = try encodeJson(encodable: addStub)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposterStub(port: port))
    }

    @discardableResult
    public func deleteImposter(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteImposter(port: port))
    }

    @discardableResult
    public func deleteAllImposters() async throws -> Imposters {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteAllImposters(), type: Imposters.self)
    }

    // MARK: - Stub

    @discardableResult
    public func putImposterStubs(imposter: Imposter, port: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.putImposterStubs(port: port))
    }

    @discardableResult
    public func deleteStub(port: Int, stubIndex: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteStub(port: port, stubIndex: stubIndex))
    }

    @discardableResult
    public func putImposterStub(stub: Stub, port: Int, stubIndex: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: stub)
        return try await sendDataToEndpoint(
            body: bodyData,
            endpoint: Endpoint.putImposterStub(port: port, stubIndex: stubIndex)
        )
    }

    // MARK: - Delete state

    @discardableResult
    public func deleteSavedProxyResponses(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedProxyResponses(port: port))
    }

    @discardableResult
    public func deleteSavedRequests(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedRequests(port: port))
    }

    // MARK: - Util

    public func getConfig() async throws -> Config {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getConfig(), type: Config.self)
    }

    public func getLogs() async throws -> Logs {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getLogs(), type: Logs.self)
    }

    public func testConnection() async throws {
        _ = try await httpClient.httpRequest(HTTPRequest(
            url: mountebankURL,
            method: .get
        ))
    }

    private func sendDataToEndpoint<T: Decodable>(
        body: Data? = nil,
        endpoint: Endpoint,
        type: T.Type = Imposter.self
    ) async throws -> T {
        let request = makeRequest(body: body, endPoint: endpoint)
        let httpResponse = try await httpClient.httpRequest(request)
        let imposterResponse = try mapHttpResponse(response: httpResponse, type: T.self)
        return imposterResponse
    }

    private func mapHttpResponse<T: Decodable>(response: HTTPResponse, type: T.Type = Imposter.self) throws -> T {
        guard response.statusCode.responseType == .success else {
            throw mapMountebankErrors(data: response.body)
        }
        return try decodeJson(data: response.body, type: T.self)
    }

    private func mapMountebankErrors(data: Data) -> MountebankValidationError {
        do {
            let error = try jsonDecoder.decode(MountebankErrors.self, from: data)
            return MountebankValidationError.remoteError(error)
        } catch {
            return MountebankValidationError.invalidResponseData
        }
    }

    private func makeRequest(body: Data?, endPoint: Endpoint) -> HTTPRequest {
        HTTPRequest(
            url: mountebankURL.appendingPathComponent(endPoint.templatePath),
            method: endPoint.method,
            body: body,
            headers: [HTTPHeaders.contentType: MimeType.json.rawValue]
        )
    }

    private func makeImposter(name: String, stubs: [Stub]) -> Imposter? {
        guard
            let rawNetworkProtocol = mountebankURL.scheme,
            let networkProtocol = NetworkProtocol(rawValue: rawNetworkProtocol) else
        {
            return nil
        }

        return Imposter(port: port, networkProtocol: networkProtocol, name: name, stubs: stubs)
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
