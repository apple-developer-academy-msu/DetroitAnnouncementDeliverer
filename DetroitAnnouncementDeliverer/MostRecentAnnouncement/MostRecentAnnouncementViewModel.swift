//
//  ViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/10/24.
//

import SwiftUI
import UserNotifications

extension MostRecentAnnouncementView {
    
    @Observable
    class ViewModel {
        var mostRecentDate: String {
                get {
                    access(keyPath: \.mostRecentDate)
                    return UserDefaults.standard.string(forKey: UserDefaults.mostRecentDate) ?? ""
                }
                set {
                    withMutation(keyPath: \.mostRecentDate) {
                        UserDefaults.standard.setValue(newValue, forKey: UserDefaults.mostRecentDate)
                    }
                }
            }
        
        var mostRecentBody: String {
                get {
                    access(keyPath: \.mostRecentBody)
                    return UserDefaults.standard.string(forKey: UserDefaults.mostRecentBody) ?? defaultHeadline
                }
                set {
                    withMutation(keyPath: \.mostRecentBody) {
                        UserDefaults.standard.setValue(newValue, forKey: UserDefaults.mostRecentBody)
                    }
                }
            }
        
        private var mostRecentUrl: String {
                get {
                    access(keyPath: \.mostRecentUrl)
                    return UserDefaults.standard.string(forKey: UserDefaults.mostRecentUrl) ?? ""
                }
                set {
                    withMutation(keyPath: \.mostRecentUrl) {
                        UserDefaults.standard.setValue(newValue, forKey: UserDefaults.mostRecentUrl)
                    }
                }
            }
        
        var storedURL: URL? {
            if mostRecentUrl.isEmpty == false {
                return URL(string: mostRecentUrl)
            } else {
                return nil
            }
        }
        
        var isShowingRegistration = false
        var isShowingDadSelection = false
        
        var headline: String {
            mostRecentDate.isEmpty ? "Welcome to DAD!" : "On \(mostRecentDate) DAD Said ..."
        }
        
        private let defaultHeadline = "Well, howdy sport! Your most recent message will be displayed here, so keep your eyes peeled! Just like DAD's famous sock collection, you won't want to miss it! Oh, and make sure your device is registered, or you might be left in the dark—and trust me, nobody wants that! Stay tuned, champ!"
        
        func handle(_ notification: UNNotification) {
            let title = notification.request.content.title
                print("Got notification title: ", title)
            let userInfo = notification.request.content.userInfo

            if let urlString = userInfo["url"] as? String, let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
                mostRecentUrl = urlString
            } else {
                mostRecentUrl = ""
            }
            
            if title != "Device Registration Complete!" {
                mostRecentBody = notification.request.content.subtitle
                mostRecentDate = notification.date.formatted(date: .abbreviated, time: .shortened)
            }
        }
    }
}
