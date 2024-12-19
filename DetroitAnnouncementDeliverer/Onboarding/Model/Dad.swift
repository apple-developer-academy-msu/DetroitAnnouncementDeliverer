//
//  Dad.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/11/24.
//

import Foundation

struct Dad: Identifiable {
    let id = UUID()
    let youngEmoji: String
    let oldEmoji: String
}

extension Dad {
    static let list = [
        Dad(youngEmoji: "👨", oldEmoji: "👴"),
        Dad(youngEmoji: "👨🏻", oldEmoji: "👴🏻"),
        Dad(youngEmoji: "👨🏼", oldEmoji: "👴🏼"),
        Dad(youngEmoji: "👨🏽", oldEmoji: "👴🏽"),
        Dad(youngEmoji: "👨🏾", oldEmoji: "👴🏾"),
        Dad(youngEmoji: "👨🏿", oldEmoji: "👴🏿")
    ]
}
