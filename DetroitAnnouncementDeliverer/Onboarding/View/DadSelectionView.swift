//
//  DadSelectionView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/10/24.
//

import SwiftUI

struct DadSelectionView: View {
    @AppStorage("selectedDadIndex") var selectedDadIndex = 0
    @AppStorage("isOld") var isOld = false
    
    let action: () -> Void

    var body: some View {
        VStack {
            Text("Select Your DAD")
                .font(.title)
                .padding()
            
            Text("Age")
                .font(.title2)
                .bold()
            
            HStack {
                Text("Younger")
                    .accessibilityHidden(true)
                
                Toggle("Is Old", isOn: $isOld)
                    .accessibilityHint(Text("Toggle on to make your dad older. Toggle off to make your dad younger."))
                    .labelsHidden()
                    .padding()
                
                Text("Older")
                    .accessibilityHidden(true)

            }
            
            Text("Appearance")
                .font(.title2)
                .bold()

            Picker("Select Your DAD", selection: $selectedDadIndex) {
                ForEach(0..<Dad.list.count, id: \.self) { index in
                    Text(isOld ? Dad.list[index].oldEmoji : Dad.list[index].youngEmoji)
                        .tag(index)
                }
            }
            
            .pickerStyle(.segmented)
            .padding()
            
            DadView()
            
            Button("Continue", action: action)
                .buttonStyle(.primary)
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    DadSelectionView() {}
}
