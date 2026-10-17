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

XCTAssertTrue(app.staticTexts["Error: 500"].exists)
