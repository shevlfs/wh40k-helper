//
//  armybuilderUITestsLaunchTests.swift
//  armybuilderUITests
//
//  Created by ted on 11/6/22.
//

import XCTest

final class armybuilderUITestsLaunchTests: XCTestCase {
// класс для запуска тестирования (встроенная функция XCTest)
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
