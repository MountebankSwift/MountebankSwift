let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launchEnvironment["imagesApiHost"] = "http://localhost:\(imagesPort)"
app.launch()

#expect(app.staticTexts["Error: 500"].exists)

app.buttons["Retry"].tap()
#expect(app.staticTexts["No podcasts found"].exists)

app.buttons["Retry"].tap()
#expect(app.staticTexts["Serial"].exists)

let listRequests = try await mountebank.getImposter(port: listsPort).requests
let imagesRequests = try await mountebank.getImposter(port: imagesPort).requests

#expect(listRequests?.count == 3)
#expect(listRequests?.first?.headers?.contains { $0 == ("Accept", "application/json") } == true)

#expect(imagesRequests?.count == 2)
