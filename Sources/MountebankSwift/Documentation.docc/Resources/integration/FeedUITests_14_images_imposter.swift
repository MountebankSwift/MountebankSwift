guard let listsPort = try await mountebank.postImposter(imposter: listsImposter).port else {
    XCTFail("Port should have been set by now")
    return
}

// Some random image
let podcastImageData = UIImage(
    systemName: "speaker.wave.2.circle.fill",
    withConfiguration: UIImage.SymbolConfiguration.preferringMulticolor()
)!

let imagesImposter = Imposter(
    name: "images",
    stubs: [
        Stub(
            response: Is(statusCode: 200, body: podcastImageData.pngData()!), // Using the binary data for the body
            predicate: .matches(Request(method: .get, path: "/discover/images"))
        ),
    ],
    recordRequests: true
)

let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launch()
