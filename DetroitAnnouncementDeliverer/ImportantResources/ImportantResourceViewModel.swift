//
//  ImportantResourceViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import SwiftUI

extension ImportantResourcesView {
    
    @Observable
    class ViewModel {
        var resources: [Resource] = []
        var searchText = ""
        
        private let resourceService: ResourceService
        
        init(resourceService: ResourceService) {
            self.resourceService = resourceService
        }
        
        func fetchImportantResources() async throws {
            switch await resourceService.fetchResources() {
            case .success(let fetchedResources):
                resources = fetchedResources
            case .failure(let failure):
                break
            }
        }
    }
}
