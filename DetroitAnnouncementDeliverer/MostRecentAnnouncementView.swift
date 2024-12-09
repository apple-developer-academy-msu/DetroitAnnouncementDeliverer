//
//  MostRecentAnnouncementView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct MostRecentAnnouncementView: View {
    @State private var isShowingRegistration = false
    @AppStorage("mostRecentTitle") var mostRecentTitle = "Welcome to DAD!"
    @AppStorage("mostRecentBody") var mostRecentBody = "The most recent announcement you have received will appear here. Make sure you have enabled notifications and registered your device to receive announcements."
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                
                DadView()
                    .padding()
                
                Text(mostRecentTitle)
                    .font(.title)
                    .padding()
                
                Text(mostRecentBody)
                    .padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Register", systemImage: "gear") {
                        isShowingRegistration = true
                    }
                }
            }
            .sheet(isPresented: $isShowingRegistration) {
                RegistrationView() {
                    isShowingRegistration = false
                }
            }
            .padding()
        }
    }
}

#Preview {
    MostRecentAnnouncementView()
}
