import MountebankSwift
import Testing

@Suite
struct FeedUITests {

    @Test
    @MainActor
    func errorHandling() async throws {
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

        let app = XCUIApplication()
        app.launch()

        // Run UI test steps
    }
}
