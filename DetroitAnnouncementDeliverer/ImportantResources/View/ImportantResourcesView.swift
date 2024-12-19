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
                if vm.searchResults.isEmpty {
                    ContentUnavailableView("No saved resources found", systemImage: "book.pages", description: Text(vm.noContentDescription))
                        .overlay {
                            if vm.isLoading {
                                ProgressView()
                            }
                        }                    
                } else {
                    ForEach(vm.searchResults, content: ResourceRow.init)
                }
            }
            .navigationTitle("Saved Resources")
            .navigationBarTitleTextColor(.accent)
            .searchable(text: $vm.searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SortMenu(selectedSort: $vm.sortType)
                }
            }
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
            .alert(vm.error?.localizedDescription ?? "Sorry, Champ!", isPresented: $vm.isAlertShowing) {
                Button("Ok", role: .cancel) {}
                Button("Try Again") {
                    Task { try await vm.fetchImportantResources() }
                }
            }
        }
    }
}

struct MockResourceService: ResourceService {
    let isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func fetchResources() async -> Result<[Resource], ResourceServiceError> {
        if isSuccess {
            .success(Resource.samples)
        } else {
            .failure(.decodingError)
        }
    }
}

#Preview {
    ImportantResourcesView(resourceService: MockResourceService(isSuccess: true))
        .environmentObject(NotificationManager())
}
