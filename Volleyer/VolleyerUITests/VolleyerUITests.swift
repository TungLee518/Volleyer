//
//  VolleyerUITests.swift
//  VolleyerUITests
//
//  Created by 李童 on 2023/10/22.
//

import XCTest

final class VolleyerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = true
    }

    func testSingleSelect() throws {
        app = XCUIApplication()
        app.launch()
        let topLabel = app.staticTexts["Hi"]
//        let rightNavBarButton = app.navigationBars["postFinder"].buttons.element(boundBy: 0)
        XCTAssertTrue(topLabel.exists)
    }
}
