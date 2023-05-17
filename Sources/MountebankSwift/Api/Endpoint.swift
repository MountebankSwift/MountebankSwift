import Foundation

// https://www.mbtest.org/docs/api/overview
public struct Endpoint {
    let method: Method
    let templatePath: String

    // Get entry hypermedia
    // static let getHypermedia = Endpoint(method: .get, templatePath: "/")

    // Get a list of all imposters
    // static let getImposters = Endpoint(method: .get, templatePath: "/imposters")

    // Get a single imposter
    // static let getImposter = Endpoint(method: .get, templatePath: "/imposters/:port")

    // Create a single imposter
    static let postImposter = Endpoint(method: .post, templatePath: "/imposters")

    // Overwrite all imposters with a new set of imposters
    // static let putImposters = Endpoint(method: .put, templatePath: "/imposters")

    // Delete a single imposter
    static let deleteImposter = Endpoint(method: .delete, templatePath: "/imposters/:port")

    // Add a stub to an existing imposter
    // static let postImposterStub = Endpoint(method: .post, templatePath: "/imposters/:port/stubs")

    // Change a stub in an existing imposter
    // static let putImposterStub = Endpoint(method: .put, templatePath: "/imposters/:port/stubs/:stubIndex")

    // Overwrite all stubs in an existing imposter
     static let putImposterStubs = Endpoint(method: .put, templatePath: "/imposters/:port/stubs")

    // Remove a single stub from an existing imposter
    // static let deleteStub = Endpoint(method: .delete, templatePath: "/imposters/:port/stubs/:stubIndex")

    // Delete saved proxy responses from an imposter
    // static let deleteSavedProxyResponses = Endpoint(method: .delete, templatePath: "/imposters/:port/savedProxyResponses")

    // Delete saved requests from an imposter
    // static let deleteSavedRequests = Endpoint(method: .delete, templatePath: "/imposters/:port/savedRequests")

    // Delete all imposters
    // static let deleteImposters = Endpoint(method: .delete, templatePath: "/imposters")

    // Get mountebank configuration and process information
    // static let getConfig = Endpoint(method: .get, templatePath: "/config")

    // Get the logs
    // static let getLogs = Endpoint(method: .get, templatePath: "/logs")
}
