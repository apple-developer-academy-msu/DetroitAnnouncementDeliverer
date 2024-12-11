//
//  Resource.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

struct Resource: Identifiable, Decodable {
    let id: UUID
    let message: String
    let date: Date = Date()
    let url: URL
    
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case message = "title"
        case url
    }
}

extension Resource {
    static let samples = [
        Resource(id: UUID(), message: "Check out the HIG", url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", url: URL(string: "https://developeracademy.msu.edu")!),
        Resource(id: UUID(), message: "Check out the HIG", url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", url: URL(string: "https://developeracademy.msu.edu")!),
        Resource(id: UUID(), message: "Check out the HIG", url: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!),
        Resource(id: UUID(), message: "ADA MSU Website", url: URL(string: "https://developeracademy.msu.edu")!)
    ]
}
