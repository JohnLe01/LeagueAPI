//
//  MSSummoner.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import Alamofire

class MSSummoner {
    let summonerID: Int
    var summonerProfileIcon: Int?
    var summonerLevel: Int?
    
    var summonerName: String?
    
    var summonerRevisionDate: NSDate?
    
    init(withID i: Int) {
        summonerID = i
    }
    
    static func fetchSummoner(using: Int) -> MSSummoner {
        let r = MSCoreLeagueApi.requestRegion
        return MSSummoner(withID: 0)
    }
}
