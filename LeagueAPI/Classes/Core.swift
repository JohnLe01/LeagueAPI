//
//  Core.swift
//  LeagueAPI
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
    
    // MARK: - Public Init
    public init(withKey k: String) {
        apiKey = k
        MSCoreRouter.key = k
    }
    
    public convenience init(withKey k: String, usingRegion r: MSLeagueRegion) {
        self.init(withKey: k)
        MSCoreLeagueApi.requestRegion = r
    }
    
    // MARK: - Dynamic Data Methods
    public func searchSummoner(byName n: String) -> MSSummoner {
        var summoner: MSSummoner = MSSummoner()
        
        Alamofire.request(MSCoreRouter.searchSummoner(id: 0, name: n)).responseObject { (response: DataResponse<MSSummoner>) in
            debugPrint(response)
            
            if let s = response.result.value {
                summoner = s
            }
        }
        
        return summoner
    }
    
    // MARK: - Static Data Methods
    public func initializeStaticData() {
        //_ = getChampionStaticData()
        _ = searchSummoner(byName: "MatrixSenpai")
    }
    
    private func getChampionStaticData() -> Array<MSChampion> {
        var champions: Array<MSChampion> = []
        
        Alamofire.request(MSCoreRouter.searchChamp(id: 0)).responseCollection { (response: DataResponse<[MSChampion]>) in
            if let champs = response.result.value {
                champions = champs
            }
        }
        
        return champions
    }
}
