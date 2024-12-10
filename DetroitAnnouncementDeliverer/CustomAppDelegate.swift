//
//  CustomAppDelegate.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI
import UserNotifications

class CustomAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    // This gives us access to the methods from our main app code inside the app delegate
    var app: DetroitAnnouncementDelivererApp?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // This is where we register this device to recieve push notifications from Apple
        // All this function does is register the device with APNs, it doesn't set up push notifications by itself
//        application.registerForRemoteNotifications()
//        
//        // Setting the notification delegate
//        UNUserNotificationCenter.current().delegate = self
//        
        return true
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: any Error
    ) {
        print(error)
    }

    
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // Once the device is registered for push notifications Apple will send the token to our app and it will be available here.
        // This is also where we will forward the token to our push server
        // If you want to see a string version of your token, you can use the following code to print it out
        let stringifiedToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("stringifiedToken:", stringifiedToken)
        sendDeviceTokenToServer(deviceToken: stringifiedToken)
        
    }
    
    func sendDeviceTokenToServer(deviceToken: String) {
        // Replace with your server's endpoint URL
        let url = URL(string: "http://10.121.53.206:8080/learners")!
        
        // Set up the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set headers (if needed, for example content type)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let id: String
        
        if let storedId = UserDefaults.standard.string(forKey: "userId") {
            id = storedId
        } else {
            id = UUID().uuidString
            UserDefaults.standard.set(id, forKey: "userId")
        }
                
        let cohort = UserDefaults.standard.string(forKey: "cohort")
        
        // Prepare the body data (e.g., device token as JSON)
        let body: [String: Any] = ["id": id, "deviceToken": deviceToken, "cohort": cohort ?? "am"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        // Send the request using URLSession
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("received remote notification")
        
        if let urlString = userInfo["url"] as? String, let url = URL(string: urlString) {
            // Open the URL in Safari or another app
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            completionHandler(.newData)
        }
        
        return completionHandler(.noData)
    }
    
}



import Combine

class NotificationManager: NSObject, ObservableObject {
    @Published var recievedNotification: UNNotification?
    
    private var notificationSubject = PassthroughSubject<UNNotification, Never>()
    
    // Publisher to observe notifications outside of the delegate methods
    var notificationPublisher: AnyPublisher<UNNotification, Never> {
        notificationSubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    // This function lets us do something when the user interacts with a notification
    // like log that they clicked it, or navigate to a specific screen
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        await MainActor.run {
            notificationSubject.send(response.notification)
        }
    }
    
    // This function allows us to view notifications in the app even with it in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        // These options are the options that will be used when displaying a notification with the app in the foreground
        // for example, we will be able to display a badge on the app a banner alert will appear and we could play a sound
        await MainActor.run {
            notificationSubject.send(notification)
        }
        
        return [.badge, .banner, .list, .sound]
    }
}
