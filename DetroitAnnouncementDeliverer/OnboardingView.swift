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
    
    let rowsData = [
        OnbardingInformationRowData(imageName: "bell.badge", imageColor: .blue, title: "Get Notified", description: "Get notified on your Academy devices to know when activities are starting"),
        OnbardingInformationRowData(imageName: "book.pages", imageColor: .blue, title: "Get Resources", description: "Get Academy resources and links sent straight to your device. Open up links with a single tap!"),
        OnbardingInformationRowData(imageName: "sharedwithyou", imageColor: .blue, title: "Stay Connected", description: "Stay up to date with Academy Alumni Announcements"),
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView() {
                withAnimation {
                    selectedTab += 1
                }
            }
            .tag(0)
            
            RegistrationView() {
                withAnimation {
                    isFirstTime = false
                }
            }
            .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct OverviewView: View {
    @Environment(\.dismiss) var dismiss
    
    let action: () -> Void
    
    let rowsData = [
        OnbardingInformationRowData(imageName: "bell.badge", imageColor: .blue, title: "Get Notified", description: "Get notified on your Academy devices to know when activities are starting"),
        OnbardingInformationRowData(imageName: "book.pages", imageColor: .blue, title: "Get Resources", description: "Get Academy resources and links sent straight to your device. Open up links with a single tap!"),
        OnbardingInformationRowData(imageName: "sharedwithyou", imageColor: .blue, title: "Stay Connected", description: "Stay up to date with Academy Alumni Announcements"),
    ]
    
    var body: some View {
        TabView {
            VStack {
                Text("Detroit Announcement Deliverer")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
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
