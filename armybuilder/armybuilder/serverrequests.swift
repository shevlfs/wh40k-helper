import Foundation

func serverHandshake()->Void{
    let url = URL(string: "http://127.0.0.1:5000")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
    }

    task.resume()
}
