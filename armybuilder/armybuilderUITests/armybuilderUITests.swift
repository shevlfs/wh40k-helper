//
//  armybuilderUITests.swift
//  armybuilderUITests
//
//  Created by ted on 11/6/22.
//

import XCTest

final class armybuilderUITests: XCTestCase {

    override func setUpWithError() throws {
         continueAfterFailure = false
    }

    func loginTest() throws {
        let app = XCUIApplication()
        app.launch()
        
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.exists)
        emailField.tap()
        emailField.typeText("shevl.fs@gmail.com")
        
        let passField = app.secureTextFields["Password"]
        XCTAssertTrue(passField.exists)
        passField.tap()
        passField.typeText("Happy7123")
        
        let button = app.buttons["Login"]
        XCTAssertTrue(button.exists)
        button.tap()
        
        Thread.sleep(forTimeInterval: 3)
        let armiesLabel = app.scrollViews.otherElements.containing(.staticText, identifier:"Your armies").element
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: armiesLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(armiesLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
