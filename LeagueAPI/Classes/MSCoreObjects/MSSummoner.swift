//
//  MSSummoner.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import Alamofire
import Datez

public class MSSummoner: ResponseObjectSerializable, CustomStringConvertible {
    private let summonerID: Int
    public let summonerProfileIcon: Int
    public let summonerLevel: Int
    
    public let summonerName: String
    
    public let summonerRevisionDate: Date
    
    public var description: String {
        var dString: String = summonerRevisionDate.description
        var timeSince: String = summonerRevisionDate.timeIntervalSinceNow.description
        var rtr: String = ""
        
        rtr += "(\(summonerID)) \(summonerName) - Level \(summonerLevel)\n"
        rtr += "Profile Icon ID: \(summonerProfileIcon)\n"
        rtr += "Last change: \(dString) (\(timeSince) seconds ago)\n"
        
        return rtr
    }
    
    public init() {
        // Default Initializer. Should never be used
        summonerID = 0
        summonerProfileIcon = 0
        summonerLevel = 0
        
        summonerName = ""
        
        summonerRevisionDate = Date()
    }
    
    public required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let rep = representation as? [String: Any],
            let drilled = rep.values.first as? [String: Any],
            let sID = drilled["id"] as? Int,
            let sProfileIcon = drilled["profileIconId"] as? Int,
            let sLevel = drilled["summonerLevel"] as? Int,
        
            let sName = drilled["name"] as? String,
        
            let sRev = drilled["revisionDate"] as? Double
        else { return nil }
        
        summonerID = sID
        summonerProfileIcon = sProfileIcon
        summonerLevel = sLevel
        
        summonerName = sName
        
        summonerRevisionDate = Date(timeIntervalSince1970: sRev)
    }
}
