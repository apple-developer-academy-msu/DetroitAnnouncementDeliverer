//
//  ImportantResourcesView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct ImportantResourcesView: View {
    var body: some View {
        NavigationStack {
            List {
                ContentUnavailableView("No saved resources", systemImage: "book.pages", description: Text("Resources mentors have marked as important will be persisted here."))
            }
            .navigationTitle("Saved Resources")
            .navigationBarTitleTextColor(.accent)
        }
    }
}

#Preview {
    ImportantResourcesView()
}
