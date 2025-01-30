//
//  ResourceRow.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct ResourceRow: View {
    let resource: Resource
    
    var body: some View {
        Link(destination: resource.url) {
            VStack(alignment: .leading) {
                Text(resource.formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(resource.message)
                    .font(.headline)
                Text(resource.url.description)
                
            }
        }
    }
}

#Preview {
    ResourceRow(resource: Resource.samples.first!)
}
