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

    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        notificationSubject.send(response.notification)
    }
    
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        notificationSubject.send(notification)
        return [.badge, .banner, .list, .sound]
    }
}
