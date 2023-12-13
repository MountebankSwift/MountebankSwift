import Foundation

/// Mountebank client to connect to the Mountebank server.
public struct Mountebank {
    private let host: Host
    private let port: Int
    public var mountebankURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    private let httpClient: HttpClientProtocol
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    /// - Parameters:
    ///   - host: The Mountebank server host adress
    ///   - port: The Mountebank server port
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

    /// Get a single Imposter
    ///
    /// Retrieving an ``Imposter`` is generally useful for one the following reasons:
    /// - You want to perform mock verifications by inspecting the requests array).
    /// - You want to debug stub predicates by inspecting the matches array (you must run mb with the --debug
    ///   command line parameter for this to work).
    /// - You proxied a real service, and want to be save off the saved responses in a subsequent disconnected test run.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    /// - Returns: A ``Imposter`` that listens to the provided port
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func getImposter(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getImposter(port: port))
    }

    /// Get a list of all Imposters
    ///
    /// This is where you will come to retrieve a list of all active ``Imposters``. By default, mountebank returns some
    /// basic information and hypermedia. If you want more information, either get the single ``Imposter`` or use the
    /// `replayable` flag.
    ///
    /// - Returns: A list of all ``Imposters``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func getAllImposters() async throws -> Imposters {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getAllImposters(), type: Imposters.self)
    }

    /// Create a single Imposter
    ///
    /// Though he's not proud to admit it, Mountebank employs an army of ``Imposters`` to fulfill your orders. Because
    /// your needs are varied and sundry, his ``Imposters`` are all different, and all are identified by a port number
    /// and associated with a protocol. The value you get out of Mountebank always starts by creating an imposter,
    /// which represents a test double listening on a socket.
    ///
    /// - Parameters:
    ///   - imposter: ``Imposter`` that will be created
    /// - Returns: The created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func postImposter(imposter: Imposter) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposter())
    }

    /// Overwrite all Imposters with a new set of Imposters
    ///
    /// Sometimes you want to create a batch of ``Imposters`` in a single call, overwriting any ``Imposters`` already created.
    /// This call is destructive - it will first delete all existing ``Imposters``. The output of a
    /// GET /imposters?replayable=true can directly be replayed through this call. This call is also used during
    /// startup if you set the --configfile command line flag.
    ///
    /// - Parameters:
    ///   - imposter: ``Imposter`` that will be created
    /// - Returns: The created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposters(imposters: Imposters) async throws -> Imposters {
        let bodyData = try encodeJson(encodable: imposters)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.putImposters(), type: Imposters.self)
    }

    /// Add a stub to an existing Imposter
    ///
    /// In most cases, you would add the stubs at the time you create the ``Imposter``, but this call allows you to add a
    /// stub to an existing ``Imposter`` without restarting it. You can add the new stub at any index between 0 and the
    /// end of the existing array. If you leave off the index field, the stub will be added to the end of the existing
    /// stubs array. On a successful request, Mountebank will return the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - stub: The Stub that will be added to the ``Imposter``
    ///   - index: The Index the ``Stub`` should be added to
    ///   - port: The ``Imposter`` server port
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func postImposterStub(stub: Stub, index: Int? = nil, port: Int) async throws -> Imposter {
        let addStub = AddStub(index: index, stub: stub)
        let bodyData = try encodeJson(encodable: addStub)
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.postImposterStub(port: port))
    }

    /// Delete a single Imposter
    ///
    /// Typically you want to delete the ``Imposter`` after each test run. This frees up the socket
    /// and removes the resource. As a convenience, the DELETE call also returns the ``Imposter`` representation just
    /// like a GET ``Imposter`` would. This allows you to optimize the number of REST calls made during a test run when
    /// looking at the requests array for mock verification.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    /// - Returns: The deleted ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteImposter(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteImposter(port: port))
    }

    /// Delete all Imposters
    ///
    /// The surest way to reset to a clean slate is to delete all ``Imposters``. Any ``Imposter`` sockets Mountebank has open
    /// will be closed, and the response body will contain exactly what you need to mass create the same ``Imposters``
    /// in the future.
    ///
    /// - Returns: The deleted ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteAllImposters() async throws -> Imposters {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteAllImposters(), type: Imposters.self)
    }

    /// Create a Imposter url
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    /// - Returns: The mountainbank ``Imposter`` url.
    public func makeImposterUrl(port: Int) -> URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    // MARK: - Stub

    /// Overwrite all stubs in an existing Imposter
    ///
    /// Use this endpoint to overwrite all existing ``Stub`` without restarting the ``Imposter``. The response will provide
    /// the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - stubs: The ``Stub`` that will be on the ``Imposter``
    ///   - port: The ``Imposter`` server port
    /// - Returns: The new updated ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposterStubs(stubs: [Stub], port: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: Stubs(stubs: stubs))
        return try await sendDataToEndpoint(body: bodyData, endpoint: Endpoint.putImposterStubs(port: port))
    }

    /// Remove a single stub from an existing Imposter
    ///
    /// Use this endpoint to remove the ``Stub`` at the given array index without restarting the ``Imposter``. The response
    /// will provide the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    ///   - stubIndex: The index of the ``Stub`` to be deleted
    /// - Returns: The updated ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteStub(port: Int, stubIndex: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteStub(port: port, stubIndex: stubIndex))
    }

    /// Change a Stub in an existing Imposter
    ///
    /// Use this endpoint to overwrite an existing ``Stub`` without restarting the ``Imposter``. The stubIndex must match the
    /// array index of the ``Stub`` you wish to change. Pass the new ``Stub`` as the body of the request. The response will
    /// provide the updated imposter resource.
    ///
    /// - Parameters:
    ///   - stub: The ``Stub`` that will be added to the ``Imposter``
    ///   - port: The ``Imposter`` server port
    ///   - stubIndex: The index of the ``Stub`` to be updated
    /// - Returns: The updated ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposterStub(stub: Stub, port: Int, stubIndex: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: stub)
        return try await sendDataToEndpoint(
            body: bodyData,
            endpoint: Endpoint.putImposterStub(port: port, stubIndex: stubIndex)
        )
    }

    // MARK: - Delete state

    /// Delete saved proxy responses from an Imposter
    ///
    /// Proxy Stubs save all responses returned from downstream systems. Usually this is what you want, as they can
    /// be played back at a later time without the actual downstream system available. However, if you need to clear
    /// them but keep the Stubs intact, you can do so with this call.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    ///
    /// - Returns: The updated ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteSavedProxyResponses(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedProxyResponses(port: port))
    }

    /// Delete saved requests from an Imposter
    ///
    /// Clear an Imposter's recorded requests (used for mock verification) while leaving the rest of the ``Imposter``
    /// intact. On a successful request, Mountebank will return the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    ///
    /// - Returns: The updated ``Imposter``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteSavedRequests(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.deleteSavedRequests(port: port))
    }

    // MARK: - Util

    /// Get Mountebank configuration and process information
    ///
    /// If you want to know about the environment Mountebank is running it, this resource will give you what you
    /// need. It describes the version, command line flags, and process information.
    ///
    /// - Returns: The Mountebank server ``Config``
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    public func getConfig() async throws -> Config {
        try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getConfig(), type: Config.self)
    }

    /// Get the logs of currect session.
    ///
    /// In the rare scenario where Mountebank is hosted on a different server and you need access to the logs,
    /// they are accessible through this endpoint.
    ///
    /// - Returns: The ``Logs`` for of the Mountebank server
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    public func getLogs(startIndex: Int? = nil, endIndex: Int? = nil) async throws -> Logs {
        return try await sendDataToEndpoint(body: nil, endpoint: Endpoint.getLogs(), type: Logs.self)
    }

    /// Test if the Mountebank server is up.
    ///
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    public func testConnection() async throws {
        _ = try await httpClient.httpRequest(HTTPRequest(
            url: mountebankURL,
            method: .get
        ))
    }

    // MARK: - Internal
    
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
