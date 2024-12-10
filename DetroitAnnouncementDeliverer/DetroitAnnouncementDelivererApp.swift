//
//  DetroitAnnouncementDelivererApp.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI

@main
struct DetroitAnnouncementDelivererApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: CustomAppDelegate
    @StateObject var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}
