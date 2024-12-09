//
//  MostRecentAnnouncementView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct MostRecentAnnouncementView: View {
    @State private var isShowingRegistration = false
    @AppStorage("mostRecentDate") var mostRecentDate = ""
    @AppStorage("mostRecentBody") var mostRecentBody = "The most recent announcement you have received will appear here. Make sure you have enabled notifications and registered your device to receive announcements."
    @AppStorage("mostRecentUrl") var url = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                
                DadView()
                    .padding()
                
                Text(mostRecentDate.isEmpty ? "Welcome to DAD!" : "On \(mostRecentDate) DAD Said ...")
                    .font(.headline)
                    .padding()
                
                
                
                if url.isEmpty == false {
                    if let url = URL(string: url) {
                        Link(destination: url) {
                            Text(mostRecentBody)
                                .font(.title)
                                .padding()
                        }
                    }
                } else {
                    Text(mostRecentBody)
                        .font(.title)
                        .padding()
                }
                
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
