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

    func testLogin() throws { // Тест авторизации
        let app = XCUIApplication()
        app.launch()
        
        let title = app.staticTexts["ArmyBuilder"]
        XCTAssertTrue(title.exists)
        
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

    func testAddArmy() throws { // Тест добавления армии
        let app = XCUIApplication()
        app.launch()
        
        let armiesLabel = app.scrollViews.otherElements.containing(.staticText, identifier:"Your armies").element
        XCTAssertTrue(armiesLabel.exists)
        
        let scrollViewItemCount = app.scrollViews.buttons.count
        
        let mainMenuNavBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        XCTAssertTrue(mainMenuNavBar.exists)
        mainMenuNavBar.buttons["Add"].tap()
        
        let factionSelectLabel = app.scrollViews.otherElements.staticTexts["Select your faction "]
        XCTAssertTrue(factionSelectLabel.exists)
        
        let scrollViewsQuery = app.scrollViews
        let factionChoosing = scrollViewsQuery.otherElements.staticTexts["Space Marines"]
        XCTAssertTrue(factionChoosing.exists)
        factionChoosing.tap()
        
        let troopsLabel = app.staticTexts["Troops:"]
        XCTAssertTrue(troopsLabel.exists)
        
        let troopsChoosing = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Troops:")
        troopsChoosing.children(matching: .button).matching(identifier: "+").element(boundBy: 0).tap()
        troopsChoosing.children(matching: .button).matching(identifier: "+").element(boundBy: 1).tap()
        troopsChoosing.children(matching: .button).matching(identifier: "+").element(boundBy: 2).tap()
        
        let addArmyBar = app.navigationBars["Add a new army!"]
        XCTAssertTrue(addArmyBar.exists)
        addArmyBar.buttons["Done"].tap()
        
        let createdArmy = scrollViewsQuery.otherElements.staticTexts["Space Marines "]
        XCTAssertTrue(createdArmy.exists && scrollViewItemCount + 1 == app.scrollViews.buttons.count)
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
