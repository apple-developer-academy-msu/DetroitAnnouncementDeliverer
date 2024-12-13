//
//  SortMenu.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import SwiftUI

extension ImportantResourcesView {
    struct SortMenu: View {
        @Binding var selectedSort: SortType
        
        var body: some View {
            Menu {
                ForEach(SortType.allCases) { sortType in
                    Button {
                        selectedSort = sortType
                    } label: {
                        HStack {
                            Text(sortType.rawValue)
                            
                            if selectedSort == sortType {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                    }
                }
            } label: {
                Label("Change Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
}
