//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    
    @AppStorage("cohort") private var cohort = "am"
    @AppStorage("isFirstTime") private var isFirstTime = true
    @State private var isShowingRegistration = false
    
    var body: some View {
        NavigationStack {
            if isFirstTime {
                OnboardingView()
            } else {
                VStack {
                    Text("Detroit Announcement Deliverer")
                        .font(.largeTitle)
                        .bold()
                    
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

#Preview {
    ContentView()
}
