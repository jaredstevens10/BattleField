//
//  StatsViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit
import QuartzCore


extension SKNode {
    
    /*
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = (try! NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe))
            
            //var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "PlayerModel")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    
    */
}


//class StatsViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, SCNPhysicsContactDelegate, SCNSceneRendererDelegate {


class StatsViewController: UIViewController, UIScrollViewDelegate {
    
//    var TouchScreenX = CGFloat()
//    var TouchScreenY = CGFloat()
//    
//    var canDeleteObject = Bool()
//    
//    var AddingObject = Bool()
//    var MovingObject = Bool()
//    var ObjectStartPoint = CGPoint()
//    var ObjectEndPoint = CGPoint()
//    
//    var TouchingNode  = SCNNode()
//    let PlacePosition = SCNVector3()
//    
//    var placeItemGesture = UILongPressGestureRecognizer()
//    
//    var WalkAnimation = CAAnimation()
//    
//    //------------ SET UP BODY NODES
//    var enemyEyeBrow = SCNNode()
//    var enemyEyeLash = SCNNode()
//    var enemyEyes = SCNNode()
//    var enemySuit = SCNNode()
//    var enemySkin = SCNNode()
//    var enemyMuscle = SCNNode()
//    var enemyShoes = SCNNode()
//    var enemyHair = SCNNode()
//    var enemyTeeth = SCNNode()
//    var enemyTongue = SCNNode()
//    
//    var enemyHead = SCNNode()
//    var enemyBody = SCNNode()
//    var bodyPlane = SCNNode()
//    
//    var enemyRootNodeString = String()
//    var enemyEyeBrowString = String()
//    var enemyEyeLashString = String()
//    var enemyEyesString = String()
//    var enemySuitString = String()
//    var enemyMuscleString = String()
//    var enemyShoesString = String()
//    var enemyHairString = String()
//    var enemyTeethString = String()
//    var enemyTongueString = String()
//    
//    var enemyEyeBrowTexture = String()
//    var enemyEyeLashTexture = String()
//    var enemyEyesTexture = String()
//    var enemySuitTexture = String()
//    var enemyMuscleTexture = String()
//    var enemyShoesTexture = String()
//    var enemyHairTexture = String()
//    var enemyTeethTexture = String()
//    var enemyTongueTexture = String()
    
    
//    var enemyNode = SCNNode()
//    var enemyRootNode = SCNNode()
//    
//    var material = SCNMaterial()
//    
//    
//    var cameraNode: SCNNode?
    
    
    
    
    
    var now: TimeInterval {
        return Date().timeIntervalSinceReferenceDate
    }
    
    var AllItems = ["Boots", "Shield", "Body", "Helmet"]
    var myGoldAmount = Int()
    var AllowedNumberToUpgrade = Int()
    var NumberItemsUpgrading: Int = 0
    var BootsUpgrading = Bool()
    var ShieldUpgrading = Bool()
    var BodyUpgrading = Bool()
    var HelmetUpgrading = Bool()
    
    
    var MoneyChangeCount = Int()
    var moneyTimer = Timer()
    @IBOutlet weak var moneyLBL: UILabel!
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var BootsUpgradeEnd = TimeInterval()
    var BootsTimer = Timer()
//    var BootsStartTime = NSTimeInterval()
    var BootsStartTime: TimeInterval = 120.0
    var BootsTimeCount: TimeInterval = 0.0
    var BootsTimeInterval: TimeInterval = 0.05
    var BootsUpgradeCost = Int()
    
    
    
    var ShieldUpgradeEnd = TimeInterval()
    var ShieldTimer = Timer()
    //    var BootsStartTime = NSTimeInterval()
    var ShieldStartTime: TimeInterval = 120.0
    var ShieldTimeCount: TimeInterval = 0.0
    var ShieldTimeInterval: TimeInterval = 0.05
    var ShieldUpgradeCost = Int()
    
    var HelmetUpgradeEnd = TimeInterval()
    var HelmetTimer = Timer()
    //    var BootsStartTime = NSTimeInterval()
    var HelmetStartTime: TimeInterval = 120.0
    var HelmetTimeCount: TimeInterval = 0.0
    var HelmetTimeInterval: TimeInterval = 0.05
    var HelmetUpgradeCost = Int()
    
    var BodyUpgradeEnd = TimeInterval()
    var BodyTimer = Timer()
    //    var BootsStartTime = NSTimeInterval()
    var BodyStartTime: TimeInterval = 120.0
    var BodyTimeCount: TimeInterval = 0.0
    var BodyTimeInterval: TimeInterval = 0.05
    var BodyUpgradeCost = Int()
    
    
   // @IBOutlet weak var overlayView: UIView!
    
    
    
    var theView: SCNView!
    var spriteScene: PlayerOverlay!
    var moneyScene: MoneyOverlay!
    
    var scnView: SCNView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var itemView1: UIView!
    @IBOutlet weak var itemView1LBL: UILabel!
    @IBOutlet weak var item1IMG: UIImageView!
    @IBOutlet weak var itemTimerView1: UIView!
    @IBOutlet weak var item1TimerLBL: UILabel!
    @IBOutlet weak var item1BTN: UIButton!
    
    @IBOutlet weak var itemView2: UIView!
    @IBOutlet weak var itemView2LBL: UILabel!
    @IBOutlet weak var item2IMG: UIImageView!
    @IBOutlet weak var itemTimerView2: UIView!
    @IBOutlet weak var item2TimerLBL: UILabel!
    @IBOutlet weak var item2BTN: UIButton!
    
    @IBOutlet weak var itemView3: UIView!
    @IBOutlet weak var itemView3LBL: UILabel!
    @IBOutlet weak var item3IMG: UIImageView!
    @IBOutlet weak var itemTimerView3: UIView!
    @IBOutlet weak var item3TimerLBL: UILabel!
    @IBOutlet weak var item3BTN: UIButton!
    
    @IBOutlet weak var itemView4: UIView!
    @IBOutlet weak var itemView4LBL: UILabel!
    @IBOutlet weak var item4IMG: UIImageView!
    @IBOutlet weak var itemTimerView4: UIView!
    @IBOutlet weak var item4TimerLBL: UILabel!
    @IBOutlet weak var item4BTN: UIButton!
    
    
    @IBOutlet weak var attributesView: UIView!
    @IBOutlet weak var attributesViewLBL: UILabel!
    @IBOutlet weak var attributesViewIMG: UIImageView!
    //@IBOutlet weak var itemTimerView4: UIView!
    //@IBOutlet weak var item4TimerLBL: UILabel!
    @IBOutlet weak var attributesViewBTN: UIButton!
    
    let camera = SCNCamera()
    
   // let cameraNode = SCNNode()
    let cameraOrbit = SCNNode()
    

    var type = NSString()
    
    var AttackingPlayer = NSString()
    var AttackingPlayerID = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackPower = Int()
    var AttackStatus = NSString()
    var username = NSString()
    var email = NSString()
    
    var timer = Timer()
    
    @IBOutlet weak var cancelBTN: UIButton!
    
    @IBOutlet weak var TimerLBL: UILabel!
    
    var counter = Int()
    
    @IBOutlet weak var AlertLBL: UILabel!
    
    var playerScene = SKScene()
    var playerScene2 = SCNScene()
    
    //var userScene = SCNScene(named: "PlayerAttackScene.scn")!
    
    var TheUserPlayerScene = SCNScene(named: "MyPlayerScene.scn")!
    
    //scene.
    var skView = SKView()
    
    @IBOutlet weak var SceneHolder: SCNView!
    
    @IBOutlet weak var SceneView: UIView!
    

    
    
    @IBOutlet weak var rightmenuButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
     @IBAction func EditAction(_ sender: AnyObject) {
    
       // self.performSegue(withIdentifier: "EditPlayer", sender: self)
        
        var PlayerAttributesInfo: TotalPlayerAttributes?
        //= TotalPlayerAttributes(Awareness: prefs.Double(forKey: "MyAttributeAwarness"), )
        // PlayerAttributesInfo = TotalPlayerAttributes(Awareness: 5.0, Charisma: 5.0, Credibility: 5.0, Endurance: 5.0, Intelligence: 5.0, Speed: 5.0, Strength: 5.0, Vision: 5.0)
        
        PlayerAttributesInfo = TotalPlayerAttributes(Awareness: prefs.double(forKey: "MyAttributeAwareness"), Charisma: prefs.double(forKey: "MyAttributeCharisma"), Credibility: prefs.double(forKey: "MyAttributeCredibility"), Endurance: prefs.double(forKey: "MyAttributeEndurance"), Intelligence: prefs.double(forKey: "MyAttributeIntelligence"), Speed: prefs.double(forKey: "MyAttributeSpeed"), Strength: prefs.double(forKey: "MyAttributeStrength"), Vision: prefs.double(forKey: "MyAttributeVision"))
        
        
        
        DispatchQueue.main.async(execute: {
            
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                
//                self.tabBarItemPlayer.isEnabled = false
//                self.tabBarItemTeam.isEnabled = false
                var view = AttributesView.instanceFromNib(title: "test", playerAttributes: PlayerAttributesInfo!)
                view.tag = 1000
                self.view.addSubview(view)

            })
            
        })
        
        
   
    }
    
    @IBAction func item1BTNAction(_ sender: AnyObject) {
        

        let item = "Boots"
        let upgradeCost = BootsUpgradeCost
        if !BootsUpgrading {
            
            
            if self.NumberItemsUpgrading >= self.AllowedNumberToUpgrade {
                
                var alertmessage = String()
                var alertTitle = String()
                if self.AllowedNumberToUpgrade > 1 {
                   alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) item at a time"
                   alertTitle = "Upgrade in Process"
                } else {
                   alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) items at a time"
                   alertTitle = "Upgrades in Process"
                }
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "\(alertTitle)"
                alertView.message = "\(alertmessage)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            } else {
        
                
                
                if upgradeCost <= myGoldAmount {
                
                    
                    

                    //NumberItemsUpgrading++
                    UpgradeCertainItem(item, cost: upgradeCost)
                    
                } else {
                    
                    let neededGold = upgradeCost - myGoldAmount
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Insufficient Gold"
                    alertView.message = "You need to collect $\(neededGold) to upgrade."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
          }
        }  else {
            
            let itemEndTime = prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval
            let timeUntilComplete = itemEndTime - now
            print("Time Until Complete = \(timeUntilComplete)")
            
            let fullUpgradeTime = prefs.value(forKey: "\(item)UPGRADETIME") as! TimeInterval
            
            let PercentComplete = (timeUntilComplete / fullUpgradeTime) 
            
            print("Percent Complete = \(PercentComplete)")
            
            let costTemp = Double((upgradeCost * 2)) * PercentComplete
            
            
            let costTemp2 = round(costTemp)
            let cost = Int(costTemp2)
            
            UpgradeCertainItemNow(item, cost: cost)
        }
            
      
    }
    
    
    
    @IBAction func item2BTNAction(_ sender: AnyObject) {
        let item = "Shield"
        let upgradeCost = ShieldUpgradeCost
        if !ShieldUpgrading {
            
            
            if self.NumberItemsUpgrading >= self.AllowedNumberToUpgrade {
                
                var alertmessage = String()
                
                if self.AllowedNumberToUpgrade > 1 {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) item at a time"
                } else {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) items at a time"
                }
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrades in process"
                alertView.message = "\(alertmessage)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            } else {
            
                
                if upgradeCost <= myGoldAmount {
                    
                    
                    //NumberItemsUpgrading++
                    UpgradeCertainItem(item, cost: upgradeCost)
                    
                } else {
                    
                    let neededGold = upgradeCost - myGoldAmount
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Insuffecient Gold"
                    alertView.message = "You need to collect $\(neededGold) to upgrade."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }

            }
        }  else {
            let itemEndTime = prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval
            let timeUntilComplete = itemEndTime - now
            print("Time Until Complete = \(timeUntilComplete)")
            
            let fullUpgradeTime = prefs.value(forKey: "\(item)UPGRADETIME") as! TimeInterval
            
            let PercentComplete = (timeUntilComplete / fullUpgradeTime) 
            
            print("Percent Complete = \(PercentComplete)")
            
            let costTemp = Double((upgradeCost * 2)) * PercentComplete
            
            
            let costTemp2 = round(costTemp)
            let cost = Int(costTemp2)
            UpgradeCertainItemNow(item, cost: cost)
        }
    }
    
    @IBAction func item3BTNAction(_ sender: AnyObject) {
        let item = "Helmet"
        let upgradeCost = HelmetUpgradeCost
        if !HelmetUpgrading {
            
            if self.NumberItemsUpgrading >= self.AllowedNumberToUpgrade {
                
                var alertmessage = String()
                
                if self.AllowedNumberToUpgrade < 2 {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) item at a time"
                } else {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) items at a time"
                }
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrades in process"
                alertView.message = "\(alertmessage)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            } else {
            
            
                if upgradeCost <= myGoldAmount {
                    
                    
                   // NumberItemsUpgrading++
                    UpgradeCertainItem(item, cost: upgradeCost)
                    
                } else {
                    
                    let neededGold = upgradeCost - myGoldAmount
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Insuffecient Gold"
                    alertView.message = "You need to collect $\(neededGold) to upgrade."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                
            }
        }  else {
            let itemEndTime = prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval
            let timeUntilComplete = itemEndTime - now
            print("Time Until Complete = \(timeUntilComplete)")
            
            let fullUpgradeTime = prefs.value(forKey: "\(item)UPGRADETIME") as! TimeInterval
            
            let PercentComplete = (timeUntilComplete / fullUpgradeTime) 
            
            print("Percent Complete = \(PercentComplete)")
            
            let costTemp = Double((upgradeCost * 2)) * PercentComplete
            
            
            let costTemp2 = round(costTemp)
            let cost = Int(costTemp2)
            UpgradeCertainItemNow(item, cost: cost)
        }
    }
    
    @IBAction func item4BTNAction(_ sender: AnyObject) {
        let item = "Body"
        let upgradeCost = BodyUpgradeCost
        
        if !BodyUpgrading {
            
            if self.NumberItemsUpgrading >= self.AllowedNumberToUpgrade {
                
                var alertmessage = String()
                
                if self.AllowedNumberToUpgrade > 1 {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) item at a time"
                } else {
                    alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) items at a time"
                }
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrades in process"
                alertView.message = "\(alertmessage)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            } else {
            
                if upgradeCost <= myGoldAmount {
                    
                    
                   // NumberItemsUpgrading++
                    UpgradeCertainItem(item, cost: upgradeCost)
                    
                } else {
                    
                    let neededGold = upgradeCost - myGoldAmount
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Insuffecient Gold"
                    alertView.message = "You need to collect $\(neededGold) to upgrade."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                
            }
        }  else {
            let itemEndTime = prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval
            let timeUntilComplete = itemEndTime - now
            print("Time Until Complete = \(timeUntilComplete)")
            
            let fullUpgradeTime = prefs.value(forKey: "\(item)UPGRADETIME") as! TimeInterval
            
            let PercentComplete = (timeUntilComplete / fullUpgradeTime) 
            
            print("Percent Complete = \(PercentComplete)")
            
            let costTemp = Double((upgradeCost * 2)) * PercentComplete
            
            
            let costTemp2 = round(costTemp)
            let cost = Int(costTemp2)
            UpgradeCertainItemNow(item, cost: cost)
        }
    }
    
    
    func UpgradeCertainItem(_ item: String, cost: Int) {
        
        
        var NotifyDate = Date()
        
        //let item = "Boots"
        var CurrentLevelTemp = String()
        var CompleteTimeTemp = TimeInterval()
        
        switch item {
        case "Boots":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELBOOTS") as! String
            CompleteTimeTemp = prefs.value(forKey: "BootsUPGRADETIME") as! TimeInterval
            
            let endTime = now + CompleteTimeTemp
            prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
            
            NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
            
            print("setting \(item) end time for \(endTime)")

        case "Body":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELBODY") as! String
            CompleteTimeTemp = prefs.value(forKey: "BodyUPGRADETIME") as! TimeInterval
            
            let endTime = now + CompleteTimeTemp
            prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
            NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
            
        case "Helmet":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELHELMET") as! String
            CompleteTimeTemp = prefs.value(forKey: "HelmetUPGRADETIME") as! TimeInterval
            
            let endTime = now + CompleteTimeTemp
            prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
            NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
            
        case "Shield":
            CurrentLevelTemp = prefs.value(forKey: "SHIELDLEVEL") as! String
            CompleteTimeTemp = prefs.value(forKey: "ShieldUPGRADETIME") as! TimeInterval
            
            let endTime = now + CompleteTimeTemp
            prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
            NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
        
        default:
            break
        }
        
        
        print("Notify date = \(NotifyDate)")
        
        
        let CurrentLevel = Int(CurrentLevelTemp)
        let NextLevel = CurrentLevel! + 1
        print("item name = \(item)")
        print("item Level = \(CurrentLevelTemp)")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "\(item) Upgrade", message: "Upgrade this item to level \(NextLevel) for $\(cost)?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
          //  self.NumberItemsUpgrading--
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            self.NumberItemsUpgrading += 1
            
            //  self.AttackingPlayer = user
            //   self.AttackingPlayersHealth = health
            print("Upgrading \(item)")
            
            //self.performSegueWithIdentifier("goto_attack", sender: self)
            
            switch item as String {
                
            
            case "Helmet":
                
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.HelmetUpgrading = true
                self.itemTimerView3.isHidden = false
                self.HelmetTimeCount = CompleteTimeTemp
                let aSelector: Selector = #selector(StatsViewController.UpdateHelmetTime)
                self.HelmetTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.HelmetStartTime = Date.timeIntervalSinceReferenceDate
                
                let localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.shared.scheduleLocalNotification(localNotification)
            
                
            case "Body":
                
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.BodyUpgrading = true
                self.itemTimerView4.isHidden = false
                self.BodyTimeCount = CompleteTimeTemp
                let aSelector: Selector = #selector(StatsViewController.UpdateBodyTime)
                self.BodyTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.BodyStartTime = Date.timeIntervalSinceReferenceDate
                
                let localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Armor Upgraded To Level \(NextLevel)"
                UIApplication.shared.scheduleLocalNotification(localNotification)
                
            case "Shield":
                
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.ShieldUpgrading = true
                self.itemTimerView2.isHidden = false
                self.ShieldTimeCount = CompleteTimeTemp
                let aSelector: Selector = #selector(StatsViewController.UpdateShieldTime)
                self.ShieldTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
    
                self.ShieldStartTime = Date.timeIntervalSinceReferenceDate
                
                let localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.shared.scheduleLocalNotification(localNotification)
                
                
            case "Boots":
                self.BootsUpgrading = true
                self.itemTimerView1.isHidden = false
                self.BootsTimeCount = CompleteTimeTemp
                let aSelector: Selector = #selector(StatsViewController.UpdateBootsTime)
                self.BootsTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.BootsStartTime = Date.timeIntervalSinceReferenceDate
                

                let localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.shared.scheduleLocalNotification(localNotification)
                
                
                
                
                
      
                
            default:
                break
                
            }
            
            
            self.UpdateMoneyUser(self.myGoldAmount, itemCost: cost)
            
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateItemTextLevel"), object: nil, userInfo: ["item":"\(item)","level":"\(NextLevel)"])

            
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
        
        
    }
    
    func UpgradeCertainItemNow(_ item: String, cost: Int) {
        
        
        //let item = "Boots"
        var CurrentLevelTemp = String()
        var itemKey = String()
        switch item {
        case "Boots":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELBOOTS") as! String
            itemKey = "ARMORLEVELBOOTS"
        case "Body":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELBODY") as! String
            itemKey = "ARMORLEVELBODY"
        case "Helmet":
            CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELHELMET") as! String
            itemKey = "ARMORLEVELHELMET"
        case "Shield":
            CurrentLevelTemp = prefs.value(forKey: "SHIELDLEVEL") as! String
            itemKey = "SHIELDLEVEL"
            
        default:
            break
        }
        
        
        
        let CurrentLevel = Int(CurrentLevelTemp)
        let NextLevel = CurrentLevel! + 1
        print("item name = \(item)")
        print("item Level = \(CurrentLevelTemp)")
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "\(item) Upgrade", message: "Complete level \(NextLevel) upgrade now for $\(cost)?", preferredStyle: .alert)

        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
           // self.NumberItemsUpgrading--
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            //  self.AttackingPlayer = user
            //   self.AttackingPlayersHealth = health
            print("Upgrading \(item)")
            
            //self.performSegueWithIdentifier("goto_attack", sender: self)
            
            switch item as String {
                
                
            case "Helmet":
                
                print("\(item) has been upgrade - rushed")
                self.itemTimerView3.isHidden = true
                self.HelmetUpgrading = false
                self.HelmetTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView3LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                
                
                
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                self.NumberItemsUpgrading -= 1
                UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)" as NSString, level: "\(NextLevel.description)" as NSString)
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                
                
            case "Body":
                
                print("\(item) has been upgrade - rushed")
                self.itemTimerView4.isHidden = true
                self.BodyUpgrading = false
                self.BodyTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView4LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) Armor has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                self.NumberItemsUpgrading -= 1
                UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)" as NSString, level: "\(NextLevel.description)" as NSString)
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                
            case "Shield":
                
                print("\(item) has been upgrade - rushed")
                self.itemTimerView2.isHidden = true
                self.ShieldUpgrading = false
                self.ShieldTimer.invalidate()

                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView2LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                self.NumberItemsUpgrading -= 1
                UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
                
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)" as NSString, level: "\(NextLevel.description)" as NSString)
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                
                
            case "Boots":
                
                print("\(item) has been upgrade - rushed")
                self.itemTimerView1.isHidden = true
                self.BootsUpgrading = false
                self.BootsTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView1LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                self.NumberItemsUpgrading -= 1
                UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
                
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)" as NSString, level: "\(NextLevel.description)" as NSString)
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                
                
            default:
                break
                
            }
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateItemTextLevel"), object: nil, userInfo: ["item":"\(item)","level":"\(NextLevel)"])
                
            self.UpdateMoneyUser(self.myGoldAmount, itemCost: cost)
            
            
           
            
                
                
            }
            
            
            actionSheetController.addAction(nextAction)
            actionSheetController.addAction(cancelAction)
            
            self.present(actionSheetController, animated: true, completion: nil)
        
        
        
    }
    
    
    
  

    
   @objc func timeString(_ time:TimeInterval) -> String {
        let minutes = Int(time) / 60
        //let seconds = Int(time) % 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
   // func UpdateBootsTime(timer: NSTimer){
    @objc func UpdateHelmetTime(){
        let item = "Helmet"
        let itemKey = "ARMORLEVELHELMET"
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
      //  print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - HelmetStartTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        
       HelmetTimeCount = HelmetTimeCount - HelmetTimeInterval
        
        if HelmetTimeCount <= 0 {
            
            print("\(item) has been upgraded")
            itemTimerView3.isHidden = true
            self.HelmetUpgrading = false
            HelmetTimer.invalidate()
            
            
            let CurrentLevelTemp = prefs.value(forKey: itemKey)
            let CurrentLevel = Int(CurrentLevelTemp as! String)
            let NextLevel = CurrentLevel! + 1
            
            self.prefs.setValue(NextLevel.description, forKey: itemKey)
            self.itemView3LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Upgrade Complete!"
            alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            self.NumberItemsUpgrading -= 1
             UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
            
            
        } else {
            item3TimerLBL.text = timeString(HelmetTimeCount)
            
        }
        
    }
    
    func HelmetTimerUpgrade(_ sender: AnyObject) {
        let aSelector: Selector = #selector(StatsViewController.UpdateHelmetTime)
        HelmetTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: ["totalTime":"10"], repeats: true)
        HelmetStartTime = Date.timeIntervalSinceReferenceDate
    }
    
    @objc func UpdateBodyTime(){
        let item = "Body"
        let itemKey = "ARMORLEVELBODY"
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
       // print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - BodyStartTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        
        BodyTimeCount = BodyTimeCount - BodyTimeInterval
        
        if BodyTimeCount <= 0 {
            
            print("\(item) has been upgraded")
            itemTimerView4.isHidden = true
            self.BodyUpgrading = false
            BodyTimer.invalidate()
            
            
            let CurrentLevelTemp = prefs.value(forKey: itemKey)
            let CurrentLevel = Int(CurrentLevelTemp as! String)
            let NextLevel = CurrentLevel! + 1
            
            self.prefs.setValue(NextLevel.description, forKey: itemKey)
            self.itemView4LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Upgrade Complete!"
            alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            self.NumberItemsUpgrading -= 1
             UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
            
        } else {
            item4TimerLBL.text = timeString(BodyTimeCount)
            
        }
        
    }
    
    func BodyTimerUpgrade(_ sender: AnyObject) {
        let aSelector: Selector = #selector(StatsViewController.UpdateBodyTime)
        BodyTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: ["totalTime":"10"], repeats: true)
        BodyStartTime = Date.timeIntervalSinceReferenceDate
    }
    

    
    @objc func UpdateShieldTime(){
        let item = "Shield"
        let itemKey = "SHIELDLEVEL"
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - ShieldStartTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        
        ShieldTimeCount = ShieldTimeCount - ShieldTimeInterval
        
        if ShieldTimeCount <= 0 {
            
            print("Boots has been upgrade")
            itemTimerView2.isHidden = true
            self.ShieldUpgrading = false
            ShieldTimer.invalidate()
            
            
            let CurrentLevelTemp = prefs.value(forKey: itemKey)
            let CurrentLevel = Int(CurrentLevelTemp as! String)
            let NextLevel = CurrentLevel! + 1
            
            self.prefs.setValue(NextLevel.description, forKey: itemKey)
            self.itemView2LBL.text = "\(item): \(self.prefs.value(forKey: itemKey)!)"
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Upgrade Complete!"
            alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            self.NumberItemsUpgrading -= 1
             UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
            
        } else {
            item2TimerLBL.text = timeString(ShieldTimeCount)
            
        }
        
    }
    
    func ShieldTimerUpgrade(_ sender: AnyObject) {
        let aSelector: Selector = #selector(StatsViewController.UpdateShieldTime)
        ShieldTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: ["totalTime":"10"], repeats: true)
        ShieldStartTime = Date.timeIntervalSinceReferenceDate
    }
    
    
    
    
    @objc func UpdateBootsTime(){
    
    let item = "Boots"
    var itemKey = "ARMORLEVELBOOTS"
    
        let currentTime = Date.timeIntervalSinceReferenceDate
        
       // print("Current Time = \(currentTime)")
    
            var elapsedTime: TimeInterval = currentTime - BootsStartTime
            
            //calculate the minutes in elapsed time.
            
            let minutes = UInt8(elapsedTime / 60.0)
            
            elapsedTime -= (TimeInterval(minutes) * 60)
            
            //calculate the seconds in elapsed time.
            
            let seconds = UInt8(elapsedTime)
            
            elapsedTime -= TimeInterval(seconds)
            
            //find out the fraction of milliseconds to be displayed.
            
            let fraction = UInt8(elapsedTime * 100)
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            
            let strMinutes = String(format: "%02d", minutes)
            let strSeconds = String(format: "%02d", seconds)
            let strFraction = String(format: "%02d", fraction)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel

        
        BootsTimeCount = BootsTimeCount - BootsTimeInterval
        
        if BootsTimeCount <= 0 {
            
            print("Boots has been upgrade")
            itemTimerView1.isHidden = true
            self.BootsUpgrading = false
            BootsTimer.invalidate()
            
            
            let CurrentLevelTemp = prefs.value(forKey: "ARMORLEVELBOOTS")
            let CurrentLevel = Int(CurrentLevelTemp as! String)
            let NextLevel = CurrentLevel! + 1

            self.prefs.setValue(NextLevel.description, forKey: "ARMORLEVELBOOTS")
            self.itemView1LBL.text = "Boots: \(self.prefs.value(forKey: "ARMORLEVELBOOTS")!)"
           // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Upgrade Complete!"
            alertView.message = "Your Boots have been upgraded to level \(NextLevel.description)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            self.NumberItemsUpgrading -= 1
            UserDefaults().removeObject(forKey: "\(item)EndUpgradeTime")
            
        } else {
            item1TimerLBL.text = timeString(BootsTimeCount)
            
        }

    }
    
    func BootsTimerUpgrade(_ sender: AnyObject) {
        let aSelector: Selector = #selector(StatsViewController.UpdateBootsTime)
        BootsTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: ["totalTime":"10"], repeats: true)
        BootsStartTime = Date.timeIntervalSinceReferenceDate
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BootsUpgradeCost = prefs.integer(forKey: "ARMORBOOTSUPRGRADECOST")
        BodyUpgradeCost = prefs.integer(forKey: "ARMORBODYUPRGRADECOST")
        HelmetUpgradeCost = prefs.integer(forKey: "ARMORHELMETUPRGRADECOST")
        ShieldUpgradeCost = prefs.integer(forKey: "SHIELDUPRGRADECOST")
        
        AllowedNumberToUpgrade = prefs.integer(forKey: "ALLOWEDNUMBERTOUPGRADE")
        self.moneyLBL.text = prefs.value(forKey: "GOLDAMOUNT") as! String
        
        
        itemView1.layer.cornerRadius = 5
        itemView1.clipsToBounds = true
        itemView1.layer.masksToBounds = true
        itemView1.layer.borderWidth = 1
        itemView1.layer.borderColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
      
        item1IMG.layer.cornerRadius = 5
        item1IMG.clipsToBounds = true
        item1IMG.layer.masksToBounds = true
        
        itemView2.layer.cornerRadius = 5
        itemView2.clipsToBounds = true
        itemView2.layer.masksToBounds = true
        itemView2.layer.borderWidth = 1
        itemView2.layer.borderColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
        
        item2IMG.layer.cornerRadius = 5
        item2IMG.clipsToBounds = true
        item2IMG.layer.masksToBounds = true
        
        itemView3.layer.cornerRadius = 5
        itemView3.clipsToBounds = true
        itemView3.layer.masksToBounds = true
        itemView3.layer.borderWidth = 1
        itemView3.layer.borderColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
        
        item3IMG.layer.cornerRadius = 5
        item3IMG.clipsToBounds = true
        item3IMG.layer.masksToBounds = true
        
        itemView4.layer.cornerRadius = 5
        itemView4.clipsToBounds = true
        itemView4.layer.masksToBounds = true
        itemView4.layer.borderWidth = 1
        itemView4.layer.borderColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
        
        item4IMG.layer.cornerRadius = 5
        item4IMG.clipsToBounds = true
        item4IMG.layer.masksToBounds = true
        
        
        attributesView.layer.cornerRadius = 40
        attributesView.clipsToBounds = true
        attributesView.layer.masksToBounds = true
        attributesView.layer.borderWidth = 1
        //attributesView.layer.borderColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
        

        
        //itemView1.hidden = true
       // itemView2.hidden = true
       // itemView3.hidden = true
       // itemView4.hidden = true
        
        
        
        itemTimerView1.isHidden = true
        itemTimerView2.isHidden = true
        itemTimerView3.isHidden = true
        itemTimerView4.isHidden = true
        
        
        if prefs.value(forKey: "ARMORLEVELBOOTS") != nil { 
        
       // if prefs.valueForKey("ARMORLEVELBOOTS") as! String != "" {
        
        
        itemView1LBL.text = "Boots: \(prefs.value(forKey: "ARMORLEVELBOOTS")!)"
        itemView2LBL.text = "Shield: \(prefs.value(forKey: "SHIELDLEVEL")!)"
        itemView3LBL.text = "Helmet: \(prefs.value(forKey: "ARMORLEVELHELMET")!)"
        itemView4LBL.text = "Body: \(prefs.value(forKey: "ARMORLEVELBODY")!)"
            
        } else {
            itemView1LBL.text = "Boots: level 0"
            itemView2LBL.text = "Shield: level 0"
            itemView3LBL.text = "Helmet: level 0"
            itemView4LBL.text = "Body: level 0"
            
        }
        
        /*
        scene = BattleGame(size: view.bounds.size)
        skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        
        */
        
        
         navigationController!.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        //navigationController!.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        
       //   navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: (UIFont(name: "Verdana", size: 25)!)?, NSAttributedString.Key.foregroundColor: UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)]
        
         navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.init(name: "Verdana", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)]
        
        let device = UIScreen.main.bounds
        let width = device.size.width
        let RevealWidth = width - 50
        
      //  self.revealViewController().rearViewRevealWidth = 200
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            rightmenuButton.target = self.revealViewController()
            rightmenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 130
            self.revealViewController().rearViewRevealWidth = RevealWidth
            
           // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
            
            
        }

        
        
        LoadMyPlayer()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(StatsViewController.UpgradeNotification(_:)), name:NSNotification.Name(rawValue: "UpgradeNotification"), object: nil)
        
        
        for item in AllItems {
            
            print("Checking \(item) end time")
            
            if (self.prefs.value(forKey: "\(item)EndUpgradeTime") != nil) {
                
                print("\(item) has an end time of \(self.prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval)")
                
                switch item {
                case "Body":
                    print("start body timer")
                    self.BodyTimeCount = self.prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval - now
                    
                    self.BodyUpgrading = true
                    self.itemTimerView4.isHidden = false
                    // self.HelmetTimeCount = CompleteTimeTemp
                    let theSelector = "Update\(item)Time"
                    let aSelector: Selector = Selector(theSelector)
                    self.BodyTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                    
                    self.BodyStartTime = Date.timeIntervalSinceReferenceDate
                     NumberItemsUpgrading += 1
                    
                case "Boots":
                    print("Start boots timer")
                    
                    
                    self.BootsTimeCount = self.prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval - now
                    
                    print("Boots Time Count = \(BootsTimeCount)")
                    
                    self.BootsUpgrading = true
                    self.itemTimerView1.isHidden = false
                    // self.HelmetTimeCount = CompleteTimeTemp
                    let theSelector = "Update\(item)Time"
                    let aSelector: Selector = Selector(theSelector)
                    
                    self.BootsTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                    
                    self.BootsStartTime = Date.timeIntervalSinceReferenceDate
                     NumberItemsUpgrading += 1
                    
                    
                case "Shield":
                    print("Start shield timer")
                    
                    
                    self.ShieldTimeCount = self.prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval - now
                    
                    self.ShieldUpgrading = true
                    self.itemTimerView2.isHidden = false
                    // self.HelmetTimeCount = CompleteTimeTemp
                    let theSelector = "Update\(item)Time"
                    let aSelector: Selector = Selector(theSelector)
                    self.ShieldTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                    
                    self.ShieldStartTime = Date.timeIntervalSinceReferenceDate
                     NumberItemsUpgrading += 1
                    
                case "Helmet":
                    print("Start helmet timer")
                    self.HelmetTimeCount = self.prefs.value(forKey: "\(item)EndUpgradeTime") as! TimeInterval - now
                    
                    self.HelmetUpgrading = true
                    self.itemTimerView3.isHidden = false
                    // self.HelmetTimeCount = CompleteTimeTemp
                    let theSelector = "Update\(item)Time"
                    let aSelector: Selector = Selector(theSelector)
                    self.HelmetTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                    
                    self.HelmetStartTime = Date.timeIntervalSinceReferenceDate
                    NumberItemsUpgrading += 1
                    
                default:
                    break
                }
                
                
            }
            
            
            
        }
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        itemView1.isHidden = true
        itemView2.isHidden = true
        itemView3.isHidden = true
        itemView4.isHidden = true
        
        
//        
//        placeItemGesture = UILongPressGestureRecognizer(target: self, action: #selector(AttackMapViewController.selectItemGestureRecognized(_:)))
//        placeItemGesture.delegate = self
//        view.addGestureRecognizer(placeItemGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // var attacktimercontroller: BattleViewControll@objc er = BattleViewController()
    
    @objc func UpgradeNotification(_ notification: Notification) {
        
        var info = notification.userInfo
        
        let item = info!["item"]
        let CurrentLevelTemp = info!["level"]
        let CurrentLevel = Int(CurrentLevelTemp as! String)
        let NextLevel = CurrentLevel! + 1
        print("item name = \(item)")
        print("item Level = \(CurrentLevelTemp)")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "\(item!) Upgrade", message: "Are you sure you want to upgrade this item to level \(NextLevel)?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
           // self.NumberItemsUpgrading--
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            //  self.AttackingPlayer = user
            //   self.AttackingPlayersHealth = health
            print("Upgrading \(item)")
            
            //self.performSegueWithIdentifier("goto_attack", sender: self)
            
            switch item as! String {
            case "Shield":
            
            self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
            
            case "Boots":
                
            self.prefs.setValue(NextLevel, forKey: "ARMORLEVELBOOTS")
                
            default:
                break
            
            }
            
            
           NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateItemTextLevel"), object: nil, userInfo: ["item":"\(item)","level":"\(NextLevel)"])
            
            
            /*
            
            if PickUpSuccess{
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = "You Picked up the"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            }
            
            */
            //self.SubmitPic()
            
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    @objc func updateCounter() {
    
    if counter != 0 {
    TimerLBL.text = "\(String(describing: counter -= 1)) Seconds"
    //timer.invalidate()
    }
    
    if counter == 0 {
    timer.invalidate()
    }
    
    if counter < 5 {
    TimerLBL.textColor = UIColor.red
    TimerLBL.layer.borderColor = UIColor.red.cgColor        }
    
    if counter == 0 {
    
    TimerLBL.text = "\(counter) Seconds"
    
    let actionSheetController: UIAlertController = UIAlertController(title: "No response!", message: "\(AttackingPlayer) failed to respond, continue your Attack?", preferredStyle: .alert)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
    }
    
    //Create and an option action
    let nextAction: UIAlertAction = UIAlertAction(title: "Attack!", style: .default) { action -> Void in
    print("Is Attacking Player = \(self.AttackingPlayer)")
    
    //  self.dismissViewControllerAnimated(true, completion: nil)
    
    //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    //   username = prefs.valueForKey("USERNAME") as! NSString as String
    
    self.TimerLBL.isHidden = true
    self.AlertLBL.isHidden = true
    self.cancelBTN.isHidden = true
    
    print("Battling - \(self.AttackingPlayer)")
    
    
    
    
  //  self.skView.presentScene(self.scene)
    
    //self.performSegueWithIdentifier("start_fight", sender: self)
    
    
    
    }
    
    
    actionSheetController.addAction(nextAction)
    actionSheetController.addAction(cancelAction)
    
    self.present(actionSheetController, animated: true, completion: nil)
    /*
    
    var alertView:UIAlertView = UIAlertView()
    alertView.title = "No Response!"
    alertView.message = "\(AttackingPlayer) failed to respond, have your way with them."
    alertView.delegate = self
    alertView.addButtonWithTitle("Attack")
    alertView.show()
    self.performSegueWithIdentifier("start_fight", sender: self)
    */
    }
    }
    
    func timercountdown(){
    
    //if counter > 0 {
    
    timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(StatsViewController.updateCounter), userInfo: nil, repeats: true)
    
    //}
    
    }
    
    
    @IBAction func CancelAttack(_ sender: AnyObject) {
    
    type = "cancelAttack"
    
    let yesSuccess =  AttackNotice(username, username: AttackingPlayer, attackpower: AttackPower, type: type, attackedID: AttackingPlayerID)
    print("Attack Cancel Notice Sent = \(yesSuccess)")
    
    self.dismiss(animated: true, completion: nil)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollWidthRatio = Float(scrollView.contentOffset.x / scrollView.frame.size.width)
        let scrollHeightRatio = Float(scrollView.contentOffset.y / scrollView.frame.size.height)
        cameraOrbit.eulerAngles.y = Float(-2 * M_PI) * scrollWidthRatio
        cameraOrbit.eulerAngles.x = Float(-M_PI) * scrollHeightRatio
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.moneyLBL.text = prefs.value(forKey: "GOLDAMOUNT") as! String
        let myGoldAmountTemp = prefs.value(forKey: "GOLDAMOUNT") as! String
        self.myGoldAmount = Int(myGoldAmountTemp)!
        
        DispatchQueue.main.async(execute: {
            print("Scheduling notification")
            
            let itemName = "knife"
            let lat = 28.811427
            let long = -81.314230
            
      //     scheduleItemNotification(itemName, lat: lat, long: long)
            
        })
        
    }
    
    
    
//    func SetupScene() {
//        
//
//            enemyEyeBrowString = "male_white-eyebrow001"
//            enemyEyeLashString = "male_white-eyelashes01"
//            enemyEyesString = "male_white-highpolyeyes"
//            enemySuitString = "male_white-male_casualsuit06"
//            enemyMuscleString = "male_white-male_muscle_13290"
//            enemyShoesString = "male_white-shoes03"
//            enemyHairString = "male_white-short04"
//            enemyTeethString = "male_white-teeth_base"
//            enemyTongueString = "male_white-tongue01"
//            
//            enemyEyeBrowTexture = "eyebrow001"
//            enemyEyeLashTexture = "eyelashes01"
//            enemyEyesTexture = "brown_eye"
//            enemySuitTexture = "male_casualsuit06_diffuse"
//            enemyMuscleTexture = "middleage_lightskinned_male_diffuse"
//            enemyShoesTexture = "shoes03_diffuse"
//            enemyHairTexture = "short04_diffuse"
//            enemyTeethTexture = "teeth"
//            enemyTongueTexture = "tongue01_diffuse"
//            enemyRootNodeString = "male_white"
//            
//            /*
//             let sphereGeometry = SCNSphere(radius: 1.0)
//             sphereGeometry.firstMaterial?.diffuse.contents = UIColor.orangeColor()
//             let sphereNode = SCNNode(geometry: sphereGeometry)
//             self.rootNode.addChildNode(sphereNode)
//             
//             */
//            //  var scene = SCNScene(named: "PlayerSceneKit/playerOBJ.scn")
//            //var scene = SCNScene(named: "playerModel")
//            // var scene = SCNScene(named: "playerOBJ.scn")
//            
//            //   let bundle = NSBundle.mainBundle()
//            //  let path = bundle.pathForResource("playerobj2", ofType: "obj")
//            //   let url = NSURL(fileURLWithPath: path!)
//            
//            
//            // let scene = SCNScene(named: "ArmyUser3D.dae")
//        
//          //  let MyPlayerScene = SCNScene(named: "PlayerAttackScene.scn")!
//        
//            
//            playerScene2 = SCNScene(named: "animate.scnassets/Man_White3.dae")!
//        
//        
//           // playerScene2.background.contents = UIImage(named: "FOShelterBG.png")
//            
//            let camera = SCNCamera()
//            camera.usesOrthographicProjection = true
//            camera.orthographicScale = 0.35
//            camera.zNear = 0
//            camera.zFar = 30
//            camera.xFov = 50
//            
//            
//            
//            let mainNode = SCNNode()
//            mainNode.camera = camera
//           // playerScene2.rootNode.addChildNode(mainNode)
//            TheUserPlayerScene.rootNode.addChildNode(mainNode)
//            print("Scene Root = \(playerScene2.rootNode.childNodes)")
//            
//            mainNode.position = SCNVector3(0.0, 0.0, 50.0)
//            
//            let cur = mainNode.rotation
//            
//    
//            
//            var BodyGeometryNode = SCNNode()
//            var BodyGeometry = SCNGeometry()
//            
//
//            material.diffuse.contents = UIImage(named: "animate.scnassets/middleage_lightskinned_male_diffuse.png")
//            
//            
//            for nodes in (playerScene2.rootNode.childNodes) {
//                
//                
//                switch nodes.name {
//                case "Armature"?:
//                    print("armature")
//                    
//                    
//                case "\(enemyRootNodeString)"?:
//                    enemyNode = nodes
//                    
//                    
//                    
//                    for nodes2 in nodes.childNodes {
//                        //   print("nodes2 name: \(nodes2.name)")
//                    }
//                    
//                    
//                    
//                case "\(enemyShoesString)"?:
//                    print("Shoes found")
//                    //   print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyShoesTexture).png")
//                    
//                    enemyRootNode.addChildNode(nodes)
//                    
//                    
//                    
//                    
//                case "\(enemyMuscleString)"?:
//                    //case "male_white-male_muscle_13290"?:
//                    print("Skin found")
//                    print("GEOMETRY: \(nodes.geometry)")
//                    
//                    //  BodyGeometryNode = nodes
//                    BodyGeometry = nodes.geometry!
//                    //enemyNode.geometry?.materials.first =
//                    // enemyNode.addChildNode(nodes)
//                    
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyMuscleTexture).png")
//                    
//                    
//                    BodyGeometry = nodes.geometry!
//                    // nodes.addChildNode(bodyPlane)
//                    
//                    
//                    enemyRootNode.addChildNode(nodes)
//                    //enemyRootNode.addChildNode(enemySkin)
//                    //enemyNode.addChildNode(nodes)
//                    
//                case "\(enemySuitString)"?:
//                    //case "male_white-male_casualsuit06"?:
//                    
//                    print("casual suit found")
//                    
//                    
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemySuitTexture).png")
//                    
//                    
//                    enemyRootNode.addChildNode(nodes)
//                    // enemyNode.addChildNode(EnemyGeometryTest)
//                    
//                case "\(enemyHairString)"?:
//                    print("Hair found")
//                    //  print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyHairTexture).png")
//                    
//                    
//                    enemyRootNode.addChildNode(nodes)
//                    
//                case "\(enemyTeethString)"?:
//                    print("teeth found")
//                    //  print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTeethTexture).png")
//                    
//                    enemyRootNode.addChildNode(nodes)
//                    
//                case "\(enemyTongueString)"?:
//                    print("tongue found")
//                    // print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTongueTexture).png")
//                    enemyRootNode.addChildNode(nodes)
//                    
//                case "\(enemyEyeBrowString)"?:
//                    print("tongue found")
//                    //    print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeBrowTexture).png")
//                    enemyRootNode.addChildNode(nodes)
//                    
//                case "\(enemyEyeLashString)"?:
//                    print("tongue found")
//                    //  print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeLashTexture).png")
//                    enemyRootNode.addChildNode(nodes)
//                    
//                case "\(enemyEyesString)"?:
//                    print("tongue found")
//                    //   print("GEOMETRY: \(nodes.geometry)")
//                    nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyesTexture).png")
//                    enemyRootNode.addChildNode(nodes)
//                    
//                    
//                    
//                case "MDL_Obj"?:
//                    print("test")
//                case "Default_Camera"?:
//                    print("\(nodes.name)")
//                case "Lamp"?:
//                    print("\(nodes.name)")
//                case "Camera"?:
//                    print("\(nodes.name)")
//                case "Infinite_Light_1"?:
//                    print("\(nodes.name)")
//                case "Image_Based_Light_1"?:
//                    print("\(nodes.name)")
//                    
//                default:
//                    print("Adding \(nodes.name) by default")
//                    //enemyRootNode.addChildNode(nodes)
//                }
//                /*
//                 if nodes.name == "Armature" {
//                 enemyNode = nodes
//                 } else {
//                 
//                 enemyRootNode.addChildNode(nodes)
//                 }
//                 */
//            }
//            
//            
//            
//            enemyNode.geometry = BodyGeometryNode.geometry
//            enemyNode.geometry?.firstMaterial = material
//            enemyNode.physicsBody? = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: BodyGeometryNode.geometry!, options: nil))
//            
//            enemyNode.physicsBody?.angularDamping = 0.9999999
//            enemyNode.physicsBody?.damping = 0.9999999
//            enemyNode.physicsBody?.rollingFriction = 0
//            enemyNode.physicsBody?.friction = 0
//            enemyNode.physicsBody?.restitution = 0
//            //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
//            enemyNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
//            // enemyNode.physicsBody?.categoryBitMask = CollisionCategory.Enemy
//            // enemyNode.physicsBody?.collisionBitMask = CollisionCategory.All
//            //^ CollisionCategory.Bullet
//            enemyNode.name = "enemyNode"
//            if #available(iOS 9.0, *) {
//                enemyNode.physicsBody?.contactTestBitMask = ~0
//            }
//            //        print("Enemy Node position: \(enemyNode.position)")
//            
//            
//            
//            enemyNode.rotation.x = 180
//        
//            enemyNode.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
//            enemyNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
//            
//            // enemyRootNode.position = SCNVector3(x: 0, y: 1, z: -7)
//            // enemyRootNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
//            
//            
//            enemyRootNode.scale = SCNVector3(x: 1, y: 1, z: 1)
//            //enemyRootNode.scale = SCNVector3(x: 0.06, y: 0.06, z: 0.06)
//            
//            
//            //enemySkin.physicsBody?.isAffectedByGravity = false
//            enemyNode.physicsBody?.isAffectedByGravity = true
//            enemyRootNode.physicsBody?.isAffectedByGravity = false
//            
//            // for nodes in
//            
//            
//            for items in enemyRootNode.childNodes {
//                items.physicsBody?.isAffectedByGravity = true
//                
//                print("Root Items Name: \(items.name)")
//            }
//            
//            //enemyRootNode.addChildNode(enemyNode)
//            
//            
//            
//            TheUserPlayerScene.rootNode.addChildNode(enemyNode)
//            TheUserPlayerScene.rootNode.addChildNode(enemyRootNode)
//            
//
//            
//            
//            let secondSphereGeometry = SCNSphere(radius: 0.5)
//            secondSphereGeometry.firstMaterial?.diffuse.contents = UIColor.purple
//            let secondSphereNode = SCNNode(geometry: secondSphereGeometry)
//            secondSphereNode.position = SCNVector3(x: 0.0, y: 0.0, z: -10.0)
//        
//        
//           // self.rootNode.addChildNode(secondSphereNode)
//           // self.background.contents = UIImage(named: "FOShelterBG.png")
//        
//        
//       // self.SceneView.backgroundColor.contents = UIImage(named: "FOShelterBG.png")
//        
//        //SceneHolder.scene = playerScene2
//        
//        
////        theView.scene = TheUserPlayerScene
////        SceneView.addSubview(theView)
////        
////        theView.autoenablesDefaultLighting = true
////        theView.allowsCameraControl = true
////        //theView.
////        
////        self.theView.allowsCameraControl = true
////        //self.SceneHolder.showsStatistics = true
////        //self.SceneHolder.backgroundColor = UIColor.white
////        
////        self.theView.scene?.physicsWorld.contactDelegate = self
////        self.theView.delegate = self
//        
//        
//    
//        
//        
//        SceneHolder.scene = TheUserPlayerScene
//       // SceneView.addSubview(SceneHolder)
//        
//        SceneHolder.autoenablesDefaultLighting = true
//        SceneHolder.allowsCameraControl = true
//        //theView.
//        
//        self.SceneHolder.allowsCameraControl = true
//        //self.SceneHolder.showsStatistics = true
//        //self.SceneHolder.backgroundColor = UIColor.white
//        
//        self.SceneHolder.scene?.physicsWorld.contactDelegate = self
//        self.SceneHolder.delegate = self
//        
//        
//        
//        
//        
//    }
    
//    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
//        print("PHYSICS DID END")
//    }
//    
//    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
//        // print("PHYSICS DID UPDATE")
//        
//        // updateEnemy()
//        
//    }
//    
//     func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
//        let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
//        
//        let contactMask2 = contact.nodeB.physicsBody!.categoryBitMask | contact.nodeA.physicsBody!.categoryBitMask
//        
//        print("contact occurred: \(contactMask)")
//        print("NODE A: \(contact.nodeA.name)")
//        print("contact occurred: \(contactMask2)")
//        print("NODE B: \(contact.nodeB.name)")
//        
//    
//    }
//    
//      func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//    
//        
//        
//    
//    }
    
    
//    func selectItemGestureRecognized(_ gesture: UILongPressGestureRecognizer) {
//        
//        var nodeMaterial: SCNMaterial?
//        
//        print("long press recognized")
//        
//        if gesture.state == .began {
//            
////            self.lookGesture.isEnabled = false
////            self.walkGesture.isEnabled = false
////            self.moveItemGesture.isEnabled = true
////            MovingObject = true
//            
//            print("long press began")
//            print("Location touching = \(gesture.location(in: self.SceneHolder)))")
//            
//            let location = gesture.location(in: self.SceneHolder)
//            
//            TouchScreenX = location.x
//            TouchScreenY = location.y
//            
//            
////            if TouchScreenX + 50 > UIScreen.main.bounds.width {
////                deleteItemViewX.constant = TouchScreenX - 100
////            } else if TouchScreenX - 50 <= 0 {
////                deleteItemViewX.constant = TouchScreenX + 100
////            } else {
////                deleteItemViewX.constant = TouchScreenX - 100
////            }
////            
////            if TouchScreenY + 50 > UIScreen.main.bounds.height {
////                deleteItemViewY.constant = TouchScreenY - 50
////            } else if TouchScreenY - 50 <= 0 {
////                deleteItemViewY.constant = TouchScreenY + 100
////            } else {
////                deleteItemViewY.constant = TouchScreenY
////            }
//            
//            
//            //  deleteItemViewY.constant = TouchScreenY
//            //   deleteItemViewX.constant = TouchScreenX
//            
//            
//           // deleteItemView.isHidden = false
//            
//            //print("Long Pressed on Screen at X:\(TouchScreenX) Y:\(TouchScreenY)")
//            
//            let NodeArray = SceneHolder.hitTest(location, options: nil)
//            
//            if NodeArray.count > 0 {
//                
//                print("NODE INFO: \(NodeArray.first?.node)")
//                
//                for item in (NodeArray.first?.node.childNodes)! {
//                    print("NODE ITEM: \(item.name)")
//                }
//                
//                nodeMaterial = NodeArray.first?.node.geometry!.firstMaterial
//                
//                print("NODE MATERIAL: \(nodeMaterial)")
//               // canDeleteObject = true
//                
//               //print("Can delete object = \(canDeleteObject)")
//                
//                // print("Node array = \(NodeArray)")
//                let result: SCNHitTestResult = NodeArray[0]
//                print("LONG PRESS result name = \(result.node.name)")
//                
//                // print("result dictionary values = \(result.dictionaryWithValuesForKeys(["tag"]))")
//                
//                //  if result.node.name == "BLOCK" {
//                if result.node.name == "WallRight" || result.node.name == "Barrel" || result.node.name == "Enemy" {
//                    
//                    
//                    let ItemMapX = floor(result.worldCoordinates.x)
//                    let ItemMapY = floor(result.worldCoordinates.z)
//                    
//                    TouchingNode = result.node
//                    
//                    let itemPosition = SCNVector3(x: TouchingNode.presentation.position.x, y: TouchingNode.presentation.position.y, z: TouchingNode.presentation.position.z)
//                    
//                    let itemRotation = SCNVector4(x: TouchingNode.presentation.rotation.x, y: TouchingNode.presentation.rotation.y, z: TouchingNode.presentation.rotation.z, w: TouchingNode.presentation.rotation.w)
//                    
//                    if TouchingNode.childNodes.count > 0 {
//                        print("Node Child Name = \(result.node.childNodes[0].name)")
//                    }
//                    
//                    let glowNode: SCNNode = result.node.copy() as! SCNNode
//                    // glowNode.size = OriginalNode.size
//                    // glowNode.anchorPoint = OriginalNode.anchorPoint
//                    // glowNode.position = CGPoint(x: 0, y: 0)
//                    // glowNode.alpha = 0.5
//                    // glowNode.blendMode = SKBlendMode.Add
//                    
//                    // add the new node to the original node
//                    // OriginalNode.addChildNode(glowNode)
//                    
//                    // add the original node to the scene
//                    // self.addChild(OriginalNode)
//                    
//                    
//                    // glowNode.
//                    glowNode.name = "GLOWCHILD"
//                    glowNode.position = itemPosition
//                    glowNode.geometry = SCNCylinder(radius: 0.15, height: 0.6)
//                    glowNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: glowNode.geometry!, options: nil))
//                    glowNode.physicsBody?.categoryBitMask = CollisionCategory.Monster
//                    glowNode.physicsBody?.collisionBitMask = CollisionCategory.All
//                    //glowNode.name = "BLOCK"
//                    let glowFilter = CIFilter(name: "CIGaussianBlur")!
//                    glowFilter.setValue(120, forKey: kCIInputRadiusKey)
//                    glowNode.filters = [glowFilter]
//                    glowNode.light = SCNLight()
//                    glowNode.light!.type = SCNLight.LightType.ambient
//                    glowNode.light!.color = UIColor.darkGray
//                    // glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
//                    glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 0.5)
//                    //glowNode.alpha = 0.5
//                    //glowNode.blendMode =
//                    // glowNode.geometry.c
//                    //glowNode.setValuesForKeysWithDictionary(["tag":"1boxtest"])
//                    // monsterNode.u
//                    if #available(iOS 9.0, *) {
//                        glowNode.physicsBody?.contactTestBitMask = ~0
//                    }
//                    
//                    print("Adding Glow Node")
//                    TouchingNode.addChildNode(glowNode)
//                    
//                    
//                    /*
//                     let nodeFilter = CIFilter(name: "CIGaussianBlur")!
//                     nodeFilter.setValue(120, forKey: kCIInputRadiusKey)
//                     TouchingNode.filters = [nodeFilter]
//                     TouchingNode.light = SCNLight()
//                     TouchingNode.light!.type = SCNLight.LightType.ambient
//                     TouchingNode.light!.color = UIColor.darkGray
//                     // glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
//                     TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 0.5)
//                     */
//                    
//                    //TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
//                    TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 1.0)
//                    
//                    
//                    // self.sceneView.scene?.rootNode.addChildNode(TouchingNode)
//                    
//                    
//                }
//                
//                //print("ITEM MAP X:\(ItemMapX) Y:\(ItemMapY)")
//                
//                let alertView:UIAlertView = UIAlertView()
//                alertView.title = "LONG PRESS Touching X: Y:"
//                // alertView.message = "Pixel X:\(ItemMapX) Y:\(ItemMapY) name: \(result.node.name)"
//                alertView.delegate = self
//                
//                alertView.addButton(withTitle: "OK")
//                //  alertView.show()
//                
//            }
//            
//            
//        }
//        
//        if gesture.state == UIGestureRecognizer.State.changed {
//            
//            let location = gesture.location(in: self.SceneHolder)
//            // let previousLocation = gesture.
//            
//         //   print("Can delete object = \(canDeleteObject)")
//            
//            // if gesture.direc
//            let NextTouchScreenX = location.x
//            let NextTouchScreenY = location.y
//            
//            if NextTouchScreenX >= TouchScreenX + 100 {
//                
//                print("Swiped to the right >= 100")
//                
//                if canDeleteObject {
//                    MovingObject = false
//                    TouchingNode.removeFromParentNode()
//                    
//                    print("swiping right, would delete the Touching Node Now")
//                    
//                } else {
//                    print("Does nothing, no item to delete seleted")
//                }
//                
//                
//            }
//            
//            print("Long press moved")
//            
//        }
//        
//        
//        if gesture.state == UIGestureRecognizer.State.ended {
//            canDeleteObject = false
//            print("Can delete object = \(canDeleteObject)")
//            TouchScreenX = 0
//            TouchScreenY = 0
//            
////            deleteItemView.isHidden = true
//            
//            print("long press ended, removing nodes from Node Named:\(TouchingNode.name)")
////            self.lookGesture.isEnabled = true
////            self.walkGesture.isEnabled = true
////            self.moveItemGesture.isEnabled = false
//            
//            if MovingObject {
//                print("Moving Object/Long Press ended")
//                // TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteColor()
//                
//                if TouchingNode.childNodes.count > 0 {
//                    if (TouchingNode.childNode(withName: "GLOWCHILD", recursively: true) != nil) {
//                        
//                        
//                        // TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
//                        if nodeMaterial != nil {
//                            
//                            TouchingNode.geometry?.firstMaterial? = nodeMaterial!
//                            
//                        }
//                        
//                        // nodeMaterial = tap.geometry!.firstMaterial
//                        // print("Touches ended, this  node has a child node")
//                        // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
//                        // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
//                        // GlowChildNode!.removeFromParentNode()
//                        //TouchingNode.filters = nil
//                        // TouchingNode.light = nil
//                        //  TouchingNode.
//                        
//                        for cnodes in TouchingNode.childNodes {
//                            print("removing ALL the child nodes")
//                            if cnodes.name == "GLOWCHILD" {
//                                print("Removing Glow Node")
//                                cnodes.removeFromParentNode()
//                            } else {
//                                // cnodes.removeFromParentNode()
//                            }
//                        }
//                    }
//                }
//                //  }
//                
//                //  MovingObject = false
//                
//                /*
//                 
//                 var location = gesture.locationInView(self.sceneView)
//                 
//                 // var location = touch.locationInNode(self.sceneView)
//                 
//                 let NodeArray = sceneView.hitTest(location, options: nil)
//                 
//                 if NodeArray.count > 0 {
//                 
//                 
//                 //NodeArray[0].node.geometry
//                 
//                 if NodeArray[0].node.childNodes.count > 0 {
//                 print("this node has a child")
//                 if (NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true) != nil) {
//                 print("this node has a child named GLOWCHILD")
//                 
//                 // NodeArray[0].node.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGrayColor()
//                 NodeArray[0].node.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteColor()
//                 // print("Touches ended, this  node has a child node")
//                 // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
//                 // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
//                 // GlowChildNode!.removeFromParentNode()
//                 for cnodes in NodeArray[0].node.childNodes {
//                 print("removing ALL the child nodes")
//                 if cnodes.name == "GLOWCHILD" {
//                 cnodes.removeFromParentNode()
//                 }
//                 }
//                 
//                 }
//                 }
//                 }
//                 */
//                MovingObject = false
//            }
//            
//            
//            
//            //let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)!
//            //  GlowChildNode.removeFromParentNode()
//        }
//        
//        
//    }
//    
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touches began")
//        
//        if let touch = touches.first {
//            super.touchesBegan(touches, with:event)
//            //var point = touch?.locationInNode(self)
//            let location = touch.location(in: self.SceneHolder)
//            
//            // var location = touch.locationInNode(self.sceneView)
//            
//            let NodeArray = SceneHolder.hitTest(location, options: nil)
//            
//            if NodeArray.count > 0 {
//                
//                // print("Node array = \(NodeArray)")
//                let result: SCNHitTestResult = NodeArray[0]
//                print("result name = \(result.node.name)")
//                // print("result position: \(result.node.position)")
//                // print("result geometry index: \(result.geometryIndex)")
//                // print("result geometry: \(result.node.geometry)")
//                
//                // print("result world normal: \(result.worldNormal)")
//                // print("result local normal: \(result.localNormal)")
//                //  print("result local coordinates: \(result.localCoordinates)")
//                //  print("result world coordinates: \(result.worldCoordinates)")
//                let ItemMapX = floor(result.worldCoordinates.x)
//                let ItemMapY = floor(result.worldCoordinates.z)
//                
//                
//                
//                print("ITEM MAP X:\(ItemMapX) Y:\(ItemMapY)")
//                
//                let alertView:UIAlertView = UIAlertView()
//                alertView.title = "Touching X: Y:"
//                alertView.message = "Pixel X:\(ItemMapX) Y:\(ItemMapY)"
//                alertView.delegate = self
//                
//                alertView.addButton(withTitle: "OK")
//                // alertView.show()
//                
//            }
//            
//            
//            //let touchedNode = sceneView.scene.no
//            
//            //  let touchedNode = sceneView.scene?.rootNode
//            print("Touched Point = \(location)")
//        } else {
//            print("No touch recognized")
//        }
//        
//    }
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    /*
    if segue.identifier == "start_fight" {
    if let battlecontroller = segue.destinationViewController as? BattleViewController {
    
    battlecontroller.AttackingPlayer = AttackingPlayer as String
    battlecontroller.AttackingPlayersHealth = AttackingPlayersHealth as String
    
    //NEED TO ADD ARMOR, PLAYER TYPE ETC VARIABLES
    }
    
    }
    */
    }
    
    func CloseAttackGame() {
    print("received close notification")
    
    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
   // let yesSuccess =  Attack(self.username, username: self.AttackingPlayer, attackpower: self.AttackPower)
    let yesSuccess = Attack(self.username, attackingID: self.email, attackedName: self.AttackingPlayer, attackedID: self.AttackingPlayerID, attackpower: self.AttackPower)
    print("Attack Success = \(yesSuccess)")
    
    DispatchQueue.main.async {
    print("dismissing timer view controller")
    self.dismiss(animated: true, completion: nil)
    }
    
    }
    
    /*
    if yesSuccess{
    var alertView:UIAlertView = UIAlertView()
    alertView.title = "Attack Success!"
    alertView.message = "Target Hit!"
    alertView.delegate = self
    alertView.addButtonWithTitle("OK")
    alertView.show()
    
    }
    */
    }
    
    
    override var prefersStatusBarHidden : Bool {
    return false
    }
    
    /*
    @IBAction func CloseAttackBTN(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
    //  self.tdelegate?.battleviewcontrollerfinished(self)
    }
    */
    
    
    override var shouldAutorotate : Bool {
    return true
    }
    
    
    //   override func supportedInterfaceOrientations() -> Int {
    //     return UIInterfaceOrientation.LandscapeLeft.rawValue
    //  }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    
    if UIDevice.current.userInterfaceIdiom == .phone {
    return UIInterfaceOrientationMask.allButUpsideDown
    } else {
        return UIInterfaceOrientationMask.all
    }
    }
    
    
    
    
    @objc func MoneyUpdateTimerUser(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! NSDictionary
        let previousAmountTemp = userInfo["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        //   print("MoneyUpdateTimer: Previous Amount: \(previousAmountTemp)")
        
        
        let newAmountTemp = userInfo["newAmount"] as! String
        let newAmount = Int(newAmountTemp)
        //    print("MoneyUpdateTimer: New Amount: \(newAmountTemp)")
        
        let differenceAmountTemp = userInfo["differenceAmount"] as! String
        let differenceAmount = Int(differenceAmountTemp)
        //   print("MoneyChangeCount = \(MoneyChangeCount.description)")
        
        
        var changeAmount = previousAmount! + MoneyChangeCount
        //   print("Change Amount = \(changeAmount)")
        
        if (previousAmount! - MoneyChangeCount) < newAmount! {
            
            moneyTimer.invalidate()
        } else {
            let TempAmount = previousAmount! - MoneyChangeCount
            moneyLBL.text = "$\(TempAmount.description)"
            MoneyChangeCount += 1
        }
        
        var differenceAmountCount = differenceAmount! + 1
        //   print("Difference Amount = \(differenceAmountCount)")
        
        
        
        
        
    }
    
    func UpdateMoneyUser(_ myGold: Int, itemCost: Int) {
        
        MoneyChangeCount = 0
        
        
      //  let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        //let previousAmountTemp = userInfo!["previousAmount"] as! String
        let previousAmount = myGold
       // let newAmountTemp = userInfo!["newAmount"] as! String
        
        let newAmount = previousAmount - itemCost
        //   print("Update Money New Amount?: \(newAmount)")
        let differenceAmount = newAmount - previousAmount
        //    print("Difference Amount = \(differenceAmount)")
        
        // let arr = [previousAmount, newAmount, differenceAmount]
        
        moneyTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(StatsViewController.MoneyUpdateTimerUser(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmount.description)"], repeats: true)
        
        //  moneyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: Selector("MoneyUpdateTimer:"), userInfo: arr, repeats: true)
        
        
         let UpdateGoldSuccess =  UpdateUserGold(username, email: email, amount: newAmount.description as NSString)
        
        if UpdateGoldSuccess {
            print("Updated users gold")
        }
        
        
        
    }
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//     
//        
////        
////        if gestureRecognizer == lookGesture {
////            // print("look gesture")
////            return touch.location(in: self).x > self.frame.size.width / 2
////        } else if gestureRecognizer == walkGesture {
////            
////            //print("is walking")
////            //print("touch view x:\(touch.location(in: self).x)")
////            //print("frame width / 2: \(self.frame.size.width / 2)")
////            return touch.location(in: self).x < self.frame.size.width / 2
////        }
//        
//        
//        
//        return true
//        
//        
//    }
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        
//        return true
//    }
    
    
    
    
    func LoadMyPlayer() {
//        let subViews = self.view.subviews
//        for subview in subViews{
//            if subview.tag == 1000 {
//                subview.removeFromSuperview()
//            }
//        }
        
        let sceneSubViews = self.SceneView.subviews
        for subview in sceneSubViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            
            
           // self.tabBarItemPlayer.isEnabled = false
           // self.tabBarItemTeam.isEnabled = false
            var wp = String()
            
            if self.prefs.value(forKey: "HOLDINGWEAPON") == nil {
                wp = "Fist"
            } else {
                wp = self.prefs.value(forKey: "HOLDINGWEAPON") as! String
            }
            
            print("wp: \(wp)")
            
            let CharacterInfoTemp = CharacterInfo(name: self.username as String, skinTone: "white", health: "100", currentWeapon: wp)
            
            
            var view = MyPlayerView.instanceFromNib(characterInfo: CharacterInfoTemp)
            view.tag = 1000
            
            self.SceneView.addSubview(view)
            
           // self.view.addSubview(view)
        })
    }
    
    
}
