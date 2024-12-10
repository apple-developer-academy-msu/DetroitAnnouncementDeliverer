//
//  ViewModel.swift
//  DetroitAnnouncementDeliverer
//
//  Created by Tom Phillips on 12/10/24.
//

import SwiftUI

extension MostRecentAnnouncementView {
    @Observable
    class ViewModel {
        var isShowingRegistration = false
        var mostRecentDate: String
        var mostRecentBody: String
        var mostRecentUrl: String
        
        init(isShowingRegistration: Bool = false, mostRecentDate: String, mostRecentBody: String, mostRecentUrl: String) {
            self.isShowingRegistration = isShowingRegistration
            self.mostRecentDate = mostRecentDate
            self.mostRecentBody = mostRecentBody
            self.mostRecentUrl = mostRecentUrl
        }
        
        var headline: String {
            mostRecentDate.isEmpty ? "Welcome to DAD!" : "On \(mostRecentDate) DAD Said ..."
        }
        
        static let defaultHeadline = "Well, howdy sport! Your most recent message will be displayed here, so keep your eyes peeled! Just like DAD's famous sock collection, you won't want to miss it! Oh, and make sure your device is registered, or you might be left in the dark—and trust me, nobody wants that! Stay tuned, champ!"
        
        var storedURL: URL? {
            if mostRecentUrl.isEmpty == false {
                return URL(string: mostRecentUrl)
            } else {
                return nil
            }
        }
    }
}
