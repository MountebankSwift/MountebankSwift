let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launchEnvironment["imagesApiHost"] = "http://localhost:\(imagesPort)"
app.launch()

XCTAssertTrue(app.staticTexts["Error: 500"].exists)

app.buttons["Retry"].tap()
XCTAssertTrue(app.staticTexts["No podcasts found"].exists)

app.buttons["Retry"].tap()
XCTAssertTrue(app.staticTexts["Serial"].exists)