//
//  armybuilderTests.swift
//  armybuilderTests
//
//  Created by ted on 11/7/22.
//

import XCTest
@testable import armybuilder
    
final class armybuilderTests: XCTestCase {
    var sut: armybuilderApp!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = armybuilderApp()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testArmyControl() throws {
        var armies = sut.armyControl.armies
        
        let countBefore = getArmyControl().count
        
        let army = Army(factionID: 0, armyid: 0)
        armies.append(army)
        addArmy(army: army)
        
        XCTAssertEqual(getArmyControl().count, countBefore + 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
