//
//  RegistrationView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct RegistrationView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("cohort") private var cohort = Cohort.am.rawValue
    @State private var vm: ViewModel
    
    init(onRegistraion: @escaping () -> Void) {
        self.vm = ViewModel(onRegistraion: onRegistraion)
    }
    
    var body: some View {
        ScrollView {
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
                ForEach(Cohort.allCases) { cohort in
                    Text(cohort.label)
                        .tag(cohort.rawValue)
                }
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
            
            if vm.isLoading {
                ProgressView()
            }
            
            Spacer()
        }
        .onAppear(perform: checkAuthorization)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            checkAuthorization()
        }
        .alert(vm.error?.localizedDescription ?? "Sorry, Champ!", isPresented: $vm.isAlertShowing) {
            Button("Ok", role: .cancel) {}
            Button("Try Again") {
                Task { await vm.register() }
            }
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
