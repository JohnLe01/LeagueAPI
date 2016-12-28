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
    
    public var coreDelegate: MSCoreListener?
    
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
    
    public func registerAsDelegate(controller: MSCoreListener) {
        coreDelegate = controller
    }
    
    public func resignDelegate() {
        coreDelegate = nil
    }
    
    // MARK: - Dynamic Data Methods
    public func searchSummoner(byName n: String) {
        Alamofire.request(MSCoreRouter.searchSummoner(id: 0, name: n)).responseObject { (response: DataResponse<MSSummoner>) in
            if let s = response.result.value {
                if(self.coreDelegate?.requestTypes != .summonerData) { return }
                self.coreDelegate?.didReturn(singleObject: s)
            }
        }
    }
    
    // MARK: - Static Data Methods
    public func initializeStaticData() {
        //_ = getChampionStaticData()
    }
    
    public func getChampionStaticData() {
        Alamofire.request(MSCoreRouter.searchChamp(id: 0)).responseCollection { (response: DataResponse<[MSChampion]>) in
            if let champs = response.result.value {
                if(self.coreDelegate?.requestTypes != .championData) { return }
                self.coreDelegate?.didReturn(collection: champs)
            }
        }
    }
}
