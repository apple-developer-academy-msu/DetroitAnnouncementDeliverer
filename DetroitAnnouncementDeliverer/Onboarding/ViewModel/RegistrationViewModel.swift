//
//  RegistrationViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

extension RegistrationView {
    
    @Observable
    class ViewModel {
        let onRegistration: () -> Void
        var service: RegistrationService
        var isShowingLinkToSettings = false
        var error: Error? {
            didSet {
                if let error {
                    isAlertShowing = true
                } else {
                    isAlertShowing = false
                }
            }
        }
        
        var isAlertShowing = false
        var isLoading = false
        
        init(service: RegistrationService, onRegistration: @escaping () -> Void) {
            self.onRegistration = onRegistration
            self.service = service
            self.isRegistered = service.isRegistered
        }
        
        var instructions: String {
            if isShowingLinkToSettings {
                "Now listen, Sport. DAD needs your permission to send notifications to your devices for Academy announcements and resources. And yes, I mean DAD. Now, listen up—this is important! Think of it as me making sure you don’t miss out on anything important, with a little extra care and a dash of dad wisdom. Go ahead and head to your settings and turn on notifications. I’m looking out for you, and I promise it’ll be worth it."
            } else {
                "DAD needs your permission to send notifications to your devices for Academy announcements and resources. Yep, you heard that right—DAD. Think of it like having a personal assistant who’s always got your back, but with extra love, a sprinkle of dad jokes, and a whole lot of helpful reminders and resources. Tap 'Allow' and let’s stay connected!"
            }
        }
        
        var isRegistered: Bool
        
        func register() async {
            service.onError = {
                self.error = $0
                self.isLoading = false
            }
            
            service.onSuccess = onRegistration
            
            isLoading = true
            await registerForRemoteNotifications()
            await checkRegistration()
            isRegistered = service.isRegistered
        }
        
        func checkRegistration() async {
            await service.checkRegistration()
            isRegistered = service.isRegistered
        }
        
        @MainActor
        private func registerForRemoteNotifications() async {
            let notificationCenter = UNUserNotificationCenter.current()
            
            do {
                try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
                UIApplication.shared.registerForRemoteNotifications()
            } catch {
                self.error = error
            }
        }
        
        func checkNotificationAuthorization() {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async { [weak self] in
                    switch settings.authorizationStatus {
                    case .notDetermined, .denied:
                        self?.isShowingLinkToSettings = true
                    case .authorized, .provisional, .ephemeral:
                        self?.isShowingLinkToSettings = false
                    @unknown default:
                        self?.isShowingLinkToSettings = true
                    }
                }
            }
        }
        
        func openAppSettings() {
            if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettingsURL) {
                    UIApplication.shared.open(appSettingsURL)
                }
            }
        }
    }
    
}
