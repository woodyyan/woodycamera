//
//  Api.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/9/2.
//

import Foundation

class Api<T: Decodable> {
    private let baseUrl = "http://47.96.151.169:8081/camera-api/"
    
    func post(key: String, body: Any) async -> T? {
//        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: baseUrl + key)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                print(json)
//            } catch {
//                print("error")
//            }
//        })
//
//        task.resume()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func login(loginRequest: [String: Any]) async -> T? {
        guard let url = URL(string: baseUrl + "user") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginRequest, options: .prettyPrinted)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                print("data = \(data)")
                return
            }
            
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                print(responseObject)
            } else {
                print(response)
            }
        }
        task.resume()
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            if let response = try? JSONDecoder().decode(T.self, from: data) {
//                return response
//            } else {
//                print(data)
//            }
//        } catch let error {
//            print(error)
//        }
        return nil
    }
    
    func getCollections() async -> T? {
        guard let url = URL(string: baseUrl + "collection") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                return response
            }
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func get(key: String) async -> T? {
        guard let url = URL(string: baseUrl + key) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                return response
            }
        } catch let error {
            print(error)
        }
        return nil
    }
}
