//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    @State private var selectedCohort = "am"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Picker("Select a Cohort", selection: $selectedCohort) {
                    Text("AM")
                        .tag("am")
                    Text("PM")
                        .tag("pm")
                }
                .pickerStyle(.segmented)
                .padding()
                
                Button("Register") {
                    Task {
                        let notificationCenter = UNUserNotificationCenter.current()
                        
                        do {
                            try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
                        } catch {
                            print("Request authorization error")
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
