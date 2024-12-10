//
//  NotificationManager.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/10/24.
//

import Combine
import UserNotifications

class NotificationManager: NSObject, ObservableObject {
    @Published var recievedNotification: UNNotification?
    
    private var notificationSubject = PassthroughSubject<UNNotification, Never>()
    
    var notificationPublisher: AnyPublisher<UNNotification, Never> {
        notificationSubject.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        await MainActor.run {
            notificationSubject.send(response.notification)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        await MainActor.run {
            notificationSubject.send(notification)
        }
        
        return [.badge, .banner, .list, .sound]
    }
}
