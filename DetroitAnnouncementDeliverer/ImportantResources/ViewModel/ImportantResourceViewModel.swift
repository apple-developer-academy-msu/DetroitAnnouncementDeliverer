//
//  ImportantResourceViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import SwiftUI

extension ImportantResourcesView {

    @Observable
    class ViewModel: Searchable {
        var searchText = ""
        var sortType: SortType = .newest
        var isLoading = true
        var error: ResourceServiceError? {
            didSet {
                if error != nil {
                    isAlertShowing = true
                } else {
                    isAlertShowing = false
                }
            }
        }
        
        var isAlertShowing: Bool = false
        
        var searchResults: [Resource] {
            resources
                .filter { searchTextMatches($0.message) }
                .sorted(by: sortType.sort)
        }
        
        var noContentDescription: String {
            if searchText.count > mininumNumberOfSearchCharacters && searchResults.isEmpty {
                "How about giving a different search a try, champ? Might find something better that way!"
            } else {
                "This is where you'll find the stuff that mentors think is really important. Think of it as their personal shortlist of the best stuff to check out!"
            }
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
                error = nil
            case .failure(let failure):
                error = failure
            }
            
            isLoading = false
        }
    }
}
