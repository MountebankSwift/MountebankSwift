import MountebankSwift

final class MyUITests: XCTestCase {
    let mountebank = Mountebank()

    @MainActor
    func testSomething() async throws {
        let imposter = Imposter(port: 1234, stubs: [...])
        try await mountebank.postImposter(imposter: imposter)

        let app = XCUIApplication()
        app.launchEnvironment = [“apiHost”: "http://localhost:1234"]
        app.launch()

        // Run UI test steps
    }
}
