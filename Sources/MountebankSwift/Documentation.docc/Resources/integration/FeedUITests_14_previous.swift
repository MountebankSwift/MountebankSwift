guard let listsPort = try await mountebank.postImposter(imposter: listsImposter).port else {
    Issue.record("Port should have been set by now")
    return
}

let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launch()
