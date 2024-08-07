import XCTest
import MountebankSwift

final class FeedUITests: XCTestCase {
    // Mountebank client to communicate with our Mountebank instance running on http://localhost:2525/
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

        // post our stub server configuration to Mountebank!
        try await mountebank.postImposter(imposter: listsImposter)

        let app = XCUIApplication()
        app.launch()

        // Run UI test steps
    }
}
