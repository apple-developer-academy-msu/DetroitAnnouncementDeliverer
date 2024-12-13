//
//  ResourceService.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import Foundation

protocol ResourceService {
    func fetchResources() async -> Result<[Resource], ResourceServiceError>
}

enum ResourceServiceError: Swift.Error, LocalizedError {
    case invalidURL, invalidData, decodingError
    
    var errorDescription: String? {
        "Whoops, champ! Looks like DAD's having some trouble grabbing your resources. Give your internet a quick check and try again. I'll get it sorted!"
    }
}

class VaporResourceService: ResourceService {
    let baseURL: URL = URL(string: VaporAPI.resources)!

    func fetchResources() async -> Result<[Resource], ResourceServiceError> {
        let cohort = UserDefaults.standard.string(forKey: UserDefaults.cohort) ?? Cohort.am.rawValue
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "cohort", value: cohort)
        ]
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return .failure(.invalidData)}
        guard let resources = try? JSONDecoder().decode([Resource].self, from: data) else { return .failure(.decodingError) }
        
        return .success(resources)
    }
    
    
}
