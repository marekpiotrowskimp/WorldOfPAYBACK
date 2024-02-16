//
//  WorldOfPAYBACKUITestsLaunchTests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import XCTest

final class WorldOfPAYBACKUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
