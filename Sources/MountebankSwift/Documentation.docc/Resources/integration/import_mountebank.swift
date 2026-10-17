import MountebankSwift

@Suite
struct MyUITests {
    let mountebank = Mountebank()

    @Test
    @MainActor
    func something() async throws {
        let imposter = Imposter(port: 1234, stubs: [...])
        try await mountebank.postImposter(imposter: imposter)

        let app = XCUIApplication()
        app.launchEnvironment = ["apiHost": "http://localhost:1234"]
        app.launch()

        // Run UI test steps
    }
}
