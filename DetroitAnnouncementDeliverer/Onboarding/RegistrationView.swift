//
//  RegistrationView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct RegistrationView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("cohort") private var cohort = "am"
    @State private var vm: ViewModel
    
    init(onRegistraion: @escaping () -> Void) {
        self.vm = ViewModel(onRegistraion: onRegistraion)
    }
    
    var body: some View {
        VStack {
            Text("Set Up")
                .font(.title)
                .padding()
            
            DadView()

            Text(vm.instructions)
                .font(.headline)
                .foregroundStyle(vm.isShowingLinkToSettings ? .red : .primary)
                .padding()

            Text("Select a Cohort")
            Picker("Select a Cohort", selection: $cohort) {
                Text("AM")
                    .tag("am")
                Text("PM")
                    .tag("pm")
                Text("Alumni")
                    .tag("alumni")
            }
            .pickerStyle(.segmented)
            .padding()
            
            Button("Register") {
                Task {
                    await vm.register()
                }
            }
            .disabled(vm.isShowingLinkToSettings)
            .buttonStyle(.primary)
            .opacity(vm.isShowingLinkToSettings ? 0.5 : 1.0)
            .foregroundStyle(.background)

            .padding()
            
            if vm.isShowingLinkToSettings {
                Button("Open App Settings to Turn On Notifications") {
                    vm.openAppSettings()
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear(perform: checkAuthorization)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            checkAuthorization()
        }
    }
    
    fileprivate func checkAuthorization() {
        if !isFirstTime {
            withAnimation {
                vm.checkNotificationAuthorization()
            }
        }
    }
}

#Preview {
    RegistrationView() {}
}
