//
//  ImportantResourcesView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct ImportantResourcesView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @State private var vm: ViewModel
    
    init(resourceService: ResourceService) {
        self.vm = ViewModel(resourceService: resourceService)
    }
    
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

struct MockResourceService: ResourceService {
    func fetchResources() async -> Result<[Resource], ResourceServiceError> {
        .success(Resource.samples)
    }
}

#Preview {
    ImportantResourcesView(resourceService: MockResourceService())
}
