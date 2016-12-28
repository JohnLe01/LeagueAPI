//
//  MSLeagueRouter.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//
//

import UIKit
import Alamofire

internal enum MSCoreRouter: URLRequestConvertible {
    case searchChamp(id: Int)
    case searchSummoner(id: Int, name: String)
    
    static let baseDynamicURL = "https://na.api.pvp.net/api/lol"
    static var key = ""
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = try {
            let k = MSCoreRouter.key
            if k.characters.count == 0 {
                throw MSCoreError.missingValidKey(details: "No key provided")
            }
            var p: Parameters = ["api_key": k]
            
            switch self {
            // MARK: - Static Data Searches
                
            // MARK: - Static Champion Data
            case let .searchChamp(id) where id > 0:
                p.updateValue("all", forKey: "champData")
                return ("/static-data/na/v1.2/champion/\(id)", p)
            case let .searchChamp(_):
                p.updateValue("all", forKey: "champData")
                return("/static-data/na/v1.2/champion", p)
                
            // MARK: - Dynamic Data Searches
                
            // MARK: - Summoner Searches
            case let .searchSummoner(id, _) where id > 0:
                return("/na/v1.4/summoner/\(id)", p)
            case let .searchSummoner(_, name):
                return("/na/v1.4/summoner/by-name/\(name)", p)
            }
        }()
        
        let url = try MSCoreRouter.baseDynamicURL.asURL()
        let request = URLRequest(url: url.appendingPathComponent(result.path))
        return try URLEncoding.default.encode(request, with: result.parameters)
    }
}
