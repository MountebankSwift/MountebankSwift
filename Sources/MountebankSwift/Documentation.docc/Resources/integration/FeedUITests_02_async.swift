import MountebankSwift
import Testing

@Suite
struct FeedUITests {

    @Test
    @MainActor
    func errorHandling() async throws {
        let app = XCUIApplication()
        app.launch()

        // Run UI test steps
    }
}
