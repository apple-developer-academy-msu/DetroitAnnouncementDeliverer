//
//  DetroitAnnouncementDelivererApp.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI

@main
struct DetroitAnnouncementDelivererApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: DADAppDelegate
    @StateObject var notificationManager = NotificationManager()
    let registrationService: RegistrationService = VaporRegistrationService()

    var body: some Scene {
        WindowGroup {
            ContentView(registrationService: registrationService)
                .environmentObject(notificationManager)
                .onAppear {
                    appDelegate.registrationService = registrationService
                }
        }
    }
}
