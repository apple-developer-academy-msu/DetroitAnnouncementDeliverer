//
//  RegistrationView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct RegistrationView: View {
    @AppStorage("cohort") private var cohort = "am"
    let onRegistraion: () -> Void

    var body: some View {
        VStack {
            Text("Set Up")
                .font(.title)
                .padding()
            
            Text("👴")
                .font(.system(size: 90))
                .accessibilityHidden(true)
                        
            Text("DAD needs your permission to send notifications to your devices for Academy announcement and resources.")
                .font(.headline)
                .padding()

            Text("Select a Cohort")
            Picker("Select a Cohort", selection: $cohort) {
                Text("AM")
                    .tag("am")
                Text("PM")
                    .tag("pm")
                Text("Alumni")
                    .tag("alumni")
            }
            .pickerStyle(.segmented)
            .padding()
            
            Button("Register") {
                Task {
                    await registerForRemoteNotifications()
                    onRegistraion()
                }
            }
            .foregroundStyle(.background)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .frame(width: 300, height: 40)
            )
            .padding()
            
            Spacer()
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
    RegistrationView() {
        
    }
}
