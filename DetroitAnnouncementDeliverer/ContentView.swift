//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    
    @AppStorage("cohort") private var cohort = "am"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Picker("Select a Cohort", selection: $cohort) {
                    Text("AM")
                        .tag("am")
                    Text("PM")
                        .tag("pm")
                }
                .pickerStyle(.segmented)
                .padding()
                
                Button("Register") {
                    Task {
                        await registerForRemoteNotifications()
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    func registerForRemoteNotifications() async {
        let notificationCenter = UNUserNotificationCenter.current()
        
        do {
            try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
            
            UIApplication.shared.registerForRemoteNotifications()
        } catch {
            print("Request authorization error")
        }
    }
}

#Preview {
    ContentView()
}
