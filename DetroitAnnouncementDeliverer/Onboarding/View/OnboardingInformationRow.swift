//
//  OnboardingInformationRow.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct OnboardingInformationRow: View {
    let data: OnbardingInformationRowData
    
    var body: some View {
        HStack {
            Image(systemName: data.imageName)
                .font(.largeTitle)
                .foregroundStyle(data.imageColor)
                .padding(.trailing, 5)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text(data.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingInformationRow(data: OnbardingInformationRowData(imageName: "bell.badge", imageColor: .accent, title: "Get Notified", description: "Get notified on your Academy devices when activities are starting, so you’re not the one left saying, 'Wait, what time does this start?'"))
}
