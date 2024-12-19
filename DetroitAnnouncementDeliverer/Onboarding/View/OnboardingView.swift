//
//  OnboardingView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @State private var selectedTab = 0
    
    let registrationService: RegistrationService
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView() {
                withAnimation {
                    selectedTab = 1
                }
            }
            .tag(0)
            
            DadSelectionView() {
                withAnimation {
                    selectedTab = 2
                }
            }
            .tag(1)
            
            RegistrationView(service: registrationService) {
                withAnimation {
                    isFirstTime = false
                }
            }
            .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

#Preview {
    OnboardingView(registrationService: VaporRegistrationService())
}
