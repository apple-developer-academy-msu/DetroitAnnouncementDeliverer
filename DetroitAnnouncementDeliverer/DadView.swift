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

    var body: some View {
        Text(isOld ? dads[selectedDadIndex].oldEmoji : dads[selectedDadIndex].youngEmoji)
            .font(.system(size: 90))
            .accessibilityHidden(true)
    }
}

#Preview {
    DadView()
}
