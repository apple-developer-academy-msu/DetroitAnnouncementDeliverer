//
//  MostRecentAnnouncementView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI
import UserNotifications

struct MostRecentAnnouncementView: View {
    @State private var vm: ViewModel
    @EnvironmentObject var notificationManager: NotificationManager
    
    init(vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                
                DadView()
                    .padding()
                
                Text(vm.headline)
                    .font(.headline)
                    .padding()
                
                if let mostRecentURL = vm.storedURL {
                    Link(destination: mostRecentURL) {
                        Text(vm.mostRecentBody)
                            .font(.title)
                            .padding()
                    }
                } else {
                    Text(vm.mostRecentBody)
                        .font(.title)
                        .padding()
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Register", systemImage: "gear") {
                        vm.isShowingRegistration = true
                    }
                }
            }
            .sheet(isPresented: $vm.isShowingRegistration) {
                RegistrationView() {
                    vm.isShowingRegistration = false
                }
            }
            .onReceive(notificationManager.notificationPublisher) { notification in
                let title = notification.request.content.title
                    print("Got notification title: ", title)
                let userInfo = notification.request.content.userInfo
                let userDefaults = UserDefaults.standard

                if let urlString = userInfo["url"] as? String, let url = URL(string: urlString) {
                    // Open the URL in Safari or another app
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    userDefaults.set(urlString, forKey: "mostRecentUrl")
                    vm.mostRecentUrl = urlString
                } else {
                    userDefaults.set("", forKey: "mostRecentUrl")
                    }
                
                if title != "Device Registration Complete!" {
                    userDefaults.set(notification.request.content.subtitle, forKey: "mostRecentBody")
                    vm.mostRecentBody = notification.request.content.subtitle
                    userDefaults.set(notification.date.formatted(date: .abbreviated, time: .shortened), forKey: "mostRecentDate")
                    vm.mostRecentDate = notification.date.formatted(date: .abbreviated, time: .shortened)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MostRecentAnnouncementView(vm: .init(mostRecentDate: "", mostRecentBody: "Hello", mostRecentUrl: ""))
}
