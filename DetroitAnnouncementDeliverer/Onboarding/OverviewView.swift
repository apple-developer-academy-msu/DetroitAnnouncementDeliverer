//
//  OverviewView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI

struct OverviewView: View {
    @Environment(\.dismiss) var dismiss
    
    let action: () -> Void
    
    let rowsData = [
        OnbardingInformationRowData(imageName: "bell.badge", imageColor: .blue, title: "Get Notified", description: "Get notified on your Academy devices when activities are starting, so you’re not the one left saying, 'Wait, what time does this start?'"),
        OnbardingInformationRowData(imageName: "book.pages", imageColor: .blue, title: "Get Resources", description: "No need for a magic wand! Academy resources and links are sent straight to your device—just one tap and BOOM, you're there faster than DAD can tell a bad pun!"),
        OnbardingInformationRowData(imageName: "sharedwithyou", imageColor: .blue, title: "Stay Connected", description: "Want to be the coolest cat at the alumni reunion? Stay up to date with Academy Alumni Announcements! You’ll be so in-the-know, even your pet goldfish will be impressed."),
    ]
    
    var body: some View {
        VStack {
            AppTitleView()
                .padding(.bottom)
            
            ScrollView {
                Text("Meet DAD!")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    ForEach(rowsData) { rowData in
                        OnboardingInformationRow(data: rowData)
                    }
                }
                
                Spacer()
                
                Button(action: action) {
                    Text("Continue")
                        .foregroundColor(.white)
                }
                
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .frame(width: 300, height: 40)
                )
                .padding()
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}


#Preview {
    OverviewView() {}
}
