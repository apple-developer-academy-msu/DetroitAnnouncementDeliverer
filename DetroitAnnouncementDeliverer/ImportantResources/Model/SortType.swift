//
//  SortType.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/19/24.
//

enum SortType: String, CaseIterable, Identifiable {
    case newest = "Newest"
    case oldest = "Oldest"
    
    func sort(lhs: Resource, rhs: Resource) -> Bool {
        switch self {
        case .newest:
            lhs.date > rhs.date
        case .oldest:
            lhs.date < rhs.date
        }
    }
    
    var id: RawValue { rawValue }
}
