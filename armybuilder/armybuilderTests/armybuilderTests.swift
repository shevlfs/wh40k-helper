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
    
    func testRegistration() throws {
        let exp = expectation(description: "Registration")
        let name = "test@example.com"
        let password = "Happy7123"
        let Url = String(format: "http://94.228.195.88:5000/registration")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: String] =
          [

            "name": name,
            "password": password,

          ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard
          let httpBody = try? JSONSerialization.data(
            withJSONObject: parameters, options: .fragmentsAllowed)
        else {
          print("something went wrong")
          return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

          if let data = data {
              do {
                  print(String(data: data, encoding: .utf8)!)
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(login(name: name,password: password), "verify your account")
    }

    func testPerformanceExample() throws {
        measure {
        }
    }

}
