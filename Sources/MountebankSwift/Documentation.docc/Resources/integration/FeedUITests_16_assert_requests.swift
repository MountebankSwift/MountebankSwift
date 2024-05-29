let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launchEnvironment["imagesApiHost"] = "http://localhost:\(imagesPort)"
app.launch()

XCTAssertTrue(app.staticTexts["Error: 500"].exists)

app.buttons["Retry"].tap()
XCTAssertTrue(app.staticTexts["No podcasts found"].exists)

app.buttons["Retry"].tap()
XCTAssertTrue(app.staticTexts["Serial"].exists)

let listRequests = try await mountebank.getImposter(port: listsPort).requests
let imagesRequests = try await mountebank.getImposter(port: imagesPort).requests

XCTAssertEqual(listRequests?.count, 3)
XCTAssertEqual(listRequests?.first?.headers?.contains { $0 == ("Accept", "application/json") }, true)

XCTAssertEqual(imagesRequests?.count, 2)
