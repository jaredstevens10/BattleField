//
//  PlayerOverlay.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/30/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerOverlay: SKScene, GameStateDelegate {
    
    
    let prefs:UserDefaults = UserDefaults.standard

    
    var money = 0
    var stockItems = [StockItem]()
    var stockItemConfigurations = [String: [String: NSNumber]]()
    var moneyLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var customer : Customer?
    var timeOfLastCustomer : CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
    var timeTillNextCustomer : CFTimeInterval = CFTimeInterval(Float((arc4random() % 15 + 15)) * TimeScale)
    
    
    
    
    
    var ShieldNode: SKSpriteNode!
    var scoreNode: SKLabelNode!
    var UpgradeBootsNode: SKLabelNode!
    var UpgradeShieldNode: SKLabelNode!
    var BootsNode: SKSpriteNode!
    
    var SpriteSizeNew: CGFloat!
    
    var score = 0 {
        didSet {
            self.scoreNode.text = "Score: \(self.score)"
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.clear
        
        let spriteSize = size.width/12
        SpriteSizeNew = spriteSize
        self.ShieldNode = SKSpriteNode(imageNamed: "ShieldIcon")
        self.ShieldNode.size = CGSize(width: 50, height: 50)
        //self.ShieldNode.size = CGSize(width: spriteSize, height: spriteSize)
        //self.pauseNode.position = CGPoint(x: spriteSize + 8, y: spriteSize + 8)
        self.ShieldNode.position = CGPoint(x: spriteSize + 8, y: 200)
        
        //let spriteSize = size.width/12
        //SpriteSizeNew = spriteSize
        self.BootsNode = SKSpriteNode(imageNamed: "BootsIcon")
        self.BootsNode.size = CGSize(width: 50, height: 50)
        //self.ShieldNode.size = CGSize(width: spriteSize, height: spriteSize)
        //self.pauseNode.position = CGPoint(x: spriteSize + 8, y: spriteSize + 8)
        self.BootsNode.position = CGPoint(x: spriteSize + 8, y: 200)
        
        self.UpgradeShieldNode = SKLabelNode(text: "Shield: \(prefs.value(forKey: "SHIELDLEVEL")!)")
        self.UpgradeShieldNode.fontName = "DINAlternate-Bold"
        self.UpgradeShieldNode.fontColor = UIColor.black
        self.UpgradeShieldNode.fontSize = 12
        //  self.UpgradeNode.position = CGPoint(x: size.width/2, y: self.ShieldNode.position.y - 9)
        self.UpgradeShieldNode.position = CGPoint(x: spriteSize + 8, y: 160)
        
        
        self.UpgradeBootsNode = SKLabelNode(text: "Boots: \(prefs.value(forKey: "ARMORLEVELBOOTS")!)")
        self.UpgradeBootsNode.fontName = "DINAlternate-Bold"
        self.UpgradeBootsNode.fontColor = UIColor.black
        self.UpgradeBootsNode.fontSize = 12
      //  self.UpgradeNode.position = CGPoint(x: size.width/2, y: self.ShieldNode.position.y - 9)
        self.UpgradeBootsNode.position = CGPoint(x: spriteSize + 8, y: 160)
        
        self.scoreNode = SKLabelNode(text: "Score: 0")
        self.scoreNode.fontName = "DINAlternate-Bold"
        self.scoreNode.fontColor = UIColor.white
        self.scoreNode.fontSize = 24
        self.scoreNode.position = CGPoint(x: size.width/2, y: self.ShieldNode.position.y - 9)
        
       // self.addChild(self.ShieldNode)
        //self.addChild(self.BootsNode)
       // self.addChild(self.scoreNode)
       // self.addChild(self.UpgradeBootsNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first// as? UITouch
        let location = touch?.location(in: self)
        
        if self.ShieldNode.contains(location!) {
            print("Is Shield")
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpgradeNotification"), object: nil, userInfo: ["item":"Shield","level":"\(prefs.value(forKey: "SHIELDLEVEL")!)"])
            
            
            /*
            if !self.paused {
                self.ShieldNode.texture = SKTexture(imageNamed: "ChestArmorIcon")
            }
            else {
                self.ShieldNode.texture = SKTexture(imageNamed: "ShieldIcon")
            }
            
            self.paused = !self.paused

*/
        }
        
        if self.BootsNode.contains(location!) {
            print("Is Boots")
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpgradeNotification"), object: nil, userInfo: ["item":"Boots","level":"\(prefs.value(forKey: "ARMORLEVELBOOTS")!)"])
            
            
            /*
            if !self.paused {
            self.ShieldNode.texture = SKTexture(imageNamed: "ChestArmorIcon")
            }
            else {
            self.ShieldNode.texture = SKTexture(imageNamed: "ShieldIcon")
            }
            
            self.paused = !self.paused
            
            */
        }
    }
    
    override func didMove(to view: SKView) {
        print("Overlay did move to view")
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerOverlay.saveGameData), name: NSNotification.Name(rawValue: "saveGameData"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(PlayerOverlay.UpdateItemTextLevel(_:)), name: NSNotification.Name(rawValue: "UpdateItemTextLevel"), object: nil)
        
        // Draw background
        /*
        let background = SKSpriteNode(imageNamed: "bg_kookiekiosk")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = CGFloat(ZPosition.background.rawValue)
        addChild(background)

        // Draw HUD in top right corner that displays the amount of money the player has
        
        let moneyBackground = SKSpriteNode(imageNamed: "bg_money")
        moneyBackground.position = CGPoint(x: size.width - moneyBackground.size.width/2 - 10, y: size.height - moneyBackground.size.height/2 - 13)
        moneyBackground.zPosition = CGFloat(ZPosition.HUDBackground.rawValue)
        addChild(moneyBackground)
*/
        
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moneyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        moneyLabel.position = CGPoint(x: size.width - 60, y: size.height - 115)
        moneyLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        moneyLabel.fontSize = 50
        moneyLabel.zPosition = CGFloat(ZPosition.hudForeground.rawValue)
        addChild(moneyLabel)
        
       // loadGameData()
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerOverlay.scheduleNotifications), name: NSNotification.Name(rawValue: "scheduleNotifications"), object: nil)
        
    }
    
    
    func updateMoneyBy(_ delta : Int) {
        let deltaLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
        if delta < 0 {
            deltaLabel.fontColor = SKColor(red: 198/255.0, green: 139/255.0, blue: 207/255.0, alpha: 1.0)
        } else {
            deltaLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        }
        deltaLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        deltaLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        deltaLabel.position = moneyLabel.position
        deltaLabel.text = String(format: "%i $", delta)
        deltaLabel.fontSize = moneyLabel.fontSize
        deltaLabel.zPosition = CGFloat(ZPosition.hudForeground.rawValue)
        addChild(deltaLabel)
        
        let moveLabelAction = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.5)
        let fadeLabelAction = SKAction.fadeOut(withDuration: 0.5)
        let labelAction = SKAction.group([moveLabelAction, fadeLabelAction])
        deltaLabel.run(labelAction, completion: {deltaLabel.removeFromParent()})
        
        money += delta
        moneyLabel.text = String(format: "%i $", money)
    }
    
    // MARK: Load and save plist file
    
    @objc func UpdateItemTextLevel(_ notification: Notification) {
        
        var info = notification.userInfo
        
        let item = info!["item"]
        let CurrentLevelTemp = info!["level"]
        let CurrentLevel = Int(CurrentLevelTemp as! String)
        let NextLevel = CurrentLevel! + 1
        print("sprite New item name = \(item)")
        print("sprite New item Text Level = \(CurrentLevelTemp)")
        
        /*
        self.UpgradeNode = SKLabelNode(text: "Shield: \(prefs.valueForKey("SHIELDLEVEL")!)")
        self.UpgradeNode.fontName = "DINAlternate-Bold"
        self.UpgradeNode.fontColor = UIColor.blackColor()
        self.UpgradeNode.fontSize = 12
        //  self.UpgradeNode.position = CGPoint(x: size.width/2, y: self.ShieldNode.position.y - 9)
        self.UpgradeNode.position = CGPoint(x: SpriteSizeNew + 8, y: 160)
        */

        
    }
    
    
    @objc func saveGameData() {
        let path = documentFilePath(fileName: "gamedata.plist")
        let stockItemData = NSMutableArray()
        for stockItem : StockItem in stockItems {
            stockItemData.add(stockItem.data())
        }
        var stockItemConfigurationsObjects = [AnyObject]()
        var stockItemConfigurationsKeys = [NSCopying]()
        for (key, stockItemConfiguration) in stockItemConfigurations {
            stockItemConfigurationsKeys.append(key as NSCopying)
            stockItemConfigurationsObjects.append(stockItemConfiguration as AnyObject)
        }
        
        let stockItemConfigurationsNSDictionary = NSDictionary(objects: stockItemConfigurationsObjects, forKeys: stockItemConfigurationsKeys)
        let objects = [stockItemConfigurationsNSDictionary, money, stockItemData] as [Any]
        let keys = ["stockItemConfigurations", "money", "weaponItemData"]
        let gameData = NSDictionary(objects: objects, forKeys: keys as [NSCopying])
        let success = gameData.write(toFile: path, atomically: true)
        print(success)
    }
    
    func loadGameData() {
        var path = documentFilePath(fileName: "gamedata.plist")
        var gameData : NSDictionary? = NSDictionary(contentsOfFile: path)
        
        print("Getting Game Data")
        // Load gamedata template from mainBundle if no saveFile exists
        if gameData == nil {
            let mainBundle = Bundle.main
            path = mainBundle.path(forResource: "gamedata", ofType: "plist")!
            gameData = NSDictionary(contentsOfFile: path)
        }
        stockItemConfigurations = gameData!["stockItemConfigurations"] as! [String: [String: NSNumber]]
        money = gameData!["money"] as! Int
        
        print("Money = \(money)")
        let stockItemDataSet = gameData!["weaponItemData"] as! [[String: AnyObject]]
        
        print("Weapon Items = \(stockItemDataSet)")
        
        for stockItemData in stockItemDataSet {
            let itemName = stockItemData["name"] as AnyObject? as! String
            let itemType = stockItemData["type"] as AnyObject? as! String
            let relativeX = stockItemData["x"] as AnyObject? as! Float
            let relativeY = stockItemData["y"] as AnyObject? as! Float
            print("Item Name = \(itemName)")
            print("Item Type = \(itemType)")
            print("x = \(relativeX)")
            print("y = \(relativeY)")
            let stockItemConfiguration = stockItemConfigurations[itemType] as [String: NSNumber]!
            print("stockItemConfiguration = \(stockItemConfiguration)")
            
           // let stockItem  = StockItem(stockItemData: stockItemData, stockItemConfiguration: stockItemConfiguration, gameStateDelegate: self)
            
            
        
        }
        
        /*
        stockItemConfigurations = gameData!["stockItemConfigurations"] as! [String: [String: NSNumber]]
        money = gameData!["money"] as! Int
        moneyLabel.text = String(format: "%i $", money)
        let stockItemDataSet = gameData!["weaponItemData"] as! [[String: AnyObject]]
        for stockItemData in stockItemDataSet {
            let itemType = stockItemData["type"] as AnyObject? as! String
            let stockItemConfiguration = stockItemConfigurations[itemType] as [String: NSNumber]!
            let stockItem  = StockItem(stockItemData: stockItemData, stockItemConfiguration: stockItemConfiguration, gameStateDelegate: self)
            let relativeX = stockItemData["x"] as AnyObject? as! Float
            let relativeY = stockItemData["y"] as AnyObject? as! Float
            stockItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
            addChild(stockItem)
            stockItems.append(stockItem)
        }
        
        */
    }
    
    func documentFilePath(fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    func gameStateDelegateChangeMoneyBy(delta: Int) -> Bool {
        if (delta < 0 && money >= -delta) || delta > 0 {
            updateMoneyBy(delta)
            return true
        } else  {
            return false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for stockItem in stockItems {
            stockItem.update()
        }
        // 1 Check whether it is time for a customer to appear
        let currentTimeAbsolute = CFAbsoluteTimeGetCurrent()
        if customer == nil && currentTimeAbsolute - timeOfLastCustomer > timeTillNextCustomer {
            // 2 Make a list of potential wishes the customer could have
            var potentialWishes = [StockItem]()
            for stockItem : StockItem in stockItems {
                if stockItem.state == State.selling || stockItem.state == State.stocked {
                    potentialWishes.append(stockItem)
                }
            }
            // 3 Select one of the potential wishes randomly and spawn the customer with it
            if potentialWishes.count > 0 {
                let random = arc4random() % UInt32(potentialWishes.count)
                let randomStockItem = potentialWishes[Int(random)]
                customer = Customer(type: randomStockItem.type, flavor: randomStockItem.flavor)
                customer!.position = CGPoint(x: frame.size.width + customer!.calculateAccumulatedFrame().size.width / 2, y: customer! .calculateAccumulatedFrame().size.height / 2)
                // 4 Animate the customer
                let moveLeft = SKAction.move(by: CGVector(dx: -customer!.calculateAccumulatedFrame().size.width, dy: 0), duration: 1)
                customer?.run(moveLeft)
                addChild(customer!)
            }
        }
    }
    
    func gameStateServeCustomerWithItemOfType(type: String, flavor: String) {
        // 1 Check if the player has served the correct item for the customer
        if customer?.type == type && customer?.flavor == flavor {
            gameStateDelegateChangeMoneyBy(delta: 50)
           // let playSound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true)
          //  runAction(playSound)
        } else {
          //  let playSound = SKAction.playSoundFileNamed("hit.wav", waitForCompletion: true)
          //  runAction(playSound)
        }
        if customer != nil {
            // 2 Clean up customer
            let moveRight = SKAction.move(by: CGVector(dx: customer!.calculateAccumulatedFrame().size.width, dy: 0), duration: 1)
            customer!.run(moveRight, completion:{
                self.customer?.removeFromParent()
                self.customer = nil
            })
            // 3 Setup spawn of next customer
            timeOfLastCustomer = CFAbsoluteTimeGetCurrent()
            timeTillNextCustomer = CFTimeInterval(Float((arc4random() % 15 + 15)) * TimeScale)
        }
    }
    
    func scheduleNotificationWith(message: String, intervalInSeconds: TimeInterval, badgeNumber: Int) {
        // 1 Create empty notification
        let localNotification = UILocalNotification()
        
        // 2 Calculate notification time using NSDate
        let now = Date()
        let notificationTime = now.addingTimeInterval(intervalInSeconds)
        
        // 3 Set properties of your notification
        localNotification.alertBody = message
        localNotification.fireDate = notificationTime
        localNotification.timeZone = TimeZone.current
        localNotification.applicationIconBadgeNumber = badgeNumber
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        // 4 Schedule the notification
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    @objc func scheduleNotifications() {
        let itemsSortedByNotificationTime = stockItems.sorted(by: {$0.notificationTime() < $1.notificationTime()})
        var count = 1
        for stockItem in itemsSortedByNotificationTime {
            let notificationMessage = stockItem.notificationMessage()
            if notificationMessage != nil {
                scheduleNotificationWith(message: notificationMessage!, intervalInSeconds: stockItem.notificationTime(), badgeNumber: count)
                count += 1
            }
        }
    }
    
    
    
    
}
