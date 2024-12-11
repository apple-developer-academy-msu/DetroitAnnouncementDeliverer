//
//  OnboardingView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isFirstTime") private var isFirstTime = true
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView() {
                withAnimation {
                    selectedTab += 1
                }
            }
            .tag(0)
            
            DadSelectionView() {
                withAnimation {
                    selectedTab += 1
                }
            }
            .tag(1)
            
            RegistrationView() {
                withAnimation {
                    isFirstTime = false
                }
            }
            .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

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


struct OnboardingInformationRow: View {
    let data: OnbardingInformationRowData
    
    var body: some View {
        HStack {
            Image(systemName: data.imageName)
                .font(.largeTitle)
                .foregroundColor(data.imageColor)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text(data.description)
                    .font(.body
                    )
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct OnbardingInformationRowData: Identifiable {
    var id = UUID()
    var imageName: String
    var imageColor: Color
    var title: String
    var description: String
}

#Preview {
    OnboardingView()
}
