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
    
    AF.request("http://127.0.0.1:5000/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString {
        response in answ = response.value!
        done = true
    }.responseJSON {
        response in
        if (answ == "logged in successfully"){
            saveCookies(response: response)
        }
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
                    answ = try? JSONDecoder().decode([serverArmy].self, from: data)
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
    return answ ?? [serverArmy]()
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
    var newmods: [String: [modification]] = [:]
    for unit in army.mods.keys{
        let strunit = String(unit)
        newmods[strunit] = [modification]()
        if (!army.mods[unit]!.isEmpty){
            for modf in army.mods[unit]!{
                newmods[strunit]!.append(modf)
            }
        }
    }
        let parameters: [String: Any] =
    [
        "name" : army.name,
        "armyid" : army.armyid,
        "factionid" : army.factionID,
        "pointCount" : army.pointCount,
        "troops" : mappedDict,
        "mods" : newmods,
        "deleted" : false
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


func saveCollection(collectionDatas: collectionData){
    let Url = String(format: "http://127.0.0.1:5000/savecollection")
        guard let serviceUrl = URL(string: Url) else { return }
    var parameters: [String: [String: Int]] =
    [:]
    for factionid in collectionDatas.collectionDict.keys{
        let strfac = "\(factionid)"
        parameters[strfac] = [:]
        for unit in collectionDatas.collectionDict[factionid]!.keys{
            parameters[strfac]!["\(unit)"] = collectionDatas.collectionDict[factionid]![unit]
        }
    }
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


func getCollectionDatas()->[Int: [Int: Int]]{
    let Url = String(format: "http://127.0.0.1:5000/getcollection")
    let serviceUrl = URL(string: Url)!
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
    var urlansw: [String: [String: Int]]?
    var answ: [Int: [Int: Int]] = [:]
    let session = URLSession.shared
        var done = false
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                HTTPCookieStorage.shared.cookies(for: response.url!)
            }
            if let data = data {
                do {
                    urlansw = try? JSONDecoder().decode([String : [String: Int]].self, from: data)
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
    if ((urlansw?.isEmpty) == nil){
        return collectionData().collectionDict
    }
    for factionid in urlansw!.keys{
        print(factionid)
        let intfac = Int(factionid)
        answ[intfac!] = [:]
        for unit in urlansw![factionid]!.keys{
            let val = urlansw![factionid]![unit]
            answ[intfac!]![Int(unit)!] = val
        }
    }
    
    
    
    return answ
    }


func updatearmy(army: Army)->Void{
    let Url = String(format: "http://127.0.0.1:5000/updatearmy")
        guard let serviceUrl = URL(string: Url) else { return }
    let mappedKeys = army.troops.map {String( $0.key)}
    var mappedDict = [String: Int]()
    let zippedArray = Array((zip(mappedKeys, army.troops.map{$0.value})))
    for element in zippedArray {
        mappedDict[element.0] = element.1
    }
    print(mappedDict)
    var newmods: [String: [[String: Any]]] = [:]
    for unit in army.mods.keys{
        let strunit = String(unit)
        newmods[strunit] = [[String: Any]]()
        if (!army.mods[unit]!.isEmpty){
            for modf in army.mods[unit]!{
            var newmod: [String: Any] = [
                "name" : modf.name,
                "range" : modf.range,
                "type" : modf.type,
                "s" : modf.s,
                "ap" : modf.ap,
                "d" : modf.d,
                "pts" : modf.pts,
                "count" : modf.count

            ]
                newmods[strunit]!.append(newmod)
            }
        }
    }
        let parameters: [String: Any] =
    [
        "name" : army.name,
        "armyid" : army.armyid,
        "factionid" : army.factionID,
        "pointCount" : army.pointCount,
        "troops" : mappedDict,
        "mods" : newmods,
        "deleted" : army.deleted
            ]
    print(parameters)
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


func changearmyname(oldname: String, newname: String)->Void{
    let Url = String(format: "http://127.0.0.1:5000/changearmyname")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] =
    [
        "oldname" : oldname,
        "newname" : newname
            ]
    print(parameters)
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

func deleteArmy(army: Army){
    let Url = String(format: "http://127.0.0.1:5000/deletearmy")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] =
    [
        "name" : army.name
        
            ]
    print(parameters)
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
    var done = false
        let session = URLSession.shared
        var task = session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                do {
                    print(String(data: data, encoding: .utf8)!)
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
    
}



func whoami()->String{
    let url = URL(string: "http://127.0.0.1:5000/whoami")!
    var text = String()
    var done = false
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
        text = String(data: data, encoding: .utf8)!
        done = true
    }
    task.resume()
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while !done
    return text
}


func logout()->String{
    let url = URL(string: "http://127.0.0.1:5000/logout")!
    var text = String()
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
        text = String(data: data, encoding: .utf8)!
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    task.resume()
    return text
}

func forgotPassword(email: String)->Void{
    let Url = String(format: "http://127.0.0.1:5000/changepasswordApp")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: String] =
            [
                
                    "email" : email
                    
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
