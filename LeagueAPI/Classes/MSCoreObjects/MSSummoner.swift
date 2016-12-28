//
//  MSSummoner.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import Alamofire


public class MSSummoner: ResponseObjectSerializable, CustomStringConvertible {
    private let summonerID: Int
    public let summonerProfileIcon: Int
    public let summonerLevel: Int
    
    public let summonerName: String
    
    public let summonerRevisionDate: NSDate
    
    public var description: String {
        var secondsAgo = 0
        var rtr: String = ""
        
        rtr += "(\(summonerID)) \(summonerName) - Level \(summonerLevel)\n"
        rtr += "Profile Icon ID: \(summonerProfileIcon)\n"
        rtr += "Last change: \(summonerRevisionDate)\n"
        
        return rtr
    }
    
    public init() {
        // Default Initializer. Should never be used
        summonerID = 0
        summonerProfileIcon = 0
        summonerLevel = 0
        
        summonerName = ""
        
        summonerRevisionDate = NSDate()
    }
    
    public required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let rep = representation as? [String: Any],
            let sID = rep["id"] as? Int,
            let sProfileIcon = rep["profileIconId"] as? Int,
            let sLevel = rep["summonerLevel"] as? Int,
        
            let sName = rep["name"] as? String,
        
            let sRev = rep["revisionDate"] as? Double
        else { return nil }
        
        summonerID = sID
        summonerProfileIcon = sProfileIcon
        summonerLevel = sLevel
        
        summonerName = sName
        
        summonerRevisionDate = NSDate(timeIntervalSince1970: sRev)
    }
}
