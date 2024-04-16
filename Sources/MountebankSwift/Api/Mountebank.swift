import Foundation

// Project wide en/decoders
let jsonDecoder = JSONDecoder()
let jsonEncoder = JSONEncoder()

/// Mountebank client to connect to the Mountebank stub server.
///
/// The client is used to submit `Imposters` to the ``Mountebank`` server.
/// Once `Imposters` are in place your application under test can use the Mountebank stub server instead of real server.
/// [mbtest.org/docs/api/overview](https://www.mbtest.org/docs/api/overview)
///
/// ```swift
/// private var mounteBank = Mountebank(host: .localhost)
/// try await mounteBank.testConnection()
///
/// let stub = Stub(
///     response: Is(statusCode: 200, body: .text("Hello world!")),
///     predicate: .equals(Request(path: "/test"))
/// )
/// let imposter = Imposter(networkProtocol: .http, stubs: [stub])
///
/// let imposterResult = try await mounteBank.postImposter(imposter: imposter)
/// let imposterURL = mounteBank.makeImposterUrl(port: imposterResult.port!)
///
/// // The application under test can now use `imposterURL` to send requests to
/// ```
public struct Mountebank {
    private let host: Host
    private let port: Int

    /// The url of the Mountebank server this client will connect to
    public var mountebankURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    private let httpClient: HttpClientProtocol

    /// - Parameters:
    ///   - host: The Mountebank server host address
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

    /// Get a single Imposter async
    ///
    /// Retrieving an ``Imposter`` is generally useful for one the following reasons:
    /// - You want to perform mock verifications by inspecting the requests array).
    /// - You want to debug stub predicates by inspecting the matches array (you must run mb with the --debug
    ///   command line parameter for this to work).
    /// - You proxied a real service, and want to be save off the saved responses in a subsequent disconnected test run.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - replayable: Set to `true` to retrieve the minimum amount of information for creating the imposter in the
    ///     future. This leaves out the requests array and any hypermedia.
    ///   - removeProxies: Set to `true` to remove all proxy responses (and `Stubs`) from the response. This is useful
    ///     in record-playback scenarios where you want to seed the imposters with proxy information but leave it out on
    ///     subsequent test runs. You can recreate the ``Imposter`` in the future by using the response.
    /// - Returns: A ``Imposter`` that listens to the provided port
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func getImposter(
        port: Int,
        replayable: Bool = false,
        removeProxies: Bool = false
    ) async throws -> Imposter {
        try await sendDataToEndpoint(
            endpoint: .getImposter(port: port, parameters: ImposterParameters(
                replayable: replayable,
                removeProxies: removeProxies
            ))
        )
    }

    /// Get a list of all Imposters async
    ///
    /// Get a list of all active [``Imposter``]'s. By default, Mountebank returns some
    /// basic information and hypermedia. If you want more information, either get the single ``Imposter`` or use the
    /// `replayable` flag.
    ///
    /// - Parameters:
    ///   - replayable: Set to `true` to retrieve the minimum amount of information for creating the imposter in the
    ///     future. This leaves out the requests array and any hypermedia.
    ///   - removeProxies: Set to `true` to remove all proxy responses (and ``Stub``'s) from the response. This is useful
    ///     in record-playback scenarios where you want to seed the `Imposters` with proxy information but leave it out on
    ///     subsequent test runs. You can recreate the ``Imposter`` in the future by using the response.
    /// - Returns: A list of all [``Imposter``]'s
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func getAllImposters(
        replayable: Bool = false,
        removeProxies: Bool = false
    ) async throws -> [Imposter] {
        try await sendDataToEndpoint(
            endpoint: .getAllImposters(parameters: ImposterParameters(
                replayable: replayable,
                removeProxies: removeProxies
            )),
            responseType: Imposters.self
        ).imposters
    }

    /// Create a single Imposter async
    ///
    /// You can create multiple `Imposters`  in Mountebank of to fulfill your testing needs. Because your
    /// needs are varied, the `Imposters` are all different, and all are identified by a port number
    /// and associated with a protocol. The value you get out of Mountebank always starts by creating an imposter,
    /// which represents a test double listening on a socket.
    ///
    /// - Parameters:
    ///   - imposter: The ``Imposter`` that will be created.
    /// - Returns: The created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func postImposter(imposter: Imposter) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: imposter)
        return try await sendDataToEndpoint(body: bodyData, endpoint: .postImposter())
    }

    /// Overwrite all Imposters with a new set of Imposters async
    ///
    /// Sometimes you want to create a batch of [``Imposter``]'s in a single call, overwriting any `Imposters` already
    /// created. This call is destructive - it will first delete all existing `Imposters`. The output of a
    /// GET /imposters?replayable=true can directly be replayed through this call. This call is also used during
    /// startup if you set the --configfile command line flag.
    ///
    /// - Parameters:
    ///   - imposters: A list of ``Imposter``'s that overwrite all existing ``Imposter``s.
    /// - Returns: The created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposters(imposters: [Imposter]) async throws -> [Imposter] {
        let bodyData = try encodeJson(encodable: Imposters(imposters: imposters))
        return try await sendDataToEndpoint(
            body: bodyData,
            endpoint: .putImposters(),
            responseType: Imposters.self
        ).imposters
    }

    /// Add a stub to an existing Imposter async
    ///
    /// In most cases, you would add the stubs at the time you create the ``Imposter``, but this call allows you to
    /// add a stub to an existing ``Imposter`` without restarting it. You can add the new stub at any index between 0
    /// and the end of the existing array. If you leave off the index field, the stub will be added to the end of the
    /// existing stubs array. On a successful request, Mountebank will return the updated ``Imposter``
    /// resource.
    ///
    /// - Parameters:
    ///   - stub: The Stub that will be added to the ``Imposter``.
    ///   - index: The Index the ``Stub`` should be added to.
    ///   - port: The ``Imposter`` server port.
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func postImposterStub(stub: Stub, index: Int? = nil, port: Int) async throws -> Imposter {
        let addStub = AddStub(index: index, stub: stub)
        let bodyData = try encodeJson(encodable: addStub)
        return try await sendDataToEndpoint(body: bodyData, endpoint: .postImposterStub(port: port))
    }

    /// Delete a single Imposter async
    ///
    /// Typically you want to delete the ``Imposter`` after each test run. This frees up the socket
    /// and removes the resource. As a convenience, the DELETE call also returns the ``Imposter`` representation just
    /// like a GET ``Imposter`` would. This allows you to optimize the number of REST calls made during a test run when
    /// looking at the requests array for mock verification.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - replayable: Set to `true` to retrieve the minimum amount of information for creating the imposter in the
    ///     future. This leaves out the requests array and any hypermedia.
    ///   - removeProxies: Set to `true` to remove all proxy responses (and ``Stub``'s) from the response. This is useful
    ///     in record-playback scenarios where you want to seed the `Imposters` with proxy information but leave it out on
    ///     subsequent test runs. You can recreate the ``Imposter`` in the future by using the response.
    /// - Returns: The deleted ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteImposter(
        port: Int,
        replayable: Bool = false,
        removeProxies: Bool = false
    ) async throws -> Imposter {
        try await sendDataToEndpoint(
            endpoint: .deleteImposter(port: port, parameters: ImposterParameters(
                replayable: replayable,
                removeProxies: removeProxies
            ))
        )
    }

    /// Delete all Imposters async
    ///
    /// If you want to have a clean state, the best way is to delete all `Imposters`. Any `Imposter`
    /// sockets Mountebank has open will be closed, and the response body will contain exactly what
    /// you need to mass create the same [``Imposter``]'s in the future.
    ///
    /// - Returns: The deleted list of [``Imposter``]'s.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteAllImposters() async throws -> [Imposter] {
        try await sendDataToEndpoint(endpoint: .deleteAllImposters(), responseType: Imposters.self).imposters
    }

    /// Create an Imposter url
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port
    /// - Returns: The Mountebank ``Imposter`` url.
    public func makeImposterUrl(port: Int) -> URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "http://\(host):\(port)")!
    }

    // MARK: - Stub

    /// Overwrite all stubs in an existing Imposter async
    ///
    /// Use this endpoint to overwrite all existing ``Stub`` without restarting the ``Imposter``. The response
    /// will provide the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - stubs: The [``Stub``]'s that will be on the ``Imposter``.
    ///   - port: The ``Imposter`` server port.
    /// - Returns: The new updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposterStubs(stubs: [Stub], port: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: Stubs(stubs: stubs))
        return try await sendDataToEndpoint(body: bodyData, endpoint: .putImposterStubs(port: port))
    }

    /// Remove a single stub from an existing Imposter async
    ///
    /// Use this endpoint to remove the ``Stub`` at the given array index without restarting the ``Imposter``.
    /// The response will provide the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - stubIndex: The index of the ``Stub`` to be deleted.
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteStub(port: Int, stubIndex: Int) async throws -> Imposter {
        try await sendDataToEndpoint(endpoint: .deleteStub(port: port, stubIndex: stubIndex))
    }

    /// Change a Stub in an existing Imposter async
    ///
    /// Use this endpoint to overwrite an existing ``Stub`` without restarting the ``Imposter``. The stubIndex must
    /// match the array index of the ``Stub`` you wish to change. Pass the new ``Stub`` as the body of the request. The
    /// response will provide the updated imposter resource.
    ///
    /// - Parameters:
    ///   - stub: The ``Stub`` that will be added to the ``Imposter``.
    ///   - port: The ``Imposter`` server port.
    ///   - stubIndex: The index of the ``Stub`` to be updated.
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func putImposterStub(stub: Stub, port: Int, stubIndex: Int) async throws -> Imposter {
        let bodyData = try encodeJson(encodable: stub)
        return try await sendDataToEndpoint(
            body: bodyData,
            endpoint: .putImposterStub(port: port, stubIndex: stubIndex)
        )
    }

    // MARK: - Delete state

    /// Delete saved proxy responses from an Imposter async
    ///
    /// ``Proxy`` Stubs save all responses returned from downstream systems. Usually this is what you want, as they can
    /// be played back at a later time without the actual downstream system available. However, if you need to clear
    /// them but keep the Stubs intact, you can do so with this call.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteSavedProxyResponses(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(endpoint: .deleteSavedProxyResponses(port: port))
    }

    /// Delete saved requests from an Imposter async
    ///
    /// Clear an Imposter's recorded requests (used for mock verification) while leaving the rest of the ``Imposter``
    /// intact. On a successful request, Mountebank will return the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///
    /// - Returns: The updated ``Imposter``.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    @discardableResult
    public func deleteSavedRequests(port: Int) async throws -> Imposter {
        try await sendDataToEndpoint(endpoint: .deleteSavedRequests(port: port))
    }

    // MARK: - Util

    /// Get Mountebank configuration and process information async
    ///
    /// If you want to know about the environment Mountebank is running it, this resource will give you what you
    /// need. It describes the version, command line flags, and process information.
    ///
    /// - Returns: The Mountebank server ``Config``.
    ///
    /// - Throws: `MountebankValidationError` if connection between the client and server fails in some way.
    public func getConfig() async throws -> Config {
        try await sendDataToEndpoint(endpoint: .getConfig(), responseType: Config.self)
    }

    /// Get the logs from the current session async
    ///
    /// In the rare scenario where Mountebank is hosted on a different server and you need access to the ``Logs``,
    /// they are accessible through this endpoint.
    ///
    /// - Parameters:
    ///   - parameters: The parameters for selecting the logs.
    /// - Returns: The ``Logs`` for of the Mountebank server.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    public func getLogs(parameters: LogParameters = LogParameters()) async throws -> Logs {
        try await sendDataToEndpoint(endpoint: .getLogs(parameters: parameters), responseType: Logs.self)
    }

    /// Validate if the Mountebank server is up async
    ///
    /// Before you want to setup all your Mountebank `Imposters` you can use this method to check if Mountebank
    /// is running.
    ///
    /// - Throws: ``MountebankValidationError`` if connection between the client and server fails in some way.
    public func testConnection() async throws {
        _ = try await httpClient.httpRequest(HTTPRequest(url: mountebankURL, method: .get))
    }

    // MARK: - Internal

    private func sendDataToEndpoint<T: Decodable>(
        body: Data? = nil,
        endpoint: Endpoint,
        responseType: T.Type = Imposter.self
    ) async throws -> T {
        let request = makeRequest(body: body, endPoint: endpoint)
        let httpResponse = try await httpClient.httpRequest(request)
        let imposterResponse = try mapHttpResponse(response: httpResponse, type: T.self)
        return imposterResponse
    }

    private func mapHttpResponse<T: Decodable>(response: HTTPResponse, type: T.Type) throws -> T {
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
            url: endPoint.makeEndpointUrl(baseUrl: mountebankURL),
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
