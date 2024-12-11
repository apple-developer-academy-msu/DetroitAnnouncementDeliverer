//
//  DadView.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/9/24.
//

import SwiftUI

struct DadView: View {
    @AppStorage("selectedDadIndex") var selectedDadIndex = 0
    @AppStorage("isOld") var isOld = false

    var emoji: String {
        isOld ? Dad.list[selectedDadIndex].oldEmoji : Dad.list[selectedDadIndex].youngEmoji
    }
    
    var body: some View {
        Text(emoji)
            .font(.system(size: 90))
            .accessibilityHidden(true)
    }
}

#Preview {
    DadView()
}
