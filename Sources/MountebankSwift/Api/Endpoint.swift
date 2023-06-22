import Foundation

// https://www.mbtest.org/docs/api/overview
public struct Endpoint {
    let method: HTTPMethod
    let templatePath: String

    // Get entry hypermedia
    // static func getHypermedia = Endpoint(method: .get, templatePath: "/")

    // Get a list of all imposters
    // static func getImposters -> Endpoint { Endpoint(method: .get, templatePath: "/imposters") }

    // Get a single imposter
    // static func getImposter -> Endpoint { Endpoint(method: .get, templatePath: "/imposters/:port") }

    // Create a single imposter
    static func postImposter() -> Endpoint {
        Endpoint(method: .post, templatePath: "/imposters")
    }

    // Overwrite all imposters with a new set of imposters
    // static func putImposters -> Endpoint { Endpoint(method: .put, templatePath: "/imposters") }

    // Delete a single imposter
    static func deleteImposter(port: Int) -> Endpoint {
        Endpoint(method: .delete, templatePath: "/imposters/\(port)")
    }

    // Add a stub to an existing imposter
    // static func postImposterStub -> Endpoint { Endpoint(method: .post, templatePath: "/imposters/:port/stubs") }

    // Change a stub in an existing imposter
    // static func putImposterStub -> Endpoint { Endpoint(method: .put, templatePath: "/imposters/:port/stubs/:stubIndex") }

    // Overwrite all stubs in an existing imposter
    static func putImposterStubs(port: Int) -> Endpoint {
        Endpoint(method: .put, templatePath: "/imposters/\(port)/stubs")
    }

    // Remove a single stub from an existing imposter
    // static func deleteStub() -> Endpoint { Endpoint(method: .delete, templatePath: "/imposters/:port/stubs/:stubIndex") }

    // Delete saved proxy responses from an imposter
    // static func deleteSavedProxyResponses() -> Endpoint { Endpoint(method: .delete, templatePath:
    // "/imposters/:port/savedProxyResponses") }

    // Delete saved requests from an imposter
    // static func deleteSavedRequests() -> Endpoint { Endpoint(method: .delete, templatePath: "/imposters/:port/savedRequests") }

    // Delete all imposters
    // static func deleteImposters() -> Endpoint { Endpoint(method: .delete, templatePath: "/imposters") }

    // Get mountebank configuration and process information
    // static func getConfig() -> Endpoint { Endpoint(method: .get, templatePath: "/config") }

    // Get the logs
    // static func getLogs() -> Endpoint { Endpoint(method: .get, templatePath: "/logs") }
}
