let app = XCUIApplication()
app.launchEnvironment["listApiHost"] = "http://localhost:\(listsPort)"
app.launchEnvironment["imagesApiHost"] = "http://localhost:\(imagesPort)"
app.launch()

#expect(app.staticTexts["Error: 500"].exists)

app.buttons["Retry"].tap()
#expect(app.staticTexts["No podcasts found"].exists)

app.buttons["Retry"].tap()
#expect(app.staticTexts["Serial"].exists)
