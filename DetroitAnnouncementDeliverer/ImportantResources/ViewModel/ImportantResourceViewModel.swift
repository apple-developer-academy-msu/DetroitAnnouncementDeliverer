//
//  ImportantResourceViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import SwiftUI

extension ImportantResourcesView {
    
    enum SortType: String, CaseIterable, Identifiable {
        case newest = "Newest"
        case oldest = "Oldest"
        
        func sort(lhs: Resource, rhs: Resource) -> Bool {
            switch self {
            case .newest:
                lhs.date > rhs.date
            case .oldest:
                lhs.date < rhs.date
            }
        }
        
        var id: RawValue { rawValue }
    }
    
    @Observable
    class ViewModel: Searchable {
        var searchText = ""
        var sortType: SortType = .newest
        var isLoading = true
        
        var searchResults: [Resource] {
            resources
                .filter { searchTextMatches($0.message) }
                .sorted(by: sortType.sort)
        }
        
        private var resources: [Resource] = []
        private let resourceService: ResourceService
        
        init(resourceService: ResourceService) {
            self.resourceService = resourceService
        }
        
        func fetchImportantResources() async throws {
            isLoading = true
            
            switch await resourceService.fetchResources() {
            case .success(let fetchedResources):
                resources = fetchedResources
            case .failure(let failure):
                break
            }
            
            isLoading = false
        }
    }
}
