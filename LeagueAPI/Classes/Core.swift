//
//  Core.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import SwiftyJSON

class MSCoreLeagueApi {
    let apiKey: String
    
    static var requestRegion: MSLeagueRegion = .all
    
    init(withKey k: String) {
        apiKey = k
    }
    
    convenience init(withKey k: String, usingRegion r: MSLeagueRegion) {
        self.init(withKey: k)
        MSCoreLeagueApi.requestRegion = r
    }
}
