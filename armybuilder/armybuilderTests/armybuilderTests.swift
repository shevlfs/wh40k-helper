import XCTest
@testable import armybuilder
    
final class armybuilderTests: XCTestCase {
    var sut: armybuilderApp!
    override func setUpWithError() throws { // Настройка тестовой среды
        try super.setUpWithError()
        sut = armybuilderApp()
    }

    override func tearDownWithError() throws { // Настройка тестовой среды
        sut = nil
        try super.tearDownWithError()
    }

    func testArmyControl() throws { // Тест добавления армии
        var armies = sut.armyControl.armies
        
        let countBefore = getArmyControl().count // Получаем количество армий с бэкенда
        
        let army = Army(factionID: 0, armyid: 0)
        armies.append(army)
        addArmy(army: army) // Добавляем армию
        
        // Проверяем добавилась ли она на бэкенд
        XCTAssertEqual(getArmyControl().count, countBefore + 1)
    }
    
    func testRegistration() throws { // Тест регистрации
        
        // Тест со слишком коротким паролем
        var exp = expectation(description: "Registration")
        var name = "test@example.com"
        var password = "abc"
        let Url = String(format: "http://94.228.195.88:5000/registration")
        guard let serviceUrl = URL(string: Url) else { return }
        var parameters: [String: String] = ["name": name,"password": password,]
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
        var session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

          if let data = data {
              do {
                  XCTAssertEqual(String(data: data, encoding: .utf8)!, "passwordTooShort")
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        // Тест с паролем без заглавных букв
        exp = expectation(description: "Registration")
        name = "test@example.com"
        password = "abcdefgh"
        guard let serviceUrl = URL(string: Url) else { return }
        parameters = ["name": name,"password": password,]
        request = URLRequest(url: serviceUrl)
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
        session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

          if let data = data {
              do {
                  XCTAssertEqual(String(data: data, encoding: .utf8)!, "caseError")
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        // Тест с неверным email
        exp = expectation(description: "Registration")
        name = "blabla"
        password = "Abcde1234"
        guard let serviceUrl = URL(string: Url) else { return }
        parameters = ["name": name,"password": password,]
        request = URLRequest(url: serviceUrl)
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
        session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          if let data = data {
              do {
                  XCTAssertEqual(String(data: data, encoding: .utf8)!, "emailError")
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        // Валидная регистрация
        exp = expectation(description: "Registration")
        name = "test@example.com"
        password = "Abcde1234"
        guard let serviceUrl = URL(string: Url) else { return }
        parameters = ["name": name,"password": password,]
        request = URLRequest(url: serviceUrl)
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
        session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          if let data = data {
              do {
                  XCTAssertEqual(String(data: data, encoding: .utf8)!, "ok!")
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        // Пытаемся зарегистрировать аккаунт с почтой которая уже зарегистрированна
        exp = expectation(description: "Registration")
        name = "test@example.com"
        password = "Abcde1234"
        guard let serviceUrl = URL(string: Url) else { return }
        parameters = ["name": name,"password": password,]
        request = URLRequest(url: serviceUrl)
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
        session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          if let data = data {
              do {
                  XCTAssertEqual(String(data: data, encoding: .utf8)!, "user already exists")
                  exp.fulfill()
              }
          }
        }.resume()
        waitForExpectations(timeout: 10)
        
        // Проверяем действительно ли мы зарегистрировались
        XCTAssertEqual(login(name: name, password: password), "verify your account")
    }
}
