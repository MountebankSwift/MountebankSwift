import Foundation
import MountebankSwiftModels

/// All Endpoints as documented on:
/// [mbtest.org/docs/api/overview](https://www.mbtest.org/docs/api/overview)
struct Endpoint {
    let method: HTTPMethod

    private let templatePath: String
    private let parameters: EndpointParameters?

    private init(method: HTTPMethod, templatePath: String, parameters: EndpointParameters? = nil) {
        self.method = method
        self.templatePath = templatePath
        self.parameters = parameters
    }

    /// Get entry hypermedia
    // static func getHypermedia() -> Endpoint { Endpoint(method: .get, templatePath: "/") }

    /// Get a list of all imposters
    static func getAllImposters(parameters: ImposterParameters) -> Endpoint {
        Endpoint(method: .get, templatePath: "/imposters", parameters: parameters)
    }

    /// Get a single imposter
    static func getImposter(port: Int, parameters: ImposterParameters) -> Endpoint {
        Endpoint(method: .get, templatePath: "/imposters/\(port)", parameters: parameters)
    }

    /// Create a single imposter
    static func postImposter() -> Endpoint {
        Endpoint(method: .post, templatePath: "/imposters")
    }

    /// Overwrite all imposters with a new set of imposters
    static func putImposters() -> Endpoint {
        Endpoint(method: .put, templatePath: "/imposters")
    }

    /// Delete a single imposter
    static func deleteImposter(port: Int, parameters: ImposterParameters) -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters/\(port)", parameters: parameters)
    }

    /// Add a stub to an existing imposter
    static func postImposterStub(port: Int) -> Endpoint {
        Endpoint(method: .post, templatePath: "/imposters/\(port)/stubs")
    }

    /// Change a stub in an existing imposter
    static func putImposterStub(port: Int, stubIndex: Int) -> Endpoint {
        Endpoint(method: .put, templatePath: "/imposters/\(port)/stubs/\(stubIndex)")
    }

    /// Change a stub in an existing imposter
    static func putImposterStubs(port: Int) -> Endpoint {
        Endpoint(method: .put, templatePath: "/imposters/\(port)/stubs")
    }

    /// Remove a single stub from an existing imposter
    static func deleteStub(port: Int, stubIndex: Int) -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters/\(port)/stubs/\(stubIndex)")
    }

    /// Delete saved proxy responses from an imposter
    static func deleteSavedProxyResponses(port: Int) -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters/\(port)/savedProxyResponses")
    }

    /// Delete saved requests from an imposter
    static func deleteSavedRequests(port: Int) -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters/\(port)/savedRequests")
    }

    /// Delete all imposters
    static func deleteAllImposters() -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters")
    }

    /// Get Mountebank configuration and process information
    static func getConfig() -> Endpoint {
        Endpoint(method: .get, templatePath: "/config")
    }

    /// Get the logs
    static func getLogs(parameters: LogParameters) -> Endpoint {
        Endpoint(method: .get, templatePath: "/logs", parameters: parameters)
    }

    /// Create a url with all query parameters appened if available.
    func makeEndpointUrl(baseUrl: URL) -> URL {
        let url = baseUrl.appendingPathComponent(templatePath)
        guard let parameters, let paramarizedUrl = url.appending(parameters.makeQueryParameters()) else {
            return url
        }

        return paramarizedUrl
    }

}
