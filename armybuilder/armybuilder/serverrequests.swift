import Foundation
import Alamofire

func serverHandshake()->String{
    let url = URL(string: "http://127.0.0.1:5000")!
    var text = String()
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
        text = String(data: data, encoding: .utf8)!
    }

    task.resume()
    return text
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
    
    AF.request("http://127.0.0.1:5000/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
        response in saveCookies(response: response)
    }.responseString {
        response in answ = response.value!
        done = true
    }
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while !done
    
    return answ
    
    }

func getArmyControl()->[serverArmy]{
    let Url = String(format: "http://127.0.0.1:5000/getarmies")
    let serviceUrl = URL(string: Url)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
    var answ: [serverArmy]?
    let session = URLSession.shared
        var done = false
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                HTTPCookieStorage.shared.cookies(for: response.url!)
            }
            if let data = data {
                do {
                    answ = try! JSONDecoder().decode([serverArmy].self, from: data)
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
    return answ!
    }


func addArmy(army: Army)->Void{
    let Url = String(format: "http://127.0.0.1:5000/addarmy")
        guard let serviceUrl = URL(string: Url) else { return }
    let mappedKeys = army.troops.map {String( $0.key)}
    var mappedDict = [String: Int]()
    let zippedArray = Array((zip(mappedKeys, army.troops.map{$0.value})))
    for element in zippedArray {
        mappedDict[element.0] = element.1
    }
    print(mappedDict)
    let mappedModKeys = army.mods.map {String( $0.key)}
    var mappedModDict = [String: [modification]]()
    let zippedModArray = Array((zip(mappedModKeys, army.mods.map{$0.value})))
    for element in zippedModArray {
        mappedModDict[element.0] = element.1
    }
        let parameters: [String: Any] =
    [
        "name" : army.name,
        "armyid" : army.armyid,
        "factionid" : army.factionID,
        "pointCount" : army.pointCount,
        "troops" : mappedDict,
        "mods" : mappedModKeys
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


func setCookie (cookie:HTTPCookie)
{
    UserDefaults.standard.set(cookie.properties, forKey: "kCookie")
    UserDefaults.standard.synchronize()
}





func saveCookies(response: AFDataResponse<Any>) {
    let headerFields = response.response?.allHeaderFields as! [String: String]
    let url = response.response?.url
    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
    var cookieArray = [[HTTPCookiePropertyKey: Any]]()
    for cookie in cookies {
        cookieArray.append(cookie.properties!)
    }
    UserDefaults.standard.set(cookieArray, forKey: "savedCookies")
    UserDefaults.standard.synchronize()
}


func loadCookies()->Bool{
    guard let cookieArray = UserDefaults.standard.array(forKey: "savedCookies") as? [[HTTPCookiePropertyKey: Any]] else { return false}
    for cookieProperties in cookieArray {
        if let cookie = HTTPCookie(properties: cookieProperties) {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
    return true
}
