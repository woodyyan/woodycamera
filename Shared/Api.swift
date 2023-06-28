//
//  Api.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/9/2.
//

import Foundation

class Api<T: Decodable> {
    private let baseUrl = "https://woodycamera-1256194296.cos.ap-guangzhou.myqcloud.com/"
    
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
