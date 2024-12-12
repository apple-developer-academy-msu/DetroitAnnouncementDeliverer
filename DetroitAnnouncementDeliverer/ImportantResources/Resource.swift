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
    
    enum CodingKeys: String, CodingKey {
        case id
        case message = "title"
        case date
        case url
    }
}

extension Resource: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.message = try container.decode(String.self, forKey: .message)
        let dateString = try container.decode(String.self, forKey: .date)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                
        if let date = formatter.date(from: dateString) {
                    self.date = date
                } else {
                    throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Invalid date format")
                }
        self.url = try container.decode(URL.self, forKey: .url)
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
