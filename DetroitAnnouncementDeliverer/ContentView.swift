//
//  ContentView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 10/28/24.
//

import SwiftUI



struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("mostRecentDate") private var mostRecentDate = "true"
    @AppStorage("mostRecentBody") private var mostRecentBody = MostRecentAnnouncementView.ViewModel.defaultHeadline
    @AppStorage("mostRecentUrl") private var mostRecentUrl = ""

    var body: some View {
        if isFirstTime {
            OnboardingView()
        } else {
            MostRecentAnnouncementView(
                vm: MostRecentAnnouncementView.ViewModel(
                    mostRecentDate: mostRecentDate,
                    mostRecentBody: mostRecentBody,
                    mostRecentUrl: mostRecentUrl
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
