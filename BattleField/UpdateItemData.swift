//
//  UpdateItemData.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/30/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


let WeaponItemKey = "weaponItemData"
let ArmorItemKey = "armorItemData"
//var bedroomFloorID: AnyObject = 101
//var bedroomWallID: AnyObject = 101

func loadGameData() {
    
    // getting path to GameData.plist
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let documentsDirectory = paths[0] as! String
    let path = (documentsDirectory as NSString).appendingPathComponent("ItemLevelList.plist")
    
    let fileManager = FileManager.default
    
    //check if file exists
    if(!fileManager.fileExists(atPath: path)) {
        // If it doesn't, copy it from the default file in the Bundle
        if let bundlePath = Bundle.main.path(forResource: "ItemLevelList", ofType: "plist") {
            
            let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
            print("Bundle ItemLevelList.plist file is --> \(resultDictionary?.description)")
            do {
            try fileManager.copyItem(atPath: bundlePath, toPath: path)
            } catch {
                print(error)
            }
          //  fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
            print("copy")
        } else {
            print("ItemLevelList.plist not found. Please, make sure it is part of the bundle.")
        }
    } else {
        print("ItemLevelList.plist already exits at path.")
        // use this to delete file from documents directory
        //fileManager.removeItemAtPath(path, error: nil)
    }
    
    let resultDictionary = NSMutableDictionary(contentsOfFile: path)
    print("Loaded ItemLevelList.plist file is --> \(resultDictionary?.description)")
    
    let myDict = NSDictionary(contentsOfFile: path)
    
    if let dict = myDict {
        //loading values
        
        
        let ArmorItems = dict["armorItemData"] as! [String: [String: NSNumber]]

        let WeaponItems = dict["weaponItemData"] as! [String: [String: NSNumber]]
        
     
        
      //  bedroomFloorID = dict.objectForKey(WeaponItemKey)!
        
        
     //   bedroomWallID = dict.objectForKey(ArmorItemKey)!
        //...
    } else {
        print("WARNING: Couldn't create dictionary from ItemLevelList.plist! Default values will be used!")
    }
}

func saveGameData() {
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let documentsDirectory = paths.object(at: 0) as! NSString
    let path = documentsDirectory.appendingPathComponent("ItemLevelList.plist")
    
   // var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
    
    let ItemDict = NSDictionary(contentsOfFile: path)
    
    
    //saving values
    
    
    
    
    
  //  dict.setObject(bedroomFloorID, forKey: WeaponItemKey)
  //  dict.setObject(bedroomWallID, forKey: ArmorItemKey)
    //...
    
    //writing to GameData.plist
    ItemDict!.write(toFile: path, atomically: false)
    
    let resultDictionary = NSMutableDictionary(contentsOfFile: path)
    print("Saved ItemLevelList.plist file is --> \(resultDictionary?.description)")
}



func CreateLocalInventory(_ Data: Foundation.Data) {
    
    loadGameData()
    
    DispatchQueue.main.async(execute: {
    FilterItemLevelData(Data)
    })
    
    /*
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
    let documentsDirectory = paths.objectAtIndex(0) as! NSString
    let path = documentsDirectory.stringByAppendingPathComponent("ItemLevelList.plist")
    
    var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
    //saving values
    dict.setObject(bedroomFloorID, forKey: WeaponItemKey)
    dict.setObject(bedroomWallID, forKey: ArmorItemKey)
    */
    
    
}

func FilterItemLevelData(_ urlData: Data) {
    
    let ArmorKey = "armorItemData"
    let WeaponKey = "weaponItemData"
    let ArmorKeyBody = "armor_body_level"
    let ArmorKeyHelmet = "armor_helmet_level"
    let ArmorKeyBoots = "armor_boots_level"
    let WeaponKeyFist = "weapon_fist_level"
    
    let prefs:UserDefaults = UserDefaults.standard
    
 //   func FilterItemData(urlData: NSData) -> [ItemInventory] {
        
        var ItemDictionary = NSMutableDictionary()
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
    
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let documentsDirectory = paths.object(at: 0) as! NSString
    let path = documentsDirectory.appendingPathComponent("ItemLevelList.plist")
    
    
    var CurrentItemDict = NSDictionary(contentsOfFile: path) as! NSMutableDictionary
    
     print("Current ItemLevelList.plist file is --> \(CurrentItemDict.description)")
    
        
        for result in json["Items"].arrayValue {
            
            if ( result["id"] != "0") {
                
                let tempusername = result["username"].stringValue
                let tempemail = result["email"].stringValue
                let templatitude = result["latitude"].stringValue
                let templongitude = result["longitude"].stringValue
                let temphealth = result["health"].stringValue
                let tempstamina = result["stamina"].stringValue
                let templevelarmorbody = result["level_armor_body"].stringValue
                let templevelarmorboots = result["level_armor_boots"].stringValue
                let templevelarmorhelmet = result["level_armor_helmet"].stringValue
                let templevelweaponfist = result["level_weapon_fist"].stringValue
                let templevelshield = result["shield_level"].stringValue
                let tempgold = result["gold"].stringValue
                let WasAttacked = result["wasAttacked"].stringValue
                let AttackedTimeDate = result["attackedtimedate"].stringValue
                let tempdiamonds = result["diamonds"].stringValue
                
                let tempstaminaPotionMax = result["staminaPotionMax"].stringValue
                let tempstaminaPotionCount = result["staminaPotionCount"].stringValue
                let temphealthPotionMax = result["healthPotionMax"].stringValue
                let temphealthPotionCount = result["healthPotionCount"].stringValue
                
                
                let templevelgoldproduction = "1"
                let tempgoldproductionLimit = "100"
                let tempgoldproductionSpeed = "36"
                
                let templevelUser = result["userLevel"].stringValue
                let templevelUserXP = result["userXP"].stringValue
                
                prefs.set(tempstaminaPotionMax, forKey: "UserStaminaPotionMax")
                prefs.set(tempstaminaPotionCount, forKey: "UserStaminaPotionCount")
                prefs.set(temphealthPotionMax, forKey: "UserHealthPotionMax")
                prefs.set(temphealthPotionCount, forKey: "UserHealthPotionCount")
                
                prefs.set(templevelarmorbody, forKey: "ARMORLEVELBODY")
                prefs.set(templevelarmorboots, forKey: "ARMORLEVELBOOTS")
                prefs.set(templevelarmorhelmet, forKey: "ARMORLEVELHELMET")
                prefs.set(templevelweaponfist, forKey: "WEAPONLEVELFIST")
                prefs.set(templevelshield, forKey: "SHIELDLEVEL")
                prefs.set(tempgold, forKey: "GOLDAMOUNT")
                prefs.set(tempdiamonds, forKey: "DIAMONDSAMOUNT")
                
                prefs.set(templevelUser, forKey: "USERLEVEL")
                prefs.set(templevelUserXP, forKey: "USERXPLEVEL")
                
                
                prefs.set(templevelgoldproduction, forKey: "GOLDPRODUCTIONLEVEL")
                prefs.set(tempgoldproductionLimit, forKey: "GOLDPRODUCTIONLIMIT")
                prefs.set(tempgoldproductionSpeed, forKey: "GOLDPRODUCTIONSPEED")
                
                prefs.set(1, forKey: "ALLOWEDNUMBERTOUPGRADE")
                
                prefs.set(120.0, forKey: "BootsUPGRADETIME")
                prefs.set(240.0, forKey: "BodyUPGRADETIME")
                prefs.set(150.0, forKey: "HelmetUPGRADETIME")
                prefs.set(150.0, forKey: "ShieldUPGRADETIME")
                prefs.set(120.0, forKey: "moneyBankUPGRADETIME")
                
                prefs.set(3600.0, forKey: "HealthReplenishTIME")
                prefs.set(3600.0, forKey: "StaminaReplenishTIME")
                let temphealthproductionLimit = "100"
                let tempstaminaproductionLimit = "100"
                let temphealthproductionSpeed = "36"
                let tempstaminaproductionSpeed = "36"
                
                let templevelhealthproduction = "1"
                let templevelstaminaproduction = "1"
                
                prefs.set(templevelhealthproduction, forKey: "GOLDPRODUCTIONLEVEL")
                prefs.set(templevelstaminaproduction, forKey: "GOLDPRODUCTIONLEVEL")
                prefs.set(temphealthproductionLimit, forKey: "HEALTHPRODUCTIONLIMIT")
                prefs.set(tempstaminaproductionLimit, forKey: "STAMINAPRODUCTIONLIMIT")
                prefs.set(tempstaminaproductionSpeed, forKey: "HEALTHPRODUCTIONSPEED")
                prefs.set(tempstaminaproductionSpeed, forKey: "STAMINAPRODUCTIONSPEED")
                
                prefs.set(50, forKey: "ARMORBOOTSUPRGRADECOST")
                prefs.set(1500, forKey: "ARMORBODYUPRGRADECOST")
                prefs.set(100, forKey: "ARMORHELMETUPRGRADECOST")
                prefs.set(50, forKey: "SHIELDUPRGRADECOST")
                
                prefs.set(Int(temphealth)!, forKey: "MYHEALTH")
                
                if Int(temphealth)! <= 0 {
                    prefs.set(true, forKey: "AmIDead")
                }
                
                prefs.set(Int(tempstamina)!, forKey: "MYSTAMINA")
                
                if Int(tempstamina)! <= 0 {
                    
                    prefs.set(true, forKey: "AmITired")
                }
                
                print("MYHEALTH!!!! = \(temphealth)")
                
                print("MYHEALTH INT!!!! = \(Int(temphealth)!)")
                
                if prefs.value(forKey: "VIEWRADIUS") == nil {
                prefs.setValue(1, forKey: "VIEWRADIUS")
                }
                
                prefs.set(WasAttacked, forKey: "WASATTACKED")
                
                prefs.set(AttackedTimeDate, forKey: "ATTACKEDTIMEDATE")
                
                let ServerURLItems = "http://\(ServerInfo.sharedInstance)/Apps/BattleField/Items/"
                
                let ServerURLMaps = "http://\(ServerInfo.sharedInstance)/Apps/BattleField/Maps/"
                
                prefs.setValue(ServerURLItems, forKey: "ServerURLItems")
                prefs.setValue(ServerURLMaps, forKey: "ServerURLMaps")
                
                let attributePointsTemp = result["attributePoints"].stringValue
                let attributePoints = Double(attributePointsTemp)!
                
                prefs.set(attributePoints, forKey: "MyAttributePoints")
                
                let AttributeAwarenessTemp = result["AttributeAwareness"].stringValue
                let AttributeCharismaTemp = result["AttributeCharisma"].stringValue
                let AttributeCredibilityTemp = result["AttributeCredibility"].stringValue
                let AttributeEnduranceTemp = result["AttributeEndurance"].stringValue
                let AttributeIntelligenceTemp = result["AttributeIntelligence"].stringValue
                let AttributeSpeedTemp = result["AttributeSpeed"].stringValue
                let AttributeStrengthTemp = result["AttributeStrength"].stringValue
                let AttributeVisionTemp = result["AttributeVision"].stringValue
                
                let AttributeAwareness = Double(AttributeAwarenessTemp)!
                let AttributeCharisma = Double(AttributeCharismaTemp)!
                let AttributeCredibility = Double(AttributeCredibilityTemp)!
                let AttributeEndurance = Double(AttributeEnduranceTemp)!
                let AttributeIntelligence = Double(AttributeIntelligenceTemp)!
                let AttributeSpeed = Double(AttributeSpeedTemp)!
                let AttributeStrength = Double(AttributeStrengthTemp)!
                let AttributeVision = Double(AttributeVisionTemp)!
                
                prefs.set(AttributeAwareness, forKey: "MyAttributeAwareness")
                prefs.set(AttributeCharisma, forKey: "MyAttributeCharisma")
                prefs.set(AttributeCredibility, forKey: "MyAttributeCredibility")
                prefs.set(AttributeEndurance, forKey: "MyAttributeEndurance")
                prefs.set(AttributeIntelligence, forKey: "MyAttributeIntelligence")
                prefs.set(AttributeSpeed, forKey: "MyAttributeSpeed")
                prefs.set(AttributeStrength, forKey: "MyAttributeStrength")
                prefs.set(AttributeVision, forKey: "MyAttributeVision")
                
                
                
                //prefs.setObject(templevelarmorbody, forKey: "ARMORLEVELBODY")
                
                
                
               // CurrentItemDict![ArmorKey]![ArmorKeyBody]?!.setObject(Int(templevelarmorbody), forKey: "level")
                
               // print("Current items test =\((CurrentItemDict["armorItemData"]!["armor_body_level"]!!["level"]!)!.stringValue)")
                
                //![ArmorKeyBody]?!.setObject(2, forKey: "level"))")
                
             //    (CurrentItemDict["armorItemData"]!["armor_body_level"]!!).setObject(2, forKey: "level")
                
                /*
                
                CurrentItemDict![ArmorKey]![ArmorKeyHelmet]?!.setObject(Int(templevelarmorhelmet), forKey: "level")
                
                CurrentItemDict![ArmorKey]![ArmorKeyBoots]?!.setObject(Int(templevelarmorboots), forKey: "level")
                
                CurrentItemDict![WeaponKey]![WeaponKeyFist]?!.setObject(Int(templevelweaponfist), forKey: "level")
                */
                
               // CurrentItemDict.writeToFile(path, atomically: false)
                
             //   let resultDictionary = NSMutableDictionary(contentsOfFile: path)
             //   print("Saved ItemLevelList.plist file is --> \(resultDictionary?.description)")
                
                /*
                
                ItemData.append(ItemInventory(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range))
                
                
                if !TotalItemsArray.contains(imageURL) {
                    
                    print("\(itemname) has not been saved yet, saving now")
                    
                    SaveNewItem(itemname, imageurltemp: imageURL, powertemp: power, rangetemp: range, speedtemp: speed, categorytemp: category)
                    
                    
                }
                
                */
                
            }
            
        }
        
      //  print("ItemData from Filter \(ItemDictionary)")
        
       // return ItemDictionary
}


