//
//  RegistrationService.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

protocol RegistrationService {
    func sendDeviceTokenToServer(deviceToken: String)
    var isRegistered: Bool { get }
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func checkRegistration() async
}


class VaporRegistrationService: RegistrationService {
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private(set) var isRegistered = false
    
    private let endpoint: String
    
    init(endpoint: String =  VaporAPI.learners) {
        self.endpoint = endpoint
    }
    
    func checkRegistration() async {
        guard let url = URL(string: "\(VaporAPI.learners)/\(userID())") else {
            isRegistered = false
                return
        }
        
        do {
            let (_, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                isRegistered = httpResponse.statusCode == 200
            } else {
                isRegistered = false
            }
        } catch {
            isRegistered = false
        }
    }

    func sendDeviceTokenToServer(deviceToken: String) {
        let body: [String: Any] = createBody(with: deviceToken)

        do {
            let request = try configureRequest(with: body)
            send(request)
        } catch {
            print("Error serializing JSON: \(error)")
            onError?(error)
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
        let cohort = UserDefaults.standard.string(forKey: UserDefaults.cohort)
        return ["id": id, "deviceToken": deviceToken, "cohort": cohort ?? "am"]
    }
    
    private func userID() -> String {
        if let storedId = UserDefaults.standard.string(forKey: UserDefaults.userId) {
            return storedId
        } else {
            let newID = UUID().uuidString
            UserDefaults.standard.set(newID, forKey: UserDefaults.userId)
            return newID
        }
    }
    
    private func send(_ request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.onError?(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Device token successfully registered.")
                self.onSuccess?()
            } else {
                print("Failed to register device token with response: \(String(describing: response))")
            }
        }
        
        task.resume()
    }
}
