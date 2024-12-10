//
//  DadSelectionView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/10/24.
//

import SwiftUI

let dads = [
    Dad(youngEmoji: "👨", oldEmoji: "👴"),
    Dad(youngEmoji: "👨🏻", oldEmoji: "👴🏻"),
    Dad(youngEmoji: "👨🏼", oldEmoji: "👴🏻"),
    Dad(youngEmoji: "👨🏽", oldEmoji: "👴🏽"),
    Dad(youngEmoji: "👨🏾", oldEmoji: "👴🏾"),
    Dad(youngEmoji: "👨🏿", oldEmoji: "👴🏿")
]

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
                ForEach(0..<dads.count) { index in
                    Text(isOld ? dads[index].oldEmoji : dads[index].youngEmoji)
                        .tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            DadView()
            
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
        }
    }
}

#Preview {
    DadSelectionView() {}
}
