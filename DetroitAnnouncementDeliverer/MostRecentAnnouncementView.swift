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
    @AppStorage("mostRecentBody") var mostRecentBody = "Well, howdy sport! Your most recent message will be displayed here, so keep your eyes peeled! Just like DAD's famous sock collection, you won't want to miss it! Oh, and make sure your device is registered, or you might be left in the dark—and trust me, nobody wants that! Stay tuned, champ!"
    @AppStorage("mostRecentUrl") var url = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
