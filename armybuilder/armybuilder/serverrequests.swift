import Foundation

func serverHandshake()->Void{
    let url = URL(string: "http://127.0.0.1:5000")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
    }

    task.resume()
}



func register(name: String, password: String)->Void{
    let Url = String(format: "http://127.0.0.1:5000/registration")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: String] =
            [
                
                    "name" : name,
                    "password": password
                    
            ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed	    ) else {
        print("json fucked up!!")
            return
        }
    let json = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
    print(json)
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                do {
                    print(String(data: data, encoding: .utf8)!)
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

func login(name: String, password: String)->String{
    let Url = String(format: "http://127.0.0.1:5000/login")
        guard let serviceUrl = URL(string: Url) else { return "ERROR" }
        let parameters: [String: String] =
            [
                    "name" : name,
                    "password": password
            ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed        ) else {
        print("json fucked up!!")
            return "ERROR"
        }
    let json = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
    print(json)
        request.httpBody = httpBody
        request.timeoutInterval = 20
        var answ = "?????"
        let session = URLSession.shared
        var done = false
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                HTTPCookieStorage.shared.cookies(for: response.url!)
            }
            if let data = data {
                do {
                    print(String(data: data, encoding: .utf8)!)
                    answ = String(data: data, encoding: .utf8)!
                    done = true
                } catch {
                    print(error)
                }
            }
        }
    task.resume()
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while !done
    
    return answ
    
    }

func getArmyControl()->armyController{
    let Url = String(format: "http://127.0.0.1:5000/getarmies")
    let serviceUrl = URL(string: Url)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
    var answ: armyController? = nil
    let session = URLSession.shared
        var done = false
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                HTTPCookieStorage.shared.cookies(for: response.url!)
            }
            if let data = data {
                do {
                    answ = try? JSONDecoder().decode(armyController.self, from: data)
                    done = true
                } catch {
                    print(error)
                }
            }
        }
    task.resume()
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while !done
    print(answ!.armies)
    return answ!
    
    }


func addArmy(army: Army)->Void{
    let Url = String(format: "http://127.0.0.1:5000/addarmy")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] =
    [
        "name" : army.name,
        "armyid" : army.armyid,
        "factionid" : army.factionID,
        "pointCount" : army.pointCount,
        /*"troops" : army.troops*/
       /* "mods" : army.mods*/
                
            ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed        ) else {
        print("json fucked up!!")
            return
        }
    let json = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
    print(json)
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                do {
                    print(String(data: data, encoding: .utf8)!)
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
