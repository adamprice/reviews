import XCTest

final class BusinessSearchUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testBusinessesLoadAndDetailViewNavigation() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--stub-responses-mode"]
        app.launch()
        
        let businessTiles = app.scrollViews["businessesScrollView"].otherElements.buttons

        XCTAssertEqual(businessTiles.count, 10)

        businessTiles["Playa Cabana"].tap()
        let name = app.staticTexts["businessNameTitle"]

        XCTAssertTrue(name.exists)
        XCTAssertEqual(name.label, "Playa Cabana")
    }
}
