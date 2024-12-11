//
//  RegistrationService.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

protocol RegistrationService {
    func sendDeviceTokenToServer(deviceToken: String)
}

class VaporRegistrationService: RegistrationService {
    let endpoint: String
    
    init(endpoint: String =  "http://10.121.53.206:8080/learners") {
        self.endpoint = endpoint
    }
    
    func sendDeviceTokenToServer(deviceToken: String) {
        let body: [String: Any] = createBody(with: deviceToken)

        do {
            let request = try configureRequest(with: body)
            send(request)
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
    }
    
    private func configureRequest(with body: [String: Any]) throws -> URLRequest{
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        return request
    }
    
    private func createBody(with deviceToken: String) -> [String: Any] {
        let id = userID()
        let cohort = UserDefaults.standard.string(forKey: "cohort")
        return ["id": id, "deviceToken": deviceToken, "cohort": cohort ?? "am"]
    }
    
    private func userID() -> String {
        if let storedId = UserDefaults.standard.string(forKey: "userId") {
            return storedId
        } else {
            let newID = UUID().uuidString
            UserDefaults.standard.set(newID, forKey: "userId")
            return newID
        }
    }
    
    private func send(_ request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending device token: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Device token successfully registered.")
            } else {
                print("Failed to register device token with response: \(String(describing: response))")
            }
        }
        
        task.resume()
    }
}
