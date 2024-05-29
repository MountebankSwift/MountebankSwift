import XCTest
import MountebankSwift

final class FeedUITests: XCTestCase {
    let mountebank = Mountebank()

    @MainActor
    func testErrorHandling() async throws {
        let listsImposter = Imposter(
            name: "lists",
            stubs: [
                Stub(
                    responses: [
                        Is(statusCode: 500),
                    ]
                    predicate: .equals(Request(method: .get, path: "/trending.json"))
                ),
            ]
        )

        guard let listsPort = try await mountebank.postImposter(imposter: listsImposter).port else {
            XCTFail("Port should have been set by now")
            return
        }

        let app = XCUIApplication()
        app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
        app.launch()

        // Run UI test steps
    }
}
