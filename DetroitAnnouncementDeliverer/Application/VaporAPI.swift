//
//  VaporAPI.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

enum VaporAPI {
    static let baseURL = "http://138.197.40.147:8080"
    static var resources: String { "\(VaporAPI.baseURL)/\(VaporAPI.Endpoint.resources)" }
    static var learners: String { "\(VaporAPI.baseURL)/\(VaporAPI.Endpoint.learners)" }
    
    enum Endpoint: String {
        case learners
        case resources
    }
}
