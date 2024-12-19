//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    let registrationService: RegistrationService

    var body: some View {
        if isFirstTime {
            OnboardingView(registrationService: registrationService)
        } else {
            TabView {
                Tab("Most Recent", systemImage: "bell.badge") {
                    MostRecentAnnouncementView(registrationService: registrationService)
                }
                
                Tab("Important Resources", systemImage: "sharedwithyou") {
                    ImportantResourcesView(resourceService: VaporResourceService())
                }
            }
        }
    }
}

#Preview {
    ContentView(registrationService: VaporRegistrationService())
}
