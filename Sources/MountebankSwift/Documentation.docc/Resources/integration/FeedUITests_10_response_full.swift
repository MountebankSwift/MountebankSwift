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
                        Is(statusCode: 200, body: ["podcasts": []]),
                        Is(statusCode: 200, body: Feed(podcasts: [
                            Podcast(
                                title: "Serial",
                                author: "Serial Productions",
                                description: "Serial returns with a history of Guantánamo.",
                                id: "2f31dfb0-2249-0132-b5ae-5f4c86fd3263",
                                url: "https://serialpodcast.org"
                            ),
                            Podcast(
                                title: "Rolling Stone's 500 Greatest Songs",
                                author: "iHeartPodcasts",
                                description: "Exclusive podcast from Rolling Stone",
                                id: "852a66f0-bdf4-013c-5160-0acc26574db2",
                                url: "https://www.iheart.com/podcast/1119-rolling-stones-500-greate-156412458/"
                            )
                        ]))
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
        app.launchEnvironment = ["apiHost": "http://localhost:\(listsPort)"]
        app.launch()

        XCTAssertTrue(app.staticTexts["Error: 500"].exists)

        app.buttons["Retry"].tap()
        XCTAssertTrue(app.staticTexts["No podcasts found"].exists)
    }
}
