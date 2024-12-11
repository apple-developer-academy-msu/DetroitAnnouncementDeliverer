//
//  MostRecentAnnouncementView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI
import UserNotifications

struct MostRecentAnnouncementView: View {
    @State private var vm = ViewModel()
    @EnvironmentObject var notificationManager: NotificationManager
    
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
            .onReceive(notificationManager.notificationPublisher, perform: vm.handle)
            .padding()
        }
    }
}

#Preview {
    MostRecentAnnouncementView()
}
