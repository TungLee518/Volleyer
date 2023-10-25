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
//        let topLabel = app.staticTexts["Hi"]
        let rightNavBarButton = app.navigationBars.buttons["postFinder"]
        sleep(5)
        XCTAssertTrue(rightNavBarButton.exists)
        rightNavBarButton.tap()
        let startTextFieldTime = app.textFields["starttime"]
        XCTAssertTrue(startTextFieldTime.exists)
    }
}
