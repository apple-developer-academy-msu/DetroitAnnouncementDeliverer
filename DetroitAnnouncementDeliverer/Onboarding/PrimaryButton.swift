//
//  PrimaryButton.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import SwiftUI


struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .frame(width: 300, height: 40)
            )
    }
}

extension ButtonStyle where Self == PrimaryButton {
    @MainActor static var primary: PrimaryButton { PrimaryButton() }
}
