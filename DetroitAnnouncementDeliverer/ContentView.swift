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
        if isFirstTime {
            OnboardingView()
        } else {
            MostRecentAnnouncementView()
        }
    }
}

#Preview {
    ContentView()
}
