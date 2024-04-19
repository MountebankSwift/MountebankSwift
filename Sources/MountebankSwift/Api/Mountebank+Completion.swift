import Foundation

extension Mountebank {

    // MARK: - Imposter

    /// Get a single Imposter with a completion handler
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
    ///   - completion: Completion with a ``Imposter`` that listens to the provided port. When the connection between
    ///   client and server fails in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func getImposter(
        port: Int,
        replayable: Bool = false,
        removeProxies: Bool = false,
        completion: ((Result<Imposter, Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(
            asyncFunction: { try await getImposter(port: port, replayable: replayable, removeProxies: removeProxies) },
            completion: completion
        )
    }

    /// Get a list of all Imposters with a completion handler
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
    ///   - completion: Completion `Result` with a list of all [``Imposter``]'s. When the connection between client and
    ///   server fails in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func getAllImposters(
        replayable: Bool = false,
        removeProxies: Bool = false,
        completion: ((Result<[Imposter], Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(
            asyncFunction: { try await getAllImposters(replayable: replayable, removeProxies: removeProxies) },
            completion: completion
        )
    }

    /// Create a single Imposter with a completion handler
    ///
    /// You can create multiple `Imposters`  in Mountebank of to fulfill your testing needs. Because your
    /// needs are varied, the `Imposters` are all different, and all are identified by a port number
    /// and associated with a protocol. The value you get out of Mountebank always starts by creating an imposter,
    /// which represents a test double listening on a socket.
    ///
    /// - Parameters:
    ///   - imposter: The ``Imposter`` that will be created.
    ///   - completion: Completion `Result` with the created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///   When the connection between client and server fails in some way the result will be a `.failure` with
    ///   a ``MountebankValidationError``.
    ///
    public func postImposter(imposter: Imposter, completion: ((Result<Imposter, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(
            asyncFunction: { try await postImposter(imposter: imposter) },
            completion: completion
        )
    }

    /// Overwrite all Imposters with a new set of Imposters with a completion handler
    ///
    /// Sometimes you want to create a batch of [``Imposter``]'s in a single call, overwriting any `Imposters` already
    /// created. This call is destructive - it will first delete all existing `Imposters`. The output of a
    /// GET /imposters?replayable=true can directly be replayed through this call. This call is also used during
    /// startup if you set the --configfile command line flag.
    ///
    /// - Parameters:
    ///   - imposters: A list of ``Imposter``'s that overwrite all existing ``Imposter``s.
    ///   - completion: Completion `Result` with the created ``Imposter`` with the port the ``Imposter`` will be available on.
    ///   When the connection between client and server fails in some way the result will be a `.failure`
    ///   with a ``MountebankValidationError``.
    ///
    public func putImposters(imposters: [Imposter], completion: ((Result<[Imposter], Error>) -> Void)? = nil) {
        mapAsyncToCompletion(
            asyncFunction: { try await putImposters(imposters: imposters) },
            completion: completion
        )
    }

    /// Add a stub to an existing Imposter with a completion handler
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
    ///   - completion: Completion `Result` with the updated ``Imposter``. When the connection between client and server fails
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func postImposterStub(
        stub: Stub,
        index: Int? = nil,
        port: Int,
        completion: ((Result<Imposter, Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(
            asyncFunction: { try await postImposterStub(stub: stub, index: index, port: port) },
            completion: completion
        )
    }

    /// Delete a single Imposter with completion handler a
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
    ///   - completion: Completion `Result` with the deleted ``Imposter`` When the connection between client and server fails.
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func deleteImposter(
        port: Int,
        replayable: Bool = false,
        removeProxies: Bool = false,
        completion: ((Result<Imposter, Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(asyncFunction: { try await deleteImposter(
            port: port,
            replayable: replayable,
            removeProxies: removeProxies
        ) }, completion: completion)
    }

    /// Delete all Imposters with completion handler a
    ///
    /// If you want to have a clean state, the best way is to delete all `Imposters`. Any `Imposter`
    /// sockets Mountebank has open will be closed, and the response body will contain exactly what
    /// you need to mass create the same [``Imposter``]'s in the future.
    ///
    /// - Parameters:
    ///   - completion: Completion `Result` with the deleted [``Imposter``]. When the connection between client and server fails.
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func deleteAllImposters(completion: ((Result<[Imposter], Error>) -> Void)? = nil) {
        mapAsyncToCompletion(asyncFunction: { try await deleteAllImposters() }, completion: completion)
    }

    // MARK: - Stub

    /// Overwrite all stubs in an existing Imposter with completion handler
    ///
    /// Use this endpoint to overwrite all existing ``Stub`` without restarting the ``Imposter``. The response
    /// will provide the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - stubs: The [``Stub``]'s that will be on the ``Imposter``.
    ///   - port: The ``Imposter`` server port.
    ///   - completion: Completion `Result` with the new updated ``Imposter`` When the connection between client and server fails.
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func putImposterStubs(stubs: [Stub], port: Int, completion: ((Result<Imposter, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(
            asyncFunction: { try await putImposterStubs(stubs: stubs, port: port) },
            completion: completion
        )
    }

    /// Remove a single stub from an existing Imposter with a completion handler
    ///
    /// Use this endpoint to remove the ``Stub`` at the given array index without restarting the ``Imposter``.
    /// The response will provide the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - stubIndex: The index of the ``Stub`` to be deleted.
    ///   - completion: Completion `Result` with the updated ``Imposter`` When the connection between client and server fails.
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func deleteStub(port: Int, stubIndex: Int, completion: ((Result<Imposter, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(
            asyncFunction: { try await deleteStub(port: port, stubIndex: stubIndex) },
            completion: completion
        )
    }

    /// Change a Stub in an existing Imposter with completion handler
    ///
    /// Use this endpoint to overwrite an existing ``Stub`` without restarting the ``Imposter``. The stubIndex must
    /// match the array index of the ``Stub`` you wish to change. Pass the new ``Stub`` as the body of the request. The
    /// response will provide the updated imposter resource.
    ///
    /// - Parameters:
    ///   - stub: The ``Stub`` that will be added to the ``Imposter``.
    ///   - port: The ``Imposter`` server port.
    ///   - stubIndex: The index of the ``Stub`` to be updated.
    ///   - completion: Completion `Result` with the updated ``Imposter`` When the connection between client and server fails.
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func putImposterStub(
        stub: Stub,
        port: Int,
        stubIndex: Int,
        completion: ((Result<Imposter, Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(
            asyncFunction: { try await putImposterStub(stub: stub, port: port, stubIndex: stubIndex) },
            completion: completion
        )
    }

    // MARK: - Delete state

    /// Delete saved proxy responses from an Imposter with a completion handler
    ///
    /// ``Proxy`` Stubs save all responses returned from downstream systems. Usually this is what you want, as they can
    /// be played back at a later time without the actual downstream system available. However, if you need to clear
    /// them but keep the Stubs intact, you can do so with this call.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - completion: Completion `Result` with the The updated ``Imposter`` When the connection between client and server fails
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func deleteSavedProxyResponses(port: Int, completion: ((Result<Imposter, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(asyncFunction: { try await deleteSavedRequests(port: port) }, completion: completion)
    }

    /// Delete saved requests from an Imposter with completion a handler
    ///
    /// Clear an Imposter's recorded requests (used for mock verification) while leaving the rest of the ``Imposter``
    /// intact. On a successful request, Mountebank will return the updated ``Imposter`` resource.
    ///
    /// - Parameters:
    ///   - port: The ``Imposter`` server port.
    ///   - completion: Completion `Result` with the deleted ``Imposter``. When the connection between client and server fails
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func deleteSavedRequests(port: Int, completion: ((Result<Imposter, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(asyncFunction: { try await deleteSavedRequests(port: port) }, completion: completion)
    }

    // MARK: - Util

    /// Get Mountebank configuration and process information with a completion handler
    ///
    /// If you want to know about the environment Mountebank is running it, this resource will give you what you
    /// need. It describes the version, command line flags, and process information.
    ///
    /// - Parameters:
    ///   - completion: Completion `Result` with the ``Config``. When the connection between client and server fails
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func getConfig(completion: ((Result<Config, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(asyncFunction: { try await getConfig() }, completion: completion)
    }

    /// Get the logs from the current session with a completion handler
    ///
    /// In the rare scenario where Mountebank is hosted on a different server and you need access to the ``Logs``,
    /// they are accessible through this endpoint.
    ///
    /// - Parameters:
    ///   - parameters: The parameters for selecting the logs.
    ///   - completion: Completion `Result` with the ``Logs``. When the connection between client and server fails
    ///   in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func getLogs(
        parameters: LogParameters = LogParameters(),
        completion: ((Result<Logs, Error>) -> Void)? = nil
    ) {
        mapAsyncToCompletion(asyncFunction: { try await getLogs(parameters: parameters) }, completion: completion)
    }

    /// Validate if the Mountebank server is up with a completion handler
    ///
    /// Before you want to setup all your Mountebank ``Imposter``'s you can use this method to check if Mountebank
    /// - Parameters:
    ///   - completion: Completion `Result` with that will be void when successful. When the connection between client and server fails in some way the result will be a `.failure` with a ``MountebankValidationError``.
    ///
    public func testConnection(completion: ((Result<Void, Error>) -> Void)? = nil) {
        mapAsyncToCompletion(asyncFunction: { try await testConnection() }, completion: completion)
    }

    private func mapAsyncToCompletion<T>(
        asyncFunction: @escaping () async throws -> T,
        completion: ((Result<T, Error>) -> Void)? = nil
    ) {
        Task {
            do {
                let result = try await asyncFunction()
                completion?(.success(result))
            } catch {
                completion?(.failure(error))
            }
        }
    }

}
