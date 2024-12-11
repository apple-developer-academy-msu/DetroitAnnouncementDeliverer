//
//  CustomAppDelegate.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI
import UserNotifications

class DADAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    var registrationService: RegistrationService?
    
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
        let stringifiedToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("stringifiedToken:", stringifiedToken)
        registrationService?.sendDeviceTokenToServer(deviceToken: stringifiedToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("received remote notification")
        
        if let urlString = userInfo["url"] as? String, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            completionHandler(.newData)
        }
        
        return completionHandler(.noData)
    }
}
