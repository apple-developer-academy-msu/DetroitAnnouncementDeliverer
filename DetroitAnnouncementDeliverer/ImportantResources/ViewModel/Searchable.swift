//
//  Searchable.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/13/24.
//

import Foundation

@MainActor
protocol Searchable: ObservableObject {
    associatedtype Model: Identifiable, Hashable
    
    var searchText: String { get set }
    var searchResults: [Model] { get }
}

extension Searchable {
    var mininumNumberOfSearchCharacters: Int { 2 }
}

// MARK: Multiword Search
extension Searchable {
    var searchTokens: [String.SubSequence] {
        searchText.split(whereSeparator: {$0.isWhitespace})
    }
    
    func searchTextMatches(_ text: String) -> Bool {
        var textTokens = text.split(whereSeparator: {$0.isWhitespace})
        
        for searchToken in searchTokens {
            var isMatch = false
            
            for (index, textToken) in textTokens.enumerated() {
                
                if let range = textToken.range(of: searchToken, options: [.caseInsensitive]),
                   range.lowerBound == textToken.startIndex {
                    isMatch = true
                    textTokens.remove(at: index)
                    break
                }
                
            }
            
            guard isMatch else { return false }
        }

        return true
    }
}
