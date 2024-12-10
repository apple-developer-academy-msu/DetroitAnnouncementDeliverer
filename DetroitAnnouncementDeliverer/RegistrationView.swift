//
//  RegistrationView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct RegistrationView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("cohort") private var cohort = "am"
    @State private var isShowingLinkToSettings = false
    let onRegistraion: () -> Void
    
    var instructions: String {
        if isShowingLinkToSettings {
            "Now listen, Sport. DAD needs your permission to send notifications to your devices for Academy announcements and resources. And yes, I mean DAD. Now, listen up—this is important! Think of it as me making sure you don’t miss out on anything important, with a little extra care and a dash of dad wisdom. Go ahead and head to your settings and turn on notifications. I’m looking out for you, and I promise it’ll be worth it."
        } else {
            "DAD needs your permission to send notifications to your devices for Academy announcements and resources. Yep, you heard that right—DAD. Think of it like having a personal assistant who’s always got your back, but with extra love, a sprinkle of dad jokes, and a whole lot of helpful reminders and resources. Click 'Allow' and let’s stay connected!"
        }
    }
    
    var body: some View {
        VStack {
            Text("Set Up")
                .font(.title)
                .padding()
            
            DadView()

            Text(instructions)
                .font(.headline)
                .foregroundStyle(isShowingLinkToSettings ? .red : .primary)
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
            .disabled(isShowingLinkToSettings)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .frame(width: 300, height: 40)
            )
            .opacity(isShowingLinkToSettings ? 0.5 : 1.0)
            .foregroundStyle(.background)

            .padding()
            
            if isShowingLinkToSettings {
                Button("Open App Settings to Turn On Notifications") {
                    openAppSettings()
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            if !isFirstTime {
                withAnimation {
                    checkNotificationAuthorization()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if !isFirstTime {
                withAnimation {
                    checkNotificationAuthorization()
                }
            }
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
    
    func checkNotificationAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined, .denied:
                    isShowingLinkToSettings = true
                case .authorized, .provisional, .ephemeral:
                    isShowingLinkToSettings = false
                @unknown default:
                    isShowingLinkToSettings = true
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

#Preview {
    RegistrationView() {
        
    }
}
