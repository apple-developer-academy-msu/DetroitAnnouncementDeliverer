//
//  Resource.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

struct Resource: Identifiable {
    let id: UUID
    let message: String
    let date: Date
    let url: URL
    
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
}

extension Resource {
    static let samples = [
        Resource(id: UUID(), message: "Check out the HIG", date: Date(), url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", date: Date(), url: URL(string: "https://developeracademy.msu.edu")!),
        Resource(id: UUID(), message: "Check out the HIG", date: Date(), url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", date: Date(), url: URL(string: "https://developeracademy.msu.edu")!),
        Resource(id: UUID(), message: "Check out the HIG", date: Date(), url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", date: Date(), url: URL(string: "https://developeracademy.msu.edu")!)
    ]
}
