//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true

    var body: some View {
        if isFirstTime {
            OnboardingView()
        } else {
            TabView {
                Tab("Most Recent", systemImage: "bell.badge") {
                    MostRecentAnnouncementView()
                }
                
                Tab("Important Resources", systemImage: "sharedwithyou") {
                    ImportantResourcesView(resourceService: VaporResourceService())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
