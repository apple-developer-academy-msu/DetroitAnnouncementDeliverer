//
//  OnboardingInformationRowData.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation
import SwiftUI

struct OnbardingInformationRowData: Identifiable {
    var id = UUID()
    var imageName: String
    var imageColor: Color
    var title: String
    var description: String
}
