//
//  MSChampion.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

import UIKit
import Alamofire

// MARK: - Core League Champion object
public struct MSChampion: ResponseObjectSerializable, CustomStringConvertible {
    let championID: Int
    
    var allyTips: Array<String>
    var enemyTips: Array<String>
    
    var championManaType: String?
    
    var championName: String
    var championTitle: String
    
    var championLore: String
    var championLoreBlurb: String
    
    var championClass: MSChampionClass
    var championImage: MSChampionImage?
    var championSkins: Array<MSChampionSkin>?
    var championInformation: MSChampionInformation?
    
    public var description: String {
        var rtr: String = ""
        
        rtr += "(\(championID)) \(championName) - \(championTitle)\n"
        
        return rtr
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            
            let cID = representation["id"] as? Int,
            
            let cName = representation["name"] as? String,
            let cTitle = representation["title"] as? String,
        
            let cLore = representation["lore"] as? String,
            let cBlurb = representation["blurb"] as? String,
        
            let tags = representation["tags"] as? [String],

            let cClass = MSChampionClass(withData: tags),
            
            let cAllyTips = representation["allytips"] as? [String],
            let cEnemyTips = representation["enemytips"] as? [String]
            
        else { return nil }
        
        championID = cID
        
        championName = cName
        championTitle = cTitle
        
        championClass = cClass
        
        championLore = cLore
        championLoreBlurb = cBlurb
        
        allyTips = cAllyTips
        enemyTips = cEnemyTips
        
        
    }
}

// MARK: - Champion add-on objects

// MARK: - Champion Image
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

// MARK: - Champion Skin
public struct MSChampionSkin {
    var skinID: Int?
    var skin: String?
    var skinNum: Int?
    
    var skinImage: UIImage?
}

// MARK: - Champion Information
public struct MSChampionInformation {
    var attack: Int?
    var defense: Int?
    var magic: Int?
    var difficulty: Int?
}

// MARK: - Champion Statistics
public struct MSChampionStatistics {
    var armor: MSScalable?
    var attackDamage: MSScalable?
    var attackSpeed: MSScalable?
    var crit: MSScalable?
    var hitpoints: MSScalable?
    var mana: MSScalable?
    var manaRegen: MSScalable?
    var magicResist: MSScalable?
    
    var attackRange: Float?
    var movementSpeed: Float?
    
    init?(withData d: Dictionary<String, Any>) {
        guard
            let cArm = d["armor"] as? Float,
            let cArmPLvl = d["armorperlevel"] as? Float
        
        else { return nil }
        
        armor = MSScalable(base: cArm, withScale: cArmPLvl)
    }
}

// MARK: - Champion Primary/Secondary Class
public struct MSChampionClass {
    let primary  : MSChampionType
    let secondary: MSChampionType
    
    init(withPrimaryClass p: MSChampionType, andSecondaryClass s: MSChampionType) {
        primary = p
        secondary = s
    }
    
    init?(withData d: Array<String?>) {
        guard
            let p = d[0],
            let s = d[1]
        else { return nil }
        
        self.init(withPrimaryClass: MSChampionType(rawValue: p)!, andSecondaryClass: MSChampionType(rawValue: s)!)
    }

    public func compare(primary: MSChampionType, secondary: MSChampionType) -> Bool {
        return (primary == self.primary) && (secondary == self.secondary)
    }
    
    public func compare(primary: MSChampionType) -> Bool {
        return primary == self.primary
    }
    
    public func compare(secondary: MSChampionType) -> Bool {
        return secondary == self.secondary
    }
}

// MARK: - Supporting types (meant to be stored as Array<T>)

// MARK: - Champion Type (Equatable)
public enum MSChampionType: String, Equatable {
    case none     = "No Class"
    case assassin = "Assassin"
    case fighter  = "Fighter"
    case mage     = "Mage"
    case marksman = "Marksman"
    case support  = "Support"
    case tank     = "Tank"
    
    public init?(rawValue: String) {
        
        switch rawValue {
        case "assassin": self = .assassin
        case "Fighter" : self = .fighter
        case "Mage"    : self = .mage
        case "Marksman": self = .marksman
        case "Support" : self = .support
        case "Tank"    : self = .tank
        default: self = .none
        }
    }
    
    public static func ==(lhs: String, rhs: MSChampionType) -> Bool {
        return lhs.lowercased() == rhs.rawValue.lowercased()
    }
    
    public static func ==(lhs: MSChampionType, rhs: String) -> Bool {
        return lhs.rawValue.lowercased() == rhs.lowercased()
    }
    
    public static func ==(lhs: MSChampionType, rhs: MSChampionType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - Scalable Type
public struct MSScalable {
    var base: Float
    var scaleBy: Float
    
    init(base b: Float, withScale s: Float) {
        base = b
        scaleBy = s
    }
    
    public func scaledBy(level: Int) -> Float {
        if !((level < 19) && (level > 0)) { print("Error! Trying to scale by invalid level! (Tried \(level))"); return 0 }
        return (base + (scaleBy * Float(level)))
    }
}
