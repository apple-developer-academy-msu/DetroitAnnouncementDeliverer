//
//  ImportantResourcesView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct ImportantResourcesView: View {
    @State private var resources = Resource.samples
    
    var body: some View {
        NavigationStack {
            List {
                if resources.isEmpty {
                    ContentUnavailableView("No saved resources", systemImage: "book.pages", description: Text("Resources mentors have marked as important will be persisted here."))
                } else {
                    ForEach(resources, content: ResourceRow.init)
                }
            }
            .navigationTitle("Saved Resources")
            .navigationBarTitleTextColor(.accent)
        }
    }
}

#Preview {
    ImportantResourcesView()
}
