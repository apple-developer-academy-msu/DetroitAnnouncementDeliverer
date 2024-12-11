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
            VStack {
                AppTitleView()
                
                Button(action: { vm.isShowingDadSelection.toggle()}) {
                    DadView()
                        .padding()
                }
                
                Text(vm.headline)
                    .font(.headline)
                    .padding()
                
                ScrollView {
                    
                    if let mostRecentURL = vm.storedURL {
                        Link(destination: mostRecentURL, label: { message })
                    } else {
                        message
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
                .sheet(isPresented: $vm.isShowingDadSelection) {
                    DadSelectionView() {
                        vm.isShowingDadSelection.toggle()
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
    
    var message: some View {
        Text(vm.mostRecentBody)
            .font(.title)
            .padding()
    }
}

#Preview {
    MostRecentAnnouncementView()
}
