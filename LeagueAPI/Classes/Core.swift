//
//  Core.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import SwiftyJSON
import Alamofire

public final class MSCoreLeagueApi {
    let apiKey: String
    
    private var staticData: Bool = false
    
    static var requestRegion: MSLeagueRegion = .all
    
    public init(withKey k: String) {
        apiKey = k
    }
    
    public convenience init(withKey k: String, usingRegion r: MSLeagueRegion) {
        self.init(withKey: k)
        MSCoreLeagueApi.requestRegion = r
    }
    
    public func initializeStaticData() {
        let championData: Array<MSChampion> = getChampionStaticData()
    }
    
    private func getChampionStaticData() -> Array<MSChampion> {
        let params: Parameters = ["champData": "all", "api_key": apiKey]
        Alamofire.request("https://global.api.pvp.net/api/lol/static-data/\(MSCoreLeagueApi.requestRegion.rawValue)/v1.2/champion/22", parameters: params).responseObject { (response: DataResponse<MSChampion>) in
            debugPrint(response)
            
            if let champ: MSChampion = response.result.value {
                print(champ)
                
            }
        }
        
        return []
    }
}
