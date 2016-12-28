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
public class MSChampion: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    private let championID: Int
    
    public let allyTips: Array<String>
    public let enemyTips: Array<String>
    
    public let championManaType: String
    
    public let championName: String
    public let championTitle: String
    
    public let championLore: String
    public let championLoreBlurb: String
    
    public let championClass: MSChampionClass
    public let championImage: MSChampionImage
    public let championSkins: Array<MSChampionSkin>
    public let championInformation: MSChampionInformation
    public let championStatistics: MSChampionStatistics
    
    public var description: String {
        var rtr: String = ""
        
        rtr += "(\(championID)) \(championName) - \(championTitle)\n"
        rtr += championClass.description
        rtr += "Mana Type: \(championManaType)\n"
        rtr += championInformation.description
        rtr += championStatistics.description
        rtr += "Skins: \(championSkins.count - 1)" // Don't count default
        
        return rtr
    }
    
    public init() {
        // Default initializer. Only for testing
        championID = 0
        allyTips = []
        enemyTips = []
        championManaType = ""
        championName = ""
        championTitle = ""
        championLore = ""
        championLoreBlurb = ""
        championClass = MSChampionClass()
        championSkins = []
        championImage = MSChampionImage()
        championInformation = MSChampionInformation()
        championStatistics = MSChampionStatistics()
    }
    
    public required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            
            let cID = representation["id"] as? Int,
            
            let cName = representation["name"] as? String,
            let cTitle = representation["title"] as? String,
        
            let cLore = representation["lore"] as? String,
            let cBlurb = representation["blurb"] as? String,
        
            let tags = representation["tags"] as? [String],

            let cClass = MSChampionClass(withData: tags),
            
            let cManaType = representation["partype"] as? String,
            
            let cAllyTips = representation["allytips"] as? [String],
            let cEnemyTips = representation["enemytips"] as? [String],
        
            let cImagesData = representation["image"] as? [String: Any],
            let cImage = MSChampionImage(withData: cImagesData),
            let cSkinsData = representation["skins"] as? [[String: Any]],
            let cInfoData = representation["info"] as? [String: Any],
            let cInfo = MSChampionInformation(withData: cInfoData),
            let cStatsData = representation["stats"] as? [String: Any],
            let cStats = MSChampionStatistics(withData: cStatsData)
        
        else { return nil }
        
        championID = cID
        
        championName = cName
        championTitle = cTitle
        
        championClass = cClass
        
        championLore = cLore
        championLoreBlurb = cBlurb
        
        allyTips = cAllyTips
        enemyTips = cEnemyTips
        
        championManaType = cManaType
        
        championStatistics = cStats
        championInformation = cInfo
        championImage = cImage
        
        var cSkins: Array<MSChampionSkin> = []
        cSkinsData.forEach { (skin) in
            guard let d = MSChampionSkin(withData: skin) else { return }
            cSkins.append(d)
        }
        
        if cSkins.count < 1 { return nil } // Failed somewhere along the way
        championSkins = cSkins
    }
}

// MARK: - Champion add-on objects

// MARK: - Champion Image
public struct MSChampionImage: MSChampionComponent {
    public let full: String
    public let sprite: String
    public let group: String
    public let imgx: Int
    public let imgy: Int
    public let imgw: Int
    public let imgh: Int
    
    public var fullImage: UIImage?
    public var spriteImage: UIImage?
    
    public var description: String {
        return "MSChampionImage(x: \(imgx) y: \(imgy) w: \(imgw) h: \(imgh))\n"
    }

    public init() {
        // Default initializer. Should only be used for testing purposes
        full = ""
        sprite = ""
        group = ""
        imgx = 0
        imgy = 0
        imgw = 0
        imgh = 0
    }
    
    public init?(withData: Dictionary<String, Any>) {
        guard
            let cFull = withData["full"] as? String,
            let cSprite = withData["sprite"] as? String,
            let cGroup = withData["group"] as? String,
        
            let cX = withData["x"] as? Int,
            let cY = withData["y"] as? Int,
            let cW = withData["w"] as? Int,
            let cH = withData["h"] as? Int
        
        else { return nil }
        
        full = cFull
        sprite = cSprite
        group = cGroup
        
        imgx = cX
        imgy = cY
        imgw = cW
        imgh = cH
    }
}

// MARK: - Champion Skin
public struct MSChampionSkin: MSChampionComponent {
    private let skinID: Int
    public let skin: String
    public let skinNum: Int
    
    public var skinImage: UIImage?
    
    public var description: String {
        if(skinNum == 0 || skin == "default") { return "" }
        return "(#\(skinNum)) \(skin)\n"
    }

    public init() {
        // Default initializer. Should only be used for testing purposes
        skinID = 0
        skin = ""
        skinNum = 0
    }
    
    public init?(withData: Dictionary<String, Any>) {
        guard
            let cID = withData["id"] as? Int,
            let cNum = withData["num"] as? Int,
            let cName = withData["name"] as? String
            
        else { return nil }
        
        skinID = cID
        skin = cName
        skinNum = cNum
    }
}

// MARK: - Champion Information
public struct MSChampionInformation: MSChampionComponent {
    public let attack: Int
    public let defense: Int
    public let magic: Int
    public let difficulty: Int
    
    public var description: String {
        var rtr = ""
        
        rtr += "Attack (AD): \(attack)\n"
        rtr += "Defense:     \(defense)\n"
        rtr += "Magic (AP):  \(magic)\n"
        rtr += "Difficulty:  \(difficulty)\n"
        
        return rtr
    }

    public init() {
        // Default initializer. Should only be used for testing purposes
        attack = 0
        defense = 0
        magic = 0
        difficulty = 0
    }
    
    init?(withData: Dictionary<String, Any>) {
        guard
            let cAttack = withData["attack"] as? Int,
            let cDefense = withData["defense"] as? Int,
            let cMagic = withData["magic"] as? Int,
            let cDiff = withData["difficulty"] as? Int
        
        else { return nil }
        
        attack = cAttack
        defense = cDefense
        magic = cMagic
        difficulty = cDiff
    }
}

// MARK: - Champion Statistics
public struct MSChampionStatistics: MSChampionComponent {
    public let armor: MSScalable
    public let attackDamage: MSScalable
    public let attackSpeed: MSScalable
    public let crit: MSScalable
    public let hitpoints: MSScalable
    public let hitpointsRegen: MSScalable
    public let mana: MSScalable
    public let manaRegen: MSScalable
    public let magicResist: MSScalable
    
    public let attackRange: Double
    public let movementSpeed: Double
    
    public var description: String {
        var rtr = ""

        rtr += "Armor (AR):              \(armor.description)"
        rtr += "Attack Damage (AD):      \(attackDamage.description)"
        rtr += "Attack Speed (AS):       \(attackSpeed.description)"
        rtr += "Critical Strike (Crit):  \(crit.description)"
        rtr += "Health (HP):             \(hitpoints.description)"
        rtr += "Health Regen (HP Regen): \(hitpointsRegen.description)"
        rtr += "Mana (MP):               \(mana.description)"
        rtr += "Mana Regen (MP Regen):   \(manaRegen.description)"
        rtr += "Magic Resist (MR):       \(magicResist.description)"
        
        rtr += String(format: "Attack Range (Range):    %.2f\n", attackRange)
        rtr += String(format: "Movement Speed (MS):     %.2f\n", movementSpeed)
        
        return rtr
    }
    
    public init() {
        // Default initializer. Should only be used for testing purposes
        armor = MSScalable()
        attackDamage = MSScalable()
        attackSpeed = MSScalable()
        crit = MSScalable()
        hitpoints = MSScalable()
        hitpointsRegen = MSScalable()
        mana = MSScalable()
        manaRegen = MSScalable()
        magicResist = MSScalable()
        
        attackRange = 0.0
        movementSpeed = 0.0
    }
    
    public init?(withData d: Dictionary<String, Any>) {
        guard
            let cArm = d["armor"] as? Double,
            let cArmPLvl = d["armorperlevel"] as? Double,
        
            let cAD = d["attackdamage"] as? Double,
            let cADPLvl = d["attackdamageperlevel"] as? Double,
        
            let cASoffset = d["attackspeedoffset"] as? Double,
            let cASPLvl = d["attackspeedperlevel"] as? Double,
        
            let cCrit = d["crit"] as? Double,
            let cCritPLvl = d["critperlevel"] as? Double,
            
            let cHP = d["hp"] as? Double,
            let cHPPLvl = d["hpperlevel"] as? Double,
        
            let cHPRegen = d["hpregen"] as? Double,
            let cHPRegenPLvl = d["hpregenperlevel"] as? Double,
            
            let cMP = d["mp"] as? Double,
            let cMPPLvl = d["mpperlevel"] as? Double,
            
            let cMPRegen = d["mpregen"] as? Double,
            let cMPRegenPLvl = d["mpregenperlevel"] as? Double,
        
            let cSpellBlock = d["spellblock"] as? Double,
            let cSpellBlockPLvl = d["spellblockperlevel"] as? Double,
        
            let cAttackRange = d["attackrange"] as? Double,
            let cMoveSpeed = d["movespeed"] as? Double
        else { return nil }
        
        armor = MSScalable(base: cArm, withScale: cArmPLvl)
        
        attackDamage = MSScalable(base: cAD, withScale: cADPLvl)
        
        let baseAttackSpeed = (1/(1.6 * (1 + cASoffset)))
        attackSpeed = MSScalable(base: baseAttackSpeed, withScale: cASPLvl)
        
        crit = MSScalable(base: cCrit, withScale: cCritPLvl)
        hitpoints = MSScalable(base: cHP, withScale: cHPPLvl)
        mana = MSScalable(base: cMP, withScale: cMPPLvl)
        hitpointsRegen = MSScalable(base: cHPRegen, withScale: cHPRegenPLvl)
        manaRegen = MSScalable(base: cMPRegen, withScale: cMPRegenPLvl)
        magicResist = MSScalable(base: cSpellBlock, withScale: cSpellBlockPLvl)
        
        attackRange = cAttackRange
        movementSpeed = cMoveSpeed
    }
}

// MARK: - Champion Primary/Secondary Class
public struct MSChampionClass: MSChampionComponent {
    public let primary  : MSChampionType
    public let secondary: MSChampionType
    
    public var description: String {
        return "MSChampionClass(primary: \(primary.rawValue), secondary: \(secondary.rawValue))\n"
    }

    public init() {
        // Default initializer. Should only be used for testing purposes
        primary = .none
        secondary = .none
    }
    
    public init(withPrimaryClass p: MSChampionType, andSecondaryClass s: MSChampionType) {
        primary = p
        secondary = s
    }
    
    public init?(withData d: Array<String?>) {
        var p: MSChampionType
        var s: MSChampionType
        if d.count > 1 {
            guard
                let pp = d[0],
                let ss = d[1]
            else { return nil }
            p = MSChampionType(fromRawValue: pp)!
            s = MSChampionType(fromRawValue: ss)!
        } else {
            guard let pp = d[0] else { return nil }
            p = MSChampionType(fromRawValue: pp)!
            s = MSChampionType.none
        }
        self.init(withPrimaryClass: p, andSecondaryClass: s)
    }
    
    public init?(withData: Dictionary<String, Any>) {
        // In this case, this should never be used
        return nil
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
    
    public init() {
        // Default initializer. Should only be used for testing purposes
        self = .none
    }
    
    public init?(fromRawValue: String) {
        
        switch fromRawValue {
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
public struct MSScalable: MSChampionComponent {
    public let base: Double
    public let scaleBy: Double
    
    public var description: String {
        return String(format: "MSScalable(base: %.2f, scale: %.2f)\n", base, scaleBy)
    }
    
    public init() {
        // Default initializer. Should only be used for testing purposes
        base = 0.0
        scaleBy = 0.0
    }
    
    public init?(withData: Dictionary<String, Any>) {
        // In this case, this should never be used
        return nil
    }
    
    public init(base b: Double, withScale s: Double) {
        base = b
        scaleBy = s
    }
    
    public func scaledBy(level: Int) -> Double {
        if !((level < 19) && (level > 0)) { print("Error! Trying to scale by invalid level! (Tried \(level))"); return 0 }
        return (base + (scaleBy * Double(level)))
    }
}

// MARK: - MSChampion subcomponents protocol
protocol MSChampionComponent {
    init?(withData: Dictionary<String, Any>)
    var description: String { get }
}
