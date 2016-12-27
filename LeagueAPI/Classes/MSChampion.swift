//
//  MSChampion.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import Alamofire

public struct MSChampion: ResponseObjectSerializable, CustomStringConvertible {
    let championID: Int!
    
    var allyTips: Array<String>?
    var enemyTips: Array<String>?
    
    var championManaType: String?
    
    var championName: String?
    var championTitle: String?
    var championLore: String?
    var championLoreBlurb: String?
    
    var championImage: MSChampionImage?
    var championSkins: Array<MSChampionSkin>?
    var championInformation: MSChampionInformation?
    
    public var description: String {
        return "\(championID) MSChampion"
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let cID = representation["id"] as? String
        else { return nil }
        
        championID = Int(cID)
    }
}

public struct MSChampionImage {
    var full: String?
    var sprite: String?
    var group: String?
    var imgx: Int?
    var imgy: Int?
    var imgw: Int?
    var imgh: Int?
    
    var fullImage: UIImage?
    var spriteImage: UIImage?
}

public struct MSChampionSkin {
    var skinID: Int?
    var skin: String?
    var skinNum: Int?
}

public struct MSChampionInformation {
    var attack: Int?
    var defense: Int?
    var magic: Int?
    var difficulty: Int?
}
