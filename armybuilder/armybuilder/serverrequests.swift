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


