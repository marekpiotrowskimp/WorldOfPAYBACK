//
//  WorldOfPAYBACKUITests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import XCTest

final class WorldOfPAYBACKUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testFilter() throws {
        let app = XCUIApplication()
        app.launch()
        let filter = app.staticTexts["Filtered by"]
        let popup = app.staticTexts["Communication Error"]
        if popup.exists {
            app.buttons["Ok"].tap()
            app.staticTexts["Tap to refresh"].tap()
        }
       
        XCTAssert(filter.exists)
    }
}
