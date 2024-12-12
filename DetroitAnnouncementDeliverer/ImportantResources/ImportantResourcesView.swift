//
//  ImportantResourcesView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

extension ImportantResourcesView {
    
    @Observable
    class ViewModel {
        var resources: [Resource] = []
        var searchText = ""
        
        func fetchImportantResources() async throws {
            let baseURL = URL(string: VaporAPI.resources)!
            let cohort = UserDefaults.standard.string(forKey: UserDefaults.cohort) ?? Cohort.am.rawValue
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
            urlComponents.queryItems = [
                URLQueryItem(name: "cohort", value: cohort)
            ]
            
            if let url = urlComponents.url {
                let (data, _) = try await URLSession.shared.data(from: url)
                resources = try JSONDecoder().decode([Resource].self, from: data)
            }
        }
    }
}
struct ImportantResourcesView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @State private var vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if vm.resources.isEmpty {
                    ContentUnavailableView("No saved resources", systemImage: "book.pages", description: Text("Resources mentors have marked as important will be persisted here."))
                } else {
                    ForEach(vm.resources, content: ResourceRow.init)
                }
            }
            .navigationTitle("Saved Resources")
            .navigationBarTitleTextColor(.accent)
            .task {
                try? await vm.fetchImportantResources()
            }
            .onReceive(notificationManager.notificationPublisher) { _ in
                Task {
                    try? await vm.fetchImportantResources()
                }
            }
            .refreshable {
                try? await vm.fetchImportantResources()
            }
        }
    }
}

#Preview {
    ImportantResourcesView()
}
