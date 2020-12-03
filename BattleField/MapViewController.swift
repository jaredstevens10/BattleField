//
//  MapViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GameKit
import SpriteKit
import SceneKit
import CoreData
import UserNotifications




class MapViewController: UIViewController, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate,  SettingsViewControllerDelegate, ArmorViewControllerDelegate, ShieldViewControllerDelegate, ItemAnnotationViewControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate  {
    
    var MapViewLoadComplete = Bool()
    
    var tabBarItemMap: UITabBarItem = UITabBarItem()
    var tabBarItemPlayer: UITabBarItem = UITabBarItem()
    var tabBarItemTeam: UITabBarItem = UITabBarItem()
    
    @IBOutlet weak var NewsHolderView: UIView!
    @IBOutlet weak var NewsBTNView: UIView!
    @IBOutlet weak var NewsBTN: UIButton!
    @IBOutlet weak var newsNotificationView: UIView!
    @IBOutlet weak var newsNotificationLBL: UILabel!
    
    
    @IBOutlet weak var missionNotificationView: UIView!
    @IBOutlet weak var missionNotificationLBL: UILabel!
    
    @IBOutlet weak var targetNotificationView: UIView!
    @IBOutlet weak var targetNotificationLBL: UILabel!
    
    @IBOutlet weak var tempBTN: UIButton!
    
    var IsSecurityArmed = Bool()
    var IsHomeSet = Bool()
    var NearbyCameras = [CameraInfo]()
    var OtherNearbyCameras = [CameraInfo]()
    
    var DoUpdateAnnotations = Bool()
    
    var ScrollItemsInView = Bool()
    @IBOutlet weak var ScrollItemsView: UIView!
    
    @IBOutlet weak var ScrollItemsViewBOTTOM: NSLayoutConstraint!
    
    
    var MoneyAmountTotalError = Int()
    var MoneyActionInProgress = Bool()
    
    var IsDead = Bool()
    
    var CloudsMovedOut = Bool()
    var NightVisionOn = Bool()
    var FlashlightOn = Bool()
    var DimLightValue = Double()
    @IBOutlet weak var daylightView: UIView!
    
    var AfterStartupLoad = Bool()

    let device = UIScreen.main.bounds
    
    
    @IBOutlet weak var MapEffectsView: UIView!
    
   // var EffectsScene: SKScene!
    var EffectsScene: EffectsOverlay!
   // var EffectSpriteView: SKView!
    //var EffectSpriteView: SKView!
    
    @IBOutlet weak var EffectsSKView: SKView!

    
    @IBOutlet weak var EffectsViewLBL: UILabel!
    
    
    var DoNotUpdateMapBool = Bool()
    var AnnotationTapped = Bool()
    
    var MissionID = String()
    var MissionLevel = String()
    var MissionObjective = String()
    var MissionXP = String()
    var MissionMapURL = String()
    var MissionObjectURL = String()
    
    
    var UserObjective = String()
    
    @IBOutlet weak var xpProgressView: UIProgressView!
    var myUserLevel = Int()
    var myXP = Int()
    @IBOutlet weak var userLevelLBL: UILabel!
    @IBOutlet weak var xpLBL: UILabel!
    
    @IBOutlet weak var xpView: UIView!
    @IBOutlet weak var userLevelView: UIView!
    
    
    var MissionInfoArray = [MissionInfo]()
    var CenterFromForeground = Bool()
    var CapturingTerritory = Bool()
    var restrictedRegion: MKCoordinateRegion!
    var TerritoryInfoArray = [TerritoryInfo]()
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var DiamondView: UIView!
    @IBOutlet weak var ShieldBTNView: UIView!
    @IBOutlet weak var ArmorBTNView: UIView!
    @IBOutlet weak var ToolsBTNView: UIView!
    @IBOutlet weak var CapturePointBTNView: UIView!
    @IBOutlet weak var FlashlightBTNView: UIView!
    
    @IBOutlet weak var missionBTNView: UIView!
    
    
    var msgLBL = UILabel()
    var RightmsgLBL = UILabel()
    var attmsgLBL = UILabel()
    
    var CenterOnUser = Bool()
    
    var now: TimeInterval {
        return Date().timeIntervalSinceReferenceDate
    }
    
    
    @IBOutlet weak var CenterUserBTN: UIButton!
    
    @IBOutlet weak var diamondsLBL: UILabel!
    
    
    var ViewingAbilities = Bool()
    @IBOutlet weak var GoldAmountView: UIView!
    
    @IBOutlet weak var GoldAmountLBLView: UIView!
    @IBOutlet weak var GoldCollectedLBLView: UIView!
    
    @IBOutlet weak var GoldContainerView: UIView!
    @IBOutlet weak var GoldProductionAmountLBL: UILabel!
    
    @IBOutlet weak var GoldCollectedAmountLBL: UILabel!
    
    var GoldProductionBoost = Double()
    var GoldProductionSpeed = Double()
    var GoldProductionSpeedPulse = Double()
    var GoldLBLShown = Bool()
    var GoldLBLViewShown = Bool()
    var GoldCollectedLBLShown = Bool()
    var GoldProductionLimit = Int()
    var GoldProductionAmount = Int()
    var GoldProductionTimer = Timer()
    var GoldProductionTimerPulse = Timer()
    var GoldProductionStartTime: TimeInterval = 120.0
    var GoldProductionEndTime = TimeInterval()
    var GoldProductionTimeCount = TimeInterval()
    var GoldProductionTimeInterval = TimeInterval()
    
    
    
    var HealthProductionBoost = Double()
    var HealthProductionSpeed = Double()
    var HealthProductionSpeedPulse = Double()
    var HealthProductionLimit = Int()
    var HealthProductionAmount = Int()
    var HealthProductionTimer = Timer()
    var HealthProductionTimerPulse = Timer()
    var HealthProductionStartTime: TimeInterval = 3600.0
    var HealthProductionEndTime = TimeInterval()
    var HealthProductionTimeCount = TimeInterval()
    var HealthProductionTimeInterval = TimeInterval()
    
    var StaminaProductionBoost = Double()
    var StaminaProductionSpeed = Double()
    var StaminaProductionSpeedPulse = Double()
    var StaminaProductionLimit = Int()
    var StaminaProductionAmount = Int()
    var StaminaProductionTimer = Timer()
    var StaminaProductionTimerPulse = Timer()
    var StaminaProductionStartTime: TimeInterval = 3600.0
    var StaminaProductionEndTime = TimeInterval()
    var StaminaProductionTimeCount = TimeInterval()
    var StaminaProductionTimeInterval = TimeInterval()
    
    
    
    var myGoldAmount = Int()
    var myDiamondsAmount = Int()
    var moneyBankUpgradeTimeLeft = TimeInterval()
    
    var moneyBankUpgrading = Bool()
    var moneyBankEnd = TimeInterval()
    var moneyBankTimer = Timer()
    //    var BootsStartTime = NSTimeInterval()
    var moneyBankStartTime: TimeInterval = 120.0
    var moneyBankTimeCount: TimeInterval = 0.0
    var moneyBankTimeInterval: TimeInterval = 0.05
    var moneyBankUpgradeCost = Int()
    
    var AllowedNumberToUpgrade = Int()
    var NumberItemsUpgrading: Int = 0
    
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    var LocNotItemName = String()
    var LocNotItemLat = Double()
    var LocNotItemLong = Double()
    
    var OpenedFromLocalNotification = Bool()
    var CustomItemAnnotationView: ItemAnnotationView!
    
    @IBOutlet weak var barGunBTN: UIButton!
    
    @IBOutlet weak var barArmorBTN: UIButton!
    @IBOutlet weak var barAbilitiesBTN: UIButton!
    @IBOutlet weak var barShieldBTN: UIButton!
    
    
    @IBOutlet weak var stealthView: UIView!
    
    
    @IBOutlet weak var mapMenuView: UIView!
    
    var regionRadius : CLLocationDistance = 1000
    
    
    
    
    @IBOutlet weak var healthLBL: UILabel!
    @IBOutlet weak var healthProgressView: VerticalProgressView!
    var healthprogress = Float()
    @IBOutlet weak var StaminaView: UIView!
    
    @IBOutlet weak var staminaLBL: UILabel!
    @IBOutlet weak var staminaProgressView: VerticalProgressView!
    var staminaprogress = Float()
    
    
    @IBOutlet weak var moneyProgressView: VerticalProgressView!
    var moneyprogress = Float()
    
    
    var MoneyChangeCount = Int()
    var HealthChangeCount = Int()
    var StaminaChangeCount = Int()
    var moneyTimer = Timer()
    var healthTimer = Timer()
    var staminaTimer = Timer()
    @IBOutlet weak var SceneView: UIView!
    @IBOutlet weak var HealthView: UIView!
    var moneyScene: MoneyOverlay!
    var theView: SCNView!
    
    
    
    var UserZoomRadius = Double()
    
    
    @IBOutlet weak var moneyLBL: UILabel!
    
    var username = NSString()
    var email = NSString()
    var ZoomLevel = Double()
    var tracking = GPSTrackingManager()
    var CurrentWeapon  = NSString()
    var CurrentShield = NSString()
    var CurrentArmor = NSString()
    var locations = [MKPointAnnotation]()
    
    
    
    @IBOutlet weak var VRange: UILabel!
    
    var AttackComplete = Bool()
    
    var weaponscontroller: WeaponsViewController = WeaponsViewController()
    
    var Armorcontroller:  ArmorViewController = ArmorViewController()
    
    var shieldcontroller: ShieldViewController = ShieldViewController()
    
    var itemannotationcontroller: ItemAnnotationViewController = ItemAnnotationViewController()
   
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var rightmenuButton: UIBarButtonItem!
    
    @IBOutlet weak var stealthBTN: UIButton!
    
    let MoveGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var ToolsBTN: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var weaponLabel: UILabel!
    
    @IBOutlet weak var shieldBTN: UIButton!
    
    @IBOutlet weak var armorBTN: UIButton!
    @IBOutlet weak var missionBTN: UIButton!
    
    @IBOutlet weak var shieldLabel: NSLayoutConstraint!
    var LocManager = CLLocationManager()
    var TrackingOn = Bool()
    //var currentLocation = CLLocation()
    var mylat = Double()
    var mylong = Double()
    var myalt = Double()
    var myloc = CLLocation()
    
    var ImageString = NSString()
    var FistImage = UIImage()
    
    var playernameArray = [NSString]()
    var playerlatArray = [Double]()
    var playerlongArray = [Double]()
    var playerhealthArray = [NSString]()
    var playerstealthArray = [NSString]()
    var AttackingPlayer = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackingPlayerID = NSString()
    var AttackingPlayerLat = NSString()
    var AttackingPlayerLong = NSString()
    var AttackingPlayerAlt = NSString()
    
    var LocationData = [NSArray]()
    
    var playernameInfo  = [NSString]()
    
    var playername = NSString()
    var playerlat2 = NSString()
    var playerlong2 = NSString()
    var playerlat = Double()
    var playerlong = Double()
    var playerhealth = NSString()
    var playerstealth = NSString()
    
    var itemname = NSString()
    var itemlat2 = NSString()
    var itemlong2 = NSString()
    var itemlat = Double()
    var itemlong = Double()
    var itemType = NSString()
    var itemStatus = NSString()
    var itemCode = NSString()
    var itemID = NSString()
    
    var PlotPoint: MKAnnotation!
    //var MyHomeBasePlotPoint: MKAnnotation!
    //var MyPlotPoint:
    var itemPoint: MKAnnotation!
    var TimerData = [NSString]()
    var UpdateLocationTimer = Timer()
    
    var AttackPower = Int()
    var ArmorDefense = Int()
    var ShieldDefense = Int()
    var SelectedWeapon = NSString()
    var SelectedItemAnnotation = NSString()
    var SelectedOpponentName = NSString()
    var SelectedOppStealthStatus = NSString()
    var userRadius = Int()
    var itemRadius = Int()
    
    var ShieldSpeed = NSString()
    var ShieldPower = NSString()
    var ShieldRange = NSString()
    
    var ArmorSpeed = NSString()
    var ArmorPower = NSString()
    var ArmorRange = NSString()
    
    var WeaponSpeed = NSString()
    var WeaponPower = NSString()
    var WeaponRange = NSString()
    var ViewRange = NSString()
    
    var AttackStatus = NSString()
    
    
    @IBOutlet weak var abilitiesIconView: UIView!
    
    
    var dist = Double()
    var CanPickUp = Bool()
    //var latGPS = Double()
    //var longGPS = Double()
    
    var prefs:UserDefaults = UserDefaults.standard
    
    var stealth_state = 0
    
    var StealthMode = Bool()
    
    @IBOutlet weak var WeaponItem: UIImageView!
    //@IBOutlet weak var ArmorPic: UIImageView!
    
    
    @IBAction func stealthBTN(_ sender: AnyObject) {
        
        switch stealth_state {
        case 0:
        stealthBTN.setImage(UIImage(named: "stealth_on"), for: UIControl.State())
            stealth_state = 1
            prefs.set(true, forKey: "STEALTHMODE")
        
        let StealthSuccess = UpdateStealthMode(self.username, stealth: "yes")
         //  let StealthSuccess = StealthMode(self.username, stealth: "yes")
        case 1:
            stealthBTN.setImage(UIImage(named: "stealth_off"), for: UIControl.State())
            prefs.set(false, forKey: "STEALTHMODE")
            stealth_state = 0
            let StealthSuccess = UpdateStealthMode(self.username, stealth: "no")
        default:
            stealthBTN.setImage(UIImage(named: "stealth_off"), for: UIControl.State())
            prefs.set(false, forKey: "STEALTHMODE")
            stealth_state = 0
            let StealthSuccess = UpdateStealthMode(self.username, stealth: "yes")
        }
        
        
        switch stealth_state {
        case 0:

        DispatchQueue.main.async(execute: {
            let degreeTemp = 1.0
            
            self.UpdateWeather("snow", degree: degreeTemp)
            
            
        })
            
            
        case 1:
            
            DispatchQueue.main.async(execute: {
                let degreeTemp = 1.0
                
                self.UpdateWeather("rain", degree: degreeTemp)
                
            })
        
         default:
            break
        }
    }
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        super.viewDidLoad()
        print("popover dismissed")
    }
    
    
    /*
    func handleFightBackNotification() {
        println("Good Job, stand up for yourself")
    }
    
    func handleRunAwayNotification() {
        println("You're running away you coward!")
        
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 10.0, *) {
           // UNUserNotificationCenter.current().delegate = self
            
            UNUserNotificationCenter.current().delegate = self
//            UNUserNotificationCenter.current().add(request){(error) in
//                
//                if (error != nil){
//                    
//                    print(error?.localizedDescription)
//                }
//            }
        } else {
            // Fallback on earlier versions
        }
        
        missionNotificationView.isHidden = true
        missionNotificationView.layer.cornerRadius = 7
        missionNotificationView.layer.masksToBounds = true
        missionNotificationView.clipsToBounds = true
        missionNotificationView.layer.borderWidth = 1
        missionNotificationView.layer.borderColor = UIColor.white.cgColor
        
        xpProgressView.clipsToBounds = true
        xpProgressView.layer.cornerRadius = 7
        xpProgressView.layer.masksToBounds = true
        //xpProgressView.layer.borderWidth = 1
        //xpProgressView.layer.borderColor = UIColor.white.cgColor
        
        targetNotificationView.isHidden = true
        targetNotificationView.layer.cornerRadius = 7
        targetNotificationView.layer.masksToBounds = true
        targetNotificationView.clipsToBounds = true
        targetNotificationView.layer.borderWidth = 1
        targetNotificationView.layer.borderColor = UIColor.white.cgColor
        
        
        newsNotificationView.layer.cornerRadius = 7
        newsNotificationView.layer.masksToBounds = true
        newsNotificationView.clipsToBounds = true
        newsNotificationView.layer.borderWidth = 1
        newsNotificationView.layer.borderColor = UIColor.white.cgColor
        
        newsNotificationView.layer.shadowColor = UIColor.black.cgColor
        newsNotificationView.layer.shadowOpacity = 1
        newsNotificationView.layer.shadowOffset = CGSize.zero
        newsNotificationView.layer.shadowRadius = 10
        

        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(MapViewController.ScrollViewSwipeDown(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.ScrollItemsView.addGestureRecognizer(swipeDown)
        
        //HIDE TAB BAR
        //self.tabBarController?.tabBar.hidden = true

        self.mapView.delegate = self
        self.mapView.mapType = MKMapType.satellite
        
        userLevelView.layer.cornerRadius = 15
        userLevelView.layer.masksToBounds = true
        userLevelView.clipsToBounds = true
        userLevelView.layer.borderWidth = 1
        userLevelView.layer.borderColor = UIColor.white.cgColor
        
        self.healthLBL.layer.cornerRadius = 5
        self.staminaLBL.layer.cornerRadius = 5
        
        self.healthLBL.layer.borderWidth = 1
        self.staminaLBL.layer.borderWidth = 1
        self.healthLBL.layer.borderColor = UIColor.black.cgColor
        self.staminaLBL.layer.borderColor = UIColor.black.cgColor
        self.healthLBL.layer.masksToBounds = true
        self.staminaLBL.layer.masksToBounds = true
        self.healthLBL.clipsToBounds = true
        self.staminaLBL.clipsToBounds = true
        
        
        GoldProductionBoost = 1.0
        HealthProductionBoost = 1.0
        StaminaProductionBoost = 1.0
       // staminaprogress = 0.8
        
        self.StealthMode = prefs.bool(forKey: "STEALTHMODE")
        
        if StealthMode {
            stealthBTN.setImage(UIImage(named: "stealth_on"), for: UIControl.State())
            stealth_state = 1
            
        } else  {
            stealthBTN.setImage(UIImage(named: "stealth_off"), for: UIControl.State())
            stealth_state = 0
        }
        
        
        
        GoldAmountView.isHidden = true
        GoldAmountLBLView.isHidden = true
        GoldCollectedLBLView.isHidden = true
        myGoldAmount = Int(prefs.value(forKey: "GOLDAMOUNT") as! String)!
        myDiamondsAmount = Int(prefs.value(forKey: "DIAMONDSAMOUNT") as! String)!
        
        myUserLevel = Int(prefs.value(forKey: "USERLEVEL") as! String)!
        myXP = Int(prefs.value(forKey: "USERXPLEVEL") as! String)!
        
        healthprogress = Float(prefs.integer(forKey: "MYHEALTH") / 100)
        
        
        self.IsDead = prefs.bool(forKey: "AmIDead")
        
        staminaprogress = Float(prefs.integer(forKey: "MYSTAMINA") / 100)
        
        let AvailableUpgradeSpace = CheckCurrentUpgradingStatus()
        print("From MapView, Available upgrade space = \(AvailableUpgradeSpace.description)")
        
        
        
        if prefs.value(forKey: "moneyBankUPGRADETIME") != nil {
        moneyBankUpgradeTimeLeft = prefs.value(forKey: "moneyBankUPGRADETIME") as! TimeInterval
        } else  {
        moneyBankUpgradeTimeLeft = 0
        }
        
        
        
        
        if prefs.value(forKey: "HealthReplenishTIME") != nil {
            moneyBankUpgradeTimeLeft = prefs.value(forKey: "HealthReplenishTIME") as! TimeInterval
        } else  {
            moneyBankUpgradeTimeLeft = 0
        }
        
        if moneyBankUpgradeTimeLeft > 0 {
            print("is upgrading money bank")
        
        } else {
            print("is NOT upgrading money bank")
        }
        
        AllowedNumberToUpgrade = prefs.integer(forKey: "ALLOWEDNUMBERTOUPGRADE")
        
        
        
        
        
        
        abilitiesIconView.layer.cornerRadius = 20
        abilitiesIconView.layer.masksToBounds = true
        abilitiesIconView.clipsToBounds = true
        abilitiesIconView.layer.borderWidth = 1
        abilitiesIconView.layer.borderColor = UIColor.black.cgColor
        
        
        stealthView.layer.cornerRadius = 20
        stealthView.layer.masksToBounds = true
        stealthView.clipsToBounds = true
        stealthView.layer.borderWidth = 1
        stealthView.layer.borderColor = UIColor.white.cgColor
        
        barGunBTN.imageView!.tintColor = UIColor.white
        barShieldBTN.imageView!.tintColor = UIColor.white
        barArmorBTN.imageView!.tintColor = UIColor.white
        
        
        /*
        healthprogress = 0.8
        
       // self.healthProgressView.setProgress(progress, animated: true)
        self.healthProgressView.progress = 0.8
        
        if healthprogress > 0.5 {
            self.healthLBL.text = (healthprogress * 100).description
          self.healthLBL.textColor = UIColor.whiteColor()
            self.healthProgressView.fillDoneColor = UIColor.greenColor()
        } else {
        self.healthLBL.text = (healthprogress * 100).description
        self.healthLBL.textColor = UIColor.darkGrayColor()
            if healthprogress < 0.3 {
                self.healthProgressView.fillDoneColor = UIColor.redColor()
            } else {
                self.healthProgressView.fillDoneColor = UIColor.orangeColor()
            }
        }
        */
        
        
        self.healthProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.healthProgressView.layer.borderWidth = 1
        self.healthProgressView.fillDoneColor = UIColor.red
      //  self.healthProgressView.fillDoneColor = UIColor.greenColor()
        self.healthProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.healthProgressView.layer.cornerRadius = 5
        
        self.staminaProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.staminaProgressView.layer.borderWidth = 1
       // self.staminaProgressView.fillDoneColor = UIColor.redColor()
        self.staminaProgressView.fillDoneColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        self.staminaProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.staminaProgressView.layer.cornerRadius = 5
        
        moneyprogress = 0.8
        
        // self.healthProgressView.setProgress(progress, animated: true)
       // self.moneyProgressView.progress = 0.8
        
        /*
        if moneyprogress > 0.5 {
          //  self.moneyLBL.text = (moneyprogress * 100).description
          //  self.moneyLBL.textColor = UIColor.whiteColor()
            self.moneyProgressView.fillDoneColor = UIColor.greenColor()
        } else {
          //  self.moneyLBL.text = (moneyprogress * 100).description
         //   self.moneyLBL.textColor = UIColor.darkGrayColor()
            if moneyprogress < 0.3 {
                self.moneyProgressView.fillDoneColor = UIColor.redColor()
            } else {
                self.moneyProgressView.fillDoneColor = UIColor.orangeColor()
            }
        }
        */
        
        
        self.moneyProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.moneyProgressView.layer.borderWidth = 1
        self.moneyProgressView.fillDoneColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0) //UIColor.greenColor()
        self.moneyProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.moneyProgressView.layer.cornerRadius = 20
        self.moneyProgressView.cornerRadius = 20
        
        
       // shakeView(moneyProgressView, repeatCount: 20)
        
        
        self.moneyLBL.text = "$\(prefs.value(forKey: "GOLDAMOUNT") as! String)"
        
        self.moneyLBL.text = prefs.value(forKey: "GOLDAMOUNT") as! String
        VRange.layer.cornerRadius = 5
        VRange.layer.masksToBounds = true
        VRange.clipsToBounds = true
        
        self.userLevelLBL.text = myUserLevel.description
        self.xpLBL.text = myXP.description
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.AttackPlayer(_:)), name: NSNotification.Name(rawValue: "AttackPlayer"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: "UnderAttack:", name: NSNotification.Name(rawValue: "UnderAttack"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateHealthStamina(_:)), name: NSNotification.Name(rawValue: "UpdateHealthStamina"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateMoney(_:)), name: NSNotification.Name(rawValue: "UpdateMoney"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateHealth(_:)), name: NSNotification.Name(rawValue: "UpdateHealth"),  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateStamina(_:)), name: NSNotification.Name(rawValue: "UpdateStamina"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.CollectGoldNotification(_:)), name: NSNotification.Name(rawValue: "CollectGoldNotification"),  object: nil)

       
    //    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleFightBackNotification", name: "FightBackNotification",  object: nil)
        
    //    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleRunAwayNotification", name: "RunAwayNotification",  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.CenterMap(_:)), name:NSNotification.Name(rawValue: "CenterMap"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.AttackCompleteStats(_:)), name:NSNotification.Name(rawValue: "AttackCompleteStats"), object: nil)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.HandleAttackMessage(_:)), name: NSNotification.Name(rawValue: "HandleAttackMessage"),  object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.HandleViewItem(_:)), name: NSNotification.Name(rawValue: "HandleViewItem"),  object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.PickUpItemNotification(_:)), name: NSNotification.Name(rawValue: "PickUpItemNotification"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.StartMissionNotification(_:)), name: NSNotification.Name(rawValue: "StartMissionNotification"),  object: nil)
        
        
          NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.ViewUserProfileNotification(_:)), name: NSNotification.Name(rawValue: "ViewUserProfileNotification"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateMap(_:)), name: NSNotification.Name(rawValue: "UpdateMap"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.HideAnnotations(_:)), name: NSNotification.Name(rawValue: "HideAnnotations"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: "UnwindTest:", name: NSNotification.Name(rawValue: "UnwindTest"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateWeapon(_:)), name: NSNotification.Name(rawValue: "UpdateWeapon"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.appMovedToBackground(_:)), name: UIApplication.willResignActiveNotification,  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateMessageLBL(_:)), name: NSNotification.Name(rawValue: "UpdateMessageLBL"),  object: nil)
        
          NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.DoNotUpdateMap(_:)), name: NSNotification.Name(rawValue: "DoNotUpdateMap"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.displayForegroundDetails), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.PlotPointNew(_:)), name: NSNotification.Name(rawValue: "PlotPointNew"),  object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateCaptureTerritoryBool(_:)), name: NSNotification.Name(rawValue: "UpdateCaptureTerritoryBool"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateMissionMessageLBL(_:)), name: NSNotification.Name(rawValue: "UpdateMissionMessageLBL"),  object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.ShowMessage(_:)), name: NSNotification.Name(rawValue: "ShowMessage"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UnwindToStart(_:)), name: NSNotification.Name(rawValue: "UnwindToStart"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateMissionNotification(_:)), name: NSNotification.Name(rawValue: "UpdateMissionNotification"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.EnableTabBarItems(_:)), name: NSNotification.Name(rawValue: "EnableTabBarItems"),  object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.UpdateTabBarItems(_:)), name: NSNotification.Name(rawValue: "UpdateTabBarItems"),  object: nil)
        
        
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.stopHealthTimer(_:)), name: NSNotification.Name(rawValue: "stopHealthTimer"),  object: nil)
//        
//          NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.stopHealthTimer(_:)), name: NSNotification.Name(rawValue: "stopHealthTimer"),  object: nil)
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //var lightRed = UIColor(red: 249, green: 148, blue: 148, alpha: 1.0)
        
        UITabBar.appearance().tintColor = UIColor(red: 249, green: 148, blue: 148, alpha: 1.0)
            
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.init(name: "Verdana", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)]
        
        tabBarController?.tabBar.barTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        //        tabBarController?.tabBar.barTintColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        
        tabBarController!.tabBar.tintColor = UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)
        
        AttackPower = 0
        
        
        let width = device.size.width
        let RevealWidth = width - 50
        
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            
            
            
            
            var UserMessageCount = Int()
            if prefs.value(forKey: "UserMessageCount") != nil {
               UserMessageCount = prefs.value(forKey: "UserMessageCount") as! Int
            } else  {
               UserMessageCount = 1
            }

            
            
            let MenuButtonNew = UIButton(type: UIButton.ButtonType.system) as UIButton
           // var msgLBL = UILabel()
            msgLBL.frame = CGRect(x: 20, y: 5, width: 18, height: 18)
            msgLBL.backgroundColor = UIColor.red
            msgLBL.layer.cornerRadius = 9
            msgLBL.layer.masksToBounds = true
            msgLBL.clipsToBounds = true
            msgLBL.text = "\(UserMessageCount.description)"
            msgLBL.textColor = UIColor.white
            msgLBL.textAlignment = NSTextAlignment.center
            
            msgLBL.font = msgLBL.font.withSize(10)
            
            MenuButtonNew.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            MenuButtonNew.setImage(UIImage(named: "message-7.png"), for: UIControl.State())
            MenuButtonNew.imageView!.tintColor = UIColor(red: 145/255, green: 28/255, blue: 37/255, alpha: 1.0)
            //MenuButtonNew.tintColor = UIColor(red: 145/255, green: 28/255, blue: 37/255, alpha: 1.0)
            //MenuButtonNew.imageView.t
            MenuButtonNew.addSubview(msgLBL)
            MenuButtonNew.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
        
            menuButton = UIBarButtonItem(customView: MenuButtonNew)
            
            
            
            let menuButtonTwo: UIBarButtonItem = UIBarButtonItem(customView: MenuButtonNew)
            self.navigationItem.leftBarButtonItem = menuButtonTwo
            
            
            
            //RIGHT MENU BUTTON BELOW
            var RightUserMessageCount = Int()
            if prefs.value(forKey: "MissionMessageCount") != nil {
                RightUserMessageCount = prefs.value(forKey: "MissionMessageCount") as! Int
            } else  {
                RightUserMessageCount = 1
            }

            
            let RightMenuButtonNew = UIButton(type: UIButton.ButtonType.system) as UIButton
            // var msgLBL = UILabel()
            RightmsgLBL.frame = CGRect(x: 20, y: 5, width: 18, height: 18)
            RightmsgLBL.backgroundColor = UIColor.red
            RightmsgLBL.layer.cornerRadius = 9
            RightmsgLBL.layer.masksToBounds = true
            RightmsgLBL.clipsToBounds = true
            RightmsgLBL.text = "\(RightUserMessageCount.description)"
            RightmsgLBL.textColor = UIColor.white
            RightmsgLBL.textAlignment = NSTextAlignment.center
            
            RightmsgLBL.font = msgLBL.font.withSize(10)
            RightMenuButtonNew.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
              RightMenuButtonNew.setImage(UIImage(named: "album-simple-7.png"), for: UIControl.State())

            RightMenuButtonNew.imageView!.tintColor = UIColor(red: 145/255, green: 28/255, blue: 37/255, alpha: 1.0)
            RightMenuButtonNew.addSubview(RightmsgLBL)
            RightMenuButtonNew.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: UIControl.Event.touchUpInside)
            
            
            rightmenuButton = UIBarButtonItem(customView: RightMenuButtonNew)
            let RightmenuButtonTwo: UIBarButtonItem = UIBarButtonItem(customView: RightMenuButtonNew)
            
            self.navigationItem.rightBarButtonItem = RightmenuButtonTwo
            
            
            
            
            
           // rightmenuButton.target = self.revealViewController()
            //rightmenuButton.action = "rightRevealToggle:"
            
            self.revealViewController().rightViewRevealWidth = 130
            self.revealViewController().rearViewRevealWidth = RevealWidth
           // self.revealViewController().rearViewRevealWidth = 50
            //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
       Armorcontroller.adelegate=self
        
       weaponscontroller.mdelegate=self
       shieldcontroller.sdelegate=self
        
       itemannotationcontroller.itemannotationdelegate=self
  
        

        HealthView.layer.masksToBounds = true
        HealthView.clipsToBounds = true
        HealthView.layer.cornerRadius = 5
        StaminaView.layer.masksToBounds = true
        StaminaView.clipsToBounds = true
        StaminaView.layer.cornerRadius = 5
        
        /*
        ToolsBTN.layer.borderWidth = 1
        ToolsBTN.layer.cornerRadius = 5
        ToolsBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        shieldBTN.layer.borderWidth = 1
        shieldBTN.layer.cornerRadius = 5
        shieldBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        armorBTN.layer.borderWidth = 1
        armorBTN.layer.cornerRadius = 5
        armorBTN.layer.borderColor = UIColor.blackColor().CGColor
        */
        
        ShieldBTNView.layer.borderWidth = 1
        ShieldBTNView.layer.cornerRadius = 5
        ShieldBTNView.layer.borderColor = UIColor.black.cgColor
        ShieldBTNView.clipsToBounds = true
        ShieldBTNView.layer.masksToBounds = true
        
        ArmorBTNView.layer.borderWidth = 1
        ArmorBTNView.layer.cornerRadius = 5
        ArmorBTNView.layer.borderColor = UIColor.black.cgColor
        ArmorBTNView.clipsToBounds = true
        ArmorBTNView.layer.masksToBounds = true
        
        ToolsBTNView.layer.borderWidth = 1
        ToolsBTNView.layer.cornerRadius = 5
        ToolsBTNView.layer.borderColor = UIColor.black.cgColor
        ToolsBTNView.clipsToBounds = true
        ToolsBTNView.layer.masksToBounds = true
        
        DiamondView.layer.borderWidth = 1
        DiamondView.layer.cornerRadius = 5
        DiamondView.layer.borderColor = UIColor.black.cgColor
        DiamondView.clipsToBounds = true
        DiamondView.layer.masksToBounds = true
        
        FlashlightBTNView.layer.borderWidth = 1
        FlashlightBTNView.layer.cornerRadius = 5
        FlashlightBTNView.layer.borderColor = UIColor.black.cgColor
        FlashlightBTNView.clipsToBounds = true
        FlashlightBTNView.layer.masksToBounds = true
        
       // LoadingView.layer.borderWidth = 1
        loadingView.layer.cornerRadius = 5
        //LoadingView.layer.borderColor = UIColor.blackColor().CGColor
        loadingView.clipsToBounds = true
        loadingView.layer.masksToBounds = true
        
        
        CapturePointBTNView.layer.borderWidth = 1
        CapturePointBTNView.layer.cornerRadius = 5
        CapturePointBTNView.layer.borderColor = UIColor.black.cgColor
        CapturePointBTNView.clipsToBounds = true
        CapturePointBTNView.layer.masksToBounds = true
        
        missionBTNView.layer.borderWidth = 1
        missionBTNView.layer.cornerRadius = 5
        missionBTNView.layer.borderColor = UIColor.black.cgColor
        missionBTNView.clipsToBounds = true
        missionBTNView.layer.masksToBounds = true
        
        NewsBTNView.layer.borderWidth = 1
        NewsBTNView.layer.cornerRadius = 5
        NewsBTNView.layer.borderColor = UIColor.black.cgColor
        NewsBTNView.clipsToBounds = true
        NewsBTNView.layer.masksToBounds = true
        
        /*
        if !prefs.boolForKey("TRACKINGON") {
        TrackingOn = checkLocationAuthorizationStatus(LocManager, status: CLLocationManager.authorizationStatus() )
        } else {
            TrackingOn = prefs.boolForKey("TRACKINGON")
        }
        
        */
        let currentZoom = mapView.zoomLevel
       // self.mapView.zoomEnabled = false
       // self.mapView.scrollEnabled = false;
        
       // print("Current Zoom = \(currentZoom)")
        
        
        
        let frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        theView = SCNView(frame: frame)
        theView.scene?.background.contents = UIColor.clear
        //theView.
        theView.overlaySKScene = self.moneyScene
       // theView.scene = self.moneyScene
        SceneView.addSubview(theView)
       // SceneView.addSubview(moneyScene)
      
        /*
        var imageName = "Fist"
        let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
        let theImageData = NSData(contentsOfURL: url)
        FistImage = UIImage(data:theImageData!)!
       */
        
        FistImage = UIImage(named: "Fist.png")!
        
      //  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "ClearSubViewsFromMap")
      //  view.addGestureRecognizer(tap)
        
        StartGoldProduction()
        
        /*
        if prefs.integerForKey("MYHEALTH") < 100 {
        StartHealthProduction()
        }
        
        if prefs.integerForKey("MYSTAMINA") < 100 {
        StartStaminaProduction()
        }
        */
        
       AddWeatherEffect()
        
       
        
    }
    
    func revealLeft(){
        print("reveal left")
    }
    
  //  func AddWeatherEffect(Effect: String, degree: Double) {
        
        
    func AddWeatherEffect() {
        
        
        let EffectsFrame = CGRect(x: 0, y: 0, width: device.width, height: device.height)

      //  EffectSpriteView = SKView(frame: EffectsFrame)
        
        
      //  EffectSpriteView.allowsTransparency = true
     
        
     //EffectSpriteView.backgroundColor = UIColor.clearColor()
        
        
     //  EffectSpriteView.scene?.backgroundColor = UIColor.clearColor()

        //EffectSpriteView.s = self.EffectsScene
        // theView.scene = self.moneyScene
      //  SceneView.addSubview(theView)
       // EffectsScene.backgroundColor = UIColor.clearColor()
      
            
     //   EffectSpriteView.presentScene(EffectsScene)
        
        
        if let scene = EffectsOverlay.unarchiveFromFileEffect("EffectsOverlay") as? EffectsOverlay {
        
       // EffectsSKView.showsFPS = true
       // EffectsSKView.showsNodeCount = true
            
            
       // scene.showsFPS = true
       // scene.showsNodeCount = true
        EffectsSKView.frame = EffectsFrame
        //scene.scaleMode = .AspectFill
        scene.scaleMode = .resizeFill
            
        EffectsSKView.allowsTransparency = true
        EffectsSKView.presentScene(scene)
            
        }
        
        //EffectsSKView.presentScene(EffectsScene)
        // EffectSpriteView.overlaySKScene = self.moneyScene
        
        // theView.scene = self.moneyScene
       // self.MapEffectsView.addSubview(EffectSpriteView)
        
        
        
    }
    
    func MoveClouds(_ Effect: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateClouds"), object: nil, userInfo: ["effect":"\(Effect)"])
    }
    
    func UpdateWeather(_ Effect: String, degree: Double) {
        
         NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMapEffect"), object: nil, userInfo: ["effect":"\(Effect)","degree":"\(degree.description)"])
        
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func StartGoldProduction() {
        var IsGoldProductionFull = Bool()
        var GoldProductionEndTimeTemp = TimeInterval()
        var GoldProductionFullDate = Date()
        // GoldProductionSpeed = 2.0
        GoldProductionSpeedPulse = 2.0
        GoldProductionTimeCount = 60
        
        if prefs.value(forKey: "GOLDPRODUCTIONLIMIT") != nil {
            let GoldProductionLimitString = prefs.value(forKey: "GOLDPRODUCTIONLIMIT") as! String
            GoldProductionLimit = Int(GoldProductionLimitString)!
        } else {
            GoldProductionLimit = 100
        }
        
        
        if prefs.value(forKey: "GOLDPRODUCTIONSPEED") != nil {
            let GoldProductionSpeedString = prefs.value(forKey: "GOLDPRODUCTIONSPEED") as! String
            GoldProductionSpeed = Double(GoldProductionSpeedString)!
        } else {
            GoldProductionSpeed = 2.0
        }
        
        
        
        let GoldProductionSpeedNew = GoldProductionSpeed / GoldProductionBoost
        
        print("Gold Production Speed with Boos = \(GoldProductionSpeedNew)")
        
        let GoldProductionLimitDouble = Double(GoldProductionLimit)
        
        print("GoldProductionLimitDouble: \(GoldProductionLimitDouble)")
        
        
        let HourlyProduction = GoldProductionSpeedNew * 60
        print("Hourly Production = \(HourlyProduction)")
        
        let TimeUntilFull = GoldProductionLimitDouble * GoldProductionSpeedNew
        
        print("Time until full = \(TimeUntilFull)")
        
        
        
        if prefs.value(forKey: "GoldProductionEndTime") != nil {
            if (prefs.value(forKey: "GoldProductionEndTime") as! TimeInterval) != 0 {
                
                GoldProductionEndTimeTemp = prefs.value(forKey: "GoldProductionEndTime") as! TimeInterval
                
            } else {
                
                GoldProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
                
            }
            
        } else {
            
            GoldProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
            
        }
        
        print("Gold Produciton End Time Temp = \(GoldProductionEndTimeTemp)")
        
        
        GoldProductionFullDate = Date(timeIntervalSinceReferenceDate: GoldProductionEndTimeTemp)
        print("Current time = \(Date(timeIntervalSinceReferenceDate: now))")
        print("Gold Production Full Date = \(GoldProductionFullDate)")
        
        let elapsedTime = Date().timeIntervalSince(GoldProductionFullDate)
        
        print("Time until full = \(elapsedTime)")
        
        var ElapsedTimeDouble = Double(elapsedTime)
        
        if ElapsedTimeDouble >= 0 {
            IsGoldProductionFull = true
        } else {
            IsGoldProductionFull = false
        }
        
        
        print("is gold production full = \(IsGoldProductionFull)")
        
        
        if IsGoldProductionFull {
            
            GoldProductionAmount = GoldProductionLimit
            
            
            let tempProgress: Float = Float(GoldProductionAmount) / 100
            
            if tempProgress < 0.3 {
                self.moneyProgressView.fillDoneColor = UIColor.red
            } else if tempProgress > 0.85 {
                self.moneyProgressView.fillDoneColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0) //UIColor.greenColor()
            } else {
                self.moneyProgressView.fillDoneColor = UIColor.orange
            }
            
            self.moneyProgressView.setProgress(tempProgress, animated: true)
            
            
            
            
        } else {
            
            GoldProductionAmount = 0
            
            let SecondsUntilFull = TimeUntilFull + ElapsedTimeDouble
            
            GoldProductionTimeCount = TimeInterval(SecondsUntilFull)
            
            print("Seconds until full = \(SecondsUntilFull)")
            
            let GoldProductionAmountDouble = SecondsUntilFull / GoldProductionSpeed
            print("Gold Prod Double = \(GoldProductionAmountDouble)")
            let GoldProdRound = round(GoldProductionAmountDouble)
            print("Gold Prod Round = \(GoldProdRound)")
            GoldProductionAmount = Int(GoldProdRound)
            
            if GoldProductionAmount >= GoldProductionLimit {
                GoldProductionAmount = GoldProductionLimit
            }
            
            print("GoldProduction Amount Final = \(GoldProductionAmount)")
            print("Updated Gold Production Time count = \(GoldProductionTimeCount)")
            
            
            let aSelector: Selector = #selector(MapViewController.UpdateGoldProductionTime)
            self.GoldProductionTimer = Timer.scheduledTimer(timeInterval: GoldProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
            
            self.GoldProductionStartTime = Date.timeIntervalSinceReferenceDate
            
            
        }
        
        
        print("Current Gold Amount = \(GoldProductionAmount)")
        
        
        
        
        
        
        
        //  let start = NSDate()
        //   let enddt = NSDate()
        //   let calendar = NSCalendar.currentCalendar()
        //  let datecomponenets = calendar.components(NSCalendarUnit.NSSecondCalendarUnit, fromDate: start, toDate: enddt, options: nil)
        //  let seconds = datecomponenets.second
        //   print("Seconds: \(seconds)")
        
        // self.moneyBankUpgrading = true
        //  self.itemTimerView3.hidden = false
        //  self.HelmetTimeCount = CompleteTimeTemp
        
        
        
        
        
        
        
        //  GoldProductionEndTime = NSTimeInterval(TimeUntilFull)
        
        //  print("Gold Production end = \(GoldProductionEndTime)")
        
        //   let GoldProductionEndTimeFinal = now + GoldProductionEndTime
        
        
        
        
        prefs.setValue(GoldProductionEndTimeTemp, forKey: "GoldProductionEndTime")
        
        
        
        /*
         let aSelector: Selector = "UpdateGoldProductionTime"
         self.GoldProductionTimer = NSTimer.scheduledTimerWithTimeInterval(GoldProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
         
         self.GoldProductionStartTime = NSDate.timeIntervalSinceReferenceDate()
         */
        
        
        
        
        let aSelectorPulse: Selector = #selector(MapViewController.UpdateGoldProductionTimePulse)
        self.GoldProductionTimerPulse = Timer.scheduledTimer(timeInterval: GoldProductionSpeedPulse, target: self, selector: aSelectorPulse, userInfo: ["totalTime":"60"], repeats: true)
        
        self.GoldProductionEndTime = Date.timeIntervalSinceReferenceDate
        
        
        
    }
    
    
    func StartHealthProduction() {
        
        
        let myhealth = prefs.integer(forKey: "MYHEALTH")
        let myhealthDouble = Double(myhealth)
        print("my health double = \(myhealthDouble)")
        
        let healthprogresstemp = myhealthDouble / 100
        
        print("my health temp = \(healthprogresstemp)")
        
        healthprogress = Float(healthprogresstemp)
        
        self.healthProgressView.setProgress(healthprogress, animated: true)
        
        self.healthLBL.text = "\(myhealth.description).0"
        
        
        
        var IsHealthProductionFull = Bool()
        var HealthProductionEndTimeTemp = TimeInterval()
        var HealthProductionFullDate = Date()
        // GoldProductionSpeed = 2.0
        HealthProductionSpeedPulse = 2.0
        HealthProductionTimeCount = 60
        
        let mystaminaprogressTemp = prefs.integer(forKey: "MYHEALTH")
        
        HealthProductionAmount = mystaminaprogressTemp
        
        print("Producing Health: current health = \(mystaminaprogressTemp)")
        
        let myhealthprogressTempDouble = Double(mystaminaprogressTemp)
        
        if prefs.value(forKey: "HEALTHPRODUCTIONLIMIT") != nil {
            let HealthProductionLimitString = prefs.value(forKey: "HEALTHPRODUCTIONLIMIT") as! String
            HealthProductionLimit = Int(HealthProductionLimitString)!
        } else {
            HealthProductionLimit = 100
        }
        
        
        if prefs.value(forKey: "HEALTHPRODUCTIONSPEED") != nil {
            let HealthProductionSpeedString = prefs.value(forKey: "HEALTHPRODUCTIONSPEED") as! String
            HealthProductionSpeed = Double(HealthProductionSpeedString)!
        } else {
            HealthProductionSpeed = 2.0
        }
        
       // HealthProductionSpeed = 1.0
        
        print("Health production speed first: \(HealthProductionSpeed)")
        let HealthProductionSpeedNew = HealthProductionSpeed / HealthProductionBoost
        
        print("Health Production Speed with Boos = \(HealthProductionSpeedNew)")
        
        let HealthProductionLimitDouble = Double(HealthProductionLimit) - myhealthprogressTempDouble
        
        print("HealthProductionLimitDouble: \(HealthProductionLimitDouble)")
        
        
        let HourlyProduction = HealthProductionSpeedNew * 60
        print("health Hourly Production = \(HourlyProduction)")
        
        let TimeUntilFull = HealthProductionLimitDouble * HealthProductionSpeedNew
        
        print("Time until full = \(TimeUntilFull)")
        
        
        
        if prefs.value(forKey: "HealthProductionEndTime") != nil {
            if (prefs.value(forKey: "HealthProductionEndTime") as! TimeInterval) != 0 {
                
               // HealthProductionEndTimeTemp = prefs.valueForKey("HealthProductionEndTime") as! NSTimeInterval
               // HealthProductionEndTimeTemp = now + NSTimeInterval(TimeUntilFull)
                
                
                
                if (prefs.value(forKey: "HealthProductionEndTime") as! TimeInterval) > now {
                    
                    HealthProductionEndTimeTemp = prefs.value(forKey: "HealthProductionEndTime") as! TimeInterval
                    
                } else {
                    
                    
                    
                    HealthProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
                    prefs.setValue(HealthProductionEndTimeTemp, forKey: "HealthProductionEndTime")
                    
                }
                
                
            } else {
                
                HealthProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
                
            }
            
        } else {
            
            HealthProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
            
        }
        
        print("Health Produciton End Time Temp = \(HealthProductionEndTimeTemp)")
        
        
        HealthProductionFullDate = Date(timeIntervalSinceReferenceDate: HealthProductionEndTimeTemp)
        print("Current time = \(Date(timeIntervalSinceReferenceDate: now))")
        print("Health Production Full Date = \(HealthProductionFullDate)")
        
        let elapsedTime = Date().timeIntervalSince(HealthProductionFullDate)
        
        print("Time until full = \(elapsedTime)")
        
        GetTimeComplete(elapsedTime)
        
        var ElapsedTimeDouble = Double(elapsedTime)
        
        if ElapsedTimeDouble >= 0 {
            IsHealthProductionFull = true
        } else {
            IsHealthProductionFull = false
        }
        
        if prefs.integer(forKey: "MYHEALTH") >= 100 {
            IsHealthProductionFull = true
        } else {
            IsHealthProductionFull = false
        }
        
        print("is Health production full = \(IsHealthProductionFull)")
        
        
        /*
        var elapsedTimeTemp = NSDate().timeIntervalSinceDate(HealthProductionFullDate)
        let minutes = elapsedTime / 60.0
        elapsedTimeTemp -= (NSTimeInterval(minutes) * 60)
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTimeTemp)
        elapsedTimeTemp -= NSTimeInterval(seconds)
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTimeTemp * 100)
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        print("TIME COMPLETE STRING: \(strMinutes) \(strSeconds) \(strFraction)")
        
        
        */
        
        
        
        
        
        if IsHealthProductionFull {
            
            HealthProductionAmount = HealthProductionLimit
            
            
           // let tempProgress: Float = Float(HealthProductionAmount) / 100
            
            
            /*
            if tempProgress < 0.3 {
                self.healthProgressView.fillDoneColor = UIColor.redColor()
            } else if tempProgress > 0.85 {
                self.healthProgressView.fillDoneColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0) //UIColor.greenColor()
            } else {
                self.healthProgressView.fillDoneColor = UIColor.orangeColor()
            }
            */
            
           // self.healthProgressView.fillDoneColor = UIColor.redColor()
          //  self.healthProgressView.setProgress(tempProgress, animated: true)
            
            
            
           // let myhealth = prefs.integerForKey("MYHEALTH")
            let myhealthDouble = Double(HealthProductionAmount)
            print("my health double = \(myhealthDouble)")
            
            let healthprogresstemp = myhealthDouble / 100
            
            print("my health temp = \(healthprogresstemp)")
            
            healthprogress = Float(healthprogresstemp)
            
            
            
        } else {
            
            HealthProductionAmount = prefs.integer(forKey: "MYHEALTH")
            
           // healthprogress = HealthProductionAmount
            var SecondsUntilFull = TimeUntilFull + ElapsedTimeDouble
            
            HealthProductionTimeCount = TimeInterval(SecondsUntilFull)
            
            print("Seconds until full = \(SecondsUntilFull)")
            
            if SecondsUntilFull < 0 {
                SecondsUntilFull = SecondsUntilFull * -1
            }
            
            let HealthProductionAmountDouble = SecondsUntilFull / HealthProductionSpeed
            print("Health Prod Double = \(HealthProductionAmountDouble)")
            let HealthProdRound = round(HealthProductionAmountDouble)
            print("Health Prod Round = \(HealthProdRound)")
           // HealthProductionAmount = Int(HealthProdRound)
            
           
            if HealthProductionAmount >= HealthProductionLimit {
                HealthProductionAmount = HealthProductionLimit
            }
 
            
           
            
            
            
            print("healthProduction Amount Final = \(HealthProductionAmount)")
            print("Updated health Production Time count = \(HealthProductionTimeCount)")
            
            
            let aSelector: Selector = #selector(MapViewController.UpdateHealthProductionTime)
            self.HealthProductionTimer = Timer.scheduledTimer(timeInterval: HealthProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60","current":"\(mystaminaprogressTemp.description)"], repeats: true)
            
            self.HealthProductionStartTime = Date.timeIntervalSinceReferenceDate
            
            
        }
        
        
        print("Current health Amount = \(HealthProductionAmount)")
        
        
        
        
        
        
        
        //  let start = NSDate()
        //   let enddt = NSDate()
        //   let calendar = NSCalendar.currentCalendar()
        //  let datecomponenets = calendar.components(NSCalendarUnit.NSSecondCalendarUnit, fromDate: start, toDate: enddt, options: nil)
        //  let seconds = datecomponenets.second
        //   print("Seconds: \(seconds)")
        
        // self.moneyBankUpgrading = true
        //  self.itemTimerView3.hidden = false
        //  self.HelmetTimeCount = CompleteTimeTemp
        
        
        
        
        
        
        
        //  GoldProductionEndTime = NSTimeInterval(TimeUntilFull)
        
        //  print("Gold Production end = \(GoldProductionEndTime)")
        
        //   let GoldProductionEndTimeFinal = now + GoldProductionEndTime
        
        
        
        
        prefs.setValue(HealthProductionEndTimeTemp, forKey: "HealthProductionEndTime")
        
        
        
        /*
         let aSelector: Selector = "UpdateGoldProductionTime"
         self.GoldProductionTimer = NSTimer.scheduledTimerWithTimeInterval(GoldProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
         
         self.GoldProductionStartTime = NSDate.timeIntervalSinceReferenceDate()
         */
        
        
        /*
         
         let aSelectorPulse: Selector = "UpdateHealthProductionTimePulse"
         self.HealthProductionTimerPulse = NSTimer.scheduledTimerWithTimeInterval(HealthProductionSpeedPulse, target: self, selector: aSelectorPulse, userInfo: ["totalTime":"60"], repeats: true)
         
         self.HealthProductionEndTime = NSDate.timeIntervalSinceReferenceDate()
         
         */
        
    }
    
    func StartStaminaProduction() {
        
        
        
        let myhealth = prefs.integer(forKey: "MYSTAMINA")
        print("prod My stamina = \(myhealth)")
        let myhealthDouble = Double(myhealth)
        print("prod my stamina double = \(myhealthDouble)")
        
        let healthprogresstemp = myhealthDouble / 100
        
        print("my stamina temp = \(healthprogresstemp)")
        
        staminaprogress = Float(healthprogresstemp)
        
        
       // staminaprogress = Float(prefs.integerForKey("MYSTAMINA") / 100)
        //staminaprogress = (prefs.integerForKey("MYSTAMINA") / 100)
        
        self.staminaProgressView.setProgress(staminaprogress, animated: true)
        self.staminaLBL.text = "\(myhealth.description).0"
        
        
        
        
        
        var IsStaminaProductionFull = Bool()
        var StaminaProductionEndTimeTemp = TimeInterval()
        var StaminaProductionFullDate = Date()
       // GoldProductionSpeed = 2.0
        StaminaProductionSpeedPulse = 2.0
        StaminaProductionTimeCount = 60
        
        
        let mystaminaprogressTemp = prefs.integer(forKey: "MYSTAMINA")
        let mystaminaprogressTempDouble = Double(mystaminaprogressTemp)
        
        StaminaProductionAmount = mystaminaprogressTemp
        
        if prefs.value(forKey: "STAMINAPRODUCTIONLIMIT") != nil {
            let StaminaProductionLimitString = prefs.value(forKey: "STAMINAPRODUCTIONLIMIT") as! String
            StaminaProductionLimit = Int(StaminaProductionLimitString)!
        } else {
            StaminaProductionLimit = 100
        }
        
        
        if prefs.value(forKey: "STAMINAPRODUCTIONSPEED") != nil {
            let StaminaProductionSpeedString = prefs.value(forKey: "STAMINAPRODUCTIONSPEED") as! String
            StaminaProductionSpeed = Double(StaminaProductionSpeedString)!
        } else {
            StaminaProductionSpeed = 2.0
        }

        print("Stamina Product speed = \(StaminaProductionSpeed)")
        
        let StaminaProductionSpeedNew = StaminaProductionSpeed / StaminaProductionBoost
        
        print("Stamina Production Speed with Boos = \(StaminaProductionSpeedNew)")
        
        let StaminaProductionLimitDouble = Double(StaminaProductionLimit - mystaminaprogressTemp)
        
        print("StaminaProductionLimitDouble: \(StaminaProductionLimitDouble)")
        
        
        let HourlyProduction = StaminaProductionSpeedNew * 60
        print("stamina Hourly Production = \(HourlyProduction)")
        
        let TimeUntilFull = StaminaProductionLimitDouble * StaminaProductionSpeedNew
        
        print("Time until full = \(TimeUntilFull)")
        
        
        
        if prefs.value(forKey: "StaminaProductionEndTime") != nil {
            if (prefs.value(forKey: "StaminaProductionEndTime") as! TimeInterval) != 0 {
            
            //StaminaProductionEndTimeTemp = prefs.valueForKey("StaminaProductionEndTime") as! NSTimeInterval
            
                if (prefs.value(forKey: "StaminaProductionEndTime") as! TimeInterval) > now {
                    StaminaProductionEndTimeTemp = prefs.value(forKey: "StaminaProductionEndTime") as! TimeInterval
                    
                } else {
                    
                    
                    
                    StaminaProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
                    prefs.setValue(StaminaProductionEndTimeTemp, forKey: "StaminaProductionEndTime")
                    
                }
                
            } else {
                
            StaminaProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
                
            }
            
        } else {
        
          StaminaProductionEndTimeTemp = now + TimeInterval(TimeUntilFull)
            
        }
        
        print("Stamina Produciton End Time Temp = \(StaminaProductionEndTimeTemp)")
        
        
        StaminaProductionFullDate = Date(timeIntervalSinceReferenceDate: StaminaProductionEndTimeTemp)
        print("Current time = \(Date(timeIntervalSinceReferenceDate: now))")
        print("Stamina Production Full Date = \(StaminaProductionFullDate)")
        
        let elapsedTime = Date().timeIntervalSince(StaminaProductionFullDate)
        
        print("Time until full stamina = \(elapsedTime)")
        
        var ElapsedTimeDouble = Double(elapsedTime)
        
        if ElapsedTimeDouble >= 0 {
            IsStaminaProductionFull = true
        } else {
            IsStaminaProductionFull = false
        }
        
        if prefs.integer(forKey: "MYSTAMINA") >= 100 {
            IsStaminaProductionFull = true
        } else {
            IsStaminaProductionFull = false
        }
        
        
        print("is Stamina production full = \(IsStaminaProductionFull)")
        
        
        if IsStaminaProductionFull {
            
            StaminaProductionAmount = StaminaProductionLimit
            
            
           // let tempProgress: Float = Float(StaminaProductionAmount) / 100
            
            /*
            if tempProgress < 0.3 {
                self.staminaProgressView.fillDoneColor = UIColor.redColor()
            } else if tempProgress > 0.85 {
                self.staminaProgressView.fillDoneColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0) //UIColor.greenColor()
            } else {
                self.staminaProgressView.fillDoneColor = UIColor.orangeColor()
            }
            
            */
            
           // self.staminaProgressView.setProgress(tempProgress, animated: true)
            
            
            
           // let myhealth = prefs.integerForKey("MYSTAMINA")
            print("prod My stamina = \(StaminaProductionAmount)")
            let myhealthDouble = Double(StaminaProductionAmount)
            print("prod my stamina double = \(myhealthDouble)")
            
            let healthprogresstemp = myhealthDouble / 100
            
            print("my stamina temp = \(healthprogresstemp)")
            
            staminaprogress = Float(healthprogresstemp)
            
            
            // staminaprogress = Float(prefs.integerForKey("MYSTAMINA") / 100)
            //staminaprogress = (prefs.integerForKey("MYSTAMINA") / 100)
            
            self.staminaProgressView.setProgress(staminaprogress, animated: true)
            
            
            
            
            
        } else {
            
            StaminaProductionAmount = prefs.integer(forKey: "MYSTAMINA")
            
            let SecondsUntilFull = TimeUntilFull + ElapsedTimeDouble
            
            StaminaProductionTimeCount = TimeInterval(SecondsUntilFull)
            
            print("Seconds until full = \(SecondsUntilFull)")
            
            let StaminaProductionAmountDouble = SecondsUntilFull / StaminaProductionSpeed
            print("stamina Prod Double = \(StaminaProductionAmountDouble)")
            let StaminaProdRound = round(StaminaProductionAmountDouble)
            print("stamina Prod Round = \(StaminaProdRound)")
            
           
           // StaminaProductionAmount = Int(StaminaProdRound)
            
            
            if StaminaProductionAmount >= StaminaProductionLimit {
                StaminaProductionAmount = StaminaProductionLimit
            } 
            
            print("GoldProduction Amount Final = \(StaminaProductionAmount)")
            print("Updated Gold Production Time count = \(StaminaProductionTimeCount)")
            
            
            let aSelector: Selector = #selector(MapViewController.UpdateStaminaProductionTime)
            self.StaminaProductionTimer = Timer.scheduledTimer(timeInterval: StaminaProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60","current":"\(mystaminaprogressTemp.description)"], repeats: true)
            
            self.StaminaProductionStartTime = Date.timeIntervalSinceReferenceDate
            
            
        }
        
        
        print("Current Stamina Amount = \(StaminaProductionAmount)")
        
        
        
        
       
        
        
      //  let start = NSDate()
     //   let enddt = NSDate()
     //   let calendar = NSCalendar.currentCalendar()
      //  let datecomponenets = calendar.components(NSCalendarUnit.NSSecondCalendarUnit, fromDate: start, toDate: enddt, options: nil)
      //  let seconds = datecomponenets.second
     //   print("Seconds: \(seconds)")
        
       // self.moneyBankUpgrading = true
      //  self.itemTimerView3.hidden = false
      //  self.HelmetTimeCount = CompleteTimeTemp
        
       
        
        
        
        
        
      //  GoldProductionEndTime = NSTimeInterval(TimeUntilFull)
        
      //  print("Gold Production end = \(GoldProductionEndTime)")
        
     //   let GoldProductionEndTimeFinal = now + GoldProductionEndTime
        
        
        
        
        prefs.setValue(StaminaProductionEndTimeTemp, forKey: "StaminaProductionEndTime")
        
        
        
        /*
        let aSelector: Selector = "UpdateGoldProductionTime"
        self.GoldProductionTimer = NSTimer.scheduledTimerWithTimeInterval(GoldProductionSpeed, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
        
        self.GoldProductionStartTime = NSDate.timeIntervalSinceReferenceDate()
        */
        
        
        /*
        
        let aSelectorPulse: Selector = "UpdateHealthProductionTimePulse"
        self.HealthProductionTimerPulse = NSTimer.scheduledTimerWithTimeInterval(HealthProductionSpeedPulse, target: self, selector: aSelectorPulse, userInfo: ["totalTime":"60"], repeats: true)

        self.HealthProductionEndTime = NSDate.timeIntervalSinceReferenceDate()
        
        */
        
    }
    
    func GetTimeComplete(_ elapsedTime: TimeInterval) {
        
        
        print("GET TIME COMPLETE:  elapsed time = \(elapsedTime)")
        
        var CompleteTimeString = String()
        
        let elapsedTimeTemp = elapsedTime * -1
        
        let seconds = elapsedTimeTemp
      //  print("Complete Tiem Seconds: \(seconds)")
        
        let mins = seconds / 60
       // print("Complete Time mins: \(mins)")
        let hrs = mins / 60
      //  print("Complete Time hours: \(hrs)")
        
        
       // let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
      //  let strHour = String(format: "%02d", hrs)
      //  let strMinutes = String(format: "%02d", mins)
      //  let strSeconds = String(format: "%02d", seconds)
        
        let strHour = String(format: "%02d", hrs)
        let strMinutes = String(format: "%02d", mins)
        let strSeconds = String(format: "%02d", seconds)
       // let strFraction = String(format: "%02d", fraction)
        /*
        if hrs > 1 {
             CompleteTimeString = "\(strHour) hrs \(strMinutes) mins \(strSeconds) secs"
        } else {
            
            if mins > 1 {
             CompleteTimeString = "\(strMinutes) mins \(strSeconds) secs"
            } else {
            CompleteTimeString = "\(strSeconds) secs"
            }
            
        }
        */
        
        
        
        if hrs > 1 {
            
            let minsTemp = mins - (round(hrs) * 60)
            let secsTemp = seconds - (round(mins) * 60)
            
            CompleteTimeString = "\(round(hrs)) hrs \(round(minsTemp)) mins \(round(secsTemp)) secs"
        } else {
            
            if mins > 1 {
                let secsTemp = seconds - (round(mins) * 60)
                let secs2 = round(secsTemp)
                let mins2 = round(mins)
                CompleteTimeString = "\(round(mins)) mins \(round(secsTemp)) secs"
            } else {
                CompleteTimeString = "\(round(seconds)) secs"
            }
            
        }
        
        print("COMPLETE TIME STRING: \(CompleteTimeString)")
        
    }
    
    @objc func UpdateGoldProductionTimePulse() {
        
        MoneyPulse(moneyProgressView, scale:1.3)
        
    }
    
    @objc func UpdateGoldProductionTime(){
        //  var item = "Helmet"
        //   var itemKey = "ARMORLEVELHELMET"
        
        var currentTime = Date.timeIntervalSinceReferenceDate
        
        //  print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - GoldProductionStartTime
        
        
        //GoldProductionAmount = GoldProductionAmount + 1
        
        //  GoldProductionLimit = 100
        
        
        let tempProgress: Float = Float(GoldProductionAmount) / 100
        
        if tempProgress < 0.3 {
            self.moneyProgressView.fillDoneColor = UIColor.red
        } else if tempProgress > 0.85 {
            self.moneyProgressView.fillDoneColor = UIColor.green
        } else {
            self.moneyProgressView.fillDoneColor = UIColor.orange
        }
        
        self.moneyProgressView.setProgress(tempProgress, animated: true)
        
        
        
        
        
        //  self.GoldProductionAmountLBL.text = "\(GoldProductionAmount.description)"
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
        
        
        GoldProductionTimeCount = GoldProductionTimeCount - GoldProductionTimeInterval
        
        
        
        
        //  if GoldProductionTimeCount <= 0 {
        
        //if GoldProductionAmount >= (GoldProductionLimit / 3) {
        
        if GoldProductionAmount >= 5 {
            // self.GoldAmountLBLView.hidden = false
            /*
             
             if !GoldLBLViewShown {
             
             let animationDuration = 0.35
             
             UIView.animateWithDuration(animationDuration, animations: { () -> Void in
             
             }) { (completion) -> Void in
             
             self.GoldAmountView.hidden = false
             
             self.GoldAmountView.transform = CGAffineTransformScale(self.GoldAmountView.transform, 0.001, 0.001)
             
             UIView.animateWithDuration(animationDuration, animations: { () -> Void in
             self.GoldAmountView.transform = CGAffineTransformIdentity
             })
             
             
             }
             GoldLBLViewShown = true
             
             
             }
             
             */
            
            if !GoldLBLShown {
                
                let animationDuration = 0.35
                
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    
                }, completion: { (completion) -> Void in
                    
                    self.GoldAmountLBLView.isHidden = false
                    
                    self.GoldAmountLBLView.transform = self.GoldAmountLBLView.transform.scaledBy(x: 0.001, y: 0.001)
                    
                    UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                        self.GoldAmountLBLView.transform = CGAffineTransform.identity
                    })
                    
                    
                }) 
                
                GoldLBLShown = true
                
            }
        }
        
        
        if GoldProductionAmount >= GoldProductionLimit {
            
            if GoldProductionAmount == GoldProductionLimit {
                self.GoldProductionAmountLBL.text = "\(GoldProductionAmount.description)"
            }
            
            // print("\(item) has been upgraded")
            //itemTimerView3.hidden = true
            //self.HelmetUpgrading = false
            GoldProductionTimer.invalidate()
            //self.GoldAmountLBLView.hidden = true
            
            
            
            print("Over Gold Production Limit")
            
            // let CurrentLevelTemp = prefs.valueForKey(itemKey)
            //  let CurrentLevel = Int(CurrentLevelTemp as! String)
            //  let NextLevel = CurrentLevel! + 1
            
            // self.prefs.setValue(NextLevel.description, forKey: itemKey)
            //self.itemView3LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
            
            
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            /*
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Upgrade Complete!"
             alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             self.NumberItemsUpgrading--
             NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
             */
            
            
            
        } else {
            
            MoneyPulse(moneyProgressView, scale:1.3)
            
            /*
             let tempProgress: Float = Float(GoldProductionAmount) / 100
             
             self.moneyProgressView.setProgress(tempProgress, animated: true)
             
             if tempProgress < 0.3 {
             self.moneyProgressView.fillDoneColor = UIColor.redColor()
             } else if tempProgress > 0.85 {
             self.moneyProgressView.fillDoneColor = UIColor.greenColor()
             } else {
             self.moneyProgressView.fillDoneColor = UIColor.orangeColor()
             }
             */
            
            
            
            self.GoldProductionAmountLBL.text = "\(GoldProductionAmount.description)"
            GoldProductionAmount = GoldProductionAmount + 1
            // MoneyPulse(GoldContainerView)
            //  item3TimerLBL.text = timeString(HelmetTimeCount)
            
        }
        
    }
    
    @objc func UpdateStaminaProductionTime(){
        //  var item = "Helmet"
        //   var itemKey = "ARMORLEVELHELMET"
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //  print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - StaminaProductionStartTime
        
        
        //GoldProductionAmount = GoldProductionAmount + 1
        
        //  GoldProductionLimit = 100
        
        
        let tempProgress: Float = Float(StaminaProductionAmount) / 100
        
        
        /*
        if tempProgress < 0.3 {
            self.staminaProgressView.fillDoneColor = UIColor.redColor()
        } else if tempProgress > 0.85 {
            self.staminaProgressView.fillDoneColor = UIColor.greenColor()
        } else {
            self.staminaProgressView.fillDoneColor = UIColor.orangeColor()
        }
        
        */
        
        self.staminaProgressView.setProgress(tempProgress, animated: true)
        
        
        
        
        
        //  self.GoldProductionAmountLBL.text = "\(GoldProductionAmount.description)"
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
        
        
        StaminaProductionTimeCount = StaminaProductionTimeCount - StaminaProductionTimeInterval
        
        
        
        
        //  if GoldProductionTimeCount <= 0 {
        
        //if GoldProductionAmount >= (GoldProductionLimit / 3) {
        
        if StaminaProductionAmount >= 5 {
            // self.GoldAmountLBLView.hidden = false
            /*
             
             if !GoldLBLViewShown {
             
             let animationDuration = 0.35
             
             UIView.animateWithDuration(animationDuration, animations: { () -> Void in
             
             }) { (completion) -> Void in
             
             self.GoldAmountView.hidden = false
             
             self.GoldAmountView.transform = CGAffineTransformScale(self.GoldAmountView.transform, 0.001, 0.001)
             
             UIView.animateWithDuration(animationDuration, animations: { () -> Void in
             self.GoldAmountView.transform = CGAffineTransformIdentity
             })
             
             
             }
             GoldLBLViewShown = true
             
             
             }
             
             */
            
            
            /*
            if !GoldLBLShown {
                
                let animationDuration = 0.35
                
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    
                }) { (completion) -> Void in
                    
                    self.GoldAmountLBLView.hidden = false
                    
                    self.GoldAmountLBLView.transform = CGAffineTransformScale(self.GoldAmountLBLView.transform, 0.001, 0.001)
                    
                    UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                        self.GoldAmountLBLView.transform = CGAffineTransformIdentity
                    })
                    
                    
                }
                
                GoldLBLShown = true
                
            }
            
            */
        }
        
        
        if StaminaProductionAmount >= StaminaProductionLimit {
            
            if StaminaProductionAmount == StaminaProductionLimit {
                self.staminaLBL.text = "\(StaminaProductionAmount.description).0"
                
                let UpdatedHealthStamina = SaveUsersHealthStamina("stamina", level: StaminaProductionAmount, emailID: self.email)
                print("Stamina was updated = \(StaminaProductionAmount)")
            }
            
            // print("\(item) has been upgraded")
            //itemTimerView3.hidden = true
            //self.HelmetUpgrading = false
            StaminaProductionTimer.invalidate()
            //self.GoldAmountLBLView.hidden = true
            
            
            
            print("Over Stamina Production Limit")
            
            // let CurrentLevelTemp = prefs.valueForKey(itemKey)
            //  let CurrentLevel = Int(CurrentLevelTemp as! String)
            //  let NextLevel = CurrentLevel! + 1
            
            // self.prefs.setValue(NextLevel.description, forKey: itemKey)
            //self.itemView3LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
            
            
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            /*
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Upgrade Complete!"
             alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             self.NumberItemsUpgrading--
             NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
             */
            
            
            
        } else {
            
           // MoneyPulse(moneyProgressView, scale:1.3)
            
            
             let tempProgress: Float = Float(StaminaProductionAmount) / 100
             
             self.staminaProgressView.setProgress(tempProgress, animated: true)
             
             /*
             if tempProgress < 0.3 {
             self.moneyProgressView.fillDoneColor = UIColor.redColor()
             } else if tempProgress > 0.85 {
             self.moneyProgressView.fillDoneColor = UIColor.greenColor()
             } else {
             self.moneyProgressView.fillDoneColor = UIColor.orangeColor()
             }
             */
            
            
            
            self.staminaLBL.text = "\(StaminaProductionAmount.description).0"
            StaminaProductionAmount = StaminaProductionAmount + 1
            
            
            self.prefs.set(StaminaProductionAmount, forKey: "MYSTAMINA")
            staminaprogress = Float(StaminaProductionAmount) / 100

            
            let UpdatedHealthStamina = SaveUsersHealthStamina("stamina", level: StaminaProductionAmount, emailID: self.email)
            print("Stamina was updated = \(StaminaProductionAmount)")
            // MoneyPulse(GoldContainerView)
            //  item3TimerLBL.text = timeString(HelmetTimeCount)
            
        }
        
    }
    
    @objc func UpdateHealthProductionTime(){
      //  var item = "Helmet"
     //   var itemKey = "ARMORLEVELHELMET"
        
        var currentTime = Date.timeIntervalSinceReferenceDate
        
        //  print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - HealthProductionStartTime
        
        
       //GoldProductionAmount = GoldProductionAmount + 1
        
      //  GoldProductionLimit = 100
        
        
        let tempProgress: Float = Float(HealthProductionAmount) / 100
        
        /*
        if tempProgress < 0.3 {
            self.healthProgressView.fillDoneColor = UIColor.redColor()
        } else if tempProgress > 0.85 {
             self.healthProgressView.fillDoneColor = UIColor.greenColor()
        } else {
             self.healthProgressView.fillDoneColor = UIColor.orangeColor()
        }
        */
        
       // self.healthProgressView.fillDoneColor = UIColor.redColor()
        self.healthProgressView.setProgress(tempProgress, animated: true)
        
        
       
        
        
      //  self.GoldProductionAmountLBL.text = "\(GoldProductionAmount.description)"
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
        
        
        HealthProductionTimeCount = HealthProductionTimeCount - HealthProductionTimeInterval
        
        
        
        
      //  if GoldProductionTimeCount <= 0 {
        
        //if GoldProductionAmount >= (GoldProductionLimit / 3) {
            
        if HealthProductionAmount >= 5 {
          // self.GoldAmountLBLView.hidden = false
            /*
            
            if !GoldLBLViewShown {
                
                let animationDuration = 0.35
                
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    
                }) { (completion) -> Void in
                    
                    self.GoldAmountView.hidden = false
                    
                    self.GoldAmountView.transform = CGAffineTransformScale(self.GoldAmountView.transform, 0.001, 0.001)
                    
                    UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                        self.GoldAmountView.transform = CGAffineTransformIdentity
                    })
                    
                    
                }
                GoldLBLViewShown = true
               
                
            }
            
            */
            
            
            /*
            if !GoldLBLShown {
            
            let animationDuration = 0.35
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                
            }) { (completion) -> Void in

            self.GoldAmountLBLView.hidden = false
            
            self.GoldAmountLBLView.transform = CGAffineTransformScale(self.GoldAmountLBLView.transform, 0.001, 0.001)
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.GoldAmountLBLView.transform = CGAffineTransformIdentity
            })
            
            
            }
                
                GoldLBLShown = true
            
            }
            
            */
        }
        
            
        if HealthProductionAmount >= HealthProductionLimit {
            
            
            
            if HealthProductionAmount == HealthProductionLimit {
                self.healthLBL.text = "\(HealthProductionAmount.description).0"
                
                let UpdatedHealthStamina = SaveUsersHealthStamina("health", level: HealthProductionAmount, emailID: self.email)
              //  print("Stamina was updated = \(UpdatedHealthStamina)")
            }
            
            
           // print("\(item) has been upgraded")
            //itemTimerView3.hidden = true
            //self.HelmetUpgrading = false
            HealthProductionTimer.invalidate()
            //self.GoldAmountLBLView.hidden = true
            
            
            
            print("Over Health Production Limit")
            
           // let CurrentLevelTemp = prefs.valueForKey(itemKey)
          //  let CurrentLevel = Int(CurrentLevelTemp as! String)
          //  let NextLevel = CurrentLevel! + 1
            
           // self.prefs.setValue(NextLevel.description, forKey: itemKey)
            //self.itemView3LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
            
            
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Upgrade Complete!"
            alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            self.NumberItemsUpgrading--
            NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
            */
            
            
            
        } else {
            
         //   MoneyPulse(moneyProgressView, scale:1.3)
            
            
            let tempProgress: Float = Float(HealthProductionAmount) / 100
            
            self.healthProgressView.setProgress(tempProgress, animated: true)
            
            /*
            if tempProgress < 0.3 {
                self.moneyProgressView.fillDoneColor = UIColor.redColor()
            } else if tempProgress > 0.85 {
                self.moneyProgressView.fillDoneColor = UIColor.greenColor()
            } else {
                self.moneyProgressView.fillDoneColor = UIColor.orangeColor()
            }
*/
            
            
            
            self.healthLBL.text = "\(HealthProductionAmount.description).0"
            HealthProductionAmount = HealthProductionAmount + 1
            self.prefs.set(HealthProductionAmount, forKey: "MYHEALTH")
            healthprogress = Float(HealthProductionAmount) / 100
            
            
            let UpdatedHealthStamina = SaveUsersHealthStamina("health", level: HealthProductionAmount, emailID: self.email)
            print("health was updated = \(UpdatedHealthStamina)")
           // MoneyPulse(GoldContainerView)
          //  item3TimerLBL.text = timeString(HelmetTimeCount)
            
        }
        
    }
    
    @IBAction func ShowGoldProductionInfo(_ sender: AnyObject) {
        
        
        let isupgradingTemp = false
        let upgradeAmountTemp = "2000"
        let upgradeNowAmountTemp = "15"
        
        ShowItemInfoMenu(3, IsUpgrading: isupgradingTemp, itemCategory: "GoldProduction", upgradeAmount: upgradeAmountTemp, upgradeNowAmount: upgradeNowAmountTemp)
        
        
    }
    
    @IBAction func ShowGoldProductionInfoStats(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "..Development in process"
        alertView.delegate = self
        
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    

    
    
    @IBAction func CollectGoldProduction(_ sender: AnyObject) {
        
        /*
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = dispatch_time(DISPATCH_TIME_NOW, Int64(delayLoad))
        
        self.GoldCollectedAmountLBL.text = "+\(GoldProductionAmount.description)"
        
        self.GoldCollectedLBLView.hidden = false
        
        self.moneyProgressView.setProgress(0.0, animated: true)
        
        let animationDuration = 0.5
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
        }) { (completion) -> Void in
            
            self.GoldCollectedLBLView.hidden = false
            
            self.GoldCollectedLBLView.transform = CGAffineTransformScale(self.GoldCollectedLBLView.transform, 0.001, 0.001)
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.GoldCollectedLBLView.transform = CGAffineTransformIdentity
            })
            
            
        }
        */
        
        if GoldLBLViewShown {
            
            let animationDuration = 0.35
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                
            }, completion: { (completion) -> Void in
                
        
        self.GoldAmountLBLView.transform = self.GoldAmountLBLView.transform.scaledBy(x: 1.0, y: 1.0)
        
        self.GoldAmountLBLView.isHidden = true
        //self.GoldAmountView.hidden = true
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.GoldAmountLBLView.transform = CGAffineTransform.identity
        })
        
            }) 
            
            GoldLBLViewShown = false
            
        }

        
        if GoldLBLShown {
            
            let animationDuration = 0.35
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                
            }, completion: { (completion) -> Void in
                
                
                
                self.GoldAmountLBLView.transform = self.GoldAmountLBLView.transform.scaledBy(x: 1.0, y: 1.0)
                
                self.GoldAmountLBLView.isHidden = true
                //self.GoldAmountView.hidden = true
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    self.GoldAmountLBLView.transform = CGAffineTransform.identity
                })
                
                
                self.GoldAmountView.transform = self.GoldAmountView.transform.scaledBy(x: 1.0, y: 1.0)
                
               // self.GoldAmountLBLView.hidden = true
                self.GoldAmountView.isHidden = true
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    self.GoldAmountView.transform = CGAffineTransform.identity
                })
                
                
            }) 
          
            GoldLBLShown = false
            
        }
        
        CollectGoldProductionNow()
        
    }
    
    
    func CollectGoldProductionNow() {
        
        
        shakeView(moneyProgressView, repeatCount: 5)
        
        
        
        let PreviousGold = self.prefs.value(forKey: "GOLDAMOUNT") as! String
        print("Collecting Gold NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold) + \(GoldProductionAmount.description)")
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMoney"), object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(self.GoldProductionAmount.description)","setting":"add"])
        
        let newAmount = Int(PreviousGold)! + GoldProductionAmount
        
        print("New")
        
        email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        print("Email is.....\(email)")
        
        
        let UpdateGoldSuccess =  UpdateUserGold(username, email: email, amount: newAmount.description as NSString)
        
        
        
        print("Collect Gold success = \(UpdateGoldSuccess)")
        
        
        GoldProductionAmount = 0
        
        
        
        backgroundThread(background: {
            //self.GetPublicTurns()
            print("BACKGROUND THREAD - Updating Users' Info")
            
            print("Saving Images now")
            
            
            let UserInfoNSData = GetUserInfo(self.email)
            
            DispatchQueue.main.async(execute: {
                print("Creating Local Inventory Data")
                CreateLocalInventory(UserInfoNSData)
                
            })
            
            
            }, completion: {
                
                DispatchQueue.main.async(execute: {
                    //self.GetMyHUD.removeFromSuperview()
                    //  self.tableView.reloadData()
                    print("DISPATCH ASYNC - Finished Getting User's Info")
                })
                // print("Done Getting Steal Turns")
                //   self.kolodaView.resetCurrentCardNumber()
        })
        
        prefs.setValue(0, forKey: "GoldProductionEndTime")
        
        StartGoldProduction()
        
    }
    
    func MoneyPulse(_ theView: UIView, scale: CGFloat) {
        
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            theView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { (finished: Bool) -> Void in
            
            UIView.animate(withDuration: 1, animations: { () -> Void in
                theView.transform = CGAffineTransform.identity
            })}) 
        
    }
    
    
    func shakeView(_ theView: UIView, repeatCount: Float){
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = repeatCount
        shake.autoreverses = true
        
        let from_point:CGPoint = CGPoint(x: theView.center.x - 1, y: theView.center.y)
        let from_value:NSValue = NSValue(cgPoint: from_point)
        
        let to_point:CGPoint = CGPoint(x: theView.center.x + 1, y: theView.center.y)
        let to_value:NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        theView.layer.add(shake, forKey: "position")
    }
    
    
    @objc func appMovedToBackground(_ notification:Notification) {
        print("App moved to background!")
        
        
        /*
        if CloudsMovedOut {
            
            dispatch_async(dispatch_get_main_queue(), {
                // dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.MoveClouds("in")
                print("Clouds moved in")
                self.CloudsMovedOut = false
            })
            
        }
        
        */
        
        
        
    }
    
    @objc func displayForegroundDetails() {
        print("APP ENTERED THE FOREGROUND")
        
        
        var window: UIWindow?
        
        
        if self.isViewLoaded && view.window != nil {
             self.DisplayLoadingView(true)
            
            
            /*
            if !CloudsMovedOut {
                
                dispatch_async(dispatch_get_main_queue(), {
                    // dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    self.MoveClouds("out")
                    print("Clouds moved out")
                    self.CloudsMovedOut = true
                })
                
            } else {
            
            
            NSNotificationCenter.defaultCenter().postNotificationName("RefreshClouds", object: nil)
            
            }
            
            */
           
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "RefreshClouds"), object: nil)
            
            
            
            self.CloudsMovedOut = false
          DispatchQueue.main.async(execute: {
           // self.DisplayLoadingView(true)
            
           // self.view.addSubview(self.RefreshHUD)
            
            DispatchQueue.main.async(execute: {
              //  print("is on my games view controller, trying to refresh my games")
              //  self.RefreshGameData(self)
                // self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                 //   print("Updating map now")
                    
                    
                   
                    self.CenterFromForeground = true
                    self.ViewDidAppearItems()
              //      self.RefreshHUD.removeFromSuperview()
              //      self.TableView.reloadData()
                })
            })
        })
            
            print("Map VC is loaded and on screen")
        } else {
            print("Map vc is not loaded or on screen")
        }
        
        if self.isViewLoaded  {
            print("Map VC is loaded")
        } else {
            print("Map vc is not loaded")
        }
        
        
        
        
        if let viewControllers = self.navigationController?.viewControllers {
            
            for viewController in viewControllers {
                if viewController.isKind(of: MapViewController.self) {
                    
                    print("Is on MapViewController now")
                    
                    
   
                    
                   
                    //, userInfo: ["effect":"\(Effect)"])
                    
                    
                    /*
                     self.view.addSubview(self.RefreshHUD)
                     
                     dispatch_async(dispatch_get_main_queue(), {
                     print("is on my games view controller, trying to refresh my games")
                     self.RefreshGameData(self)
                     // self.TableView.reloadData()
                     dispatch_async(dispatch_get_main_queue(), {
                     self.RefreshHUD.removeFromSuperview()
                     self.TableView.reloadData()
                     })
                     })
                     */
                } else {
                    //   UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
                    print("Not on My Games ViewController")
                }
            }
        } else {
            print("else showing")
            
            /*
             self.navigationController?.popToRootViewControllerAnimated(false)
             UIApplication.sharedApplication().keyWindow?.makeKeyAndVisible()
             UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self, animated: false, completion: nil)
             */
        }
        
    }
    

    func checkLocationAuthorizationStatus(_ manager: CLLocationManager!, status: CLAuthorizationStatus) -> Bool {
        switch status {
        case .authorizedAlways:
            print("Authorized")
            prefs.set(true, forKey: "TRACKINGON")
            return true
    case .authorizedWhenInUse, .denied, .restricted:
            return false
        case .notDetermined:
            print("NotDetermined")
            manager.requestAlwaysAuthorization()
        default:
            print("Default")
            return false
        }
        return false
    }
    
    var mapChangedFromUserInteraction = false
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
         mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
        
       // print("Region Will Change:  UserZoom Radius = \(UserZoomRadius)")
        
        if (mapChangedFromUserInteraction) {
            // user will change map region
            
            self.CenterOnUser = false
            
            self.CenterUserBTN.setImage(UIImage(named: "Center Direction-50.png"), for: UIControl.State())
            
          //  print("user WILL change map.")
        }
        
    }
    
   
    
    fileprivate func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended ) {
                   // print("map region changed by user gesture")
                    return true
                }
            }
        }
        return false
    }
   

    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
       // let location = locations.
        
        //IsSecurityArmed
       
        
        myloc = LocManager.location!
        mylat = myloc.coordinate.latitude
        mylong = myloc.coordinate.longitude
        myalt = myloc.altitude
        
       // print("MY LAT: \(mylat)")
       // print("MY LONG: \(mylong)")
        
        prefs.setValue(mylat.description, forKey: "MYCURRENTLAT")
        prefs.setValue(mylong.description, forKey: "MYCURRENTLONG")
        prefs.setValue(myalt.description, forKey: "MYCURRENTALT")
        
        let homeLat = prefs.value(forKey: "HomeLat") as! Double
        let homeLong = prefs.value(forKey: "HomeLong") as! Double
        let homeAlt = prefs.value(forKey: "HomeAlt") as! Double
        
        let range: Double = 100
        var mylocnow = CLLocation(latitude: mylat, longitude: mylong)
        var homeLocation = CLLocation(latitude: homeLat, longitude: homeLong)
        var distance = mylocnow.distance(from: homeLocation)
        var miles = distance / 1609.34
        var feet = Double(round(1000*(miles * 5280))/1000)
        
        //print("***Home Distance (feet away): \(feet)***")
        
        var IsNearHQ = Bool()
        if range >= feet {
          //  print("***STILL CLOSE ENOUGHT TO HQ***")
            IsNearHQ = true
        } else {
         //   print("***TOO FAR AWAY FROM HQ***")
            IsNearHQ = false
            UserDefaults.standard.set(false, forKey: "SecuritySet")
        }

        
        
        if CenterOnUser {
            
            if IsNearHQ {
                if UserDefaults.standard.bool(forKey: "SecuritySet") {
                   // print("IS CLOSE ENOUGH AND ARMED")
                ChangeSunLightEffect(0.0)
                } else {
                  //  print("IS CLOSE ENOUGH BUT NOT ARMED")
                    if !FlashlightOn {
                   UpdateDaylight()
                }
                }
            } else {
                
                
                if UserDefaults.standard.bool(forKey: "SecuritySet") {
                   // print("NOT CLOSE ENOUGH BUT ARMED")
                    
                    //ChangeSunLightEffect(0.0)
                    if !FlashlightOn {
                        UpdateDaylight()
                    }
                    
                } else {
                  //  print("NOT CLOSE ENOUGH AND NOT ARMED")
                    if !FlashlightOn {
                        UpdateDaylight()
                    }
                }
                
                
               // print("NOT CLOSE ENOUGH")
            }
            
         //   print("Center on User while driving")
            
            regionRadius = 200
            
            //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
            
       //     print("Center Map on User - Region Radius = \(regionRadius)")
            
            

            
            let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
            
            
            
            // mapView.setCenterCoordinate(location.coordinate, animated: true)
            
            ZoomLevel = self.UserZoomRadius
            
            
            //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
            // print("Centering with zoom level \(ZoomLevel)")
            
            if !CapturingTerritory {
            
                
                
            //mapView.setRegion(coordinateRegion, animated: true)
                
                let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
                
                 if !mapChangedFromUserInteraction {
                
                   // print("LOCATION UPDATE AFTER START UP = \(AfterStartupLoad)")
                    
                    if AfterStartupLoad {
                    
                       // DispatchQueue.main.async(execute: {
                            self.mapView.setCenter(self.myloc.coordinate, animated: true)
                       // })
                        
                    }
                    
                }
                
               // print("Starting View: New Room Radius = \(NewZoomRadius)")
                
              //  mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: (NewZoomRadius), animated: true)
                
            
            }
            
            /*
             else {
                
                mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: 17.9, animated: true)
                
               mapView.setCenterCoordinate(myloc.coordinate, animated: true)
                
            }
            
            */
        } else {
            
            //FLASHLIGHTON (this is probably where the  light at night going off
            if !FlashlightOn {
                UpdateDaylight()
            }

           // UpdateDaylight()
        }
        
       // println("updated mylat = \(mylat)")
       // println("updated mylong = \(mylong)")
        
       // println("Did Update Location items")
        
    }
    
    
    
  //  func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    
    //SWIFT 3 ERROR
    /*
    func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.newLocation
        let fromLocation = locations.fromLocation
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newLocation.coordinate
        
        // let currentZoom = mapView.zoomLevel
        //print("Current Zoom in location manager = \(currentZoom)")
        
        // Also add to our map so we can remove old values later
        locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = locations.first!
            locations.remove(at: 0)
            
            // Also remove from the map
            mapView.removeAnnotation(annotationToRemove)
        }
        
        if UIApplication.shared.applicationState == .active {
            mapView.showAnnotations(locations, animated: true)
        } else {
            NSLog("App is backgrounded. New location is %@", newLocation)
        }
    }
    
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if !prefs.bool(forKey: "SettingsLoggingOut") {
        
        print("did appear DoNotUpdateMapBool = \(DoNotUpdateMapBool)")
        
        if !DoNotUpdateMapBool {
        
        ViewDidAppearItems()
            
        }
        
        if DoUpdateAnnotations {
            
            
            UpdateAnnotations()
            
        }
        /*
         dispatch_async(dispatch_get_main_queue(), {
         var view = activitiesView.instanceFromNib()
         self.view.addSubview(view)
         })
        */
       
        DispatchQueue.main.async(execute: {
           self.MapViewLoadComplete = true
        })
        
        
    }
    }
    
    func UpdateAnnotations(){
        //DELETE BELOW
        
        var URLData = CompleteLocations(username, latitude: mylat, longitude: mylong, radius: userRadius, altitude: myalt)
        //  println("URLData: \(URLData)")
        var LocInfo = FilterGameData(URLData)
        
        
        
        //   println("LocInfo: \(LocInfo)")
        //playernameInfo = LocInfo[0] as! [(NSString)]
        //print("ITEM RADIUS = \(itemRadius)")
        
        
        
        var URLDataItems = ItemLocations(username, latitude: mylat, longitude: mylong, radius: itemRadius, altitude: myalt)
        
        //   println("URLData: \(URLDataItems)")
        var ItemInfo = FilterItemData(URLDataItems)
        //   println("LocInfo: \(ItemInfo)")
        
        print("EMAIL = \(self.email)")
        var TerritoryURLData = GetTerritory(self.email, Type: "all")
        TerritoryInfoArray = FilterTerritoryData(TerritoryURLData)
        
        
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        let MissionURLData = GetMission(self.email, level: level as NSString, status: status as NSString)
        MissionInfoArray = FilterMissionItems(MissionURLData)
        
        let CameraURLData = GetCameras(self.email, level: level as NSString, status: status as NSString)
        NearbyCameras = FilterCameraItems(CameraURLData)
        
        let OtherCameraURLData = GetOtherCameras(self.email, level: level as NSString, status: status as NSString, background: false)
        OtherNearbyCameras = FilterOtherCameraItems(OtherCameraURLData)
        
        let HomeURLData = GetHomeInfo(self.email, level: level as NSString, status: status as NSString)
        IsHomeSet = FilterHomeItems(HomeURLData)
        
        //CAMERA TEST
        
        //AddCameras()
     
        
        
        DispatchQueue.main.async(execute: {
            
            print("Territory Array = \(self.TerritoryInfoArray)")
            self.RenderTerritoryArray(self.TerritoryInfoArray)
        })
        
        
    }
    
    /*
    
    func AddCameras() {
        
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        
        
        print("ADDING CAMERA")
       // let itemID = result["id"].stringValue
        let itemID = "1"
        // print("ITEM NAME = \(itemName)")
       // let latTemp = result["latitude"].stringValue
        let lat = 28.683700
        
       // let longTemp = result["longitude"].stringValue
        let long = -81.262700
        
        
       // let status = result["status"].stringValue
       // let level = result["level"].stringValue
        
        let status = "incomplete"
        let level = "1"
        let objective = "test objective"
       // let xp = result["xp"].stringValue
        let xp = "10"
        //let itemID = "NA"
        
        
        
        let itemImageURL = "" //result["imageURL"].stringValue
        
        
        
       // MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
        
        let missionTitle = "test"
        
        let missionCoordinate = CLLocationCoordinate2DMake(lat, long)
        
        let imageName = "Camera"
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        let itemImage = UIImage(data:theImageData!)!
        
      //  let missionMapURL = result["imageURL"].stringValue
        let missionMapURL = "Camera"
        let missionObjectURL = "Hammer"
        
        let itemOwner = "John Doe"
        
        
        let StartTemp = "2017-01-11 14:47:22"
        let StartTempFormated = formatter.date(from: StartTemp)
        let EndTemp = "2017-01-12 14:47:22"
        let EndTempFormated = formatter.date(from: StartTemp)
        
        let itemStart = StartTempFormated
        let itemEnd = EndTempFormated
        let itemRadius = 5.0
        let range: Double = 50
      
        
        NearbyCameras.append(CameraInfo(id: itemID, level: level, lat: lat, long: long, status: status, owner: itemOwner, startTime: itemStart!, endTime: itemEnd!, radius: itemRadius, range: range))
        
        let cameraPoint = CameraLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "camera", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, missionID: itemID)
        
        
        
        
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        var itemLocation = CLLocation(latitude: lat,longitude: long)
        var distance = mylocnow.distance(from: itemLocation)
        
        
        var miles = distance / 1609.34
        //print("Cmiles: \(miles)")
      
        var feet = Double(round(1000*(miles * 5280))/1000)
        
        print("***CAMERA Distance (feet away): \(feet)***")
        
        if range >= feet {
            
            print("***TOO CLOSE, YOUVE BEEN SPOTTED***")
            self.tempBTN.setTitle("f(b):\(feet)", for: .normal)
            let alertController = UIAlertController(
                title: "Alert!",
                message: "You've been spotted.",
                preferredStyle: .alert)
            
            //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            //  alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
                
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            
            self.tempBTN.setTitle("f(g):\(feet)", for: .normal)
            print("***NOT SPOTTED, YOURE SAFE***")
        }
        
        
        
        
        print("ADDING camera POINT TO MAP NOW")
        
        self.mapView.addAnnotation(cameraPoint)
        
    }
    
    */
    func FilterCameraItems(_ urlData: Data) -> [CameraInfo] {
        
        
        print("GETTING CAMERAS NOW")
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        
        
        
        var NearbyCamerasTemp = [CameraInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
       // print("Json Mission valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                let itemID = result["id"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let starttimeTemp = result["starttime"].stringValue
                let endtimeTemp = result["endtime"].stringValue
                let rangeTemp = result["range"].stringValue
                var range = Double(rangeTemp)
                
                let targetName = result["targetname"].stringValue
                let targetID = result["targetid"].stringValue
                
                //let itemID = "NA"
                
                
                // {\"id\":\"$locationID\",\"latitude\":\"$PointLat\",\"longitude\":\"$PointLong\",\"status\":\"$MissionStatus\",\"level\":\"$MissionLevel\",\"targetname\":\"$TargetName\",\"targetid\":\"$TargetID\",\"starttime\":\"$StartTime\",\"endtime\":\"$EndTime\",\"ownername\":\"$OwnerName\",\"ownerid\":\"$OwnerID\",\"range\":\"$Range\"},";
                
                
                
                
                
                // let status = result["status"].stringValue
                // let level = result["level"].stringValue
                
                let objective = "test objective"
                // let xp = result["xp"].stringValue
                let xp = "10"
                //let itemID = "NA"
                
                
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                
                
                // MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                
                let missionTitle = "Survellencex"
                
                let missionCoordinate = CLLocationCoordinate2DMake(lat!, long!)
                
                let imageName = "Camera"
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                let theImageData = try? Data(contentsOf: url)
                let itemImage = UIImage(data:theImageData!)!
                
                //  let missionMapURL = result["imageURL"].stringValue
                let missionMapURL = "Camera"
                let missionObjectURL = "Camera"
                
                let itemOwner = self.username
                
                
                // let StartTemp = "2017-01-11 14:47:22"
                let StartTempFormated = formatter.date(from: starttimeTemp)
                //   let EndTemp = "2017-01-12 14:47:22"
                let EndTempFormated = formatter.date(from: endtimeTemp)
                
                let itemStart = StartTempFormated
                let itemEnd = EndTempFormated
                let itemRadius = 5.0
                //let range: Double = 50
                
                range = 50
                let missionLevel = "0"
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                let killcount = "0"
                let killedcount = "0"
                let altitude = 0.0
                
                NearbyCamerasTemp.append(CameraInfo(id: itemID, level: level, lat: lat!, long: long!, status: status, owner: itemOwner as String, startTime: itemStart!, endTime: itemEnd!, radius: itemRadius, range: range!))
                
                let cameraPoint = CameraLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "camera", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: false, missionID: itemID, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                
                
                
                
                var curLoc = CLLocation()
                var curLocManager = CLLocationManager()
                curLoc = curLocManager.location!
                var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
                var itemLocation = CLLocation(latitude: lat!,longitude: long!)
                var distance = mylocnow.distance(from: itemLocation)
                
                
                var miles = distance / 1609.34
                //print("Cmiles: \(miles)")
                
                var feet = Double(round(1000*(miles * 5280))/1000)
                
                print("***CAMERA Distance (feet away): \(feet)***")
                
                if range! >= feet {
                    
                    print("***TOO CLOSE, YOUVE BEEN SPOTTED***")
                    self.tempBTN.setTitle("f(b):\(feet)", for: .normal)
                    let alertController = UIAlertController(
                        title: "Alert!",
                        message: "You've been spotted.",
                        preferredStyle: .alert)
                    
                    //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    //  alertController.addAction(cancelAction)
                    
                    let openAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        
                        
                    }
                    alertController.addAction(openAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                } else {
                    
                    //self.tempBTN.setTitle("f(g):\(feet)", for: .normal)
                    
                    self.tempBTN.setTitle("\(myalt)", for: .normal)
                    
                    print("***NOT SPOTTED, YOURE SAFE***")
                }
                
                
                
                
                print("ADDING camera POINT TO MAP NOW")
                
                self.mapView.addAnnotation(cameraPoint)
                
                
                
                
                
            }
            
        }
        
        
        return NearbyCamerasTemp
    }
    
    func FilterOtherCameraItems(_ urlData: Data) -> [CameraInfo] {
        
        
        print("GETTING OTHER CAMERAS NOW")
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        
        
        
        var NearbyCamerasTemp = [CameraInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
       // print("Json Other cameras valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                print("OTHER CAMERA INFO FOUND")
                
                let itemID = result["id"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let starttimeTemp = result["starttime"].stringValue
                let endtimeTemp = result["endtime"].stringValue
                let rangeTemp = result["range"].stringValue
                let range = Double(rangeTemp)
                
                let targetName = result["targetname"].stringValue
                let targetID = result["targetid"].stringValue
                
                //let itemID = "NA"
                
                
                // {\"id\":\"$locationID\",\"latitude\":\"$PointLat\",\"longitude\":\"$PointLong\",\"status\":\"$MissionStatus\",\"level\":\"$MissionLevel\",\"targetname\":\"$TargetName\",\"targetid\":\"$TargetID\",\"starttime\":\"$StartTime\",\"endtime\":\"$EndTime\",\"ownername\":\"$OwnerName\",\"ownerid\":\"$OwnerID\",\"range\":\"$Range\"},";
                
                
                
                
                
                // let status = result["status"].stringValue
                // let level = result["level"].stringValue
                
                let objective = "test objective"
                // let xp = result["xp"].stringValue
                let xp = "10"
                //let itemID = "NA"
                
                
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                
                
                // MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                
                let missionTitle = "Survellencex"
                
                let missionCoordinate = CLLocationCoordinate2DMake(lat!, long!)
                
                let imageName = "Camera"
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                let theImageData = try? Data(contentsOf: url)
                let itemImage = UIImage(data:theImageData!)!
                
                //  let missionMapURL = result["imageURL"].stringValue
                let missionMapURL = "Camera"
                let missionObjectURL = "Camera"
                
                let itemOwner = self.username
                
                
                // let StartTemp = "2017-01-11 14:47:22"
                let StartTempFormated = formatter.date(from: starttimeTemp)
                //   let EndTemp = "2017-01-12 14:47:22"
                let EndTempFormated = formatter.date(from: endtimeTemp)
                
                let itemStart = StartTempFormated
                let itemEnd = EndTempFormated
                let itemRadius = 5.0
                //  let range: Double = 50
                let missionLevel = "0"
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                let killcount = "0"
                let killedcount = "0"
                
                let altitude = 0.0
                
                NearbyCamerasTemp.append(CameraInfo(id: itemID, level: level, lat: lat!, long: long!, status: status, owner: itemOwner as String, startTime: itemStart!, endTime: itemEnd!, radius: itemRadius, range: range!))
                
                let cameraPoint = OtherCameraLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "othercamera", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: false, missionID: itemID, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                
                
                
                
                var curLoc = CLLocation()
                var curLocManager = CLLocationManager()
                curLoc = curLocManager.location!
                var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
                var itemLocation = CLLocation(latitude: lat!,longitude: long!)
                var distance = mylocnow.distance(from: itemLocation)
                
                
                var miles = distance / 1609.34
                //print("Cmiles: \(miles)")
                
                var feet = Double(round(1000*(miles * 5280))/1000)
                
                print("***CAMERA Distance (feet away): \(feet)***")
                
                if range! >= feet {
                    print("***TOO CLOSE, YOUVE BEEN SPOTTED***")
                    
                    
                    
                    
                } else {
                    print("***NOT SPOOTED, YOURE SAFE***")
                }
                
                
                
                
                print("ADDING camera POINT TO MAP NOW")
                
                self.mapView.addAnnotation(cameraPoint)
                
                
                
                
                
            }
            
        }
        
        
        return NearbyCamerasTemp
    }
    
    func FilterHomeItems(_ urlData: Data) -> Bool {
        
        
        print("GETTING HOME INFO NOW")
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"

        var HomeSet = Bool()
        
        
       // var NearbyCamerasTemp = [CameraInfo]()

        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json Home valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                
                
                print("OTHER CAMERA INFO FOUND")
                
                let itemID = result["id"].stringValue
                
                
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                let altTemp = result["altitude"].stringValue
                let alt = Double(altTemp)
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let starttimeTemp = result["startupgrade"].stringValue
                let endtimeTemp = result["endupgrade"].stringValue
                let goldTemp = result["goldamount"].stringValue
                let goldamount = Double(goldTemp)
                
                let homename = result["name"].stringValue
             
                
                let missionCoordinate = CLLocationCoordinate2DMake(lat!, long!)
                
               
                
                var imageName = String()
                var missionMapURL = String()
                var missionObjectURL = String()
                
                switch level {
                    
                    case "1":
                    imageName = "HQlevel1_100"
                    missionMapURL = "HQlevel1"
                    missionObjectURL = "HQlevel1"
                    
                default:
                    imageName = "HQlevel1_100"
                    missionMapURL = "HQlevel1"
                    missionObjectURL = "HQlevel1"
                }
               // let imageName = "HQlevel1_100"
                
                if itemID == "home" {
                    
                    print("ID is home")
                    UserDefaults.standard.set(true, forKey: "HomeSet")
                    UserDefaults.standard.set(lat, forKey: "HomeLat")
                    UserDefaults.standard.set(long, forKey: "HomeLong")
                    UserDefaults.standard.set(alt, forKey: "HomeAlt")
                    UserDefaults.standard.set(level, forKey: "HomeLevel")
                    UserDefaults.standard.set(imageName, forKey: "HomeimageName")
                    UserDefaults.standard.set(homename, forKey: "HomeName")
                    UserDefaults.standard.set(itemID, forKey: "HomeID")
                    UserDefaults.standard.set(goldTemp, forKey: "HomeGoldAmount")
                    UserDefaults.standard.set(status, forKey: "HomeStatus")
                    UserDefaults.standard.set(starttimeTemp, forKey: "HomeStartUpgrade")
                    UserDefaults.standard.set(endtimeTemp, forKey: "HomeEndUpgrade")
                    HomeSet = true
                }
                
                 let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
               // let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
                let theImageData = try? Data(contentsOf: url)
                let itemImage = UIImage(data:theImageData!)!
                
                //  let missionMapURL = result["imageURL"].stringValue
                
                
                let itemOwner = self.username
                
                
               // let StartTemp = "2017-01-11 14:47:22"
                let StartTempFormated = formatter.date(from: starttimeTemp)
             //   let EndTemp = "2017-01-12 14:47:22"
                let EndTempFormated = formatter.date(from: endtimeTemp)
                
                let itemStart = StartTempFormated
                let itemEnd = EndTempFormated
                let itemRadius = 5.0
              //  let range: Double = 50
                
                let missionTitle = homename
                let xp = ""
                let objective = "test"
                let missionLevel = "NA"
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                let killcount = "0"
                let killedcount = "0"
                let altitude = 0.0
               // NearbyCamerasTemp.append(CameraInfo(id: itemID, level: level, lat: lat!, long: long!, status: status, owner: itemOwner as String, startTime: itemStart!, endTime: itemEnd!, radius: itemRadius, range: range!))
                
                let homePoint = HomeLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "home", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: false, missionID: itemID, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
               
                
                self.mapView.addAnnotation(homePoint)

 
            }
            
        }
        
        
        return HomeSet
    }
    
    
    func ViewDidAppearItems() {
        msgLBL.text = "1"
        myGoldAmount = Int(prefs.value(forKey: "GOLDAMOUNT") as! String)!
        myDiamondsAmount = Int(prefs.value(forKey: "DIAMONDSAMOUNT") as! String)!
        diamondsLBL.text = "\(myDiamondsAmount.description)"
        
        
        //TrackingOn = checkLocationAuthorizationStatus(LocManager, status: CLLocationManager.authorizationStatus() )
        //JARED REMOVED 12-3-2020
        
        if !prefs.bool(forKey: "TRACKINGON") {
            TrackingOn = checkLocationAuthorizationStatus(LocManager, status: CLLocationManager.authorizationStatus() )
        } else {
            TrackingOn = prefs.bool(forKey: "TRACKINGON")
        }
        
        
        //TrackingOn = prefs.boolForKey("TRACKINGON")
        
        print("TRACKING FROM View did Appear - VC = \(TrackingOn)")
        
        self.moneyLBL.text = "$\(prefs.value(forKey: "GOLDAMOUNT") as! String)"
        
        let WasAttacked = prefs.value(forKey: "WASATTACKED") as! String
        // checkLocationAuthorizationStatus()
        
        //  UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        let tempXP: Float = Float(myXP) / 100
        
        if tempXP < 0.3 {
            //  self.xpProgressView.fillDoneColor = UIColor.redColor()
        } else if tempXP > 0.85 {
            //  self.xpProgressView.fillDoneColor = UIColor.greenColor()
        } else {
            //  self.xpProgressView.fillDoneColor = UIColor.orangeColor()
        }
        
        self.xpProgressView.setProgress(tempXP, animated: true)
        
        
        if !prefs.bool(forKey: "NOTFIRSTLAUNCH") {
            print("THIS IS THE FIRST LAUNCH")
            
            
            UserDefaults.standard.set(true, forKey: "ShowBlood")
            
            if Reachability.isConnectedToNetwork() {
                
                
                //if LocManager.location != nil {
                if TrackingOn {
                   // if LocManager.location != nil {
                    mapView.showsUserLocation = true
                    var mtype = mapView.mapType
                    mtype = MKMapType.hybrid
                    
                    LocManager.desiredAccuracy = kCLLocationAccuracyBest
                    
                    // LocManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                    
                    LocManager.delegate = self
                    LocManager.startUpdatingLocation()
                    myloc = LocManager.location!
                    mylat = myloc.coordinate.latitude
                    mylong = myloc.coordinate.longitude
                    myalt = myloc.altitude
                    
                    print("FIRST LAUNCH LAT: \(mylat) long: \(mylong), alt: \(myalt)")
                    
                    
                    self.MergeMyLevelMissions(username: self.username, email: self.email, lat: mylat, long: mylong, alt: myalt)
                    
                    //currentLocation = LocManager.location
                    
                    //centerMapOnLocation(myloc)
                    
                    
                    if prefs.value(forKey: "WRADIUS") != nil {
                        userRadius = prefs.value(forKey: "WRADIUS") as! Int
                        itemRadius = prefs.value(forKey: "VIEWRADIUS") as! Int
                        UserZoomRadius = Double(itemRadius)
                        print("User Weapon Radius = \(userRadius)")
                        print("User Zoom Radius = \(UserZoomRadius)")
                    } else {
                        print("User Zoom is NIL")
                        userRadius = 2
                        prefs.set(userRadius, forKey: "WRADIUS")
                        itemRadius = 2
                        prefs.set(itemRadius, forKey: "VIEWRADIUS")
                        UserZoomRadius = Double(itemRadius)
                        
                    }
                    
                    
                    if userRadius < 2 {
                        VRange.text = "Range: \(userRadius) Mile"
                    } else {
                        VRange.text = "Range: \(userRadius) Miles"
                    }
                    
                    
                    let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
                    
                    //print("Starting View: New Room Radius = \(NewZoomRadius)")
                    
                   // mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: (NewZoomRadius), animated: false)
                    
                    
                    
                    
                    // tempImage = UIImage(named: "fist.png")!
                    
                    
                    if prefs.value(forKey: "HOLDINGWEAPON") != nil {
                        CurrentWeapon =  prefs.value(forKey: "HOLDINGWEAPON") as! NSString
                        
                        if CurrentWeapon == "Night Vision Goggles" {
                            print("You're holding Night Vision Goggles")
                            self.ToggleNightVision(true)
                        }
                        
                    } else {
                        CurrentWeapon =  "Fist"
                    }
                    
                    
                    if prefs.value(forKey: "HOLDINGSHIELD") != nil {
                        CurrentShield =  prefs.value(forKey: "HOLDINGSHIELD") as! NSString
                        
                    } else {
                        CurrentShield =  ""
                    }
                    
                    if prefs.value(forKey: "HOLDINGARMOR") != nil {
                        CurrentArmor =  prefs.value(forKey: "HOLDINGARMOR") as! NSString
                        
                    } else {
                        CurrentArmor =  ""
                    }
                    
                    
                    //tempImage = UIImage(named: "magnum gun.png")!
                    // CurrentWeapon =  prefs.valueForKey("HOLDINGWEAPON") as! NSString
                    
                    /*
                     switch CurrentWeapon {
                     case "binoculars":
                     ToolsBTN.setImage(UIImage(named: "binoculars.png")!, forState:.Normal);
                     case "Fist":
                     
                     // var imageName = "Fist"
                     // let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
                     // let theImageData = NSData(contentsOfURL: url)
                     // tempImage = UIImage(data:theImageData!)!
                     
                     
                     ToolsBTN.setImage(FistImage, forState:.Normal);
                     case "sniper rifle":
                     ToolsBTN.setImage(UIImage(named: "Sniper Rifle.png")!, forState:.Normal);
                     case "knife":
                     ToolsBTN.setImage(UIImage(named: "knife.png")!, forState:.Normal);
                     default:
                     ToolsBTN.setImage(FistImage, forState:.Normal);
                     }
                     
                     
                     switch CurrentArmor {
                     case "black armor":
                     armorBTN.setImage(UIImage(named: "black armor.png")!, forState:.Normal);
                     case "wood armor":
                     armorBTN.setImage(UIImage(named: "wood armor.png")!, forState:.Normal);
                     
                     default:
                     break
                     //  armorBTN.setImage(tempImage, forState:.Normal);
                     }
                     
                     switch CurrentShield {
                     case "blue shield":
                     shieldBTN.setImage(UIImage(named: "blue shield.png")!, forState:.Normal);
                     case "metal shield":
                     shieldBTN.setImage(UIImage(named: "metal shield.png")!, forState:.Normal);
                     case "wooden sheild":
                     shieldBTN.setImage(UIImage(named: "wooden shield.png")!, forState:.Normal);
                     case "american shield":
                     shieldBTN.setImage(UIImage(named: "American Shield.png")!, forState:.Normal);
                     default:
                     break
                     // shieldBTN.setImage(tempImage, forState:.Normal);
                     }
                     
                     */
                    
                    if CurrentWeapon != "" {
                        print("CURRENT WEAPON =\(CurrentWeapon)")
                        if prefs.value(forKey: "\(CurrentWeapon)ImageIcon") != nil {
                        
                        let CurrentWeaponStringURL = prefs.value(forKey: "\(CurrentWeapon)ImageIcon") as! String
                        let CurrentWeaponurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentWeaponStringURL).png")
                        let CurrentWeaponImageData = try? Data(contentsOf: CurrentWeaponurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentWeaponImage = UIImage(data: CurrentWeaponImageData!)
                        ToolsBTN.setImage(CurrentWeaponImage, for:UIControl.State());
                            
                        } else {
                            ToolsBTN.setImage(UIImage(named: "Fist.png"), for:UIControl.State());
                        }
                        
                    } else {
                        
                        ToolsBTN.setImage(UIImage(named: "Fist.png"), for:UIControl.State());
                        
                    }
                    
                    if CurrentArmor != "" {
                        let CurrentArmorStringURL = prefs.value(forKey: "\(CurrentArmor)ImageIcon") as! String
                        let CurrentArmorurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentArmorStringURL).png")
                        let CurrentArmorImageData = try? Data(contentsOf: CurrentArmorurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentArmorImage = UIImage(data: CurrentArmorImageData!)
                        armorBTN.setImage(CurrentArmorImage, for:UIControl.State());
                    } else {
                        armorBTN.setImage(UIImage(named: "ArmorIconNA.png")!, for:UIControl.State());
                    }
                    
                    
                    if CurrentShield != "" {
                        let CurrentShieldStringURL = prefs.value(forKey: "\(CurrentShield)ImageIcon") as! String
                        let CurrentShieldurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentShieldStringURL).png")
                        let CurrentShieldImageData = try? Data(contentsOf: CurrentShieldurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentShieldImage = UIImage(data: CurrentShieldImageData!)
                        //shieldBTN.setImage(CurrentShieldImage, for:UIControl.State());
                    } else {
                        
                        //shieldBTN.setImage(UIImage(named: "ShieldIconNA.png"), for:UIControl.State());
                        
                    }
                    
                    
                    
                    //   var currentloc = currentLocation.coordinate.latitude
                    //  var currentlong = currentLocation.coordinate.longitude        // Do any additional setup after loading the view.
                    //mapView.delegate = self
                    
                    //let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    //  username = prefs.valueForKey("USERNAME") as! NSString as String
                    email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
                    //print("Email = \(email)")
                    
                    
                    if prefs.value(forKey: "USERNAME") != nil {
                        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                        email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
                        print("Email From VC = \(email)")
                    } else {
                        username = "UnknownUsername"
                        email = "UnknownEmail"
                    }
                    
                   //TimerData = [username, mylat, mylong]
                    // UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("SaveMyLocTimer"), userInfo: TimerData, repeats: true)
                    // GPSData =
                    //StartSavingMyLoc()
                    
                    //var userinfo:[Double] = [mylat, mylong]
                    
                    /*
                     
                     dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                     
                     self.UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("StartSavingMyLoc:"), userInfo: ["lat":self.mylat, "long":self.mylong], repeats: true)
                     
                     //}
                     }
                     */
                    
                    
                    //UNCOMMENT BELOW
                    // UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("StartSavingMyLoc:"), userInfo: ["lat":mylat, "long":mylong], repeats: true)
                    
                    print("TRACKING STARTED")
                    tracking.startTracking()
                    
                    
                    
                    //userRadius = 10
                    self.itemRadius = 1
                    
                    
                    
                    
                    
                    
                    
                    
                    //DELETE BELOW
                    
                    var URLData = CompleteLocations(username, latitude: mylat, longitude: mylong, radius: userRadius, altitude: myalt)
                    //  println("URLData: \(URLData)")
                    var LocInfo = FilterGameData(URLData)
                    
                    
                    
                    //   println("LocInfo: \(LocInfo)")
                    //playernameInfo = LocInfo[0] as! [(NSString)]
                    //print("ITEM RADIUS = \(itemRadius)")
                    
                   
                    
                    var URLDataItems = ItemLocations(username, latitude: mylat, longitude: mylong, radius: itemRadius, altitude: myalt)
                    
                    //   println("URLData: \(URLDataItems)")
                    var ItemInfo = FilterItemData(URLDataItems)
                    //   println("LocInfo: \(ItemInfo)")
                    
                    print("EMAIL = \(self.email)")
                    var TerritoryURLData = GetTerritory(self.email, Type: "all")
                    TerritoryInfoArray = FilterTerritoryData(TerritoryURLData)
                    
                    
                    let level = prefs.value(forKey: "USERLEVEL") as! String
                    let status = "incomplete"
                    
                    let MissionURLData = GetMission(self.email, level: level as NSString, status: status as NSString)
                    MissionInfoArray = FilterMissionItems(MissionURLData)
                    
                    
                    let CameraURLData = GetCameras(self.email, level: level as NSString, status: status as NSString)
                    NearbyCameras = FilterCameraItems(CameraURLData)
                    
                    let OtherCameraURLData = GetOtherCameras(self.email, level: level as NSString, status: status as NSString, background: false)
                    OtherNearbyCameras = FilterOtherCameraItems(OtherCameraURLData)
                    
                    let HomeURLData = GetHomeInfo(self.email, level: level as NSString, status: status as NSString)
                    IsHomeSet = FilterHomeItems(HomeURLData)
                    
                   // AddCameras()
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        print("Territory Array = \(self.TerritoryInfoArray)")
                        self.RenderTerritoryArray(self.TerritoryInfoArray)
                    })
                    
                    
 
                    
                    
                    
                    
                    
                    
                    
                    if (prefs.value(forKey: "SELECTEDWEAPON") != nil) {
                        var defaultWeapon =  prefs.value(forKey: "SELECTEDWEAPON") as! UIImage
                        
                        self.armorBTN.setImage(defaultWeapon, for:UIControl.State())
                    }
                    
                    if (prefs.value(forKey: "SELECTEDSHIELD") != nil) {
                        var defaultShield =  prefs.value(forKey: "SELECTEDSHIELD") as! UIImage
                        
                        self.armorBTN.setImage(defaultShield, for:UIControl.State())
                    }
                    
                    if (prefs.value(forKey: "SELECTEDARMOR") != nil) {
                        var defaultArmor =  prefs.value(forKey: "SELECTEDARMOR") as! UIImage
                        
                        self.armorBTN.setImage(defaultArmor, for:UIControl.State())
                    }
                    
                    
                    /*
                     println("adding label")
                     let MyLabel = UserLabel(title: "jared", userHealth: "100.0", discipline: "test", coordinate: CLLocationCoordinate2D(latitude: mylat, longitude: mylong))
                     
                     mapView.addAnnotation(MyLabel)
                     
                     for items in LocInfo {
                     
                     }
                     
                     let MyLabel2 = UserLabel(title: "jared", userHealth: "100.0", discipline: "test", coordinate: CLLocationCoordinate2D(latitude: 28.81142, longitude: -81.3414234))
                     
                     mapView.addAnnotation(MyLabel2)
                     */
                    
                    /* }
                     else {
                        
                        
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Location Error"
                        alertView.message = "We need to track your location, please update your location tracking settings in your general settings"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        //  alertView.show()
                        
                    }
                    */
                }
                
            }
            prefs.set(true, forKey: "NOTFIRSTLAUNCH")
            
            let HowToItems = [String]()
            let HowToItemsDescriptions = [String]()
            
            LoadHowToView(item: "health", description: "Your Health meter", itemsArray: HowToItems, descriptionsArray: HowToItemsDescriptions, itemsCount: 19)
            
            
            
        } else {
            
            
            if Reachability.isConnectedToNetwork() {
                
                if TrackingOn {
                    if LocManager.location != nil {
                    mapView.showsUserLocation = true
                    var mtype = mapView.mapType
                    mtype = MKMapType.hybrid
                    
                    LocManager.desiredAccuracy = kCLLocationAccuracyBest
                    
                    // LocManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                    
                    LocManager.delegate = self
                    LocManager.startUpdatingLocation()
                    myloc = LocManager.location!
                    mylat = myloc.coordinate.latitude
                    mylong = myloc.coordinate.longitude
                    myalt = myloc.altitude
                        
                        print("My Altitude is \(myalt)")
                        
                    if prefs.value(forKey: "USERNAME") != nil {
                            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
                            print("Email From VC = \(email)")
                        } else {
                            username = "UnknownUsername"
                            email = "UnknownEmail"
                        }
                    
                    //currentLocation = LocManager.location
                    //centerMapOnLocation(myloc)
                        
                        self.MergeMyLevelMissions(username: self.username, email: self.email, lat: mylat, long: mylong, alt: myalt)
                    
                    
                    if prefs.value(forKey: "WRADIUS") != nil {
                        userRadius = prefs.value(forKey: "WRADIUS") as! Int
                        itemRadius = prefs.value(forKey: "VIEWRADIUS") as! Int
                        UserZoomRadius = Double(itemRadius)
                        print("User Weapon Radius = \(userRadius)")
                        print("User Zoom Radius = \(UserZoomRadius)")
                    } else {
                        print("User Zoom is NIL")
                        userRadius = 2
                        prefs.set(userRadius, forKey: "WRADIUS")
                        itemRadius = 2
                        prefs.set(itemRadius, forKey: "VIEWRADIUS")
                        UserZoomRadius = Double(itemRadius)
                        
                    }
                    
                    
                    if userRadius < 2 {
                        VRange.text = "Range: \(userRadius) Mile"
                    } else {
                        VRange.text = "Range: \(userRadius) Miles"
                    }
                    
                    
                    
                    let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
                    
                   // print("Starting View: New Room Radius = \(NewZoomRadius)")
                    
                   // mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: (NewZoomRadius), animated: true)

                    
                    
                    
                    
                    
                    
                    
                    FistImage = UIImage(named: "Fist.png")!
                    
                    
                    if prefs.value(forKey: "HOLDINGWEAPON") != nil {
                        CurrentWeapon =  prefs.value(forKey: "HOLDINGWEAPON") as! NSString
                        print("Current Weapon = \(CurrentWeapon)")
                        if CurrentWeapon == "Night Vision Goggles" {
                            print("You're holding Night Vision Goggles")
                            self.ToggleNightVision(true)
                        }
                        
                        
                    } else {
                        CurrentWeapon =  "Fist"
                    }
                    
                    
                    if prefs.value(forKey: "HOLDINGSHIELD") != nil {
                        CurrentShield =  prefs.value(forKey: "HOLDINGSHIELD") as! NSString
                        
                    } else {
                        CurrentShield =  ""
                    }
                    
                    if prefs.value(forKey: "HOLDINGARMOR") != nil {
                        CurrentArmor =  prefs.value(forKey: "HOLDINGARMOR") as! NSString
                        
                    } else {
                        CurrentArmor =  ""
                    }
                    
                    
                    //tempImage = UIImage(named: "magnum gun.png")!
                    // CurrentWeapon =  prefs.valueForKey("HOLDINGWEAPON") as! NSString
                    
                    /*
                     switch CurrentWeapon {
                     case "binoculars":
                     ToolsBTN.setImage(UIImage(named: "binoculars.png")!, forState:.Normal);
                     case "Fist":
                     ToolsBTN.setImage(UIImage(named: "Fist.png")!, forState:.Normal);
                     case "sniper rifle":
                     ToolsBTN.setImage(UIImage(named: "Sniper Rifle.png")!, forState:.Normal);
                     case "knife":
                     ToolsBTN.setImage(UIImage(named: "knife.png")!, forState:.Normal);
                     default:
                     ToolsBTN.setImage(FistImage, forState:.Normal);
                     }
                     
                     
                     switch CurrentArmor {
                     case "black armor":
                     armorBTN.setImage(UIImage(named: "black armor.png")!, forState:.Normal);
                     case "wood armor":
                     armorBTN.setImage(UIImage(named: "wood armor.png")!, forState:.Normal);
                     
                     default:
                     break
                     //  armorBTN.setImage(tempImage, forState:.Normal);
                     }
                     
                     switch CurrentShield {
                     case "blue shield":
                     shieldBTN.setImage(UIImage(named: "blue shield.png")!, forState:.Normal);
                     case "metal shield":
                     shieldBTN.setImage(UIImage(named: "metal shield.png")!, forState:.Normal);
                     case "wooden sheild":
                     shieldBTN.setImage(UIImage(named: "wooden shield.png")!, forState:.Normal);
                     case "american shield":
                     shieldBTN.setImage(UIImage(named: "American Shield.png")!, forState:.Normal);
                     default:
                     break
                     // shieldBTN.setImage(tempImage, forState:.Normal);
                     }
                     */
                    if CurrentWeapon != "" {
                        
                        if prefs.value(forKey: "\(CurrentWeapon)ImageIcon") != nil {
                       // print("\(CurrentWeapon)ImageIcon is Not Nil")
                        let CurrentWeaponStringURL = prefs.value(forKey: "\(CurrentWeapon)ImageIcon") as! String
                        let CurrentWeaponurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentWeaponStringURL).png")
                        let CurrentWeaponImageData = try? Data(contentsOf: CurrentWeaponurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentWeaponImage = UIImage(data: CurrentWeaponImageData!)
                        ToolsBTN.setImage(CurrentWeaponImage, for:UIControl.State());
                            
                        } else {

                          //NOTIFICAITON TO DOWNLOAD IMAGES FROM SERVER
                         NotificationCenter.default.post(name: Notification.Name(rawValue: "RefreshItemInfo"), object: nil, userInfo: nil)

                        
                        // print("\(CurrentWeapon)ImageIcon IS Nil")
                         ToolsBTN.setImage(UIImage(named: "Fist.png"), for:UIControl.State());

                        }
                        
                    } else {
                        
                        ToolsBTN.setImage(UIImage(named: "Fist.png"), for:UIControl.State());
                        
                    }
                    print("Current Armor = \(CurrentArmor)")
                    if CurrentArmor != "" {
                        let CurrentArmorStringURL = prefs.value(forKey: "\(CurrentArmor)ImageIcon") as! String
                        let CurrentArmorurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentArmorStringURL).png")
                        let CurrentArmorImageData = try? Data(contentsOf: CurrentArmorurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentArmorImage = UIImage(data: CurrentArmorImageData!)
                        armorBTN.setImage(CurrentArmorImage, for:UIControl.State());
                    } else {
                        armorBTN.setImage(UIImage(named: "ArmorIconNA.png")!, for:UIControl.State());
                    }
                    
                    
                    if CurrentShield != "" {
                        let CurrentShieldStringURL = prefs.value(forKey: "\(CurrentShield)ImageIcon") as! String
                        let CurrentShieldurl = URL(fileURLWithPath: dirpath).appendingPathComponent("\(CurrentShieldStringURL).png")
                        let CurrentShieldImageData = try? Data(contentsOf: CurrentShieldurl)
                        
                        // let url = NSURL.fileURLWithPath(path)
                        let CurrentShieldImage = UIImage(data: CurrentShieldImageData!)
                       // shieldBTN.setImage(CurrentShieldImage, for:UIControl.State());
                    } else {
                        
                       // shieldBTN.setImage(UIImage(named: "ShieldIconNA.png"), for:UIControl.State());
                        
                    }
                    
                    
                    //   var currentloc = currentLocation.coordinate.latitude
                    //  var currentlong = currentLocation.coordinate.longitude        // Do any additional setup after loading the view.
                    //mapView.delegate = self
                    
                    //let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    //username = prefs.valueForKey("USERNAME") as! NSString as String
                   
                    
                    
                    
                    
                                 //TimerData = [username, mylat, mylong]
                    // UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("SaveMyLocTimer"), userInfo: TimerData, repeats: true)
                    // GPSData =
                    //StartSavingMyLoc()
                    
                    //var userinfo:[Double] = [mylat, mylong]
                    
                    /*
                     
                     dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                     
                     self.UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("StartSavingMyLoc:"), userInfo: ["lat":self.mylat, "long":self.mylong], repeats: true)
                     
                     //}
                     }
                     */
                    
                    
                    //UNCOMMENT BELOW
                    // UpdateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: Selector("StartSavingMyLoc:"), userInfo: ["lat":mylat, "long":mylong], repeats: true)
                    
                    print("TRACKING STARTED")
                    tracking.startTracking()
                    
                    
                    
                    //userRadius = 10
                    self.itemRadius = 1
                    
                    
                    
                    
                    
                    //DELETE BELOW
                  
                    var URLData = CompleteLocations(username, latitude: mylat, longitude: mylong, radius: userRadius, altitude: myalt)
                    //  println("URLData: \(URLData)")
                    var LocInfo = FilterGameData(URLData)
                    //   println("LocInfo: \(LocInfo)")
                    //playernameInfo = LocInfo[0] as! [(NSString)]
                    //print("ITEM RADIUS = \(itemRadius)")
             
                    
                    
                    
                    var URLDataItems = ItemLocations(username, latitude: mylat, longitude: mylong, radius: itemRadius, altitude: myalt)
                    
                       //print("Items - URLData: \(URLDataItems)")
                   
                    var ItemInfo = FilterItemData(URLDataItems)
                    //   println("LocInfo: \(ItemInfo)")
                    
                    
                    var TerritoryURLData = GetTerritory(email, Type: "all")
                    TerritoryInfoArray = FilterTerritoryData(TerritoryURLData)
                    
                    DispatchQueue.main.async(execute: {
                       // print("Territory Array Count: \(self.TerritoryInfoArray.count)")
                        self.RenderTerritoryArray(self.TerritoryInfoArray)
                    })
                    
                    let level = prefs.value(forKey: "USERLEVEL") as! String
                    let status = "incomplete"
                    
                    let MissionURLData = GetMission(self.email, level: level as NSString, status: status as NSString)
                    MissionInfoArray = FilterMissionItems(MissionURLData)
                    
                    
                    let CameraURLData = GetCameras(self.email, level: level as NSString, status: status as NSString)
                    NearbyCameras = FilterCameraItems(CameraURLData)
                        
                    let OtherCameraURLData = GetOtherCameras(self.email, level: level as NSString, status: status as NSString, background: false)
                    OtherNearbyCameras = FilterOtherCameraItems(OtherCameraURLData)
                    
                   // AddCameras()
                    
                    
                        let HomeURLData = GetHomeInfo(self.email, level: level as NSString, status: status as NSString)
                        IsHomeSet = FilterHomeItems(HomeURLData)
                    
                    
                    
                    
                    if (prefs.value(forKey: "SELECTEDWEAPON") != nil) {
                        var defaultWeapon =  prefs.value(forKey: "SELECTEDWEAPON") as! UIImage
                        
                        self.armorBTN.setImage(defaultWeapon, for:UIControl.State())
                    }
                    
                    if (prefs.value(forKey: "SELECTEDSHIELD") != nil) {
                        var defaultShield =  prefs.value(forKey: "SELECTEDSHIELD") as! UIImage
                        
                        self.armorBTN.setImage(defaultShield, for:UIControl.State())
                    }
                    
                    if (prefs.value(forKey: "SELECTEDARMOR") != nil) {
                        var defaultArmor =  prefs.value(forKey: "SELECTEDARMOR") as! UIImage
                        
                        self.armorBTN.setImage(defaultArmor, for:UIControl.State())
                    }
                    
                    
                    /*
                     println("adding label")
                     let MyLabel = UserLabel(title: "jared", userHealth: "100.0", discipline: "test", coordinate: CLLocationCoordinate2D(latitude: mylat, longitude: mylong))
                     
                     mapView.addAnnotation(MyLabel)
                     
                     for items in LocInfo {
                     
                     }
                     
                     let MyLabel2 = UserLabel(title: "jared", userHealth: "100.0", discipline: "test", coordinate: CLLocationCoordinate2D(latitude: 28.81142, longitude: -81.3414234))
                     
                     mapView.addAnnotation(MyLabel2)
                     */
                        
                    } else {
                        
                        
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Location Error"
                        alertView.message = "We need to track your location, please update your location tracking settings in your general settings"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                       // alertView.show()
                        
                        
                        let alertController = UIAlertController(
                            title: "We Can't Get Your Location",
                            message: "Turn on location services on your device.",
                            preferredStyle: .alert)
                        
                      //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                      //  alertController.addAction(cancelAction)
                        
                        let openAction = UIAlertAction(title: "Location Settings", style: .default) { (action) in
                            if let url = URL(string:UIApplication.openSettingsURLString) {
                                UIApplication.shared.openURL(url)
                            }
                        }
                        alertController.addAction(openAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    
                    
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Location Error"
                    alertView.message = "We need to track your location, please update your location tracking settings in your general settings"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    //  alertView.show()
                    
                    
                    
                    var alertController = UIAlertController (title: "Location Error", message: "Update Settings", preferredStyle: .alert)
                    
                    var settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                        
                        let LocationUrl = URL(string:"prefs:root=LOCATION_SERVICES")
                        
                        if let url = LocationUrl {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    
                    var cancelAction = UIAlertAction(title: "Later", style: .default, handler: nil)
                    alertController.addAction(settingsAction)
                    alertController.addAction(cancelAction)
                    
                    present(alertController, animated: true, completion: nil);
                    
                    
                    
                    
                }
            }
                
            else
                
            {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Network Error"
                alertView.message = "Please Confirm your network settings"
                alertView.delegate = self
                
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
            
            
            
        }
        
        
        if WasAttacked == "yes" {
            
            DispatchQueue.main.async(execute: {
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "You Were Attacked!"
                alertView.message = "Uh Oh you were attacked"
                alertView.delegate = self
                
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            })
            
            
            
            prefs.set("no", forKey: "WASATTACKED")
            
            /*
             let subViews = self.view.subviews
             for subview in subViews{
             if subview.tag == 1000 {
             subview.removeFromSuperview()
             }
             }
             
             dispatch_async(dispatch_get_main_queue(), {
             var view = ArmorMenu.instanceFromNib()
             view.tag = 1000
             self.view.addSubview(view)
             })
             */
            
            
        } else {
            print("You were not attacked")
        }
        
        
        //  print("Setting up notification settings")
        setupNotificationSettings()
        
        
        
        
        OpenedFromLocalNotification = prefs.bool(forKey: "OPENEDFROMLOCALNOTIFICATION")
        print("OpenedFromLocalNotification = \(OpenedFromLocalNotification)")
        
        if OpenedFromLocalNotification {
            
            self.CenterOnUser = false
            // self.CenterUserBTN.setImage(UIImage(named: "CenterMapIconColor.png"), forState: UIControl.State.Selected)
            self.CenterUserBTN.setImage(UIImage(named: "Center Direction-50.png"), for: UIControl.State())
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Should Center Now"
            alertView.message = "Test"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            //alertView.show()
            
            
            //OpenedFromLocalNotification = false
            prefs.set(false, forKey: "OPENEDFROMLOCALNOTIFICATION")
            
            LocNotItemName = prefs.value(forKey: "LOCNOTIFYITEMNAME") as! String
            
            let LocNotItemLattemp = prefs.value(forKey: "LOCNOTIFYITEMLAT") as! String
            
            let LocNotItemLongtemp = prefs.value(forKey: "LOCNOTIFYITEMLONG") as! String
            
            LocNotItemLat = Double(LocNotItemLattemp)!
            LocNotItemLong = Double(LocNotItemLongtemp)!
            
            CenterOnItem(LocNotItemName, latitude: LocNotItemLat, longitude: LocNotItemLong)
            
        } else {
            
            self.CenterUserBTN.setImage(UIImage(named: "CenterMapIconColor.png"), for: UIControl.State())
            self.CenterOnUser = true
        }
        
        //  print("my health is \(prefs.integerForKey("MYHEALTH"))")
        
        let myhealth = prefs.integer(forKey: "MYHEALTH")
        print("My Health = \(myhealth)")
        let myhealthDouble = Double(myhealth)
        print("my health double = \(myhealthDouble)")
        
        let healthprogresstemp = myhealthDouble / 100
        
        print("my health temp = \(healthprogresstemp)")
        
        healthprogress = Float(healthprogresstemp)
        
        //print("MY HEALTH PROGRESs = \(healthprogress)")
        
        
        if healthprogress > 0.5 {
            self.healthLBL.text = (healthprogress * 100).description
            //self.healthLBL.textColor = UIColor.whiteColor()
           // self.healthProgressView.fillDoneColor = UIColor.greenColor()
        } else {
            self.healthLBL.text = (healthprogress * 100).description
           // self.healthLBL.textColor = UIColor.darkGrayColor()
            if healthprogress < 0.3 {
                self.healthProgressView.fillDoneColor = UIColor.red
            } else {
                self.healthProgressView.fillDoneColor = UIColor.orange
            }
        }
        
        self.healthProgressView.setProgress(healthprogress, animated: true)
        self.healthProgressView.progress = healthprogress
        
        
        if staminaprogress > 0.5 {
            self.staminaLBL.text = (staminaprogress * 100).description
           // self.staminaLBL.textColor = UIColor.blackColor()
            self.staminaProgressView.fillDoneColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
            //UIColor.greenColor()
            
            //UIColor(red: 241/255, green: 196/255, blue: 15/255)
        } else {
            self.staminaLBL.text = (staminaprogress * 100).description
          //  self.staminaLBL.textColor = UIColor.darkGrayColor()
            if staminaprogress < 0.3 {
                self.staminaProgressView.fillDoneColor = UIColor.red
            } else {
                self.staminaProgressView.fillDoneColor = UIColor.orange
            }
        }
        
        self.staminaProgressView.setProgress(staminaprogress, animated: true)
        self.staminaProgressView.progress = staminaprogress
        
        DispatchQueue.main.async(execute: {
        self.DisplayLoadingView(false)
        })
        
        /*
        var Point1 = CLLocationCoordinate2D()
        var Point2 = CLLocationCoordinate2D()
        var Point3 = CLLocationCoordinate2D()
        var Point4 = CLLocationCoordinate2D()
        
        Point1 = CLLocationCoordinate2D(latitude: 28.811515, longitude: -81.340064)
        Point2 = CLLocationCoordinate2D(latitude: 28.812759, longitude: -81.340059)
        Point3 = CLLocationCoordinate2D(latitude: 28.813172, longitude: -81.34081)
        Point4 = CLLocationCoordinate2D(latitude: 28.811555, longitude: -81.341304)
        
        addBoundry(Point1, Point2: Point2, Point3: Point3, Point4: Point4, id: "NA")
        */
        
        
        if prefs.value(forKey: "NEARITEMSARRAY") != nil {
            var NearItemsArray = [NSDictionary]()
            
            print("MAP VIEW, NEARITEMSARRAY is not nil")
            //let NearItemsArrayData = prefs.valueForKey("NEARITEMSARRAY") as! NSData
            
            NearItemsArray = prefs.value(forKey: "NEARITEMSARRAY") as! [NSDictionary]
            
            // NearItemsArray.append(NearItemsInfo(itemID: itemID, itemName: itemName, itemLat: lat, itemLong: long))
           // NearItemsArray.append(["itemName":"\(itemName)","itemID":"\(itemID)","itemLat":"\(lat.description)","itemLong":"\(long.description)"])
            
            
            var ItemsMissedNameArray = [String]()
            var MissedItemsInfoTemp = [NearbyItem]()
            
            
            
            for itemsMissed in NearItemsArray {
                
                let theItemName = itemsMissed["itemName"] as! String
                let theItemID = itemsMissed["itemID"] as! String
                let theItemLatTemp = itemsMissed["itemLat"] as! String
                
                let theItemLat = Double(theItemLatTemp)!
                let theItemLongTemp = itemsMissed["itemLong"] as! String
                let theItemLong = Double(theItemLongTemp)!
                let theImageName = itemsMissed["imageName"] as! String
                
                
                ItemsMissedNameArray.append(theItemName)
                
                let TempImage = UIImage(named: "Fist.png")!
                
                MissedItemsInfoTemp.append(NearbyItem(name: theItemName, itemStatus: "", Location: CLLocationCoordinate2D(latitude: theItemLat, longitude: theItemLong), itemID: theItemID, itemImage: TempImage, imageName: theImageName))
                
            }
           
            prefs.removeObject(forKey: "NEARITEMSARRAY")
            
            
            
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Missed Items"
            alertView.message = "You misssed these items: \(ItemsMissedNameArray)"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            */
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    subview.removeFromSuperview()
                }
            }
            
          //  var MissedItemsInfoTemp = [MissedItemsInfo]()
            
          //  let TempImage = UIImage(named: "Fist.png")!
          //  let TempImage2 = UIImage(named: "binoculars.png")!
            
       //     MissedItemsInfoTemp.append(MissedItemsInfo(itemName: "Fist", itemImage: TempImage))
        //    MissedItemsInfoTemp.append(MissedItemsInfo(itemName: "Binoculars", itemImage: TempImage2))
            
            DispatchQueue.main.async(execute: {
                var view = MissedItemsView.instanceFromNib(MissedItemsInfoTemp)
                view.tag = 1000
                self.view.addSubview(view)
            })
            
            
        }
        
        let userCoordinate = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
        
        let eyeLat = mylat - 0.021078
        let eyeLong = mylong + 0.04904
        let eyeCoordinate = CLLocationCoordinate2D(latitude: eyeLat, longitude: eyeLong)
        let mapCamera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 100.0)
        
       // mapView.setCamera(mapCamera, animated: true)
        
        
       
        
        print("Should add overlay view did appear")
        //let tempImage = UIImage(named: "fortressIconTemplate.png")!
        
        let midPoint = CGPoint(x: 28.812000, y: -81.340900)
        let Point1 = CGPoint(x: 28.811515, y: -81.340064)
        let Point2 = CGPoint(x: 28.812759, y: -81.340059)
        let Point3 = CGPoint(x: 28.813172, y: -81.34081)
        let Point4 = CGPoint(x: 28.811555, y: -81.341304)
        
       // let tempImage = "fortressIconTemplate.png"
        let tempImage = "fortressIconTemplate"
        var TestImageIconForMap = ImageIconForMap(imageName: tempImage, CenterPoint: midPoint, Point1: Point1, Point2: Point2, Point3: Point3, Point4: Point4)
        
        DispatchQueue.main.async(execute: {
        self.AddImageOverlayTemp(TestImageIconForMap)
        })
        
        
        UpdateDaylight()
        
        
        /*
         dispatch_async(dispatch_get_main_queue(), {
            
        let overlay = ImageMapOverlay(ImageIconOverlay: TestImageIconForMap) // as! ImageMapOverlay
        print("Over is from View did apepar: \(overlay)")
        print("adding Overlay from View did appear")
        self.mapView.addOverlay(overlay)
       // self.mapView.addOverlayImage(self.mapView, rendererForOverlay: overlay)
        
        })
        */
        
       
        
        //SunLightEffect(CurrentTime, SunsetTime: SunSet!, SunriseTime: SunRise!)
      //  self.EffectsViewLBL.text = "Effects View: Sunrise = \(SunRise) and Sunset = \(SunSet)"
        
   
        /*
        dispatch_async(dispatch_get_main_queue(),{
        let degreeTemp = 1.0
    
        self.UpdateWeather("snow", degree: degreeTemp)
            
        })
        */
        
        
        
        let seconds = 4.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
       // MoveClouds("in")
        
        if !CloudsMovedOut {
         DispatchQueue.main.async(execute: {
       // dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.MoveClouds("out")
            print("Clouds moved out at view did appear")
            self.CloudsMovedOut = true
        })
        
        }
        /*
        let tempH = prefs.integerForKey("MYHEALTH")
        let tempH2 = tempH / 100
        healthprogress = Float(tempH2)
        */
        
        
        
        
        if prefs.integer(forKey: "MYHEALTH") < 100 {
            StartHealthProduction()
        }
        
       
        
        if prefs.integer(forKey: "MYSTAMINA") < 100 {
            StartStaminaProduction()
        }
        
        
        
        var homelevel = "1"
        // let level = prefs.value(forKey: "USERXPLEVEL") as! String
        let homestatus = "incomplete"
        
       // let HomeURLData = GetHomeInfo(self.email, level: homelevel as NSString, status: homestatus as NSString)
       // IsHomeSet = FilterHomeItems(HomeURLData)
        
       // print("***Is Home Set: \(IsHomeSet)")
        
        
        
        
    }
    
    func MergeMyLevelMissions(username: NSString, email: NSString, lat: Double, long: Double, alt: Double) {
        
        
        print("!!!MERGING MY LEVEL MISSIONS NOW")
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        //GET MY CURRENT MISSIONS (IN USERS DATABASE)
        let URLData = GetMission(email, level: level as NSString, status: status as NSString)
        
        
        let MissionIDsArray = FilterMyMissionsData(URLData)
        
        print("My Current Mission IDs: \(MissionIDsArray)")
        let URLDataItems = GetServerMissionData(username, level: level as NSString)
        let (WasMyMissionsUpdated, NewMissionsCount) = MergeMissionInfoData(URLDataItems, CurrentMissionIDs: MissionIDsArray, email: email, lat: lat, long: long, alt: alt)
        
        if NewMissionsCount > 0 {
            missionNotificationView.isHidden = false
            missionNotificationLBL.text = NewMissionsCount.description
        } else {
            missionNotificationView.isHidden = true
        }
        
    }
    
    func UpdateDaylight() {
        
        
        
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let solar = Solar(withTimeZone: TimeZone.autoupdatingCurrent, latitude: mylat, longitude: mylong)
        
        let IsItDayTime = solar?.isDaytime
        let IsItNightTime = solar?.isNighttime
        
      //  print("Solar: is it day time: \(IsItDayTime)")
        
       // print("Solar: is it night time: \(IsItNightTime)")
        
        let SunRise = solar!.sunrise
        let SunSet = solar!.sunset
        let CurrentTime = Date()
        
        
        let SunRiseTempString = "2016-05-03 07:33:12"
        let SunSetTempString = "2016-05-02 18:33:12"
        let CurrentTimeTempString = "2016-05-02 23:33:12"
        
        
        let SunRiseTemp = formatter.date(from: SunRiseTempString)
        let SunSetTemp = formatter.date(from: SunSetTempString)
        let CurrentTimeTemp = formatter.date(from: CurrentTimeTempString)
        
       // print("SUN RISE TEMP TIME FROM STRING = \(SunRiseTemp)")
       // print("SUN SET TEMP TIME FROM STRING = \(SunSetTemp)")
       // print("CURRENT TEMP TIME FROM STRING = \(CurrentTimeTemp)")
        /*
         formatter.timeZone = NSTimeZone.localTimeZone()
         
         let CurrentLocalTime = formatter.stringFromDate(CurrentTime)
         print("Current Local Time = \(CurrentLocalTime)")
         
         let CurrentSunRiseTime = formatter.stringFromDate(SunRise!)
         print("Current Local Sunrise Time = \(CurrentSunRiseTime)")
         
         let CurrentSunSetTime = formatter.stringFromDate(SunSet!)
         print("Current Local Sunset Time = \(CurrentSunSetTime)")
         
         */
        // let CurrentLocalTime = CurrentTime - ltzOffset()
        
        /*
         let date = NSDate()
         let calendar = NSCalendar.currentCalendar()
         let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
         let hour = components.hour
         let minutes = components.minute
         */
        
        /*
        var BeforeSunrise = Bool()
        
        if CurrentTime < SunRise {
            BeforeSunrise = true
        } else {
           BeforeSunrise = false
        }
 
        
        let BeforeSunrise = CurrentTime < SunRise!
        let BeforeSunset = CurrentTime < SunSet!
        
        print("Is Current Time: \(CurrentTime) < SunRise: \(SunRise).....\(BeforeSunrise)")
        print("Is Current Time: \(CurrentTime) < SunSet: \(SunSet).....\(BeforeSunset)")
        
        */
        
        //DimLightValue = SunLightEffect(CurrentTimeTemp!, SunsetTime: SunSetTemp!, SunriseTime: SunRiseTemp!, IsDayTime: IsItDayTime)
        
        DimLightValue = SunLightEffect(CurrentTime, SunsetTime: SunSet!, SunriseTime: SunRise!, IsDayTime: IsItDayTime!)
        
       // print("DimLightValue = \(DimLightValue.description)")
        
        
        ChangeSunLightEffect(DimLightValue)
    }
    
    
    
    
    func createOverlay(_ frame : CGRect, DimValue: CGFloat)
    {
        
        let overlayView = UIView(frame: frame)
        overlayView.alpha = DimValue
        overlayView.backgroundColor = UIColor.black
        self.daylightView.addSubview(overlayView)
        
        let maskLayer = CAShapeLayer()
        
        // Create a path with the rectangle in it.
        var path = CGMutablePath()
        
        let radius : CGFloat = 60.0
        let xOffset : CGFloat = (device.width/2) - 30
        let yOffset : CGFloat = (device.height/2) - 30
        
        let Tangent1_Temp = overlayView.frame.width - (radius/2)// - xOffset
        let Tangent1 = Tangent1_Temp - xOffset
       // var colorG = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        var colorG = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        path.addArc(tangent1End: CGPoint(x: overlayView.frame.width - radius/2 - xOffset, y: yOffset), tangent2End: CGPoint(x: 0.0, y: 2 * 3.14), radius: radius)
       // path.addArc(tangent1End: Tangent1, tangent2End: yOffset, radius: radius)
       // CGPathAddArc(path, nil, overlayView.frame.width - radius/2 - xOffset, yOffset, radius, 0.0, 2 * 3.14, false)
       // CGPathAddRect(path, nil, CGRect(x: 0, y: 0, width: overlayView.frame.width, height: overlayView.frame.height))
        path.addRect(CGRect(x: 0, y: 0, width: overlayView.frame.width, height: overlayView.frame.height))
        
        var CircleLayer: CALayer = RadialGradientLayer(center: CGPoint(x: overlayView.center.x, y: overlayView.center.y + 20), radius: radius, colors: colorG)
        //CircleLayer.center
        
        /*
        let l = CAGradientLayer()
        l.frame = overlayView.bounds
        l.colors = [UIColor.clearColor(), UIColor.blackColor()]
        l.startPoint = CGPointMake(overlayView.center.x, overlayView.center.y + 20)
         //  l.endPoint = CGPointMake(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>)
        */
        
      
        
        maskLayer.backgroundColor = UIColor.black.cgColor
        //maskLayer.backgroundColor = UIColor.blackColor().CGColor
        
        maskLayer.path = path;
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
       // overlayView.layer.m
        // Release the path since it's not covered by ARC.
        overlayView.layer.mask = maskLayer
        //overlayView.layer.mask = CircleLayer
        overlayView.clipsToBounds = true
    }
    
    func ChangeSunLightEffect(_ DimValue: Double) {
        
      
        
        
        let DimValueTemp = CGFloat(DimValue)
        //print("Flash Light, Dim Value: \(DimValueTemp.description)")
      //  createOverlay(self.view.frame, DimValue: DimValueTemp)
        
        if !NightVisionOn {
        
        self.daylightView.backgroundColor = UIColor.black
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.daylightView.alpha = DimValueTemp
           // self.loadingView.hidden = true
        })
            
        }
        
    }
    
    @IBAction func FlashLightBTN(_ sender: AnyObject) {
        
        print("Flashlight button tapped")
        
        //FlashLight(self.DimLightValue)
        FlashLight(self.DimLightValue)
        
    }
    
    
    func FlashLight(_ DimValue: Double) {
        
        let DimValueTemp = CGFloat(DimValue)
        
        if FlashlightOn {
          
            self.daylightView.subviews.forEach({$0.removeFromSuperview() })
            ChangeSunLightEffect(DimLightValue)
            FlashlightOn = false
            print("Flashlight off")
          
        } else {
        
           self.daylightView.backgroundColor = UIColor.clear
           createOverlay(self.view.frame, DimValue: DimValueTemp)
           FlashlightOn = true
            print("Flashlight on")
        }
        
        
    }
    
    
    
    func ConvertZoomRadius(_ UserZoomRadiusTemp: Double) -> Double {
        
        var NewZoomRadius = Double()
        
        switch UserZoomRadiusTemp {
            
        case 1:
            NewZoomRadius = 0.5
        case 2:
            NewZoomRadius = 17.5
        case 3:
            NewZoomRadius = 17
        case 4:
            NewZoomRadius = 16
        case 5:
            NewZoomRadius = 15
        case 6:
            NewZoomRadius = 14
        case 7:
            NewZoomRadius = 13
        case 8:
            NewZoomRadius = 12
        case 9:
            NewZoomRadius = 11
        case 10:
            NewZoomRadius = 10
        case 11:
            NewZoomRadius = 9
        case 12:
            NewZoomRadius = 8
        case 13:
            NewZoomRadius = 7
        case 14:
            NewZoomRadius = 6
        case 15:
            NewZoomRadius = 5
        case 16:
            NewZoomRadius = 4
        case 17:
            NewZoomRadius = 3
        case 18:
            NewZoomRadius = 2
        case 19:
            NewZoomRadius = 1
        case 20:
            NewZoomRadius = 0.01
        default:
            NewZoomRadius = 17.5
            
        }
        
        return NewZoomRadius
    }
    
    
    func DisplayLoadingView(_ show: Bool) {
        
        
        if !show {
        self.loadingView.isHidden = false
        self.loadingView.alpha = 1.0
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.loadingView.alpha = 0.0
            self.loadingView.isHidden = true
        })
        } else {
            self.loadingView.isHidden = true
            self.loadingView.alpha = 0.0
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.loadingView.alpha = 1.0
                self.loadingView.isHidden = false
            })
        }
        
    }
    
    @objc func UpdateTabBarItems(_ notification: Notification)
    {
        
        let attPointDouble = prefs.double(forKey: "MyAttributePoints")
        let attPointCount = Int(attPointDouble)
        
        if attPointCount > 0 {
            tabBarItemPlayer.badgeValue = "\(attPointCount)"
        } else  {
            tabBarItemPlayer.badgeValue = nil
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let tabBarControllerItems = self.tabBarController?.tabBar.items
        
        if let arrayOfTabBarItems = tabBarControllerItems as! AnyObject as? NSArray{
            
            tabBarItemMap = arrayOfTabBarItems[0] as! UITabBarItem
            //tabBarItemONE.enabled = false
            
            tabBarItemPlayer = arrayOfTabBarItems[1] as! UITabBarItem
            //(tabBarController!.tabBar.items![1] as! UITabBarItem).badgeValue = "2"
            
            let attPointDouble = prefs.double(forKey: "MyAttributePoints")
            let attPointCount = Int(attPointDouble)
            
            if attPointCount > 0 {
            (arrayOfTabBarItems[1] as! UITabBarItem).badgeValue = "\(attPointCount)"
            }
            
//           // let tabBarItemPlayerNew = UIButton(type: UIButton.ButtonType.system) as UIButton
//            let tabBarItemPlayerNew = UIButton(type: UIButton.ButtonType.system) as UITabBarItem
//            
//            let attPointDouble = prefs.double(forKey: "MyAttributePoints")
//            let attPoinCount = round(attPointDouble)
//            // var msgLBL = UILabel()
//            attmsgLBL.frame = CGRect(x: 20, y: 5, width: 18, height: 18)
//            attmsgLBL.backgroundColor = UIColor.red
//            attmsgLBL.layer.cornerRadius = 9
//            attmsgLBL.layer.masksToBounds = true
//            attmsgLBL.clipsToBounds = true
//            attmsgLBL.text = "\(UserMessageCount.description)"
//            attmsgLBL.textColor = UIColor.white
//            attmsgLBL.textAlignment = NSTextAlignment.center
//            
//            attmsgLBL.font = attmsgLBL.font.withSize(10)
//            
//            tabBarItemPlayerNew.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            tabBarItemPlayerNew.setImage(UIImage(named: "message-7.png"), for: UIControl.State())
//            tabBarItemPlayerNew.imageView!.tintColor = UIColor(red: 145/255, green: 28/255, blue: 37/255, alpha: 1.0)
//            //MenuButtonNew.tintColor = UIColor(red: 145/255, green: 28/255, blue: 37/255, alpha: 1.0)
//            //MenuButtonNew.imageView.t
//            tabBarItemPlayerNew.addSubview(attmsgLBL)
//            
//            tabBarItemPlayerNew.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
//            
//            menuButton = UIBarButtonItem(customView: tabBarItemPlayerNew)
            
            
            
            //tabBarItemPlayer.enabled = false
            
            tabBarItemTeam = arrayOfTabBarItems[2] as! UITabBarItem
            //tabBarItemTeam.enabled = false
            
        }

      //  healthprogress = Float(prefs.integerForKey("MYHEALTH") / 100)
        
      //  print("MY HEALTH PROGRESS View will appear = \(healthprogress)")
      
       // self.healthProgressView.setProgress(healthprogress, animated: true)
      //  self.healthProgressView.progress = healthprogress
 
    }
    
    
    @objc func EnableTabBarItems(_ notification: Notification)
    {
        
        tabBarItemPlayer.isEnabled = true
        tabBarItemTeam.isEnabled = true
        
    }
    
    
    
    
    
    func StartSavingMyLoc(_ val: Timer){
        
       // print("My Location is now being saved")
        
      //  dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            
        
        
        var arr = val.userInfo as! NSDictionary
      //  println("userinfo1 = \(val.userInfo)")
      //  println("user info = \(arr)")
        var mylatRefresh = arr["lat"] as! Double
        var mylongRefresh = arr["long"] as! Double
        var myaltRefresh = arr["alt"] as! Double

            if SaveMyLoc(username, latitude: mylatRefresh, longitude: mylongRefresh, email: self.email, altitude: myaltRefresh) {
            print("My loc (lat: \(mylatRefresh) long: \(mylongRefresh)) have been saved to server")
           // return true
        }
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        
        
        var URLData = CompleteLocations(username, latitude: mylatRefresh, longitude: mylongRefresh, radius: userRadius, altitude: myalt)
       // println("URLData Refreshed: \(URLData)")
        var LocInfo = FilterGameData(URLData)
      //  println("LocInfo Refreshed: \(LocInfo)")
     //   println("User Locations Updated")
 
 
        
        var URLDataItems = ItemLocations(username, latitude: mylat, longitude: mylong, radius: itemRadius, altitude: myalt)
       // println("URLData: \(URLDataItems)")
        var ItemInfo = FilterItemData(URLDataItems)
       // println("LocInfo: \(ItemInfo)")/*
       // print("items location updated")
       // }

    }

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeaponsMenu" {
            
            if let WeaponsViewController = segue.destination as? WeaponsViewController {
          //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
            WeaponsViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            WeaponsViewController.popoverPresentationController!.delegate = self
            
            WeaponsViewController.myLat = self.mylat.description
            WeaponsViewController.myLong = self.mylong.description
           
            }

        } else
        
        if segue.identifier == "ArmorMenu" {
            if let ArmorViewController = segue.destination as? UIViewController {
            ArmorViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            ArmorViewController.popoverPresentationController!.delegate = self
            }
        }
        
        if segue.identifier == "ShieldMenu" {
            
            if let ShieldViewController = segue.destination as? UIViewController {
            ShieldViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            ShieldViewController.popoverPresentationController!.delegate = self
            }
        }
        
        if segue.identifier == "GameItemView" {
            
         //   let ItemAnnotationViewController = segue.destinationViewController as! UIViewController
         //   ItemAnnotationViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
         //   ItemAnnotationViewController.popoverPresentationController!.delegate = self
            
            
            if let ItemAnnotationViewController = segue.destination as? ItemAnnotationViewController {
                
                var selectedAnnotation: MKAnnotation = self.mapView.selectedAnnotations[0] 
                
                
                //ItemAnnotationViewController.itemTitle = "Test"//SelectedOpponentName as String
                
                //OppStatsViewController.StealthStatus = SelectedOppStealthStatus
                
                print("item view selected")
                
                /*
                 OppStatsViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                 OppStatsViewController.popoverPresentationController!.delegate = self
                 */
            }

            
            
        }
        
        if segue.identifier == "OppStats" {
            
            
            
         if let OppStatsViewController = segue.destination as? OppStatsViewController {
            
            var selectedAnnotation: MKAnnotation = self.mapView.selectedAnnotations[0] 
            
            
                OppStatsViewController.TheirName = SelectedOpponentName as String as String as NSString
            
                OppStatsViewController.StealthStatus = SelectedOppStealthStatus
            
            print("opp view selected")
            
            /*
            OppStatsViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            OppStatsViewController.popoverPresentationController!.delegate = self
*/
            }
        }
            
            if segue.identifier == "goto_attack" {
                if let battlecontroller = segue.destination as? AttackTimerViewController {
                    
                    battlecontroller.AttackingPlayer = AttackingPlayer as String as String as NSString
                    battlecontroller.AttackingPlayersHealth = AttackingPlayersHealth as String as String as NSString
                    battlecontroller.AttackingPlayerID = AttackingPlayerID as String as String as NSString
                    battlecontroller.AttackStatus = AttackStatus
                    battlecontroller.AttackPower = AttackPower
                    //NEED TO ADD ARMOR, PLAYER TYPE ETC VARIABLES
                }
                
              //  battlecontroller.modalPresentationStyle = UIModalPresentationStyle.Popover
             //   battlecontroller.popoverPresentationController!.delegate = self
                
            }
        if segue.identifier == "ViewUserProfile" {
            if let battlecontroller = segue.destination as? UserProfileViewController {
                //print("self.AttackingPlyaer: \(self.AttackingPlayer)")
                battlecontroller.TargetUserName = AttackingPlayer as String
                battlecontroller.TargetUserID = AttackingPlayerID as String
                battlecontroller.TargetLat = AttackingPlayerLat as String
                battlecontroller.TargetLong = AttackingPlayerLong as String
                battlecontroller.TargetAlt = AttackingPlayerAlt as String
            }
            
            
        }
        
        if segue.identifier == "AttackPlayer" {
            if let battlecontroller = segue.destination as? AttackLoadingViewController {
                //AttackMapViewController {
                var wp = String()
                
                if self.prefs.value(forKey: "HOLDINGWEAPON") == nil {
                    wp = "Fist"
                } else {
                    wp = self.prefs.value(forKey: "HOLDINGWEAPON") as! String
                }
                
                battlecontroller.currentWeapon = wp
                
                battlecontroller.MissionID = MissionID
                battlecontroller.MissionLevel = MissionLevel
                battlecontroller.MissionObjective = MissionObjective
                battlecontroller.MissionXP = MissionXP
                battlecontroller.MissionMapURL = MissionMapURL
                battlecontroller.MissionObjectURL = MissionObjectURL
                
                battlecontroller.UserObjective = UserObjective
                
                battlecontroller.AttackingPlayer = AttackingPlayer as String as String as NSString
                battlecontroller.AttackingPlayersHealth = AttackingPlayersHealth as String as String as NSString
                battlecontroller.AttackingPlayerID = AttackingPlayerID as String as String as NSString
                battlecontroller.AttackStatus = AttackStatus
                battlecontroller.AttackPower = AttackPower
                battlecontroller.isAttacking = true
                //NEED TO ADD ARMOR, PLAYER TYPE ETC VARIABLES
            }
            
            //  battlecontroller.modalPresentationStyle = UIModalPresentationStyle.Popover
            //   battlecontroller.popoverPresentationController!.delegate = self
            
        }
        
        }
    
    func UnwindTest() {
   
            self.DoNotUpdateMapBool = true
            self.DoUpdateAnnotations = true
            
            if prefs.value(forKey: "AttackCompletedDictionary") != nil {
                
                
                
                // let tempView: MKAnnotationView = prefs.objectForKey("SELECTEDANNOTATIONVIEW") as! MKAnnotationView
                
                //self.mapView(self.mapView, didDeselectAnnotationView: view)
                
                for views in self.mapView.annotations {
                    print("Deselect Views: \(views)")
                    self.mapView.deselectAnnotation(views, animated: true)
                }
                
                
                
                print("Map ViewAttack Dictinoary not nil")
                
                let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
                
                
                let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
                let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
                
                let AttackPlayerTemp = AttackCompletedDictionary["attackPlayer"] as! String
                let AttackResultTemp = AttackCompletedDictionary["attackStatus"] as! String
                let AttackPowerTemp = AttackCompletedDictionary["attackPower"] as! String
                let AttackNewHealthTemp = AttackCompletedDictionary["attackNewHealth"] as! String
                let AttackStartHealthTemp = AttackCompletedDictionary["attackStartHealth"] as! String
                print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
                print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
                print("From Unwind - players start health: \(AttackStartHealthTemp)")
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Attack Complete"
                alertView.message = "Info(Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount))"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                // alertView.show()
                
                
                
                let subViews = self.view.subviews
                for subview in subViews{
                    if subview.tag == 1000 {
                        self.CapturingTerritory = false
                        subview.removeFromSuperview()
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    var view = AttackCompleteView.instanceFromNib(AttackPlayerTemp, AttackedResult: AttackResultTemp, AttackedPower: AttackPowerTemp, AttackedNewHealth: AttackNewHealthTemp, AttackedStartHealth: AttackStartHealthTemp)
                    view.tag = 1000
                    self.view.addSubview(view)
                })
                
                
                
            }
            
        }
    
    
    
    
    
    
    
    
    @IBAction func unwindToMapView(_ segue: UIStoryboardSegue) {
    
     if let FromAttackViewController = segue.source as? AttackLoadingViewController {
        self.DoNotUpdateMapBool = true
        self.DoUpdateAnnotations = true
        
        if prefs.value(forKey: "AttackCompletedDictionary") != nil {
            
            
            
           // let tempView: MKAnnotationView = prefs.objectForKey("SELECTEDANNOTATIONVIEW") as! MKAnnotationView
            
            //self.mapView(self.mapView, didDeselectAnnotationView: view)
            
            for views in self.mapView.annotations {
                print("Deselect Views: \(views)")
                self.mapView.deselectAnnotation(views, animated: true)
            }
            
           
            
            print("Map ViewAttack Dictinoary not nil")
            
            let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
            
            
            let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
            let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
            
            let AttackPlayerTemp = AttackCompletedDictionary["attackPlayer"] as! String
            let AttackResultTemp = AttackCompletedDictionary["attackStatus"] as! String
            let AttackPowerTemp = AttackCompletedDictionary["attackPower"] as! String
            let AttackNewHealthTemp = AttackCompletedDictionary["attackNewHealth"] as! String
            let AttackStartHealthTemp = AttackCompletedDictionary["attackStartHealth"] as! String
            print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
            print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
            print("From Unwind - players start health: \(AttackStartHealthTemp)")
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Attack Complete"
            alertView.message = "Info(Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount))"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
           // alertView.show()
            
            
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    self.CapturingTerritory = false
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                var view = AttackCompleteView.instanceFromNib(AttackPlayerTemp, AttackedResult: AttackResultTemp, AttackedPower: AttackPowerTemp, AttackedNewHealth: AttackNewHealthTemp, AttackedStartHealth: AttackStartHealthTemp)
                view.tag = 1000
                self.view.addSubview(view)
                self.UpdateMap()
            })
            

            
        }
        
        }

    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController!, traitCollection: UITraitCollection!) -> UIModalPresentationStyle {
      return UIModalPresentationStyle.none
    }

    @IBAction func didmoveButton(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    func GetZoom() -> Double {
        
        let CurrentZoom = mapView.zoomLevel()
       // print("MapView Zoom Level Function \(CurrentZoom)")
        
        
        return Double(CurrentZoom)
        
    }
    
  //  override func real
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //var TempZoomRadius: Double = 1.0
        
        if mylat == 0.0 {
            
          //  print("LAT IS 0.0")
            
            /*
            let LocManagerTemp = CLLocationManager()
            LocManagerTemp.startUpdatingLocation()
            
            if let mylocTemp = LocManagerTemp.location {
            mylat = mylocTemp.coordinate.latitude
            mylong = mylocTemp.coordinate.longitude
            }
            
            */
            
            regionRadius = 200
            
            print("Center Map on User - Region Radius = \(regionRadius)")

            let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
            
            ZoomLevel = self.UserZoomRadius
            mapView.setRegion(coordinateRegion, animated: true)
            
            /*
 LocManager.delegate = self
 LocManager.startUpdatingLocation()
 myloc = LocManager.location!
 mylat = myloc.coordinate.latitude
 mylong = myloc.coordinate.longitude
 */
 
            } else {
            
       //     print("LAT IS NOT 0.0")
      //  print("REGION DID CHANGE My Lat: \(mylat)")
      //  print("REGION DID CHANGE My Long: \(mylong)")
        //let MetersDistance = realWorldDistanceOfMapView(mapView)
        
       // let MetersDistance = mapView.realWorldDistanceOfMapView()
        
      //  print("Meter Real World Distance: \(MetersDistance)")
        
        
        let TempZoomRadius = GetZoom()
        let TempZoomExp = 20 - TempZoomRadius
      
        /*
        print("Region Did Change: Current Zoom Radius (TempZoomRadius) = \(TempZoomRadius)")
        print("Region Did Change: Allowed Zoom Radius (UserZoomRadius) = \(UserZoomRadius)")
        print("Region Did Change: Current Zoom Exponent = \(TempZoomExp)")
        */
        if CapturingTerritory {
            self.mapChangedFromUserInteraction = false
        }
        
        
        if (mapChangedFromUserInteraction) {
            
           
            
            self.CenterOnUser = false
            
            self.CenterUserBTN.setImage(UIImage(named: "Center Direction-50.png"), for: UIControl.State())
            
            
           // print("user CHANGED map.")
            
            if TempZoomExp == 18 {
               
               // print("ZOOMED IN TOO CLOSE, ZOOM OUT!")
                /*
                if !AnnotationTapped {
                
                 mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: 17.9, animated: true)
            
                let TempZoomRadiusTest = GetZoom()
                let TempZoomExpTest = 20 - TempZoomRadiusTest
                
              //  print("Test Region Did Change: Allowed Zoom Radius (UserZoomRadius) = \(UserZoomRadiusTest)")
                print("Test Region Did Change: Current Zoom Exponent = \(TempZoomExpTest)")
                    
                }
                
                */
                
            } else {
            
        
        if TempZoomRadius <= (UserZoomRadius) {
           // print("\(TempZoomRadius) <= \(UserZoomRadius)")
            
            print("Zoom is less than user zoom radius: current zoom - \(TempZoomRadius), max zoom - \(UserZoomRadius)")
            
            
        } else {
            //print("\(TempZoomRadius) > \(UserZoomRadius)")
            print("User Exceeded Zoom Radius, zooming in now")
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    self.CapturingTerritory = false
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                var view = MessageInfoView.instanceFromNib("View Range Exceeded")
                view.tag = 1000
                self.view.addSubview(view)
            })
            
            //mapView.setCoordinateZoom(mapView.centerCoordinate, zoomLevel: (UserZoomRadius * 10), animated: true)
            let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
            
            
            print("New Room Radius = \(NewZoomRadius)")
            
            mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: (NewZoomRadius), animated: true)
            
            //mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: (UserZoomRadius * 10), animated: true)
            
            ShowZoomRadiusError()
            
            switch UserZoomRadius {
            case 1:
               regionRadius = (UserZoomRadius * 10000)
            default:
               regionRadius = (UserZoomRadius * 100)
            }
           // regionRadius = (UserZoomRadius * 1000)
           //regionRadius = (UserZoomRadius * 100)
            
            //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
                //mapView.centerCoordinate.)
         //   print("reset Region to center with zoom level of \(UserZoomRadius)")
        }
                
            }
        
        } else {
            
           // print("Region Changed, NOT from manual interaction")
            var updateRegion: Bool = false
            
           // var locationTemp = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
            
          //  print("My Lat: \(mylat)")
         //   print("My Long: \(mylong)")
            
            var locationTemp = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
            
            var spanTemp = MKCoordinateSpan()
            
            if CapturingTerritory {
                print("IS CAPTURIN TERRITORY")
                 print("Span should be 0.001")
                spanTemp = MKCoordinateSpan (latitudeDelta: 0.003, longitudeDelta: 0.003)
            } else {
              //  print("Span should be 0.005")
                spanTemp = MKCoordinateSpan (latitudeDelta: 0.005, longitudeDelta: 0.005)
            }
            
            //print("REGION DID CHANGE Loc Temp: \(locationTemp)")
            restrictedRegion = MKCoordinateRegion(center: locationTemp, span: spanTemp)
            
            
            if ((mapView.region.span.latitudeDelta > restrictedRegion.span.latitudeDelta * 4) || (mapView.region.span.longitudeDelta > restrictedRegion.span.longitudeDelta * 4) ) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.latitude - restrictedRegion.center.latitude) > restrictedRegion.span.latitudeDelta) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.longitude - restrictedRegion.center.longitude) > restrictedRegion.span.longitudeDelta) {
                updateRegion = true
            }
            if (updateRegion) {
              //  self.manuallyChangingMap = true
                print("Updating region is true")
                self.mapChangedFromUserInteraction = true
                if MapViewLoadComplete {
                mapView.setRegion(restrictedRegion, animated:true)
                }
                self.mapChangedFromUserInteraction = false
               
               self.AfterStartupLoad = true
               // self.manuallyChangingMap = false
            }
            
            
            
            
        }
       // print("REGION CHANGED")
        
    }
    
    }
    
    
    func ShowZoomRadiusError() {
        if  let TempRadiusText = prefs.object(forKey: "WRADIUS") as? Int {
        
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity

        if TempRadiusText < 2 {
            self.VRange.text = "Exceeded Viewing Radius"
        } else {
            self.VRange.text = "Exceeded Viewing Radius"
        }
        
           
            
            
        })
        
         DispatchQueue.main.async(execute: {
          
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                
                if TempRadiusText < 2 {
                    self.VRange.text = "Range: \(self.itemRadius) Mile"
                } else {
                    self.VRange.text = "Range: \(self.itemRadius) Miles"
                }
                
                
            })
            
        })
        //VRange.text = ""
        
        
        //var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
       // prefs.setObject(userRadius, forKey: "WRADIUS")
      //  prefs.setObject(itemRadius, forKey: "VIEWRADIUS")
        
        }
        
    }
    
    
    func CenterOnItem(_ itemName: String, latitude: Double, longitude: Double) {
        
        regionRadius = 200
        
        //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
        
        print("Center Map on Item Name: \(itemName) - Region Radius:\(regionRadius) Lat:\(latitude) Long:\(longitude)")
        
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: latitude, longitude: longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
        
        // mapView.setCenterCoordinate(location.coordinate, animated: true)
        
        ZoomLevel = self.UserZoomRadius
        
        
        //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
        // print("Centering with zoom level \(ZoomLevel)")
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
    
    
    @IBAction func CenterUserLocation(_ sender: AnyObject) {
        
        self.CenterUserBTN.setImage(UIImage(named: "CenterMapIconColor.png"), for: UIControl.State())
        self.CenterOnUser = true
        
        regionRadius = 200
        
        //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
        
        print("Center Map on User - Region Radius = \(regionRadius)")
        
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
        
        // mapView.setCenterCoordinate(location.coordinate, animated: true)
        
        ZoomLevel = self.UserZoomRadius
        
        
        //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
       // print("Centering with zoom level \(ZoomLevel)")
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
       
        regionRadius = 1000
        
        print("Region Radius = \(regionRadius)")
      //  let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        /*
       var coordinateRegion = MKCoordinateRegion()
        
        if CenterFromForeground {
            print("CENTER FROM FOREGROUND CALLED")
            
           coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, regionRadius * 5.0, regionRadius * 5.0)
            
            CenterFromForeground = false
        } else {
        */
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
      //  }
       // mapView.setCenterCoordinate(location.coordinate, animated: true)

        ZoomLevel = self.UserZoomRadius
        
        
     //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
        print("Centering with zoom level \(ZoomLevel)")
        if CenterFromForeground {
        mapView.setRegion(coordinateRegion, animated: true)
            CenterFromForeground = false
        } else {
        mapView.setRegion(coordinateRegion, animated: true)
        }
    }


    
     @IBAction func closeScrollItemsView(_ sender: AnyObject) {
        print("Close scroll tapped")
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.ScrollItemsView.center.y = self.ScrollItemsView.center.y + 255
            self.ScrollItemsViewBOTTOM.constant = -200
            
            
            // self.loadingView.hidden = true
        })
        
        
        self.ScrollItemsInView = false
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
       

        
    }
    
    @objc func ScrollViewSwipeDown(_ gesture: UIGestureRecognizer) {
  
    
    
    
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            print("Swiped right")
        case UISwipeGestureRecognizer.Direction.down:
            print("Swiped down")
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.ScrollItemsView.center.y = self.ScrollItemsView.center.y + 275
                self.ScrollItemsViewBOTTOM.constant = -200
                
                self.ScrollItemsInView = false
                
               
                
                // self.loadingView.hidden = true
            })

            DispatchQueue.main.async(execute: {
            for views in self.ScrollItemsView.subviews {
                views.removeFromSuperview()
            }
            })
            
        case UISwipeGestureRecognizer.Direction.left:
            print("Swiped left")
        case UISwipeGestureRecognizer.Direction.up:
            print("Swiped up")
        default:
            break
        }
    
    }
        
    }
    
    @IBAction func WeaponsPickTest(_ sender: AnyObject) {
        
        
       // self.CloseScrollItemsViewsTap.enabled = true
        self.ScrollItemsInView = true
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = MyWeaponsView.instanceFromNib()
            view.tag = 1000
            
            print("Adding Scroll Sub View")
            self.ScrollItemsView.addSubview(view)
        })
        
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.ScrollItemsView.center.y = self.ScrollItemsView.center.y - 275
            self.ScrollItemsViewBOTTOM.constant = 55
            
            
            // self.loadingView.hidden = true
        })
        
        
    }
    
    @IBAction func weaponsPick(_ sender: AnyObject) {
        
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "WeaponsMenu") as! WeaponsViewController
        
 //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
      //  savingsInformationViewController.delegate=self
        
     //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        savingsInformationViewController.mdelegate = self
        
        
        savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController2 = savingsInformationViewController.popoverPresentationController {
            popoverController2.sourceView = sender as! UIView
            
            popoverController2.sourceRect = sender.bounds
            
            popoverController2.permittedArrowDirections = .any
        popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController2.delegate = self
        }
        present(savingsInformationViewController, animated: true, completion: nil)
        
        
      
    }
    
    @IBAction func ArmorPick(_ sender: AnyObject) {
        
        let armorinfoController = storyboard?.instantiateViewController(withIdentifier: "ArmorMenu") as! ArmorViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text

        armorinfoController.adelegate=self
        
        
        armorinfoController.modalPresentationStyle = .popover
        if let popoverController = armorinfoController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            
            popoverController.sourceRect = sender.bounds
            
            popoverController.permittedArrowDirections = .any
            popoverController.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController.delegate = self
        }
        present(armorinfoController, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func ViewMissions(_ sender: Any) {
    
        self.performSegue(withIdentifier: "currentMissions", sender: self)
        
    }
    
    
    //SHIELD PICK NOT USED RIGHT NOW 1-10-17
    @IBAction func ShieldPick(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "currentTargets", sender: self)
        
        /*
        
        let shieldinfoController = storyboard?.instantiateViewController(withIdentifier: "ShieldMenu") as! ShieldViewController
        
        //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
        //  savingsInformationViewController.delegate=self
        
        //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
        
        shieldinfoController.sdelegate=self
        
        
        shieldinfoController.modalPresentationStyle = .popover
        if let popoverController = shieldinfoController.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            
            popoverController.sourceRect = sender.bounds
            
            popoverController.permittedArrowDirections = .any
            popoverController.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
            
            popoverController.delegate = self
        }
        present(shieldinfoController, animated: true, completion: nil)
        
        
        
        */
        
    }
    
    func FilterTerritoryData(_ urlData: Data) -> [TerritoryInfo] {
       // print("FILTERING TERRITORY DATA NOW")
        
        var TerritoryInfoArrayTemp = [TerritoryInfo]()
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
       // print("Territory Json value: \(jsonData)")
        //  println("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                print("ID did not = NA")
                let pointID = result["id"].stringValue
                let pointLat1temp = result["PointLat1"].stringValue
                let pointLong1temp = result["PointLong1"].stringValue
                
                let pointLat1 = Double(pointLat1temp)
                let pointLong1 = Double(pointLong1temp)
                
                let pointLat2temp = result["PointLat2"].stringValue
                let pointLong2temp = result["PointLong2"].stringValue
                
                let pointLat2 = Double(pointLat2temp)
                let pointLong2 = Double(pointLong2temp)
                
                let pointLat3temp = result["PointLat3"].stringValue
                let pointLong3temp = result["PointLong3"].stringValue
                
                
                let pointLat3 = Double(pointLat3temp)
                let pointLong3 = Double(pointLong3temp)
                
                let pointLat4temp = result["PointLat4"].stringValue
                let pointLong4temp = result["PointLong4"].stringValue
                
                
                let pointLat4 = Double(pointLat4temp)
                let pointLong4 = Double(pointLong4temp)
                
                let pointLat5temp = result["PointLat5"].stringValue
                let pointLong5temp = result["PointLong5"].stringValue
                
                let pointLat5 = Double(pointLat5temp)
                let pointLong5 = Double(pointLong5temp)
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                let killcount = "0"
                let killedcount = "0"
                
                
                if (1 == 1) {
                    TerritoryInfoArrayTemp.append(TerritoryInfo(pointID: pointID, Point1: CLLocationCoordinate2DMake(pointLat1!, pointLong1!), Point2: CLLocationCoordinate2DMake(pointLat2!, pointLong2!), Point3: CLLocationCoordinate2DMake(pointLat3!, pointLong3!), Point4: CLLocationCoordinate2DMake(pointLat4!, pointLong4!), Point5: CLLocationCoordinate2DMake(pointLat5!, pointLong5!)))
                    
                    //  mapView.addAnnotation(MyPlotPoint)
                    
                }
                
                if pointID == "home" {
                    
                    let missionLevel = "0"
                    let imageName = "Tent"
                    let xp = "0"
                    let objective = "NA"
                    
                   let altitude = 0.0
                    
                    let MyHomeBasePlotPoint = MyBaseLabel(title: "", userHealth: "", discipline: "", stealth: "", coordinate: CLLocationCoordinate2DMake(pointLat5!, pointLong5!), image: UIImage(named: "blackFlag.png")!, PinType: "", GoldAmount: "0", isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    
                    mapView.addAnnotation(MyHomeBasePlotPoint)
                }
                /*
                 playernameArray.append(playername)
                 playerlatArray.append(playerlat)
                 playerlongArray.append(playerlong)
                 playerhealthArray.append(playerhealth)
                 playerstealthArray.append(playerstealth)
                 */
            }
            
        }
        /*
         LocationData.append(playernameArray)
         LocationData.append(playerlatArray)
         LocationData.append(playerlongArray)
         LocationData.append(playerhealthArray)
         LocationData.append(playerstealthArray)
         */
        
        return TerritoryInfoArrayTemp
    }
    
    
    func FilterGameData(_ urlData: Data) -> [NSArray] {
        
        var traits = [NSString]()
        
       let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary

        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
      //  println("Json valueJSON: \(json)")

        for result in json["members"].arrayValue {

            if ( result["username"] != "dummy") {
                var imageName = String()
                
                 playername = result["username"].stringValue as NSString
                let targetplayerID = result["playerid"].stringValue
               // print("Playername = \(playername)")
                
                 playerlat2 = result["latitude"].stringValue as NSString
                 playerlong2 = result["longitude"].stringValue as NSString
//                let altitude2 = result["altitude"].stringValue as NSString
//                let altitude = (altitude2 as NSString).doubleValue)
                let altitude = 0.0
                
                playerhealth = result["health"].stringValue as NSString
                playerstealth = result["stealth"].stringValue as NSString
                playerlat = (playerlat2 as NSString).doubleValue
                playerlong = (playerlong2 as NSString).doubleValue
                
                imageName = result["imagename"].stringValue
               //  print("Image Name = \(imageName)")
               // imageName = "spyIcon"
                
                //imageName = "Camo Cream-48"
                imageName = "AgentS"
                
                
                let userGold = result["gold"].stringValue
                let userLevel = result["level"].stringValue
                let armorBody = result["level_armor_body"].stringValue
                let armorBoots = result["level_armor_boots"].stringValue
                let armorHelmet = result["level_armor_helmet"].stringValue
                let userShieldLevel = result["shield_level"].stringValue
                
                let userWasAttacked = result["wasAttacked"].stringValue
                let userWasAttackedTime = result["AttackedTimeDate"].stringValue
                
                
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
                
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: AttributeAwareness, Charisma: AttributeCharisma, Credibility: AttributeCredibility, Endurance: AttributeEndurance, Intelligence: AttributeIntelligence, Speed: AttributeSpeed, Strength: AttributeStrength, Vision: AttributeVision)
                
                let killcount = result["killcount"].stringValue
                let killedcount = result["killedcount"].stringValue
                
                
                let xp = result["xp"].stringValue
                let objective = "NA"
                let missionLevel = "NA"
                
               
                
                if (playername == username) {
                    imageName = "user"
                    //let imageName = result["imagename"].stringValue
                    
                  //  PlotPoint = MyLabel(title: playername as String, userHealth: playerhealth as String, discipline: "test", stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong), image: UIImage(named: "\(imageName).png")!)
                    
                    let MyPlotPoint = MyLabelPulse(title: playername as String, userHealth: playerhealth as String, discipline: "test", stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong), image: UIImage(named: "\(imageName).png")!, isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    
                  //  mapView.addAnnotation(MyPlotPoint)
                
                } else {
                
                    if (playerstealth == "yes") {
                        
                        
                        
                        PlotPoint = UserLabel(title: "Unknown", userHealth: playerhealth as String, discipline: playername as String, stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong), image: UIImage(named: "\(imageName).png")!, PinType: "player", GoldAmount: userGold, isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                        
                    } else {
                        
                        PlotPoint = UserLabel(title: playername as String, userHealth: playerhealth as String, discipline: targetplayerID as String, stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong), image: UIImage(named: "\(imageName).png")!, PinType: "player", GoldAmount: userGold, isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    }
                    
                    //DELETE COMMENT BELOW
                mapView.addAnnotation(PlotPoint)
                }
                /*
                playernameArray.append(playername)
                playerlatArray.append(playerlat)
                playerlongArray.append(playerlong)
                playerhealthArray.append(playerhealth)
                playerstealthArray.append(playerstealth)
               */
            }
            
        }
        /*
        LocationData.append(playernameArray)
        LocationData.append(playerlatArray)
        LocationData.append(playerlongArray)
        LocationData.append(playerhealthArray)
        LocationData.append(playerstealthArray)
        */

        return LocationData
    }
    
    func FilterItemData(_ urlData: Data) -> [NSArray] {
        
        var traits = [NSString]()
        
         let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
       //print("Json Items valueJSON: \(json)")
        
        for result in json["items"].arrayValue {
            
            if ( result["name"] != "dummy") {
                if ( result["isAvailable"] != "no") {
                itemname = result["name"].stringValue as NSString
                itemID = result["id"].stringValue as NSString
                itemlat2 = result["latitude"].stringValue as NSString
                itemlong2 = result["longitude"].stringValue as NSString
                
                itemType = result["type"].stringValue as NSString
                   // println("ItemType Test: - \(itemType)")
                itemStatus = result["isAvailable"].stringValue as NSString
                itemCode = result["code"].stringValue as NSString
                itemlat = (itemlat2 as NSString).doubleValue
                itemlong = (itemlong2 as NSString).doubleValue
                var itemAmount = result["amount"].stringValue
                    
                let imageName = result["imagename"].stringValue
                    
                 let category = result["category"].stringValue
                 let count = result["count"].stringValue
                    let level = result["level"].stringValue
                    let health = result["health"].stringValue
                    let stamina = result["stamina"].stringValue
                    let ammoCount = result["ammoCount"].stringValue
                    let speed = result["speed"].stringValue
                    let power = result["power"].stringValue
                    let range = result["range"].stringValue
                    let viewrange = result["viewrange"].stringValue
                    
                    
                    
                    
                   // print("Image Name = \(imageName)")
                /*
                
                if (playername == username) {
                    
                    PlotPoint = MyLabel(title: playername as String, userHealth: playerhealth as String, discipline: "test", stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong))
                    
                    mapView.addAnnotation(PlotPoint)
                    
                } else {
*/
                    
                    
                   // let dirpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
                    
                    
                    let xp = "10"
                    let objective = "NA"
                    let missionLevel = "NA"
                    
                    let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                    let killcount = "0"
                    let killedcount = "0"
                    let altitude = 0.0
                    
                    let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                    
                    print("IMAGE URL: \(url)")
                    if let theImageData = try? Data(contentsOf: url) {
                    
                   // UIImage(data:theImageData!)!
                        itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(data:theImageData)!, amount: itemAmount as String, PinType: "item", category: category, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    } else {
                        
                      itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(named: "\(imageName).png")!, amount: itemAmount as String, PinType: "item", category: category, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                        
                        
                        
                    }
                    
                    
                    /*
                    
                    if itemname == "Cannon" || itemname == "Grenade" || itemname == "Assault Rifle" || itemname == "Gold" {
                        
                        itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(data:theImageData!)!, amount: itemAmount as String, PinType: "item")
                        
                    }  else {
                    
                    // let url = NSURL.fileURLWithPath(path)
                    // let ItemImage = UIImage(data: theImageData!)

                    
                    
                    
                    itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(named: "\(imageName).png")!, amount: itemAmount as String, PinType: "item")
                        
                    }
                    
                    */
                    //DELETE BELWO
                    mapView.addAnnotation(itemPoint)
              //  }
                /*
                playernameArray.append(playername)
                playerlatArray.append(playerlat)
                playerlongArray.append(playerlong)
                playerhealthArray.append(playerhealth)
                playerstealthArray.append(playerstealth)
                */
                }
            }
            
        }
        /*
        LocationData.append(playernameArray)
        LocationData.append(playerlatArray)
        LocationData.append(playerlongArray)
        LocationData.append(playerhealthArray)
        LocationData.append(playerstealthArray)
        */
        
        return LocationData
    }
    @objc    
    func CenterMap(_ notification: Notification) {
        
        var info = notification.userInfo
        
        let lattemp = info!["lat"] as! String
        let longtemp = info!["long"] as! String
        
        let lat = Double(lattemp)
        let long = Double(longtemp)
        //let CurrentLevelTemp = info!["level"]
        //let CurrentLevel = Int(CurrentLevelTemp as! String)
        
        
        centerMapOnLocation(CLLocation(latitude: lat!, longitude: long!))
        
        
    }
    
    
    @objc    
    func AttackCompleteStats(_ notification: Notification) {
        
        
        print("ATTACK COMPLETE STATS NOW")
        
        if prefs.value(forKey: "AttackCompletedDictionary") != nil {
            
            
             print("ATTACK COMPLETE STATS NOT NIL")
            // let tempView: MKAnnotationView = prefs.objectForKey("SELECTEDANNOTATIONVIEW") as! MKAnnotationView
            
            //self.mapView(self.mapView, didDeselectAnnotationView: view)
            
            for views in self.mapView.annotations {
                print("Deselect Views: \(views)")
                self.mapView.deselectAnnotation(views, animated: true)
            }
            
            
            
            print("Map ViewAttack Dictinoary not nil")
            
            let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
            
            
            let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
            let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
            
            let AttackPlayerTemp = AttackCompletedDictionary["attackPlayer"] as! String
            
            let AttackResultTemp = AttackCompletedDictionary["attackStatus"] as! String
            let AttackPowerTemp = AttackCompletedDictionary["attackPower"] as! String
            let AttackNewHealthTemp = AttackCompletedDictionary["attackNewHealth"] as! String
            let AttackStartHealthTemp = AttackCompletedDictionary["attackStartHealth"] as! String
            print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
            print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
            print("From Unwind - players start health: \(AttackStartHealthTemp)")
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Attack Complete"
            alertView.message = "Info(Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount))"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            // alertView.show()
            
            
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    self.CapturingTerritory = false
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                var view = AttackCompleteView.instanceFromNib(AttackPlayerTemp, AttackedResult: AttackResultTemp, AttackedPower: AttackPowerTemp, AttackedNewHealth: AttackNewHealthTemp, AttackedStartHealth: AttackStartHealthTemp)
                view.tag = 1000
                self.view.addSubview(view)
                self.UpdateMap()
            })
            
            
            
        }
    }
    @objc    
    func PickUpItemNotification(_ notification: Notification) {
        
        
        var info = notification.userInfo
        
        let itemLattemp = info!["itemLat"] as! String
        let itemLongtemp = info!["itemLong"] as! String
        let itemAlttemp = info!["itemAlt"] as! String
        
        let itemLat = Double(itemLattemp)!
        let itemLong = Double(itemLongtemp)!
        let itemAlt = Double(itemAlttemp)!
        
        let itemName = info!["itemName"] as! String
        let itemType = info!["itemType"] as! String
        
        let itemCode = info!["itemCode"] as! String
        let itemID = info!["itemID"] as! String
        let amount = info!["amount"] as! String
        
        let isMissionText = info!["isMission"] as! String
        
        
        var missionObjective = info!["missionObjective"] as! String
        var missionXP = info!["missionXP"] as! String
        var missionMapURL = info!["missionMapURL"] as! String
        let MissionID = info!["MissionID"] as! String
        let level = info!["level"] as! String

        
        var isMissionItem = Bool()
        
        if isMissionText == "yes" {
            isMissionItem = true
        }
        
        print("attack!")
        
        //  print("Item Lat = \(itemLat)")
        //  print("Item Long = \(itemLong)")
        
        var email = NSString()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        
        
        CanPickUp = false
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
        var itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
        
        var distance = mylocnow.distance(from: itemLocation)
        print("distance: \(distance)")
        var miles = distance / 1609.34
        print("miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
            print("Dist = \(dist)")
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
                print("foot: \(distance)")
                CanPickUp = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanPickUp = true                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
            // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
        if CanPickUp {
            
            
            
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Pick Up item?", message: "Are you sure you want to pick up this item?", preferredStyle: .alert)
            
             print("YOU SURE MAP View")
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Do some stuff
            }
            
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                
                //  self.AttackingPlayer = user
                //   self.AttackingPlayersHealth = health
                
                // print("Picking up Item = \(self.itemname)")
                
                //self.performSegueWithIdentifier("goto_attack", sender: self)
                
                if itemName == "Gold" {
                    
                    
                    let PickUpSuccess =  PickUpGold(self.username, id: itemID as NSString, amount: amount as NSString)
                    print("Item Pick Up Success = \(PickUpSuccess)")
                    
                    
                    
                    if PickUpSuccess{
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "You Picked up the \(amount) coins"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        let PreviousGold = self.prefs.value(forKey: "GOLDAMOUNT") as! String
                        print("NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold)")
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMoney"), object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(amount)","setting":"add"])
                        
                        
                        backgroundThread(background: {
                            //self.GetPublicTurns()
                            print("BACKGROUND THREAD - Updating Users' Info")
                            
                            print("Saving Images now")
                            
                            
                            let UserInfoNSData = GetUserInfo(email)
                            
                            DispatchQueue.main.async(execute: {
                                print("Creating Local Inventory Data")
                                CreateLocalInventory(UserInfoNSData)
                                
                            })
                            
                            
                            }, completion: {
                                
                                DispatchQueue.main.async(execute: {
                                    //self.GetMyHUD.removeFromSuperview()
                                    //  self.tableView.reloadData()
                                    print("DISPATCH ASYNC - Finished Getting User's Info")
                                })
                                // print("Done Getting Steal Turns")
                                //   self.kolodaView.resetCurrentCardNumber()
                        })
                        
                        
                        
                        
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
                        
                    }
                    
                    
                } else {
                    
                    
                    if isMissionItem {
                        print("PICK UP MISSION ITEM")
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMissionNotification"), object: nil, userInfo: ["missionID":"\(MissionID)","lat":"\(itemLong)","long":"\(itemLat)","status":"complete","objective":"\(missionObjective)","xp":"\(missionXP)","action":"updateStatus","imageName":"\(missionMapURL)","level":"\(level)","alt":"\(itemAlt)"])
                        
                    } else {
                    
                    let PickUpSuccess =  PickUpItem(self.username, id: itemID as NSString)
                    print("Item Pick Up Success = \(PickUpSuccess)")
                    
                    
                    
                    if PickUpSuccess{
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "Item picked up!"
                        //alertView.message = "You Picked up the \(itemName)"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
                        
                     }
                    }
                    
                }
                //self.SubmitPic()
               // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
                
            }
            
            
            actionSheetController.addAction(nextAction)
            actionSheetController.addAction(cancelAction)
            
            // var v1Ctrl = MapViewController()
            
            self.present(actionSheetController, animated: true, completion: nil)
            
        } else  {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "You're not close enough!"
            alertView.message = "You need to get closer to pick up this item"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
    }
    @objc    
    func StartMissionNotification(_ notification: Notification) {
        
        
        var info = notification.userInfo
        
        let itemLattemp = info!["itemLat"] as! String
        let itemLongtemp = info!["itemLong"] as! String
        
        let itemLat = Double(itemLattemp)!
        let itemLong = Double(itemLongtemp)!
        
        MissionID = info!["missionID"] as! String
        MissionLevel = info!["missionLevel"] as! String
        
        MissionObjective = info!["missionObjective"] as! String
        MissionXP = info!["missionXP"] as! String
        
        MissionMapURL = info!["missionMapURL"] as! String
        MissionObjectURL = info!["missionObjectURL"] as! String
        
        print("Start Mission: Mission Map URL \(MissionMapURL)")
        
        
      
        
        AttackingPlayer = ""
        AttackingPlayersHealth = ""
        AttackingPlayerID = ""
        AttackStatus = ""
        AttackPower = 0
       // isAttacking = true
       // let amount = info!["amount"] as! String
        
        
        
          //  print("attack!")
        
          //  print("Item Lat = \(itemLat)")
          //  print("Item Long = \(itemLong)")
            
            var email = NSString()
            
            
            if prefs.value(forKey: "USERNAME") != nil {
                username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
                print("Email From VC = \(email)")
            } else {
                username = "UnknownUsername"
                email = "UnknownEmail"
            }
            
            
            
            
            CanPickUp = false
            var curLoc = CLLocation()
            let curLocManager = CLLocationManager()
            curLoc = curLocManager.location!
            
            let mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
            
            let itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
            
            let distance = mylocnow.distance(from: itemLocation)
            print("distance: \(distance)")
            let miles = distance / 1609.34
            print("miles: \(miles)")
            if (miles < 1) {
                dist = Double(round(1000*(miles * 5280))/1000)
                
                print("Dist = \(dist)")
                if (dist < 1) {
                    // distanceLBL.text = ("Distance: \(dist.description) Foot")
                    print("foot: \(distance)")
                    CanPickUp = true
                } else {
                    //distanceLBL.text = ("Distance: \(dist.description) Feet")
                    if (dist < 100) {
                        CanPickUp = true                }
                }
                
            } else {
                dist = Double(round(1000*miles)/1000)
                // distanceLBL.text = ("Distance: \(dist.description) Miles")
            }
            
            if CanPickUp {
                
                
                
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Start Mission?", message: "Are you sure you want to start this mission?", preferredStyle: .alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    //Do some stuff
                }
                
                //Create and an option action
                let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                    
                    
                    self.UserObjective = "mission"
                    /*
                    let userInfo = notification.userInfo
                    
                    
                    let AttackPlayerTemp = userInfo!["attackUserName"] as! String
                    let AttackPlayerHealthTemp = userInfo!["attackUserHealth"] as! String
                    let AttackPlayerIDTemp = userInfo!["attackUserID"] as! String
                    
                    self.AttackingPlayer = AttackPlayerTemp
                    self.AttackingPlayersHealth = AttackPlayerHealthTemp
                    self.AttackingPlayerID = AttackPlayerIDTemp
                    self.AttackStatus = ""
                    self.AttackPower = 1
                    */

                    
                    self.performSegue(withIdentifier: "AttackPlayer", sender: self)
                    
                    
                    
                    
                    //  self.AttackingPlayer = user
                    //   self.AttackingPlayersHealth = health
                    
                    // print("Picking up Item = \(self.itemname)")
                    
                    //self.performSegueWithIdentifier("goto_attack", sender: self)
                    
                    /*
                    if itemName == "Gold" {
                        
                        
                        let PickUpSuccess =  PickUpGold(self.username, id: itemID, amount: amount)
                        print("Item Pick Up Success = \(PickUpSuccess)")
                        
                        
                        
                        if PickUpSuccess{
                            var alertView:UIAlertView = UIAlertView()
                            alertView.title = "Success!"
                            alertView.message = "You Picked up the \(amount) coins"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
                            let PreviousGold = self.prefs.valueForKey("GOLDAMOUNT") as! String
                            print("NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold)")
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("UpdateMoney", object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(amount)","setting":"add"])
                            
                            
                            backgroundThread(background: {
                                //self.GetPublicTurns()
                                print("BACKGROUND THREAD - Updating Users' Info")
                                
                                print("Saving Images now")
                                
                                
                                let UserInfoNSData = GetUserInfo(email)
                                
                                dispatch_async(dispatch_get_main_queue(),{
                                    print("Creating Local Inventory Data")
                                    CreateLocalInventory(UserInfoNSData)
                                    
                                })
                                
                                
                                }, completion: {
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        //self.GetMyHUD.removeFromSuperview()
                                        //  self.tableView.reloadData()
                                        print("DISPATCH ASYNC - Finished Getting User's Info")
                                    })
                                    // print("Done Getting Steal Turns")
                                    //   self.kolodaView.resetCurrentCardNumber()
                            })
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                    } else {
                        
                        */
                    
                    /*
                        let PickUpSuccess =  PickUpItem(self.username, id: itemID)
                        print("Item Pick Up Success = \(PickUpSuccess)")
                        
                        
                        
                        if PickUpSuccess{
                            
                            */
                    
                    /*
                            var alertView:UIAlertView = UIAlertView()
                            alertView.title = "Coming Soon!"
                            alertView.message = "Start the mission!"
                            //alertView.message = "You Picked up the \(itemName)"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                    
                    */
                            
                     //   }
                        
                    }
                    //self.SubmitPic()
                  //  NSNotificationCenter.defaultCenter().postNotificationName("UpdateMap", object: nil)
                    
               // }
                
                
                actionSheetController.addAction(nextAction)
                actionSheetController.addAction(cancelAction)
                
               // var v1Ctrl = MapViewController()
                
                self.present(actionSheetController, animated: true, completion: nil)
                
            } else {
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "You're not close enough!"
                alertView.message = "You need to get closer to start this mission"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            }
            
        }
    
    
    @objc func UpdateMessageLBL(_ notification:Notification) {
     
        /*
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let messagCount = userInfo!["messageCount"] as! String
        
        let previousAmount = Int(messagCount)
 
 */
        self.msgLBL.text = ""
        self.msgLBL.isHidden = true
        
    }
    
    @objc func DoNotUpdateMap(_ notification: Notification) {
        
        DoNotUpdateMapBool = true
        
    }
    
   

    
    @objc func UpdateMissionMessageLBL(_ notification:Notification) {
        
        /*
         let userInfo = notification.userInfo
         //  print("Money UserInfo = \(userInfo)")
         
         let messagCount = userInfo!["messageCount"] as! String
         
         let previousAmount = Int(messagCount)
         
         */
        self.RightmsgLBL.text = ""
        self.RightmsgLBL.isHidden = true
        
    }
    @objc func UnwindToStart(_ notification:Notification) {
        
        print("unwind to start")
        
        LocManager.stopUpdatingLocation()
        
        self.prefs.set(0, forKey: "ISLOGGEDIN")
        //integer(forKey: "ISLOGGEDIN") as Int
        
        
        self.performSegue(withIdentifier: "GoBackToStart", sender: self)
        
//        print("Clearing User Defaults - Count: \(UserDefaults.standard.dictionaryRepresentation().keys.count)")
//        
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//            
//        }
//        
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
//        
//        self.performSegue(withIdentifier: "GoBackToStart", sender: self)
    //self.per
    }
    
    @objc func UpdateMissionNotification(_ notification:Notification) {
        
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        let missionIDtemp = userInfo!["missionID"] as! String
        let missionLattemp = userInfo!["lat"] as! String
        let missionLongtemp = userInfo!["long"] as! String
        let missionAlttemp = userInfo!["alt"] as! String
        let missionStatustemp = userInfo!["status"] as! String
        let missionObjectivetemp = userInfo!["objective"] as! String
        let missionXPtemp = userInfo!["xp"] as! String
        let missionActiontemp = userInfo!["action"] as! String
        
        let missionLeveltemp = userInfo!["level"] as! String
        let missionImageName = userInfo!["imageName"] as! String
        
        
        if missionStatustemp == "complete" {
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    self.CapturingTerritory = false
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                var view = MissionStatusView.instanceFromNib("Mission Complete", imageName: missionImageName, contentMessage: "Great job completing this mission!")
                view.tag = 1000
                self.view.addSubview(view)
            })
            
            
        }
        
        
        let theData = UpdateMission(self.email, id: missionIDtemp as NSString, lat: missionLattemp as NSString, long: missionLongtemp as NSString, level: missionLeveltemp as NSString, status: missionStatustemp as NSString, objective: missionObjectivetemp as NSString, xp: missionXPtemp as NSString, action: missionActiontemp as NSString, alt: missionAlttemp as NSString)
        
        
        DispatchQueue.main.async(execute: {
            
           self.UpdateMap()
    
            
        })
        
        
        
        
    }
    
    @objc func ShowMessage(_ notification:Notification) {
        let userInfo = notification.userInfo
         //  print("Money UserInfo = \(userInfo)")
        let messageTitle = userInfo!["msgTitle"] as! String
        let messageTemp = userInfo!["msgMSG"] as! String
        
        
        
        
        switch messageTitle {
            
        case "HQ Security":
            
            let alertController = UIAlertController(
                title: "\(messageTitle)",
                message: "\(messageTemp)",
                preferredStyle: .alert)
            
            
            alertController.addTextField { (textField: UITextField!) in
               // textField.n
                textField.keyboardType = UIKeyboardType.numberPad
                textField.placeholder = "Security Code"
                textField.isSecureTextEntry = true
                textField.textAlignment = .center
            }
            
            let armAction = UIAlertAction(title: "Arm", style: .default) { (action) in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                if firstTextField.text == "1234" {
                    let alertControllerError = UIAlertController(
                        title: "Armed!",
                        message: "Your security system is now armed",
                        preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        UserDefaults.standard.set(true, forKey: "SecuritySet")
                        
                        self.CenterUserBTN.setImage(UIImage(named: "CenterMapIconColor.png"), for: UIControl.State())
                        self.CenterOnUser = true
                        
                        self.regionRadius = 200
                        
                        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: self.regionRadius * 5.0, longitudinalMeters: self.regionRadius * 5.0)
                        
                        self.ZoomLevel = self.UserZoomRadius
                        self.mapView.setRegion(coordinateRegion, animated: true)
                    }
                    alertControllerError.addAction(cancelAction)
                    self.present(alertControllerError, animated: true, completion: nil)
                    
                    
                } else {
                    
                    let alertControllerError = UIAlertController(
                        title: "Invalid Code",
                        message: "Please try again",
                        preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                       
                    }
                    alertControllerError.addAction(cancelAction)
                    self.present(alertControllerError, animated: true, completion: nil)
                    
                    
                    
                }
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
            }
            
            
            
           
            alertController.addAction(armAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        
        case "Item Alert":
            
            
            let lat1 = userInfo!["lat"] as! String
            let lng1 = userInfo!["long"] as! String
            let vanueName = userInfo!["name"] as! String
            
            
            let alertController = UIAlertController(
                title: "\(vanueName)",
                message: "\(messageTemp)",
                preferredStyle: .alert)
            
            //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            //  alertController.addAction(cancelAction)
            
            
            let DirAction = UIAlertAction(title: "Directions", style: .default) { (action) in
                
                
                let latitude:CLLocationDegrees =  Double(lat1)!
                let longitude:CLLocationDegrees =  Double(lng1)!
                
                let regionDistance:CLLocationDistance = 10000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "\(vanueName)"
                mapItem.openInMaps(launchOptions: options)
                
            }
            
            
            let openAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                
                
            }
            
            alertController.addAction(DirAction)
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
            
           // let lat1 : NSString = self.venueLat
           // let lng1 : NSString = self.venueLng
            
            
        default:
         
            
            
            let alertController = UIAlertController(
                title: "\(messageTitle)",
                message: "\(messageTemp)",
                preferredStyle: .alert)
            
            //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            //  alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
                
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        

    }
    
    
    @objc func UpdateCaptureTerritoryBool(_ notification: Notification) {
        
        self.CapturingTerritory = false
        
    }
    
    @objc func PlotPointNew(_ notification: Notification) {
       
         let userInfo = notification.userInfo
        
        let NewLat = userInfo!["lat"] as! Double
        let NewLong = userInfo!["long"] as! Double
        
        let missionLevel = "0"
        let imageName = "Tent"
        let xp = "0"
        let objective = "NA"
        
        let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
        let killcount = "0"
        let killedcount = "0"
        let altitude = 0.0
        
        let MyHomeBasePlotPoint = MyBaseLabel(title: "", userHealth: "", discipline: "", stealth: "", coordinate: CLLocationCoordinate2DMake(NewLat, NewLong), image: UIImage(named: "blackFlag.png")!, PinType: "", GoldAmount: "0", isMission: false, missionID: "0", xp: xp, objective: objective, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
        
        mapView.addAnnotation(MyHomeBasePlotPoint)
        
    }
    
    func UpdateMap() {
        
       // print("UpdatingMap")
         if LocManager.location != nil {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        
            if SaveMyLoc(username, latitude: mylat, longitude: mylong, email: self.email, altitude: myalt) {
          //  print("My loc saved to server")
            // return true
        }

        
        var URLData = CompleteLocations(username, latitude: mylat, longitude: mylong, radius: userRadius, altitude: myalt)
        //println("URLData: \(URLData)")
        var LocInfo = FilterGameData(URLData)
        //println("LocInfo: \(LocInfo)")
        //playernameInfo = LocInfo[0] as! [(NSString)]
        var URLDataItems = ItemLocations(username, latitude: mylat, longitude: mylong, radius: itemRadius, altitude: myalt)
       // println("URLData: \(URLDataItems)")
        var ItemInfo = FilterItemData(URLDataItems)
        //println("LocInfo: \(ItemInfo)")
        
        
        var TerritoryURLData = GetTerritory(self.email, Type: "all")
        TerritoryInfoArray = FilterTerritoryData(TerritoryURLData)
        
        
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        let MissionURLData = GetMission(self.email, level: level as NSString, status: status as NSString)
        MissionInfoArray = FilterMissionItems(MissionURLData)
            
        let CameraURLData = GetCameras(self.email, level: level as NSString, status: status as NSString)
        NearbyCameras = FilterCameraItems(CameraURLData)
            
        let OtherCameraURLData = GetOtherCameras(self.email, level: level as NSString, status: status as NSString, background: false)
        OtherNearbyCameras = FilterOtherCameraItems(OtherCameraURLData)
            
            let HomeURLData = GetHomeInfo(self.email, level: level as NSString, status: status as NSString)
            IsHomeSet = FilterHomeItems(HomeURLData)
            
            //AddCameras()
        
        
        DispatchQueue.main.async(execute: {
            
            print("Territory Array = \(self.TerritoryInfoArray)")
            self.RenderTerritoryArray(self.TerritoryInfoArray)
        })
        
        
       print("Should start to add iamge overlay")
        
      //  let tempImage = UIImage(named: "fortressIconTemplate.png")!
        
        let midPoint = CGPoint(x: 28.812000, y: -81.340900)
        let Point1 = CGPoint(x: 28.811515, y: -81.340064)
        let Point2 = CGPoint(x: 28.812759, y: -81.340059)
        let Point3 = CGPoint(x: 28.813172, y: -81.34081)
        let Point4 = CGPoint(x: 28.811555, y: -81.341304)
        
        let tempImage = "fortressIconTemplate.png"
        
        var TestImageIconForMap = ImageIconForMap(imageName: tempImage, CenterPoint: midPoint, Point1: Point1, Point2: Point2, Point3: Point3, Point4: Point4)
        
        AddImageOverlayTemp(TestImageIconForMap)
        
        // mapView.addOverlay(overlay)
       // mapView.addOverlayImage(self.mapView, rendererForOverlay: overlay)
        
        UpdateDaylight()
        
        /*
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = dispatch_time(DISPATCH_TIME_NOW, Int64(delayLoad))
        
        
       // MoveClouds("in")
        
        if !CloudsMovedOut {
             dispatch_async(dispatch_get_main_queue(), {
          //  dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.MoveClouds("out")
                print("Clouds moved out")
                self.CloudsMovedOut = true
            })
            
        } else {
             dispatch_async(dispatch_get_main_queue(), {
           // dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.MoveClouds("in")
                print("Clouds moved in")
                self.CloudsMovedOut = false
            })
  
        }
        
        */
    } else {
    
    
    var alertView:UIAlertView = UIAlertView()
    alertView.title = "Location Error"
    alertView.message = "We need to track your location, please update your location tracking settings in your general settings"
    alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    //  alertView.show()
    
    }
    
    }

    @objc func UpdateMap(_ notification:Notification) {
        
        UpdateMap()
        
    }


    @IBAction func RefreshMap(_ sender: AnyObject) {
        
        UpdateMap()
        
    }
    
    @objc func MoneyUpdateTimer(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! NSDictionary
        let previousAmountTemp = userInfo["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        
        let settingTemp = userInfo["setting"] as! String
        //   print("MoneyUpdateTimer: Previous Amount: \(previousAmountTemp)")
        
        
        let newAmountTemp = userInfo["newAmount"] as! String
        let newAmount = Int(newAmountTemp)
        
        
        self.MoneyAmountTotalError = newAmount!
        //    print("MoneyUpdateTimer: New Amount: \(newAmountTemp)")
        
        let differenceAmountTemp = userInfo["differenceAmount"] as! String
        let differenceAmount = Int(differenceAmountTemp)
        //   print("MoneyChangeCount = \(MoneyChangeCount.description)")
        
        
        if settingTemp == "add" {
            
            var changeAmount = previousAmount! + MoneyChangeCount
            //   print("Change Amount = \(changeAmount)")
            
            if (previousAmount! + MoneyChangeCount) > newAmount! {
                
                MoneyActionInProgress = false
                moneyTimer.invalidate()
            } else {
                let TempAmount = previousAmount! + MoneyChangeCount
                moneyLBL.text = "$\(TempAmount.description)"
                MoneyChangeCount += 1
            }
            
            var differenceAmountCount = differenceAmount! + 1
            //   print("Difference Amount = \(differenceAmountCount)")
            
        } else {
            print("PREVIOUS AMOUNT = \(previousAmount)")
            print("SUBTRACTED MONEY CHANGE AMOUNT = \(MoneyChangeCount)")
            let changeAmount = previousAmount! - MoneyChangeCount
            print("SUBTRACTED  Change Amount = \(changeAmount)")
            
            if (previousAmount! - MoneyChangeCount) < newAmount! {
                
                moneyTimer.invalidate()
                MoneyActionInProgress = false
            } else {
                let TempAmount = previousAmount! + MoneyChangeCount
                moneyLBL.text = "$\(TempAmount.description)"
                MoneyChangeCount -= 1
            }
            
            var differenceAmountCount = differenceAmount! - 1
            
        }
        
        
        
    }
    
    @objc func StaminaUpdateTimer(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! NSDictionary
        let previousAmountTemp = userInfo["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        
        let settingTemp = userInfo["setting"] as! String
        //   print("MoneyUpdateTimer: Previous Amount: \(previousAmountTemp)")
        
        
        let newAmountTemp = userInfo["newAmount"] as! String
        let newAmount = Int(newAmountTemp)
        
        
        self.MoneyAmountTotalError = newAmount!
        //    print("MoneyUpdateTimer: New Amount: \(newAmountTemp)")
        
        let differenceAmountTemp = userInfo["differenceAmount"] as! String
        let differenceAmount = Int(differenceAmountTemp)
        //   print("MoneyChangeCount = \(MoneyChangeCount.description)")
        
        
        let staminaprogressTemp = prefs.integer(forKey: "MYSTAMINA")
        
        if settingTemp == "add" {
            
            var changeAmount = previousAmount! + MoneyChangeCount
            //   print("Change Amount = \(changeAmount)")
            
          
            
            if staminaprogressTemp > 100 {
           // if (previousAmount! + HealthChangeCount) > newAmount! {
               // MoneyActionInProgress = false
                staminaTimer.invalidate()
            } else {
                let TempAmount = previousAmount! + StaminaChangeCount
                staminaLBL.text = "\(TempAmount.description).0"
                StaminaChangeCount += 1
            }
            
            var differenceAmountCount = differenceAmount! + 1
            //   print("Difference Amount = \(differenceAmountCount)")
            
        } else {
            print("PREVIOUS AMOUNT = \(previousAmount)")
            print("SUBTRACTED MONEY CHANGE AMOUNT = \(StaminaChangeCount)")
            let changeAmount = previousAmount! - StaminaChangeCount
            print("SUBTRACTED  Change Amount = \(changeAmount)")
            
            if (previousAmount! - StaminaChangeCount) < newAmount! {
                
                staminaTimer.invalidate()
               // MoneyActionInProgress = false
            } else {
                let TempAmount = previousAmount! + MoneyChangeCount
                staminaLBL.text = "\(TempAmount.description).0"
                StaminaChangeCount -= 1
            }
            
            var differenceAmountCount = differenceAmount! - 1
            
        }
        
        
        
    }
    
    
//    func stopHealthTimer (_ notifcaiton: Notification) {
//        
//        healthTimer.invalidate()
//    }
//    
//    
//    func stopStaminaTimer (_ notifcaiton: Notification) {
//        
//        staminaTimer.invalidate()
//    }
    
    @objc func HealthUpdateTimer(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! NSDictionary
        let previousAmountTemp = userInfo["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        
        let settingTemp = userInfo["setting"] as! String
     //   print("MoneyUpdateTimer: Previous Amount: \(previousAmountTemp)")
        
        
        let newAmountTemp = userInfo["newAmount"] as! String
        let newAmount = Int(newAmountTemp)
        
        
        self.MoneyAmountTotalError = newAmount!
     //    print("MoneyUpdateTimer: New Amount: \(newAmountTemp)")
        
        let differenceAmountTemp = userInfo["differenceAmount"] as! String
        let differenceAmount = Int(differenceAmountTemp)
     //   print("MoneyChangeCount = \(MoneyChangeCount.description)")
        
        
        
         let healthprogressTemp = prefs.integer(forKey: "MYHEALTH")
        
        if settingTemp == "add" {
        
        var changeAmount = previousAmount! + HealthChangeCount
     //   print("Change Amount = \(changeAmount)")
        
            
            if healthprogressTemp > 100 {
       // if (previousAmount! + HealthChangeCount) > newAmount! {
            
           // MoneyActionInProgress = false
            healthTimer.invalidate()
        } else {
            let TempAmount = previousAmount! + HealthChangeCount
            healthLBL.text = "$\(TempAmount.description)"
            HealthChangeCount += 1
        }
        
        var differenceAmountCount = differenceAmount! + 1
     //   print("Difference Amount = \(differenceAmountCount)")
        
        } else {
            print("PREVIOUS AMOUNT = \(previousAmount)")
            print("SUBTRACTED MONEY CHANGE AMOUNT = \(HealthChangeCount)")
            let changeAmount = previousAmount! - HealthChangeCount
               print("SUBTRACTED  Change Amount = \(changeAmount)")
            
            if (previousAmount! - HealthChangeCount) < newAmount! {
                
                healthTimer.invalidate()
              //  MoneyActionInProgress = false
            } else {
                let TempAmount = previousAmount! + HealthChangeCount
                healthLBL.text = "$\(TempAmount.description)"
                HealthChangeCount -= 1
            }
            
            var differenceAmountCount = differenceAmount! - 1
            
        }
        
        
        
    }
    
    
    
    @objc func ViewUserProfileNotification(_ notification: Notification) {
        
        let userInfo = notification.userInfo
        
        
        let AttackPlayerTemp = userInfo!["attackUserName"] as! String
        let AttackPlayerHealthTemp = userInfo!["attackUserHealth"] as! String
        let AttackPlayerIDTemp = userInfo!["attackUserID"] as! String
        let AttackPlayerLatTemp = userInfo!["attackUserLat"] as! String
        let AttackPlayerLongTemp = userInfo!["attackUserLong"] as! String
        let AttackPlayerAltTemp = userInfo!["attackUserAlt"] as! String
        
        self.AttackingPlayer = AttackPlayerTemp as NSString
        self.AttackingPlayersHealth = AttackPlayerHealthTemp as NSString
        self.AttackingPlayerID = AttackPlayerIDTemp as NSString
        
        self.AttackingPlayerLat = AttackPlayerLatTemp as NSString
        self.AttackingPlayerLong = AttackPlayerLongTemp as NSString
        self.AttackingPlayerAlt = AttackPlayerAltTemp as NSString
        
        self.AttackStatus = ""
        self.AttackPower = 1
        
        print("View User Profile \(AttackingPlayer): about to segue")
        
        self.performSegue(withIdentifier: "ViewUserProfile", sender: self)
        
    }
    @objc    
    func AttackPlayer(_ notification: Notification) {
        
         let userInfo = notification.userInfo
        
        
        let AttackPlayerTemp = userInfo!["attackUserName"] as! String
        let AttackPlayerHealthTemp = userInfo!["attackUserHealth"] as! String
        let AttackPlayerIDTemp = userInfo!["attackUserID"] as! String
        
        
        let StaminaUsedTemp = userInfo!["StaminaUsed"] as! String
        
        self.AttackingPlayer = AttackPlayerTemp as NSString
        self.AttackingPlayersHealth = AttackPlayerHealthTemp as NSString
        self.AttackingPlayerID = AttackPlayerIDTemp as NSString
        self.AttackStatus = ""
        self.AttackPower = 1
        
        let enemyStartDistanceTemp = userInfo!["enemyDistanceAway"] as! String
        
        
        print("dist temp: \(enemyStartDistanceTemp)")
        
        var enemyStartDistance = Float()
        
        let enemyStartDistanceTempDouble = Double(enemyStartDistanceTemp)
        
        let enemyStartDistanceIntTemp = round(enemyStartDistanceTempDouble!)
   
        let enemyStartDistanceInt = Int(enemyStartDistanceIntTemp)
        
        switch enemyStartDistanceInt {
            
//        case _ where enemyStartDistanceInt < 0:
//            enemyStartDistance = -7
//            print("someVar is \(enemyStartDistanceInt)")
        case 0:
            enemyStartDistance = -2
            print("someVar is 0")
        case _ where enemyStartDistanceInt > 100:
            enemyStartDistance = -20
            print("someVar is \(enemyStartDistanceInt)")
        case _ where enemyStartDistanceInt > 50:
            enemyStartDistance = -10
            print("someVar is \(enemyStartDistanceInt)")
        case _ where enemyStartDistanceInt > 20:
            enemyStartDistance = -7
            print("someVar is \(enemyStartDistanceInt)")
            
            
        default:
            enemyStartDistance = -7
        }
        
        
        print("Attacking Player \(AttackingPlayer): about to segue")
        
        //self.performSegue(withIdentifier: "AttackPlayer", sender: self)
        
        
        
        
//        type = "willAttack"
//        
//        let yesSuccess =  AttackNotice(username, username: AttackingPlayerTemp, attackpower: AttackPower, type: type)
//        print("***Atttack Notice send = \(yesSuccess)")
        
        
        LoadPlayerAttack(name: self.username as String, skin: "white", health: "100", AttackingPlayer: AttackPlayerTemp, AttackingPlayersHealth: AttackPlayerHealthTemp, AttackingPlayerID: AttackPlayerIDTemp, StaminaUsed: StaminaUsedTemp, AttackPower: AttackPower, AttackStatus: AttackStatus as String, startDistance: enemyStartDistance)
        
    }
    
    
    
    
    @objc    
    func UpdateHealthStamina(_ notification: Notification) {
       
        
    let userInfo = notification.userInfo
    let PotionType = userInfo!["potionType"] as! String
    let PotionAction = userInfo!["potionAction"] as! String
    let PotionAmount = userInfo!["potionAmount"] as! String
        
        
        print("Updating \(PotionType)")
    
        
        switch PotionType {
           case "stamina":
          //  self.staminaTimer.invalidate()
            self.StaminaProductionTimer.invalidate()
            let PrefsAmount = prefs.integer(forKey: "MYSTAMINA")
            
            
            var NewAmount = Int()
            if PotionAction == "add" {
                NewAmount = PrefsAmount + Int(PotionAmount)!
                
                if NewAmount > 100 {
                    NewAmount = 100
                }
            } else {
                
                NewAmount = PrefsAmount - Int(PotionAmount)!
                
                
                if NewAmount < 0 {
                    NewAmount = 0
                }
            }
            
            
            // let tempAmount = PotionAmount
            
            // let tempAmountInt = Int(tempAmount)!
            let tempDouble = Double(NewAmount)
            
            
            let tempProgress = tempDouble / 100
            let tempFloat: Float = Float(tempProgress)
            
            prefs.set(NewAmount, forKey: "MYSTAMINA")
            
            self.staminaProgressView.setProgress(tempFloat, animated: true)
            self.staminaLBL.text = "\(NewAmount.description).0"
            
            
            let UpdatedHealthStamina = SaveUsersHealthStamina("stamina", level: NewAmount, emailID: self.email)
            print("Stamina was updated = \(UpdatedHealthStamina)")
            
            
            if tempDouble < 100 {
                 //self.staminaTimer.invalidate()
                self.StartStaminaProduction()
            }
            
            case "health":
                //self.healthTimer.invalidate()
                self.HealthProductionTimer.invalidate()
                let PrefsAmount = prefs.integer(forKey: "MYHEALTH")
                
                var NewAmount = Int()
                if PotionAction == "add" {
                NewAmount = PrefsAmount + Int(PotionAmount)!
                
                if NewAmount > 100 {
                    NewAmount = 100
                    
                }
                } else {
                    
                    NewAmount = PrefsAmount - Int(PotionAmount)!
                    
                    
                    
                    
                    if NewAmount < 0 {
                     NewAmount = 0
                    }
                }
                
                
               // let tempAmount = PotionAmount
                
               // let tempAmountInt = Int(tempAmount)!
                let tempDouble = Double(NewAmount)
                
                
                let tempProgress = tempDouble / 100
                let tempFloat: Float = Float(tempProgress)
                
                prefs.set(NewAmount, forKey: "MYHEALTH")
                
                self.healthProgressView.setProgress(tempFloat, animated: true)
                self.healthLBL.text = "\(NewAmount.description).0"
            
                let UpdatedHealthStamina = SaveUsersHealthStamina("health", level: NewAmount, emailID: self.email)
                print("health was updated = \(UpdatedHealthStamina)")
                
                self.healthTimer.invalidate()
            
                if tempDouble < 100 {
                   // self.healthTimer.invalidate()
                    self.StartHealthProduction()
                }
            
            
            
            
        default:
            break
        }
        
        
    }
    @objc    
    func CollectGoldNotification(_ notification:Notification) {
        
        
      //  if GoldLBLViewShown {
            
            let animationDuration = 0.35
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                
            }, completion: { (completion) -> Void in
                
                
                self.GoldAmountLBLView.transform = self.GoldAmountLBLView.transform.scaledBy(x: 1.0, y: 1.0)
                
                self.GoldAmountLBLView.isHidden = true
                //self.GoldAmountView.hidden = true
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    self.GoldAmountLBLView.transform = CGAffineTransform.identity
                })
                
            }) 
            
      //      GoldLBLViewShown = false
            
      //  }
        
        
        CollectGoldProductionNow()
    }
    
    @objc func HideAnnotations(_ notification:Notification) {
        
        var view = MKAnnotationView()
        
      //  mapView(self.mapView, didDeselectAnnotationView:  view)
       // mapView.deselectAnnotation(<#T##annotation: MKAnnotation?##MKAnnotation?#>, animated: true)
        
      //  for view in self.mapView.
    }
    
    
    @objc func UpdateWeapon(_ notification:Notification) {
      
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.ScrollItemsView.center.y = self.ScrollItemsView.center.y + 255
            self.ScrollItemsViewBOTTOM.constant = -200
            
            self.ScrollItemsInView = false
            
            
            
            // self.loadingView.hidden = true
        })
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let itemNameTemp = userInfo!["itemName"] as! String

        let itemImageURLtemp = userInfo!["itemImageURL"] as! String
        let itemRangeTemp = userInfo!["itemRange"] as! String
        let itemPowerTemp = userInfo!["itemPower"] as! String
        let itemSpeedTemp = userInfo!["itemSpeed"] as! String
        let itemViewRangeTemp = userInfo!["itemViewRange"] as! String
        
        
       // var imageName = itemImageURLtemp
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(itemImageURLtemp).png")
        let theImageData = try? Data(contentsOf: url)
        let ItemImageTemp = UIImage(data: theImageData!)
        
          print("Updating Weapon - name: \(itemNameTemp)")
        
        prefs.setValue(itemNameTemp, forKey: "HOLDINGWEAPON")
        let RangeSelectedInt = Int(itemRangeTemp as String)
        //prefs.setValue(RangeSelected, forKey: "PULSEWEAPONRANGE")
        prefs.set(Float(RangeSelectedInt!), forKey: "PULSEWEAPONRANGE")
        
        
       
        
        
        
 
            
            //     self.WeaponItem.image = settingsViewController.weaponPKimage
            
            self.ToolsBTN.setImage(ItemImageTemp, for:UIControl.State())
            
            switch itemNameTemp {
            case "Brass Knuckles":
                print("Knuckles")
                AttackPower = 5
                //  case "Sniper Rifle":
                //      print("Sniper Rifle")
            //      AttackPower = 10
            case "Magnum":
                print("Magnum")
                AttackPower = 10
            case "Night Vision Goggles":
                NightVisionOn = true
                
            default:
                AttackPower = 0
            }
            
            
            /*
             if settingsViewController.weaponPKLabel == "Flashlight" {
             self.FlashlightBTNView.hidden = false
             } else {
             self.FlashlightBTNView.hidden = true
             }
             
             */
            
       
            
            
            if itemNameTemp == "Night Vision Goggles" {
                //self.NightVisionOn = true
                print("You selected night vision goggles")
                self.ToggleNightVision(true)
                
            } else {
                // self.NightVisionOn = false
                
                self.ToggleNightVision(false)
            }
            
            
            
            WeaponSpeed = itemSpeedTemp as NSString
            WeaponPower = itemPowerTemp as NSString
            WeaponRange = itemRangeTemp as NSString
            ViewRange = itemViewRangeTemp as NSString
            userRadius = Int((WeaponRange as NSString).doubleValue)
            itemRadius = Int((ViewRange as NSString).doubleValue)
            
            UserZoomRadius = Double(itemRadius)
            
            if userRadius < 2 {
                VRange.text = "Range: \(itemRadius) Mile"
            } else {
                VRange.text = "Range: \(itemRadius) Miles"
            }
            //var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            prefs.set(userRadius, forKey: "WRADIUS")
            prefs.set(itemRadius, forKey: "VIEWRADIUS")
            // userRadius = Int(Rad)
            print("Attack Power = \(WeaponPower)")
            //= settingsViewController.weaponPKimage
            UpdateMap()
            
            
            let templat =   mapView.userLocation.coordinate.latitude
            let templong = mapView.userLocation.coordinate.longitude
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "CenterMap"), object: nil, userInfo: ["lat":"\(templat)","long":"\(templong)"])
        
        
        DispatchQueue.main.async(execute: {
            for views in self.ScrollItemsView.subviews {
                views.removeFromSuperview()
            }
        })
        
        
        }
    @objc    
    func UpdateMoney(_ notification:Notification) {
        
        MoneyChangeCount = 0
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let previousAmountTemp = userInfo!["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        let newAmountTemp = userInfo!["newAmount"] as! String
        let settingTemp = userInfo!["setting"] as! String
        
        var newAmount = Int()
        //   print("Update Money New Amount?: \(newAmount)")
        let differenceAmount = newAmount - previousAmount!
        
        
        print("UPDATE MONEY TYPE = \(settingTemp)")
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        if settingTemp == "add" {
            self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! + previousAmount!
        } else {
            self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! - previousAmount!
        }
        
        self.GoldCollectedLBLView.isHidden = false
        
        self.moneyProgressView.setProgress(0.0, animated: true)
        
        let animationDuration = 0.5
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
        }, completion: { (completion) -> Void in
            
            self.GoldCollectedLBLView.isHidden = false
            
            self.GoldCollectedLBLView.transform = self.GoldCollectedLBLView.transform.scaledBy(x: 0.001, y: 0.001)
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                self.GoldCollectedLBLView.transform = CGAffineTransform.identity
            })
            
            
        }) 
        
        
        
        
        
        //    print("Difference Amount = \(differenceAmount)")
        
        // let arr = [previousAmount, newAmount, differenceAmount]
        
        
        if MoneyActionInProgress {
            moneyTimer.invalidate()
            moneyLBL.text = "$\(MoneyAmountTotalError.description)"
        }
        
        moneyTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(MapViewController.MoneyUpdateTimer(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmountTemp)","setting":"\(settingTemp)"], repeats: true)
        
        
        
        
        //  moneyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: Selector("MoneyUpdateTimer:"), userInfo: arr, repeats: true)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
            let animationDurationTWO = 1.00
            
            UIView.animate(withDuration: animationDurationTWO, animations: { () -> Void in
                
            }, completion: { (completion) -> Void in
                
                
                
                self.GoldCollectedLBLView.transform = self.GoldCollectedLBLView.transform.scaledBy(x: 1.0, y: 1.0)
                
                self.GoldCollectedLBLView.isHidden = true
                
                UIView.animate(withDuration: animationDurationTWO, animations: { () -> Void in
                    self.GoldCollectedLBLView.transform = CGAffineTransform.identity
                })
                
                
            }) 
            
        })
        
        
    }
   //     @objc   }
   @objc func UpdateHealth(_ notification:Notification) {
        
        MoneyChangeCount = 0
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let previousAmountTemp = userInfo!["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        let newAmountTemp = userInfo!["newAmount"] as! String
        let settingTemp = userInfo!["setting"] as! String
        
        var newAmount = Int()
        //   print("Update Money New Amount?: \(newAmount)")
        let differenceAmount = newAmount - previousAmount!
        
        
        print("UPDATE MONEY TYPE = \(settingTemp)")
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        if settingTemp == "add" {
            self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! + previousAmount!
        } else {
            self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! - previousAmount!
        }
        
       
        
        
        //self.GoldCollectedLBLView.hidden = false
        
        
        
       
        
        self.healthProgressView.setProgress(0.0, animated: true)
        
        let animationDuration = 0.5
        
        /*
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
        }) { (completion) -> Void in
            
            self.GoldCollectedLBLView.hidden = false
            
            self.GoldCollectedLBLView.transform = CGAffineTransformScale(self.GoldCollectedLBLView.transform, 0.001, 0.001)
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.GoldCollectedLBLView.transform = CGAffineTransformIdentity
            })
            
            
        }
        */
        
        
        
        
        //    print("Difference Amount = \(differenceAmount)")
        
        // let arr = [previousAmount, newAmount, differenceAmount]
        
        /*
        if MoneyActionInProgress {
            moneyTimer.invalidate()
            moneyLBL.text = "$\(MoneyAmountTotalError.description)"
        }
        */
        
        
        healthTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(MapViewController.HealthUpdateTimer(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmountTemp)","setting":"\(settingTemp)"], repeats: true)
        
        
        //  moneyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: Selector("MoneyUpdateTimer:"), userInfo: arr, repeats: true)
        
        
       /*
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            let animationDurationTWO = 1.00
            
            UIView.animateWithDuration(animationDurationTWO, animations: { () -> Void in
                
            }) { (completion) -> Void in
                
                
                
                self.GoldCollectedLBLView.transform = CGAffineTransformScale(self.GoldCollectedLBLView.transform, 1.0, 1.0)
                
                self.GoldCollectedLBLView.hidden = true
                
                UIView.animateWithDuration(animationDurationTWO, animations: { () -> Void in
                    self.GoldCollectedLBLView.transform = CGAffineTransformIdentity
                })
                
                
            }
            
        })
        
        */
        
        
    }
    
    @objc    
    func UpdateStamina(_ notification:Notification) {
        
        MoneyChangeCount = 0
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let previousAmountTemp = userInfo!["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        let newAmountTemp = userInfo!["newAmount"] as! String
        let settingTemp = userInfo!["setting"] as! String
        
        var newAmount = Int()
        //   print("Update Money New Amount?: \(newAmount)")
        let differenceAmount = newAmount - previousAmount!
        
        
        print("UPDATE MONEY TYPE = \(settingTemp)")
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        if settingTemp == "add" {
            self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! + previousAmount!
        } else {
            self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! - previousAmount!
        }
        
        
        
        
        //self.GoldCollectedLBLView.hidden = false
        
        
        
        
        
        self.healthProgressView.setProgress(0.0, animated: true)
        
        let animationDuration = 0.5
        
        /*
         
         UIView.animateWithDuration(animationDuration, animations: { () -> Void in
         
         }) { (completion) -> Void in
         
         self.GoldCollectedLBLView.hidden = false
         
         self.GoldCollectedLBLView.transform = CGAffineTransformScale(self.GoldCollectedLBLView.transform, 0.001, 0.001)
         
         UIView.animateWithDuration(animationDuration, animations: { () -> Void in
         self.GoldCollectedLBLView.transform = CGAffineTransformIdentity
         })
         
         
         }
         */
        
        
        
        
        //    print("Difference Amount = \(differenceAmount)")
        
        // let arr = [previousAmount, newAmount, differenceAmount]
        
        /*
         if MoneyActionInProgress {
         moneyTimer.invalidate()
         moneyLBL.text = "$\(MoneyAmountTotalError.description)"
         }
         */
        
        
        staminaTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(MapViewController.StaminaUpdateTimer(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmountTemp)","setting":"\(settingTemp)"], repeats: true)
        
        
        //  moneyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: Selector("MoneyUpdateTimer:"), userInfo: arr, repeats: true)
        
        
        /*
         dispatch_after(dispatchTime, dispatch_get_main_queue(), {
         
         let animationDurationTWO = 1.00
         
         UIView.animateWithDuration(animationDurationTWO, animations: { () -> Void in
         
         }) { (completion) -> Void in
         
         
         
         self.GoldCollectedLBLView.transform = CGAffineTransformScale(self.GoldCollectedLBLView.transform, 1.0, 1.0)
         
         self.GoldCollectedLBLView.hidden = true
         
         UIView.animateWithDuration(animationDurationTWO, animations: { () -> Void in
         self.GoldCollectedLBLView.transform = CGAffineTransformIdentity
         })
         
         
         }
         
         })
         
         */
        
        
    }
    @objc    
    func HandleViewItem(_ notification:Notification) {
        
        OpenedFromLocalNotification = true
        prefs.set(true, forKey: "OPENEDFROMLOCALNOTIFICATION")
        
        let userInfo:Dictionary<String,String?> = notification.userInfo as! Dictionary<String,String?>
        
        var jsonAlert = JSON(userInfo)
        print("ITEM ALERT - JSON \(jsonAlert)")
        //   println("JSON ALERT \(jsonAlert)")
        var NotificationMessage = jsonAlert["message"].stringValue
        var ItemName = jsonAlert["ItemName"].stringValue
        var ItemLatTemp = jsonAlert["ItemLat"].stringValue
        var ItemLongTemp = jsonAlert["ItemLong"].stringValue
        var category = jsonAlert["category"].stringValue
        
        
        let ItemLat = Double(ItemLatTemp)!
        let ItemLong = Double(ItemLongTemp)!
        
        if category == "NearbyItem" {
            
            LocNotItemName = ItemName
            LocNotItemLat = ItemLat
            LocNotItemLong = ItemLong
            
            prefs.setValue(ItemName, forKey: "LOCNOTIFYITEMNAME")
            prefs.setValue(ItemLat.description, forKey: "LOCNOTIFYITEMLAT")
            prefs.setValue(ItemLong.description, forKey: "LOCNOTIFYITEMLONG")
            
            
            print("Centering on item now")
          //  CenterOnItem(ItemName, latitude: ItemLat, longitude: ItemLong)
            
            
        }
        
        
    }
    @objc    
    func HandleAttackMessage(_ notification:Notification) {
    
    print("Did Receive Remote Notification While In Game")
        
  // var notificationDetails: NSDictionary = userInfo as! NSDictionary
  //  var infotest = object["object"]
        
        let userInfo:Dictionary<String,String?> = notification.userInfo as! Dictionary<String,String?>
       // let message = userInfo["message"]!
        
      //  println("USER INFO FROM ALERT = \(userInfo)")
        
       // var attackedBy = userInfo["attackedBy"]
       // var message = userInfo["message"]
      //  var category = userInfo["category"]
       // println("message = \(message)")
    
    //println("Object Info?? \(object)")
   // println("infotest?? \(infotest)")
    
        var jsonAlert = JSON(userInfo)
        print("JSON ALERT \(jsonAlert)")
    //   println("JSON ALERT \(jsonAlert)")
    var NotificationMessage = jsonAlert["message"].stringValue
    var attackedBy = jsonAlert["attackedBy"].stringValue
    var attackingID = jsonAlert["attackedBy"].stringValue
    var category = jsonAlert["category"].stringValue
    
    print("in Game Alert Category: \(category)")
        
    //NEEDTO DELETE
    attackingID = self.email as String
    
    if category == "willAttack" {
        
        print("TRYING TO SHOW ALERT CONTROLLER")
        
        
        if let topController = UIApplication.topViewController() {
            
            var alert = AlertHelper()
            alert.showAttackAlert(fromController: topController, message: "\(NotificationMessage)", title: "Under Attack!", email: self.email, attackingID: attackingID as NSString, attackedBy: attackedBy)
            
        }
        
        
        
        
        
//      //  let actionSheetController = DBAlertController(title: "DBAlertController", message: NotificationMessage, preferredStyle: .Alert)
//        
//        let actionSheetController: UIAlertController = UIAlertController(title: "Under Attack!", message: "\(NotificationMessage)", preferredStyle: .alert)
//
//        
//        //actionSheetController2.addAction(UIAlertAction(title: "Fight Back", style: .Default, handler: nil))
//        //actionSheetController2.addAction(UIAlertAction(title: "Run Away"))
//        //actionSheetController2.show()
//    
//       // let actionSheetController: UIAlertController = UIAlertController(title: "Attack Alert!", message: "You are under Attack!", preferredStyle: .Alert)
//        
//        //Create and add the Cancel action
//        let FightbackAction: UIAlertAction = UIAlertAction(title: "Fight Back", style: .default) { action -> Void in
//    
//            
//            UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "fight", action: "write") {
//                (result, attackResponse) in
//               // if let AttackResponseUpdated = result {
//                    print("Response Updated: \(result), attackResponse: \(attackResponse)")
//               // }
//            }
//            
//           // let (AttackResponseUpdated, response) = UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "fight", action: "write")
//            
//           // let (AttackResponseUpdated, response) = UpdateAttackResponse(self.email as String, attackingID: self.email as String, response: "fight", action: "write")
//            
//          //  print("Attack Respone Updated: \(AttackResponseUpdated), Attack Response: \(response)")
//            
//            
//            print("You're fighting back against \(attackedBy).  Way to be a man")
//            self.AttackStatus = "fightingback"
//            //self.AttackingPlayersHealth = health
//
//            
//            print("Attacking Player = \(self.AttackingPlayer)")
//            
//          //  self.performSegueWithIdentifier("goto_attack", sender: self)
//            
//            
//            
//            
//          
//            let alertView:UIAlertView = UIAlertView()
//            alertView.title = "You are now attacking \(attackedBy)"
//            alertView.message = "Prepare yourself for the attack...coming soon"
//            alertView.delegate = self
//            alertView.addButton(withTitle: "OK")
//            alertView.show()
//
//        }
//        
//        //Create and an option action
//        let RunawayAction: UIAlertAction = UIAlertAction(title: "Run Away!", style: .default) { action -> Void in
//
//            print("You're running away from \(attackedBy).  Be a Man!")
//            
//            // let (AttackResponseUpdated, response) = UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "run", action: "write")
//            
//            
//            UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "run", action: "write") {
//                (result, attackResponse) in
//                // if let AttackResponseUpdated = result {
//                print("Response Updated: \(result), attackResponse: \(attackResponse)")
//                // }
//            }
//            
//            //let (AttackResponseUpdated, response) = UpdateAttackResponse(self.email as String, attackingID: self.email as String, response: "run", action: "write")
//            
//          //  print("Attack Respone Updated: \(AttackResponseUpdated), Attack Response: \(response)")
//            
//            
//            
//            let RandomCowardMessages = ["Stand up for yourself!", "Smart move, live to fight another day", "You should feel ashamed...you coward"]
//            
//            let randomIndex = Int(arc4random_uniform(UInt32(RandomCowardMessages.count)))
//            let RunAwayMessage = RandomCowardMessages[randomIndex]
//         
//                var alertView:UIAlertView = UIAlertView()
//                alertView.title = "You are running away from \(attackedBy)"
//                alertView.message = "\(RunAwayMessage)"
//                alertView.delegate = self
//                alertView.addButton(withTitle: "OK")
//                alertView.show()
//            
//            
//            //self.SubmitPic()
//
//        }
//        
//        
//        actionSheetController.addAction(RunawayAction)
//        actionSheetController.addAction(FightbackAction)
//        
//        
//        
//       // UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(actionSheetController, animated: true, completion: nil)
//        
//        self.present(actionSheetController, animated: true, completion: nil)
 
        
        
        /*
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            var view = WeaponMenu.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })
        
        */
        
        
    
    } else if category == "userMessage" {
    var notifiAlert = UIAlertView()
    //var NotificationMessage = jsonAlert["aps"]["alert"].stringValue
    //var attackedBy = jsonAlert["aps"]["attackedBy"].stringValue
    //var TestMessage : AnyObject? = userInfo["alert"]
    notifiAlert.title = "Incoming Message"
    notifiAlert.message = NotificationMessage
    notifiAlert.addButton(withTitle: "Ok")
    notifiAlert.show()
    } else if category == "didAttack" {
    
        print("HandleAttack - Category - you just got attacked")
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "You did not respond in time to  \(attackedBy)'s attack"
        alertView.message = "Let's take a look at the damage"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    
    } else if category == "cancelAttack" {
        
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Attack Cancelled"
        alertView.message = "\(attackedBy) has shown mercy on you."
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
  }
    
    
    @IBAction func ViewWeaponsBTN(_ sender: AnyObject) {
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = WeaponMenu.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })
        
    }
    
    @IBAction func ViewShieldsBTN(_ sender: AnyObject) {
        
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = ShieldMenu.instanceFromNib()
             view.tag = 1000
            //var customView = (NSBundle.mainBundle().loadNibNamed("ItemAnnotationView", owner: self, options: nil))[0] as! ItemAnnotationView;
            self.view.addSubview(view)
        })
        
    }
    
    @IBAction func ViewPotionsBTN(_ sender: AnyObject) {
        
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = PotionMenu.instanceFromNib()
            view.tag = 1000
            //var customView = (NSBundle.mainBundle().loadNibNamed("ItemAnnotationView", owner: self, options: nil))[0] as! ItemAnnotationView;
            self.view.addSubview(view)
        })
        
    }
    
    
    @IBAction func ViewArmorsBTN(_ sender: AnyObject) {
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = ArmorMenu.instanceFromNib()
             view.tag = 1000
            self.view.addSubview(view)
        })
    }
    
    
    
    @IBAction func ViewCharacter(_ sender: AnyObject) {
        //DEMO BUTTON
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = MyCharacterMenu.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })
    }
    
    @IBAction func TrackMissle(_ sender: AnyObject) {
        //DEMO BUTTON
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        var itemLat = 28.1347
        var itemLong = -81.1316
var itemAlt = 0.0
        var datetime = "2017-01-05 12:09:07"
        var name = "test"
        
        
        // var itemLat = 28.1347
        //  var itemLong = -81.1316
        
        DispatchQueue.main.async(execute: {
            let view = DistanceAttackView.instanceFromNib(lat: itemLat, long: itemLong, datetime: datetime, name: name, alt: itemAlt)
            view.tag = 1000
            self.view.addSubview(view)
        })
    }
    
    
    @IBAction func ViewAbilitiesBTN(_ sender: AnyObject) {
        
        ViewingAbilities = prefs.bool(forKey: "VIEWINGABILITIES")
        print("Viewing Abilities from map = \(ViewingAbilities)")
        
        if !ViewingAbilities {
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = AbilitiesView.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })
            
         ViewingAbilities = true
         
          prefs.set(true, forKey: "VIEWINGABILTIES")
            
        }
        
            /*
        } else {
            
            
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    subview.removeFromSuperview()
                }
            }
            
           ViewingAbilities = false
        }
 */
    }
    
    
    func removeSubview(){
        print("Start remove sibview")
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Checking status after first click")
        if status == .authorizedAlways {
            print("tracking accepted, tracking on")
            TrackingOn = true
        }
        
    }
    
    
    
    
    
    func GenerateGold() {
  
            let item = "GoldProduction"
            let upgradeCost = moneyBankUpgradeCost
            if !moneyBankUpgrading {
                
                
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
    
    func UpgradeCertainItem(_ item: String, cost: Int) {
        
        
        var NotifyDate = Date()
        
        //let item = "Boots"
        var CurrentLevelTemp = String()
        var CompleteTimeTemp = TimeInterval()
        
        switch item {
        case "GoldProduction":
            CurrentLevelTemp = prefs.value(forKey: "GOLDPRODUCTIONLEVEL") as! String
            CompleteTimeTemp = prefs.value(forKey: "moneyBankUPGRADETIME") as! TimeInterval
            
            let endTime = now + CompleteTimeTemp
            prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
            
            NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
            
            print("setting \(item) end time for \(endTime)")
            
            
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
                print("Helmet")
                /*
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.HelmetUpgrading = true
                self.itemTimerView3.hidden = false
                self.HelmetTimeCount = CompleteTimeTemp
                let aSelector: Selector = "UpdateHelmetTime"
                self.HelmetTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.HelmetStartTime = NSDate.timeIntervalSinceReferenceDate()
                
                var localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                */
                
            case "Body":
                print("Body")
                /*
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.BodyUpgrading = true
                self.itemTimerView4.hidden = false
                self.BodyTimeCount = CompleteTimeTemp
                let aSelector: Selector = "UpdateBodyTime"
                self.BodyTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.BodyStartTime = NSDate.timeIntervalSinceReferenceDate()
                
                var localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Armor Upgraded To Level \(NextLevel)"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                */
            case "Shield":
                
                print("Shield")
                /*
                //self.prefs.setValue(NextLevel, forKey: "SHIELDLEVEL")
                self.ShieldUpgrading = true
                self.itemTimerView2.hidden = false
                self.ShieldTimeCount = CompleteTimeTemp
                let aSelector: Selector = "UpdateShieldTime"
                self.ShieldTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.ShieldStartTime = NSDate.timeIntervalSinceReferenceDate()
                
                var localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                */
                
            case "Boots":
                
                print("Boots")
                /*
                self.BootsUpgrading = true
                self.itemTimerView1.hidden = false
                self.BootsTimeCount = CompleteTimeTemp
                let aSelector: Selector = "UpdateBootsTime"
                self.BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: aSelector, userInfo: ["totalTime":"60"], repeats: true)
                
                self.BootsStartTime = NSDate.timeIntervalSinceReferenceDate()
                
                
                var localNotification = UILocalNotification()
                localNotification.fireDate = NotifyDate
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "\(item) Upgraded To Level \(NextLevel)"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
                
                */
                
                
                
                
            default:
                break
                
            }
            
            
            self.UpdateMoneyUser(self.myGoldAmount, itemCost: cost)
            
            
            
        //    NSNotificationCenter.defaultCenter().postNotificationName("UpdateItemTextLevel", object: nil, userInfo: ["item":"\(item)","level":"\(NextLevel)"])
            
            
            
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
                
                
            case "GoldProduction":
                print("GoldProductionLevel")
                /*
                CurrentLevelTemp = prefs.valueForKey("GOLDPRODUCTIONLEVEL") as! String
                CompleteTimeTemp = prefs.valueForKey("moneyBankUPGRADETIME") as! NSTimeInterval
                
                let endTime = now + CompleteTimeTemp
                prefs.setValue(endTime, forKey: "\(item)EndUpgradeTime")
                
                NotifyDate = NSDate(timeIntervalSinceReferenceDate: endTime)
                
                print("setting \(item) end time for \(endTime)")
                
                */
                
                /*
                
                print("\(item) has been upgrade - rushed")
                self.itemTimerView3.hidden = true
                self.HelmetUpgrading = false
                self.HelmetTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView3LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                
                
                
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.NumberItemsUpgrading--
                NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)", level: "\(NextLevel.description)")
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }

                */
                
            case "Helmet":
                
                print("Helmet")
                /*
                print("\(item) has been upgrade - rushed")
                self.itemTimerView3.hidden = true
                self.HelmetUpgrading = false
                self.HelmetTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView3LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                
                
                
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.NumberItemsUpgrading--
                NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)", level: "\(NextLevel.description)")
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                */
                
            case "Body":
                print("Body")
                
                /*
                print("\(item) has been upgrade - rushed")
                self.itemTimerView4.hidden = true
                self.BodyUpgrading = false
                self.BodyTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView4LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) Armor has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.NumberItemsUpgrading--
                NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)", level: "\(NextLevel.description)")
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
 
 */
                
            case "Shield":
                print("Shield")
                
                /*
                print("\(item) has been upgrade - rushed")
                self.itemTimerView2.hidden = true
                self.ShieldUpgrading = false
                self.ShieldTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView2LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) has been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.NumberItemsUpgrading--
                NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
                
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)", level: "\(NextLevel.description)")
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                */
                
            case "Boots":
                print("Boots")
                
                /*
                print("\(item) has been upgrade - rushed")
                self.itemTimerView1.hidden = true
                self.BootsUpgrading = false
                self.BootsTimer.invalidate()
                
                self.prefs.setValue(NextLevel.description, forKey: itemKey)
                self.itemView1LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
                // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Upgrade Complete!"
                alertView.message = "Your \(item) have been upgraded to level \(NextLevel.description)"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                self.NumberItemsUpgrading--
                NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
                
                
                let UpdateItemLevelSuccess =  UpdateUserLevel(self.username, email: self.email, category: "\(item)", level: "\(NextLevel.description)")
                if UpdateItemLevelSuccess {
                    print("Upgrade \(item) level to \(NextLevel)")
                }
                */
                
            default:
                break
                
            }
            
            
          //  NSNotificationCenter.defaultCenter().postNotificationName("UpdateItemTextLevel", object: nil, userInfo: ["item":"\(item)","level":"\(NextLevel)"])
            
            self.UpdateMoneyUser(self.myGoldAmount, itemCost: cost)
            
            
            
            
            
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
        
        
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
        
        moneyTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: Selector("MoneyUpdateTimerUser:"), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmount.description)","setting":"add"], repeats: true)
        
        //  moneyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target:self, selector: Selector("MoneyUpdateTimer:"), userInfo: arr, repeats: true)
        
        
        let UpdateGoldSuccess =  UpdateUserGold(username, email: self.email, amount: newAmount.description as NSString)
        
        if UpdateGoldSuccess {
            print("Updated users gold")
        }
        
        
        
    }
    
    
    @IBAction func addDiamondsBTN(_ sender: AnyObject) {
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Add Diamonds"
        alertView.message = "Coming Soon..Development in process"
        alertView.delegate = self
        
        alertView.addButton(withTitle: "OK")
       // alertView.show()
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = TreasureView.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })
        
    }
    
    
    func RenderTerritoryArray(_ TerritoryInfoTemp: [TerritoryInfo]) {
        
        
        for territories in TerritoryInfoTemp {
            
            self.addBoundry(territories.Point1, Point2: territories.Point2, Point3: territories.Point3, Point4: territories.Point4, id: territories.pointID)
            
        }
        
        
        
    }
    
    /*
    func addImageOverlay(image: UIImage) {
        
        
       let overlayImage = MKCG
        let overlayImageView = UIImageView(image: image)
        overlayImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        overlayImage.addSubview(overlayImageView)
        
        
        
        mapView.addOverlay(overlayImage)
        
        
    }
    */
    
    func AddImageOverlayTemp(_ TestImageIconForMap: ImageIconForMap) {
        let overlay = ImageMapOverlay(ImageIconOverlay: TestImageIconForMap)
        
        
        var points = [TestImageIconForMap.overlayTopLeftCoordinate, TestImageIconForMap.overlayTopRightCoordinate, TestImageIconForMap.overlayBottomRightCoordinate, TestImageIconForMap.overlayBottomLeftCoordinate]
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        
        polygon.title = "image"
        polygon.subtitle = TestImageIconForMap.ImageName
        print("Polygon Rec: \(polygon.boundingMapRect)")

        
        
      //  mapView.addOverlay(overlay, level: MKOverlayLevel.AboveLabels)
        mapView.addOverlay(polygon)
        // mapView.addOverlay(overlay)
      //  mapView.addOverlayImage(self.mapView, rendererForOverlay: overlay)
        
    }
    
    func addBoundry(_ Point1: CLLocationCoordinate2D, Point2: CLLocationCoordinate2D, Point3: CLLocationCoordinate2D, Point4: CLLocationCoordinate2D, id: String)
    {
       // var points=[CLLocationCoordinate2DMake(49.142677,  -123.135139),CLLocationCoordinate2DMake(49.142730, -123.125794),CLLocationCoordinate2DMake(49.140874, -123.125805),CLLocationCoordinate2DMake(49.140885, -123.135214)]
        
        var points = [Point1, Point2, Point3, Point4]
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        print("Polygon Rec: \(polygon.boundingMapRect)")
        
        
         //  print("Overlay Polygon: \(polygon)")
        
        mapView.addOverlay(polygon)
        
        
        /*
        if id != "home" {
         mapView.addOverlay(polygon)
        } else {
            print("Adding Home Over Lay")
         mapView.addOverlayWithInfo(polygon, id: id)
        }
        
        */
       
    }
    

    /*
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        //  print("Over, from mapview render overlay: \(overlay)")
        //   print("Over lay info bounding map rect: \(overlay.boundingMapRect)")
        //   print("OverLay info: \(overlay.coordinate)")
        
        //   print("Overlay Title ==== \(overlay.theTitle)")
    
            
            print("is kind of class imagemapoverlay")
            //if overlay is ImageMapOverlay {
            print("over lay from kind class = \(overlay)")
            // var OL: ImageMapOverlay
            //  OL = overlay.ImageName
            
            print("Overlay was an image map overlay view")
            let FortImage = UIImage(named: "fortressIconTemplate")!
            // var FortImage = overlay.ImageName
            
            let imageMapView = ImageMapOverlayView(overlay: overlay, overlayImage: FortImage)
            
            return imageMapView
            
      
        //  }
    }
    */
 
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
     //  print("Over, from mapview render overlay: \(overlay)")
     //   print("Over lay info bounding map rect: \(overlay.boundingMapRect)")
     //   print("OverLay info: \(overlay.coordinate)")
     
     //   print("Overlay Title ==== \(overlay.theTitle)")
        
        let TempRenderer = MKOverlayRenderer()
        
        if overlay.isKind(of: ImageMapOverlay.self) {
        
        print("is kind of class imagemapoverlay")
            
        //if overlay is ImageMapOverlay {
            
         //   print("over lay from kind class = \(overlay)")
            // var OL: ImageMapOverlay
            //  OL = overlay.ImageName
            
         //   print("Overlay was an image map overlay view")
            let FortImage = UIImage(named: "fortressIconTemplate")!
            // var FortImage = overlay.ImageName
            
            let imageMapView = ImageMapOverlayView(overlay: overlay, overlayImage: FortImage, mapView: mapView, mainView: self.view)

            return imageMapView
            
        } else if overlay is MKPolygon {
            
          //  let theType = overlay.GetType()
           // print("POLYGON TITLE: \(overlay.title)")
            
            let theTitle = overlay.title
            
            //print("IS POLYGON")
            
            if theTitle != nil {
                
                let CompareTitle: String = "image"
                
                if theTitle! == CompareTitle {
                
                let ImageTitle = theTitle! as String!
                
                let theImageName = overlay.subtitle!
                    
                   // print("OVERLAY SUBTITLE: \(theImageName)")
                    
                let FortImage = UIImage(named: "fortressIconTemplate")!
                // var FortImage = overlay.ImageName
                
                //let imageMapView = ImageMapOverlayView(overlay: overlay, overlayImage: FortImage)
                 let imageMapView = ImageMapOverlayView(overlay: overlay, overlayImage: FortImage, mapView: mapView, mainView: self.view)
                return imageMapView
                
                
                
            } else {
                
                
                
                let polygonView = MKPolygonRenderer(overlay: overlay)
                //polygonView.strokeColor = UIColor.magentaColor()
                polygonView.lineWidth = 1
                polygonView.strokeColor = UIColor.yellow
                return polygonView
                
            }

                
            } else {
            
            
            
            let polygonView = MKPolygonRenderer(overlay: overlay)
            //polygonView.strokeColor = UIColor.magentaColor()
            polygonView.lineWidth = 1
            polygonView.strokeColor = UIColor.yellow
            return polygonView
                
            }
        }
 
        
     
//print("OVERLAY IS NIL")
        
       // return nil
           return TempRenderer
      //  }
    }
    
    
    
    @IBAction func captureTerritoryBTN(_ sender: AnyObject) {
        print("CAPTURING TERRITORY")
        CapturingTerritory = true
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                
                subview.removeFromSuperview()
            }
        }
        
        
        

        self.CenterUserBTN.setImage(UIImage(named: "CenterMapIconColor.png"), for: UIControl.State())
        self.CenterOnUser = true
        
        regionRadius = 200
        
        //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
        
        print("Capture Terrirtory: Center Map on User - Region Radius = \(regionRadius)")
        
        
      //  let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, regionRadius * 1.0, regionRadius * 1.0)
        
        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: 0.0168, longitudinalMeters: 0.0168)
        
        
        let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
        
        
        print("New Room Radius = \(NewZoomRadius)")
        
        mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: 17.9, animated: true)
        
        // mapView.setCenterCoordinate(location.coordinate, animated: true)
        
        ZoomLevel = self.UserZoomRadius
        
        
        //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
        // print("Centering with zoom level \(ZoomLevel)")
        
 //    mapView.setRegion(coordinateRegion, animated: true)
 

        DispatchQueue.main.async(execute: {
            var view = CaptureTerritoryView.instanceFromNib()
            view.tag = 1000
            self.view.addSubview(view)
        })

        
    }
    
  
    
    func FilterMissionItems(_ urlData: Data) -> [MissionInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var MyWeaponsInventoryArrayTemp = [MissionInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
       // print("Json Mission valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                let missionID = result["id"].stringValue
                let name = result["name"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let objective = result["objective"].stringValue
                let xp = result["xp"].stringValue
                let category = result["category"].stringValue
                let categoryTitle = result["categoryTitle"].stringValue
                
                let itemStatus = "yes"
                
                let itemType = categoryTitle
                let itemCode = "123"
                let theItemID = "0"
                let itemAmount = "1"
                let itemCategory = "misc"
                let count = "1"
                let itemLevel = "1"
                let health = "0"
                let stamina = "0"
                let ammoCount = "0"
                let speed = "0"
                let power = "0"
                let range = "10"
                let viewrange = "10"
                
                //let isMission = true
                //let itemID = "NA"
               
                
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
                let killcount = "0"
                let killedcount = "0"
                
                
                MyWeaponsInventoryArrayTemp.append(MissionInfo(id: missionID, name: name, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                
                
                if status != "complete" {
                
                let missionTitle = "test"
              
                let missionCoordinate = CLLocationCoordinate2DMake(lat!, long!)
                //let itemImage = UIImage(named: "mapFolderIcon.png")!
             
                let missionMapURL = result["imageURL"].stringValue
                let missionObjectURL = result["imageURL"].stringValue
       
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(missionMapURL).png")
                let theImageData = try? Data(contentsOf: url)
                let itemImage = UIImage(data:theImageData!)!
                
                //let MissionPoint = MissionLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "mission", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: true, missionID: missionID)
                print("ITEM LEVEL: \(itemLevel)")
                
                    let altitude = 0.0
                    
                switch category {
                    
                case "item":
                    let MissionPoint = ItemLabel(title: categoryTitle as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: missionCoordinate, itemCode: itemCode as String, itemID: theItemID as String, image: itemImage, amount: itemAmount as String, PinType: "item", category: itemCategory, count: count, level: itemLevel, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: true, missionID: missionID, xp: xp, objective: objective, missionLevel: level, imageName: missionMapURL, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    
                    self.mapView.addAnnotation(MissionPoint)
                 
                default:
                    let MissionPoint = MissionLabel(title: missionTitle, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "mission", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: true, missionID: missionID, missionLevel: level, imageName: missionMapURL, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: altitude)
                    
                    self.mapView.addAnnotation(MissionPoint)
                    
                 }
                    
                }
                
               // print("ADDING MISSION POINT TO MAP NOW")
                
                
                
                
                
                
            }
            
        }
        
        
        return MyWeaponsInventoryArrayTemp
    }
    
    
    @IBAction func xpExplainedBTN(_ sender: AnyObject) {
        //DEMO BUTTON
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Experience Points"
        alertView.message = "Earn XP by completing missions, conquering territories, defeating enemies and many other items"
        alertView.delegate = self
        
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    
    @IBAction func DemoBTN(_ sender: AnyObject) {
        
    let subViews = self.view.subviews
    for subview in subViews{
    if subview.tag == 1000 {
    subview.removeFromSuperview()
    }
    }
        
    var MissedItemsInfoTemp = [NearbyItem]()
        
        let TempImage = UIImage(named: "Fist.png")!
       

        
        MissedItemsInfoTemp.append(NearbyItem(name: "Binoculars", itemStatus: "", Location: CLLocationCoordinate2D(latitude: 28.34, longitude: -81.34), itemID: "1", itemImage: TempImage, imageName: "Binoculars"))
        
         MissedItemsInfoTemp.append(NearbyItem(name: "Bomb", itemStatus: "", Location: CLLocationCoordinate2D(latitude: 28.34, longitude: -81.34), itemID: "1", itemImage: TempImage, imageName: "Bomb"))
        
         MissedItemsInfoTemp.append(NearbyItem(name: "Cannon", itemStatus: "", Location: CLLocationCoordinate2D(latitude: 28.34, longitude: -81.34), itemID: "1", itemImage: TempImage, imageName: "Cannon"))
        

      //  MissedItemsInfoTemp.append(MissedItemsInfo(itemName: "Fist", itemImage: TempImage))
     //   MissedItemsInfoTemp.append(MissedItemsInfo(itemName: "Binoculars", itemImage: TempImage2))
    
    DispatchQueue.main.async(execute: {
    var view = MissedItemsView.instanceFromNib(MissedItemsInfoTemp)
    view.tag = 1000
    self.view.addSubview(view)
    })
    
    }
    
    @IBAction func GoldPouchInfo(_ sender: AnyObject) {
        
        /*
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            var view = ItemOptionsView.instanceFromNib(2, IsUpgrading: false, itemCategory: "GoldPurse")
            view.tag = 1000
            self.view.addSubview(view)
        })
        */
        
        ShowItemInfoMenu(3, IsUpgrading: false, itemCategory: "GoldPurse", upgradeAmount: "2000", upgradeNowAmount: "15")
        
        
    }
    
    func ShowItemInfoMenu(_ NumViews: Int, IsUpgrading: Bool, itemCategory: String, upgradeAmount: String, upgradeNowAmount: String) {
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            var view = ItemOptionsView.instanceFromNib(NumViews, IsUpgrading: IsUpgrading, itemCategory: itemCategory, upgradeAmount: upgradeAmount, upgradeNowAmount: upgradeNowAmount)
            view.tag = 1000
            self.view.addSubview(view)
        })
        
    }
    
    //RETURNS USER TIMEZONE - OFFSET
    func ltzOffset() -> Int {
        return NSTimeZone.local.secondsFromGMT()
    }
    
   
    
    func ToggleNightVision(_ Status: Bool) {
        
        
        let DimValueTemp = CGFloat(self.DimLightValue)
        
        if !Status {
            self.NightVisionOn = false
            
            
            self.daylightView.backgroundColor = UIColor.black
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.daylightView.alpha = DimValueTemp
                // self.loadingView.hidden = true
            })
            
            
        } else {
            self.NightVisionOn = true
            
            print("Night Vision On")
            self.daylightView.backgroundColor = UIColor.green
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.daylightView.alpha = 0.4
                // self.loadingView.hidden = true
            })
        }
        
    }
    
    
    @IBAction func GoToNews(_ sender: Any) {
        
        self.performSegue(withIdentifier: "News", sender: self)
        
    }

    
    
    @IBAction func HowToTestViewBTN(_ sender: AnyObject) {
        
        //TEMP BTN WAS 'WEAPONSPICKTEST'
        /*
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = HowToView.instanceFromNib("test", item: "health", description: "test description", itemsArray: ["test"], descriptionsArray: ["test"])
            view.tag = 1000
            self.view.addSubview(view)
        })
        */
        
        
        //HOW TO VIEW TEST BELOW
        /*
        let HowToItems = [String]()
        let HowToItemsDescriptions = [String]()
        
        LoadHowToView(item: "health", description: "Your Health meter", itemsArray: HowToItems, descriptionsArray: HowToItemsDescriptions, itemsCount: 19)
        
        */
           // let CharacterInfoTemp = CharacterInfo(name: self.username as String, skinTone: "white", health: "100", currentWeapon: wp)
        //LoadPlayerAttack(name: self.username as String, skin: "white", health: "100")
        
        
//        let type: NSString = "willAttack"
//        
//        let yesSuccess =  AttackNotice(username, username: "jaredstevens10", attackpower: 1, type: type, attackedID: "jaredstevens10@yahoo.com")
//        print("***Atttack Notice send = \(yesSuccess)")
        
        
        let startDistanceArray = [-7, -2, -10, -20, -30, -5]
        
        let randomIndex = Int(arc4random_uniform(UInt32(startDistanceArray.count)))
        let randomStart = Float(startDistanceArray[randomIndex])
        
        
        LoadPlayerAttack(name: self.username as String, skin: "white", health: "100", AttackingPlayer: "jaredstevens10", AttackingPlayersHealth: "100", AttackingPlayerID: "jaredstevens10@yahoo.com", StaminaUsed: "10", AttackPower: 1, AttackStatus: "", startDistance: randomStart)
        
    }
    
    func LoadHowToView(item: String, description: String, itemsArray: [String], descriptionsArray: [String], itemsCount: Int) {
        
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = HowToView.instanceFromNib("test", item: item, description: description, itemsArray: itemsArray, descriptionsArray: descriptionsArray, itemsCount: itemsCount)
            view.tag = 1000
            self.view.addSubview(view)
            
        })
    }
    
    
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
   
    
    
    func LoadPlayerAttack(name: String, skin: String, health: String, AttackingPlayer: String, AttackingPlayersHealth: String, AttackingPlayerID: String, StaminaUsed: String, AttackPower: Int, AttackStatus: String, startDistance: Float) {
        
        
        self.DisplayLoadingView(true)
        
        
        DispatchQueue.main.async(execute: {
        
        
        let NewStaminaAmount = self.prefs.integer(forKey: "MYSTAMINA") - Int(StaminaUsed)!
        
        let UpdatedHealthStamina = SaveUsersHealthStamina("stamina", level: NewStaminaAmount, emailID: self.email)
        print("Stamina was updated = \(UpdatedHealthStamina)")
        
        
        
        let StaminaUsedNew = Int(StaminaUsed)
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
          
            
            self.tabBarItemPlayer.isEnabled = false
            self.tabBarItemTeam.isEnabled = false
            var wp = String()
            
            if self.prefs.value(forKey: "HOLDINGWEAPON") == nil {
                wp = "Fist"
            } else {
                wp = self.prefs.value(forKey: "HOLDINGWEAPON") as! String
            }
            
            print("wp: \(wp)")
            
            let CharacterInfoTemp = CharacterInfo(name: name, skinTone: skin, health: health, currentWeapon: wp)
            
            
            var view = PlayerAttackView.instanceFromNib(characterInfo: CharacterInfoTemp, AttackingPlayer: AttackingPlayer, AttackingPlayersHealth: AttackingPlayersHealth, AttackingPlayerID: AttackingPlayerID, StaminaUsed: StaminaUsedNew!, AttackPower: AttackPower, AttackStatus: AttackStatus, startDistance: startDistance, altitude: self.myalt)
            view.tag = 1000
            
            
            
            self.view.addSubview(view)
            
            self.DisplayLoadingView(false)
        })
 
    })
    
    }
    
  
}

extension MKMapView {
    
    func addOverlayWithInfo(_ overlay: MKOverlay!, id: String) -> MKOverlayRenderer! {
        
        
        if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        //polygonView.strokeColor = UIColor.magentaColor()
        
        if id == "home" {
        polygonView.strokeColor = UIColor.green
        polygonView.lineWidth = 1
        } else {
        polygonView.strokeColor = UIColor.yellow
        }
        
        return polygonView
    }
    return nil
}
    
  //  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
   // func addOverlayImage(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
  /*
        
     func addOverlayImage(mapView: MKMapView!, rendererForOverlay overlay: ImageMapOverlay!) -> ImageMapOverlayView! {
        let FortImage = UIImage(named: "fortressIconTemplate")!
        // var FortImage = overlay.ImageName
        
        let imageMapView = ImageMapOverlayView(overlay: overlay, overlayImage: FortImage)
        print("else returne3d imagemapview overlay")
        
        
        return imageMapView
        
        /*
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            //polygonView.strokeColor = UIColor.magentaColor()
            
            if id == "home" {
                polygonView.strokeColor = UIColor.greenColor()
                polygonView.lineWidth = 1
            } else {
                polygonView.strokeColor = UIColor.yellowColor()
            }
            
            return polygonView
        }
        return nil
        */
    }
    
    */
    
   
   
    
    
}



extension MapViewController {
    func settingsViewControllerFinished(_ settingsViewController: WeaponsViewController) {
        
   //     self.WeaponItem.image = settingsViewController.weaponPKimage
        
        self.ToolsBTN.setImage(settingsViewController.weaponPKimage, for:UIControl.State())
        
        switch settingsViewController.weaponPKLabel {
        case "Brass Knuckles":
            print("Knuckles")
            AttackPower = 5
      //  case "Sniper Rifle":
      //      print("Sniper Rifle")
      //      AttackPower = 10
        case "Magnum":
            print("Magnum")
            AttackPower = 10
        case "Night Vision Goggles":
            NightVisionOn = true
            
        default:
            AttackPower = 0
        }
        
        
        /*
        if settingsViewController.weaponPKLabel == "Flashlight" {
            self.FlashlightBTNView.hidden = false
        } else {
            self.FlashlightBTNView.hidden = true
        }
        
        */
        
        print("WEAPON SELECTED: \(settingsViewController.weaponPKLabel)")
        
        
         if settingsViewController.weaponPKLabel == "Night Vision Goggles" {
         //self.NightVisionOn = true
            print("You selected night vision goggles")
            self.ToggleNightVision(true)
            
         } else {
           // self.NightVisionOn = false
            
            self.ToggleNightVision(false)
         }
         
 
        
        WeaponSpeed = settingsViewController.SpeedSelected
        WeaponPower = settingsViewController.PowerSelected
        WeaponRange = settingsViewController.RangeSelected
        ViewRange = settingsViewController.ViewRangeSelected
        userRadius = Int((WeaponRange as NSString).doubleValue)
        itemRadius = Int((ViewRange as NSString).doubleValue)
        
        UserZoomRadius = Double(itemRadius)
        
        if userRadius < 2 {
        VRange.text = "Range: \(itemRadius) Mile"
        } else {
            VRange.text = "Range: \(itemRadius) Miles"
        }
        //var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        prefs.set(userRadius, forKey: "WRADIUS")
        prefs.set(itemRadius, forKey: "VIEWRADIUS")
       // userRadius = Int(Rad)
        print("Attack Power = \(WeaponPower)")
            //= settingsViewController.weaponPKimage
        UpdateMap()
        
        
        let templat =   mapView.userLocation.coordinate.latitude
        let templong = mapView.userLocation.coordinate.longitude
        
         NotificationCenter.default.post(name: Notification.Name(rawValue: "CenterMap"), object: nil, userInfo: ["lat":"\(templat)","long":"\(templong)"])
        
        
    }
    

    
}


extension MapViewController  {
    func ArmorViewControllerFinished(_ armorviewController: ArmorViewController) {
    
   // self.WeaponItem.image = ArmorViewController.armorPKimage
    
    self.armorBTN.setImage(armorviewController.armorPKimage, for:UIControl.State())
        
        
        switch armorviewController.armorPKLabel {
            case "Wood Armor":
            print("wood armor")
            ArmorDefense = 5
            case "Black Armor":
            print("black armor")
            ArmorDefense = 10
            default:
            ArmorDefense = 0
        }
        
        ArmorSpeed = armorviewController.SpeedSelected
        ArmorPower = armorviewController.PowerSelected
        ArmorRange = armorviewController.RangeSelected
    print("ArmorDefense =  \(ArmorPower)")
        UpdateMap()
        //= settingsViewController.weaponPKimage
    
  }
}


extension MapViewController {
    func ShieldViewControllerFinished(_ shieldviewController: ShieldViewController) {
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        
        //self.shieldBTN.setImage(shieldviewController.armorPKimage, for:UIControl.State())
        
        switch shieldviewController.armorPKLabel {
        case "Wood Armor":
            print("wood armor")
            ShieldDefense = 5
        case "Black Armor":
            print("black armor")
            ShieldDefense = 10
        default:
            ShieldDefense = 0
        }
        
        ShieldSpeed = shieldviewController.SpeedSelected
        ShieldPower = shieldviewController.PowerSelected
        ShieldRange = shieldviewController.RangeSelected
     
        UpdateMap()
        
        print("SheildDefense =  \(ShieldPower)")
        //= settingsViewController.weaponPKimage
        
    }
}




extension MapViewController {
    func itemannotationViewControllerFinished(_ shieldviewController: ItemAnnotationViewController) {
        
    
        
    }
}


struct TerritoryInfo {
    
    var pointID: String
    
    var Point1: CLLocationCoordinate2D
    var Point2: CLLocationCoordinate2D
    var Point3: CLLocationCoordinate2D
    var Point4: CLLocationCoordinate2D
    var Point5: CLLocationCoordinate2D
}

import UIKit
import MapKit

class ImageMapOverlayView: MKOverlayRenderer {
    var overlayImage: UIImage
    var mapView: MKMapView
    var mainView: UIView
    init(overlay:MKOverlay, overlayImage:UIImage, mapView: MKMapView, mainView: UIView) {
        
        print("Drawing Image: \(overlayImage)")
        self.overlayImage = overlayImage
        self.mapView = mapView
        self.mainView = mainView
        
        super.init(overlay: overlay)
        
        print("...Overlay = \(overlay)")
        
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext!) {
        
      //  let imageReference = overlayImage.CGImage
        let LandImage = UIImage(named: "GrassLandTexture")!
        
        
        
        let imageReferenceTemp = drawLand(overlayImage, LandImage: LandImage, LandRect: mapRect, mapView: mapView, mainView: mainView)
        let imageReference = imageReferenceTemp.cgImage
        
        let theMapRect = overlay.boundingMapRect
        
      //  print("Bounding Map rect: \(overlay.boundingMapRect)")
     //   print("Context: \(context)")
        let theRect = rect(for: theMapRect)
        
     //   CGContextScaleCTM(context, 5.0, -1.0)
        
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.translateBy(x: 0.0, y: -theRect.size.height)
        context.draw(imageReference!, in: theRect)
    }
    
    
    func drawLand(_ FortImage: UIImage, LandImage: UIImage, LandRect: MKMapRect, mapView: MKMapView, mainView: UIView) -> UIImage {
        
        print("Drawing Land")
        
        let theLandRegion = MKCoordinateRegion(LandRect)
        print("theland region: \(theLandRegion)")
        
        
        let theLandRect = mapView.convert(theLandRegion, toRectTo: mainView)
        
        let LandView = drawShapeLayer(LandImage, theLandRect: theLandRect)
        
        
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(theLandRect.size.width, theLandRect.size.height) * 0.6
        let plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        
        
        
        
      //  let path = UIBezierPath(CGPath: <#T##CGPath#>)
        
        
        //let LandView = UIView(frame: theLandRect)
       // LandView.
        
        print("The Land CGRect: \(theLandRect)")
        //var theLandRect = mapview(convertR)theLandRegion.con
        
     //   UIGraphicsBeginImageContextWithOptions(CGSize(width: LandRect.size.width, height: LandRect.size.height), false, 0)
        
      //  UIGraphicsBeginImageContext(CGSize(width: LandRect.size.width, height: LandRect.size.height))
        
        
        
         UIGraphicsBeginImageContext(CGSize(width: theLandRect.size.width, height: theLandRect.size.height))
        
        plusPath.move(to: CGPoint(
            x:theLandRect.size.width/2 - plusWidth/2,
            y:theLandRect.size.height/2))
        
        
        plusPath.addLine(to: CGPoint(
            x:theLandRect.size.width/2 + plusWidth/2,
            y:theLandRect.size.height/2))
        
        /*
        plusPath.moveToPoint(CGPoint(
            x:0,
            y:0))
        
        plusPath.addLineToPoint(CGPoint(
            x:0,
            y:0))
        
        */
        
        plusPath.move(to: CGPoint(
            x:theLandRect.size.width,
            y:0))
        
        plusPath.addLine(to: CGPoint(
            x:theLandRect.size.width,
            y:0))
        
        
        UIColor.white.setStroke()
        
       // let context = UIGraphicsGetCurrentContext()
        
      //  let LandWidth = CGFloat(LandRect.size.width)
     //   let LandHeight = CGFloat(LandRect.size.height)
        let LandWidth = CGFloat(theLandRect.size.width)
        let LandHeight = CGFloat(theLandRect.size.height)
        
        
        
        
        print("Land Width : \(LandWidth)")
        print("Land Height : \(LandHeight)")
        
        LandImage.draw(in: CGRect(x: 0,y: 0, width: LandWidth, height: LandHeight))
        
        let XPoint = CGFloat(theLandRect.size.width / 4)
        let YPoint = CGFloat(theLandRect.size.height / 4)
        
        let CurtFortImageW = CGFloat(FortImage.size.width)
        let CurtFortImageH = CGFloat(FortImage.size.height)
        
        print("Current Fort W: \(CurtFortImageW)")
        print("Current Fort H: \(CurtFortImageH)")
        
        let CurtWH_Diff = CurtFortImageW / CurtFortImageH
        
        print("Diff: \(CurtWH_Diff)")
        
        let NewWidth: CGFloat = CGFloat(theLandRect.size.width)  / 2
        let NewHeight: CGFloat = NewWidth / CurtWH_Diff
        
        
        
        
        FortImage.draw(in: CGRect(x: XPoint, y: YPoint, width: NewWidth, height: NewHeight))
        
        plusPath.stroke()
        
        
        var NewImage = UIImage()
        
        if UIGraphicsGetImageFromCurrentImageContext() != nil {
            
            NewImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext()
           // return NewImage
        } else  {
            NewImage = UIImage(named :"GrassLandTexture.png")!
            NewImage.draw(in: CGRect(x: 0,y: 0, width: LandWidth, height: LandHeight))
            //return nil
        }
        
       UIGraphicsEndImageContext()
        
        return NewImage
        
    }
    
    
    func drawShapeLayer(_ LandImage: UIImage, theLandRect: CGRect) -> UIView {
        
       
        let view = UIView(frame: theLandRect)
    //    XCPShowView("view", view)
        
        
        let imageView = UIImageView(image: LandImage)
        imageView.frame = view.bounds
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(imageView)
        
        
        
        let shape = CAShapeLayer()
        view.layer.addSublayer(shape)
        shape.opacity = 0.5
        shape.lineWidth = 2
        shape.lineJoin = CAShapeLayerLineJoin.miter
        shape.strokeColor = UIColor(hue: 0.786, saturation: 0.79, brightness: 0.53, alpha: 1.0).cgColor
        shape.fillColor = UIColor(hue: 0.786, saturation: 0.15, brightness: 0.89, alpha: 1.0).cgColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 120, y: 20))
        path.addLine(to: CGPoint(x: 230, y: 90))
        path.addLine(to: CGPoint(x: 240, y: 250))
        path.addLine(to: CGPoint(x: 40, y: 280))
        path.addLine(to: CGPoint(x: 100, y: 150))
        path.close()
        shape.path = path.cgPath
        
        return view
        
    }
    
    
}

extension UIBezierPath {
    
    /** Returns an image of the path drawn using a stroke */
    func strokeImageWithColor(_ strokeColor: UIColor?,fillColor: UIColor?) -> UIImage {
        var strokeColor = strokeColor, fillColor = fillColor
        
        // get your bounds
        let bounds: CGRect = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width + self.lineWidth * 2, height: bounds.size.width + self.lineWidth * 2), false, UIScreen.main.scale)
        
        // get reference to the graphics context
        let reference: CGContext = UIGraphicsGetCurrentContext()!
        
        // translate matrix so that path will be centered in bounds
        reference.translateBy(x: self.lineWidth, y: self.lineWidth)
        
        if strokeColor == nil {
            strokeColor = fillColor!;
        }
        else if fillColor == nil {
            fillColor = strokeColor!;
        }
        
        // set the color
        fillColor?.setFill()
        strokeColor?.setStroke()
        
        // draw the path
        fill()
        stroke()
        
        
        // grab an image of the context
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}


class ImageMapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
   // var theTitle: String
    var ImageName: String
    
 //   init(ImageIconOverlay: )
    
    init(ImageIconOverlay: ImageIconForMap) {
        print("Image Map Overlay init")
        
        boundingMapRect = ImageIconOverlay.overlayBoundingMapRect
        print(" Bound Map Rec: \(boundingMapRect)")
        coordinate = ImageIconOverlay.midCoordinate
      //  theTitle = "imageOverlay"
        ImageName = ImageIconOverlay.ImageName
    }
}



class ImageIconForMap {
    var boundary: [CLLocationCoordinate2D]
    var boundaryPointsCount: NSInteger
    
    var ImageName: String
    
    var midCoordinate: CLLocationCoordinate2D
    var overlayTopLeftCoordinate: CLLocationCoordinate2D
    var overlayTopRightCoordinate: CLLocationCoordinate2D
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D
  //  var overlayBottomRightCoordinate: CLLocationCoordinate2D
    
    
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                              overlayTopRightCoordinate.longitude)
        }
    }
    
    
   // var overlayBoundingMapRect: MKMapRect
    
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPoint(overlayTopLeftCoordinate)
            let topRight = MKMapPoint(overlayTopRightCoordinate)
            let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
            
          //  print("TOP LEFT: \(overlayTopLeftCoordinate)")
          //  print("TOP RIGHT: \(overlayTopRightCoordinate)")
          //  print("BOTTOM LEFT: \(overlayBottomLeftCoordinate)")
            
            return MKMapRect(x: topLeft.x,
                             y: topLeft.y,
                             width: fabs(topLeft.x-topRight.x),
                             height: fabs(topLeft.y - bottomLeft.y))
        }
    }
 
    
    var name: String?
    
   // init(filename: String) {
    
    init(imageName: String, CenterPoint: CGPoint, Point1: CGPoint, Point2: CGPoint, Point3: CGPoint, Point4: CGPoint) {
        
        print("DID INIT CLASS imageiconformap")
        
        let filePath = "" //NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        let properties = "" //NSDictionary(contentsOfFile: filePath!)
        
        //let midPoint = CGPointFromString(properties!["midCoord"] as! String)
      //  let midPoint = CGPoint(x: 28.812000, y: -81.340900)
        
        midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(CenterPoint.x), CLLocationDegrees(CenterPoint.y))
       // print("Mid Coordinate: \(midCoordinate)")
        
        
      //  midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(28.812530), CLLocationDegrees(-81.340516))

        ImageName = imageName
        
        let Pwidth = fabs(Point1.x - Point2.x)
        let PHeight = fabs(Point1.y - Point3.y)
        
       // overlayBoundingMapRect = MKMapRectMake(Double(Point1.x), Double(Point1.y), Double(Pwidth), Double(PHeight))
      //  print("OverLayBoundinMapRec: \(overlayBoundingMapRect)")
        
        
    //    "Point1":[{"longitude":"-81.340064","latitude":"28.811515"}],"Point2":[{"longitude":"-81.340059","latitude":"28.812759"}],"Point3":[{"longitude":"-81.34081","latitude":"28.813172"}],"Point4":[{"longitude":"-81.341304","latitude":"28.811555"}],"Point5":[{"longitude":"-81.340900","latitude":"28.812000"}]}]}
        
        
       // let overlayTopLeftPoint = CGPointFromString(properties!["overlayTopLeftCoord"] as! String)
       //let overlayTopLeftPoint = CGPoint(x: 28.811515, y: -81.340064)
        
        

        overlayTopLeftCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Point1.x), CLLocationDegrees(Point1.y))

    //    print("overlay top left Coordinate: \(overlayTopLeftCoordinate)")
     // let overlayTopRightPoint = CGPoint(x: 28.812759, y: -81.340059)
//let overlayTopRightPoint = CGPointFromString(properties!["overlayTopRightCoord"] as! String)
        
        overlayTopRightCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Point2.x), CLLocationDegrees(Point2.y))
        
      //  let overlayBottomLeftPoint = CGPoint(x: 28.813172, y: -81.34081)
//        let overlayBottomLeftPoint = CGPointFromString(properties!["overlayBottomLeftCoord"] as! String)
        overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Point3.x), CLLocationDegrees(Point3.y))
        
        
      //  overlayBottomRightCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Point4.x), CLLocationDegrees(Point4.y))
        
        
        let boundaryPoints = ["{28.811515, -81.340064}","{28.812759, -81.340900}","{28.813172, -81.34081}","{28.812759, -81.340059}"]
        
        
        
        boundaryPointsCount = boundaryPoints.count
      //  boundaryPointsCount = 4
        
       // boundaryPointsCount = boundary.count
        boundary = []
        
     //   boundary = [CLLocationCoordinate2D(latitude: CLLocationDegrees(Point1.x), longitude: CLLocationDegrees(Point1.y)), CLLocationCoordinate2D(latitude: CLLocationDegrees(Point2.x), longitude: CLLocationDegrees(Point2.y)), CLLocationCoordinate2D(latitude: CLLocationDegrees(Point3.x), longitude: CLLocationDegrees(Point3.y)), CLLocationCoordinate2D(latitude: CLLocationDegrees(Point4.x), longitude: CLLocationDegrees(Point4.y))]
       
        /*
        boundary.append(CLLocationCoordinate2D(latitude: 28.811515, longitude: -81.340064))
        boundary.append(CLLocationCoordinate2D(latitude: 28.812759, longitude: -81.340900))
        boundary.append(CLLocationCoordinate2D(latitude: 28.813172, longitude: -81.34081))
        boundary.append(CLLocationCoordinate2D(latitude: 28.812759, longitude: -81.340059))
*/
        
        
        for i in 0...boundaryPointsCount-1 {
            let p = NSCoder.cgPoint(for: boundaryPoints[i] )
           // print("Boundary P X:\(p.x)")
           // print("Boundary P Y:\(p.y)")
            boundary += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
        }
        
    
    }
}

extension MKOverlay {
    
    func GetType() -> String {
        //let OverLayType: String?
        let OverLayType = String()
        return OverLayType
    }
    
    
}

class RadialGradientLayer: CALayer {
    
    override init(){
        
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init()
        
    }
    
    var center:CGPoint = CGPoint(x: 200,y: 200)
    var radius:CGFloat = 20
  //  var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).CGColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).CGColor]
    
    var colors:[CGColor] = [UIColor.clear.cgColor, UIColor.black.cgColor]
    
    override func draw(in ctx: CGContext!) {
        
        ctx.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var locations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0,1.0])
        
        var startPoint = CGPoint(x: 0, y: self.bounds.height)
        var endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: [])
      //  CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, radius, 0)
        
    }
    
}

extension MapViewController:UNUserNotificationCenterDelegate{
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let requestIdentifier = "SampleRequest"
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}
