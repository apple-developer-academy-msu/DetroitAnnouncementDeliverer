//
//  Cohort.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

enum Cohort: String, CaseIterable {
    case am, pm, renaissance, alumni
    
    var label: String {
        switch self {
        case .am:
            "AM"
        case .pm:
            "PM"
        case .renaissance:
            "Renaissance"
        case .alumni:
            "Alumni"
        }
    }
}

extension Cohort: Identifiable {
    var id: RawValue { rawValue }
}
