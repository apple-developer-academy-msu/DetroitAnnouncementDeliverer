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
                .font(.headline)
            
            HStack {
                Text("Younger")
                Toggle("Is Old", isOn: $isOld)
                    .labelsHidden()
                    .padding()
                Text("Older")

            }
            
            Text("Appearance")
                .font(.headline)
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
