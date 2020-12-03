//
//  CustomUIViews.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit


class ItemAnnotationView: UIView, MKMapViewDelegate {
    
    
    var TotalPlayerAttributesTemp: TotalPlayerAttributes?
    var killcount = String()
    var killedcount = String()
    
    //MAIN VIEWS-------------
    
    var isMission = Bool()
    var IsDead = Bool()
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var BGViewEnemy: UIView!
    @IBOutlet weak var BGViewMission: UIView!
    @IBOutlet weak var BGViewHome: UIView!
    @IBOutlet weak var BGViewCamera: UIView!
    @IBOutlet weak var BGViewCameraOther: UIView!
    
    
    var username = NSString()
    var email = NSString()
    var dist = Double()
    var prefs:UserDefaults = UserDefaults.standard
    
    //ENEMY ITEMS-------------
    @IBOutlet weak var attackBTN: UIButton!
    @IBOutlet weak var statsBTN: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var healthProgressView: VerticalProgressView!
    @IBOutlet weak var staminaProgressView: VerticalProgressView!
    @IBOutlet weak var healthLBL: UILabel!
    @IBOutlet weak var slealthLBL: UILabel!
    @IBOutlet weak var playerNameLBL: UILabel!
    @IBOutlet weak var playerLevelLBL: UILabel!
    @IBOutlet weak var playerGoldLBL: UILabel!
    
    var CanAttack = Bool()
    var healthprogress = Float()
    var staminaprogress = Float()
    var isOpen = Bool()
    var attackUserName = String()
    //var itemType = String()
    var attackUserLat = Double()
    var attackUserLong = Double()
    var attackUserID = String()
    var attackUserHealth = String()
    var attackUserStamina = String()
    var attackUserImage = UIImage()
    var attackUserDistance = Double()
    
    var attackUserAlt = Double()

    
    
    //GAME ITEMS-------------
    @IBOutlet weak var pickupBTN: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var distanceLBL: UILabel!
    @IBOutlet weak var levelLBL: UILabel!
    
    @IBOutlet weak var missionIcon: UIImageView!
    
    
    var CanPickUp = Bool()
    var itemID = String()
    var itemName = String()
    var itemType = String()
    var itemLat = Double()
    var itemLong = Double()
    var itemCode = String()
    var itemAlt = Double()
    
    var amount = String()
    var itemImageIMG = UIImage()
    var itemDistance = Double()
    var PinType = String()
    var itemTitle: String!
    
    var category = String()
    var count = String()
    var level = String()
    var health = String()
    var stamina = String()
    var ammoCount = String()
    var speed = String()
    var power = String()
    var range = String()
    var viewrange = String()
    
    
    var StaminaUsed = Int()
    
    
    //MISSION ITEMS-------
    
    @IBOutlet weak var startMission: UIButton!
    @IBOutlet weak var missionObjectiveLBL: UILabel!
    @IBOutlet weak var missionMapView: MKMapView!
    var missionTitle = String()
    var missionObjective = String()
    var missionLevel = String()
    var missionCoordinate = CLLocationCoordinate2D()
    var missionXP = String()
    var missionImage = UIImage()
    var missionID = String()
    var missionMapURL = String()
    var missionObjectURL = String()
    
    var titleText: String! {
        didSet {
            titleLBL.text = titleText
        }
        
    }
    
    
    //MY SURVELENCE ITEMS-----
    
    @IBOutlet weak var mycameralevelLBL: UILabel!
    @IBOutlet weak var mycameraArmSecurityBTN: UIButton!
    @IBOutlet weak var resetCameraBTN: UIButton!
    @IBOutlet weak var mycameraImage: UIImageView!
    var mycamera_Image = UIImage()
    
    //OTHER SURVELENCE ITEMS-----
    
    @IBOutlet weak var othercameralevelLBL: UILabel!
    //@IBOutlet weak var mycameraArmSecurityBTN: UIButton!
    //@IBOutlet weak var resetCameraBTN: UIButton!
    @IBOutlet weak var othercameraImage: UIImageView!
    var othercamera_Image = UIImage()
    
    

    //HOME ITEMS------
    
    @IBOutlet weak var homelevelLBL: UILabel!
    @IBOutlet weak var homegoldLBL: UILabel!
    @IBOutlet weak var homeArmSecurityBTN: UIButton!
    @IBOutlet weak var homeDepositGoldBTN: UIButton!
    @IBOutlet weak var homebaseImage: UIImageView!
    var homeImage = UIImage()
    
    var buttonClicked = Bool()
  
    
    override func awakeFromNib() {
        
       // print("AWAKE FROM NIB PIN TYPE: \(self.PinType)")
        /*
        switch PinType {
        case "player":
            print("Player")
            
        case "item":
            print("item")
            
        case "mission":
            print("mission")
            startMission.layer.cornerRadius = 5
            FocusOnMissionLocation(itemLat, missionLong: itemLong)
            
        default:
            break
        }
        */
        
        //STAMINA USED...NEED TO CHANGE AS IT SHOULD BASED UPON ATTACK
        
        IsDead = prefs.bool(forKey: "AmIDead")
        
        StaminaUsed = 25
        
        startMission.layer.cornerRadius = 5
        
        
        
        BGView.layer.cornerRadius = 10
        BGView.clipsToBounds = true
        BGView.layer.masksToBounds = true
        BGView.layer.borderWidth = 1
        BGView.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        
        BGViewMission.layer.cornerRadius = 10
        BGViewMission.clipsToBounds = true
        BGViewMission.layer.masksToBounds = true
        BGViewMission.layer.borderWidth = 1
        BGViewMission.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        
        BGViewHome.layer.cornerRadius = 10
        BGViewHome.clipsToBounds = true
        BGViewHome.layer.masksToBounds = true
        BGViewHome.layer.borderWidth = 1
        BGViewHome.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        
        BGViewCamera.layer.cornerRadius = 10
        BGViewCamera.clipsToBounds = true
        BGViewCamera.layer.masksToBounds = true
        BGViewCamera.layer.borderWidth = 1
        BGViewCamera.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        
        BGViewCameraOther.layer.cornerRadius = 10
        BGViewCameraOther.clipsToBounds = true
        BGViewCameraOther.layer.masksToBounds = true
        BGViewCameraOther.layer.borderWidth = 1
        BGViewCameraOther.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        
        self.missionMapView.delegate = self
        self.missionMapView.mapType = MKMapType.hybrid
        self.missionMapView.isUserInteractionEnabled = false
        
        
        FocusOnMissionLocation(itemLat, missionLong: itemLong)
        pickupBTN.layer.cornerRadius = 5
        pickupBTN.clipsToBounds = true
        pickupBTN.layer.masksToBounds = true
        
        if CanPickUp {
         //   pickupBTN.hidden = false
            
        } else {
            
         //  pickupBTN.hidden = true
        }
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString

        
        
        
       // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        
        BGViewEnemy.layer.cornerRadius = 10
        BGViewEnemy.clipsToBounds = true
        BGViewEnemy.layer.masksToBounds = true
        BGViewEnemy.layer.borderWidth = 2
        BGViewEnemy.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1).cgColor
        
        attackBTN.layer.cornerRadius = 5
        attackBTN.clipsToBounds = true
        attackBTN.layer.masksToBounds = true
        
        homeDepositGoldBTN.layer.cornerRadius = 5
        homeDepositGoldBTN.clipsToBounds = true
        homeDepositGoldBTN.layer.masksToBounds = true
        
        homeArmSecurityBTN.layer.cornerRadius = 5
        homeArmSecurityBTN.clipsToBounds = true
        homeArmSecurityBTN.layer.masksToBounds = true
        
      //  print("Attack btn enabled = \(attackBTN.enabled)")
        
        statsBTN.layer.cornerRadius = 5
        statsBTN.clipsToBounds = true
        statsBTN.layer.masksToBounds = true

        
        if let attackUserHealthTemp = Double(attackUserHealth) {
            let UserHealthProgress = attackUserHealthTemp / 100
            print("ENEMY USER HEALTH = \(UserHealthProgress.description)")  
        }
        
        
        
       
        
         healthprogress = 0.8
      //  healthprogress = Float(UserHealthProgress)
        
        //  self.healthProgressView.setProgress(healthprogress, animated: true)
        self.healthProgressView.progress = healthprogress
        
        DispatchQueue.main.async(execute: {
            
            if self.healthprogress > 0.5 {
                self.healthLBL.text = (self.healthprogress * 100).description
                self.healthLBL.textColor = UIColor.white
                self.healthProgressView.fillDoneColor = UIColor.green
            } else {
                self.healthLBL.text = (self.healthprogress * 100).description
                self.healthLBL.textColor = UIColor.darkGray
                if self.healthprogress < 0.3 {
                    self.healthProgressView.fillDoneColor = UIColor.red
                } else {
                    self.healthProgressView.fillDoneColor = UIColor.orange
                }
            }
            
        })
        
        
        
        self.healthProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.healthProgressView.layer.borderWidth = 1
        self.healthProgressView.fillDoneColor = UIColor.red
        self.healthProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.healthProgressView.layer.cornerRadius = 5
        
        self.staminaProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.staminaProgressView.layer.borderWidth = 1
        self.staminaProgressView.fillDoneColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        self.staminaProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.staminaProgressView.layer.cornerRadius = 5
        
         print("awake is mission = \(self.isMission), mission Title: \(self.missionTitle)")
        
    }
    
  //  override func awake
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.frame = bounds
        
        self.frame = CGRect(x: -75, y: -145, width: 200, height: 150)
        
        
        if UserDefaults.standard.bool(forKey: "SecuritySet") {
          self.homeArmSecurityBTN.setTitle("Disarm Security", for: .normal)
        } else {
          self.homeArmSecurityBTN.setTitle("Arm Security", for: .normal)
        }
        
        if self.isMission {
            self.missionIcon.isHidden = false
        } else {
            self.missionIcon.isHidden = true
        }
        
        
        if self.PinType == "player" {
          //  self.BGView.hidden = true
          //  self.BGViewEnemy.hidden = false
            
            
           /*
            let attackUserHealthTemp = Double(attackUserHealth)!
            
            let UserHealthProgress = attackUserHealthTemp / 100
            
            print("ENEMY USER HEALTH = \(UserHealthProgress.description)")
            
           // healthprogress = 0.8
            healthprogress = Float(UserHealthProgress)
            
          //  self.healthProgressView.setProgress(healthprogress, animated: true)
            
            */
            
            /*
            self.healthProgressView.progress = healthprogress
            
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
            
            
            
            self.healthProgressView.layer.borderColor = UIColor.darkGrayColor().CGColor
            self.healthProgressView.layer.borderWidth = 1
            self.healthProgressView.fillDoneColor = UIColor.redColor()
            self.healthProgressView.filledView?.backgroundColor = UIColor.whiteColor().CGColor
            self.healthProgressView.layer.cornerRadius = 5
            */
            
            
            
        }
         print("layout is mission = \(isMission)")
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    @IBAction func ViewStats(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Stats"
        alertView.message = "Stats Coming Soon."
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
       // alertView.show()
        
        
         NotificationCenter.default.post(name: Notification.Name(rawValue: "ViewUserProfileNotification"), object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)","attackUserLat":"\(self.attackUserLat)","attackUserLong":"\(self.attackUserLong)","attackUserAlt":"\(self.attackUserAlt)"])
        
    }
    
    @IBAction func DepositGold(_ sender: AnyObject) {
       
        
        let HomeLat = prefs.value(forKey: "HomeLat") as! Double
        let HomeLong = prefs.value(forKey: "HomeLong") as! Double
        let homelevel = prefs.value(forKey: "HomeLevel") as! String
        let homeID = prefs.value(forKey: "HomeID") as! String
        let homeImageName = prefs.value(forKey: "HomeimageName") as! String
        let homegoldAmount = prefs.value(forKey: "HomeGoldAmount") as! String
        let homeName = prefs.value(forKey: "HomeName") as! String
        let homestartupgrade = prefs.value(forKey: "HomeStartUpgrade") as! String
        let homeendupgrade = prefs.value(forKey: "HomeEndUpgrade") as! String
        let homeStatus = prefs.value(forKey: "HomeStatus") as! String
        let homeAlt = prefs.value(forKey: "HomeAlt") as! String
        
        let homeinfoUpdated = ManageHomeInfo(email, username: username, level: homelevel as NSString, status: homeStatus as NSString, action: "updateGoldAmount", lat: HomeLat.description as! NSString, long: HomeLong.description as! NSString, id: homeID as! NSString, startupgrade: homestartupgrade as! NSString, endupgrade: homeendupgrade as! NSString, goldamount: homegoldAmount as! NSString, alt: homeAlt as! NSString)
    
    if homeinfoUpdated {
    
   // self.HomeSet = true
   // UserDefaults.standard.set(true, forKey: "HomeSet")
   // UserDefaults.standard.set(mylat, forKey: "HomeLat")
   // UserDefaults.standard.set(self.mylong, forKey: "HomeLong")
   // UserDefaults.standard.set(self.homelevel, forKey: "HomeLevel")
   // UserDefaults.standard.set(self.homeImageName, forKey: "HomeimageName")
   // UserDefaults.standard.set(self.homeName, forKey: "HomeName")
   // UserDefaults.standard.set(self.homeID, forKey: "HomeID")
        
    UserDefaults.standard.set(homegoldAmount, forKey: "HomeGoldAmount")
    
   // self.HomeReset = true
    
   
    
    } else {
    
        /*
    
    let actionSheetControllerError: UIAlertController = UIAlertController(title: "Error", message: "There was an error saving your Headquarters location.  Please try again later.", preferredStyle: .alert)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
    
    }
    
    
    actionSheetControllerError.addAction(cancelAction)
    
    present(actionSheetControllerError, animated: true, completion: nil)
        */
        
    let msgTitletemp = "Error"
    let msgMSGtemp = "There was an error saving your Headquarters location.  Please try again later."
    NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowMessage"), object: nil, userInfo: ["msgTitle":"\(msgTitletemp)","msgMSG":"\(msgMSGtemp)"])
    
    
    }

    }
    
    @IBAction func ArmSecurity(_ sender: AnyObject) {
        
        
        if UserDefaults.standard.bool(forKey: "SecuritySet") {
            
            UserDefaults.standard.set(false, forKey: "SecuritySet")
            
            self.homeArmSecurityBTN.setTitle("Arm Security", for: .normal)
            
        } else {
           // self.homeArmSecurityBTN.setTitle("Arm Security", for: .normal)
        

        let msgTitletemp = "HQ Security"
        let msgMSGtemp = "Enter code to arm Headquarters security"
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowMessage"), object: nil, userInfo: ["msgTitle":"\(msgTitletemp)","msgMSG":"\(msgMSGtemp)"])
        
        self.isHidden = true
        
        /*
        let HomeLat = prefs.value(forKey: "HomeLat") as! Double
        let HomeLong = prefs.value(forKey: "HomeLong") as! Double
        let homelevel = prefs.value(forKey: "HomeLevel") as! String
        let homeID = prefs.value(forKey: "HomeID") as! String
        let homeImageName = prefs.value(forKey: "HomeimageName") as! String
        let homegoldAmount = prefs.value(forKey: "HomegoldAmount") as! String
        let homeName = prefs.value(forKey: "HomeName") as! String
        let homestartupgrade = prefs.value(forKey: "HomeStartUpgrade") as! String
        let homeendupgrade = prefs.value(forKey: "HomeEndUpgrade") as! String
        let homeStatus = prefs.value(forKey: "HomeStatus") as! String
        
        
        let homeinfoUpdated = ManageHomeInfo(email, username: username, level: homelevel as NSString, status: homeStatus as NSString, action: "updateGoldAmount", lat: HomeLat.description as! NSString, long: HomeLong.description as! NSString, id: homeID as! NSString, startupgrade: homestartupgrade as! NSString, endupgrade: homeendupgrade as! NSString, goldamount: homegoldAmount as! NSString)
        
        if homeinfoUpdated {
            
            // self.HomeSet = true
            // UserDefaults.standard.set(true, forKey: "HomeSet")
            // UserDefaults.standard.set(mylat, forKey: "HomeLat")
            // UserDefaults.standard.set(self.mylong, forKey: "HomeLong")
            // UserDefaults.standard.set(self.homelevel, forKey: "HomeLevel")
            // UserDefaults.standard.set(self.homeImageName, forKey: "HomeimageName")
            // UserDefaults.standard.set(self.homeName, forKey: "HomeName")
            // UserDefaults.standard.set(self.homeID, forKey: "HomeID")
            
            UserDefaults.standard.set(homegoldAmount, forKey: "HomegoldAmount")
            
            // self.HomeReset = true
            
            
            
        } else {
            
            
            let actionSheetControllerError: UIAlertController = UIAlertController(title: "Error", message: "There was an error saving your Headquarters location.  Please try again later.", preferredStyle: .alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                
            }
            
            
            actionSheetControllerError.addAction(cancelAction)
            
            present(actionSheetControllerError, animated: true, completion: nil)
            
            
        }
        
        */
        }
    }
    
    
    @IBAction func AttackPlayer(_ sender: AnyObject) {
        /*
         var alertView:UIAlertView = UIAlertView()
         alertView.title = "Attack Player?"
         alertView.message = "Attack Player Coming Soon."
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         // alertView.show()
         */
        
        let healthTemp = Int(attackUserHealth)!
        
        if healthTemp <= 0 {
        
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Unable to Attack"
            alertView.message = "You are trying to attack someone who is already dead."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
       
        
            
        } else {
        if IsDead {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Seek Medical Help!"
            alertView.message = "You're too weak to attack right now, you need medical attention."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        } else {
        
         let NewAmount = prefs.integer(forKey: "MYSTAMINA") - StaminaUsed
            
            
            if NewAmount < 0 {
                
                
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "You Need Rest!"
                alertView.message = "You're too tired to attack right now.  Your Stamina is too low to attack"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
                
                
            
            } else {
        
        print("Attacking Player now")
                
         
        
                AttackPlayerNow(self.attackUserName, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, attackUserAlt: self.attackUserAlt)
                
            }
        
         }
            
        }
        // NSNotificationCenter.defaultCenter().postNotificationName("AttackPlayer", object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)"])
        
    }
    
    func AttackPlayerNow(_ attackUserName: String, attackUserLat: Double, attackUserLong: Double, attackUserID: String, attackUserHealth: String, attackUserAlt: Double) {
        
        
        
        print("Item Lat = \(attackUserLat.description)")
        print("Item Long = \(attackUserLong.description)")
        
        var email = NSString()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
         //   print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        
        
        CanAttack = false
        var curLoc = CLLocation()
        let curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        let mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
        let attackUserLocation = CLLocation(latitude: attackUserLat,longitude: attackUserLong)
        
        let distance = mylocnow.distance(from: attackUserLocation)
       // print("distance: \(distance)")
        
        
        let miles = distance / 1609.34
       print("MILES AWAY FROM TARGET = \(miles)")
        
        // print("miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
           // print("Dist = \(dist)")
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
              //  print("foot: \(distance)")
                CanAttack = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanAttack = true                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
            // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
        
        //NEED TO UPDATE THIS, no reason to have to be close to enemy, if you an see him then you can attack
        CanAttack = true
        
        if CanAttack {
            
            print("dist descp1: \(dist.description)")
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackPlayer"), object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)","StaminaUsed":"\(StaminaUsed)","enemyDistanceAway":"\(dist.description)"])
            
            
            /*
             
             let actionSheetController: UIAlertController = UIAlertController(title: "Attack Player?", message: "Are you sure you want to attck this player?", preferredStyle: .Alert)
             
             //Create and add the Cancel action
             let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
             //Do some stuff
             }
             
             //Create and an option action
             let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
             
             //  self.AttackingPlayer = user
             //   self.AttackingPlayersHealth = health
             
             // print("Picking up Item = \(self.itemname)")
             
             //self.performSegueWithIdentifier("goto_attack", sender: self)
             
             NSNotificationCenter.defaultCenter().postNotificationName("AttackPlayer", object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)"])
             
             
             // let PickUpSuccess =  PickUpItem(Myusername, id: itemID)
             //  print("Item Pick Up Success = \(PickUpSuccess)")
             
             
             
             //self.SubmitPic()
             //   NSNotificationCenter.defaultCenter().postNotificationName("UpdateMap", object: nil)
             
             }
             
             
             actionSheetController.addAction(nextAction)
             actionSheetController.addAction(cancelAction)
             
             var v1Ctrl = MapViewController()
             
             v1Ctrl.presentViewController(actionSheetController, animated: true, completion: nil)
             
             */
            
        } else  {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "You're not close enough!"
            alertView.message = "You need to get closer to attack this player"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
        
    }
    
    
    
    @IBAction func PickUpItemClicked(_ sender: AnyObject) {
        
        /*
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Pick Up Item?"
        alertView.message = "Pick up item Coming Soon."
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
        */
        
        
        let IsDead = prefs.bool(forKey: "AmIDead")
        
        if IsDead {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Seek Medical Help!"
            alertView.message = "You're barely standing up right now, you need urgent medical attention."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        } else {
        
            var isMissionText = String()
        
            if self.isMission {
                isMissionText = "yes"
            } else {
               isMissionText = "no"
            }
        
    NotificationCenter.default.post(name: Notification.Name(rawValue: "PickUpItemNotification"), object: nil, userInfo: ["username":"\(username)","itemName":"\(itemName)","itemLat":"\(itemLat)","itemLong":"\(itemLong)","itemType":"\(itemType)","itemCode":"\(itemCode)","itemID":"\(itemID)","amount":"\(amount)","isMission":"\(isMissionText)","missionObjective":"\(self.missionObjective)","missionXP":"\(self.missionXP)","missionMapURL":"\(self.missionMapURL)","MissionID":"\(self.missionID)","level":"\(self.missionLevel)","itemAlt":"\(itemAlt)"])
        
          
            
        }
       // PickUpClicked(username, itemName: itemName, itemLat: itemLat, itemLong: itemLong, itemType: itemType, itemCode: itemCode, itemID: itemID, amount: amount)
        
    }

    
    
    
    func PickUpClicked(_ Myusername: NSString, itemName: NSString, itemLat: Double, itemLong: Double, itemType: NSString, itemCode: NSString, itemID: NSString, amount: String, itemAlt: Double) {
      //  print("attack!")
        
       // print("Item Lat = \(itemLat)")
      //  print("Item Long = \(itemLong)")
        
        var email = NSString()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
          //  print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        
        
        CanPickUp = false
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        var myaltnow = curLoc.altitude
        
        var itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
        
        var distance = mylocnow.distance(from: itemLocation)
       // print("distance: \(distance)")
        var miles = distance / 1609.34
      //  print("miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
          //  print("Dist = \(dist)")
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
              //  print("foot: \(distance)")
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
                    
                    
                    let PickUpSuccess =  PickUpGold(Myusername, id: itemID, amount: amount as NSString)
                 //   print("Item Pick Up Success = \(PickUpSuccess)")
                    
                    
                    
                    if PickUpSuccess{
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "You Picked up the \(amount) coins"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        let PreviousGold = self.prefs.value(forKey: "GOLDAMOUNT") as! String
                      //  print("NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold)")
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMoney"), object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(amount)","setting":"add"])
                        
                        
                        backgroundThread(background: {
                            //self.GetPublicTurns()
                          //  print("BACKGROUND THREAD - Updating Users' Info")
                           //
                          //  print("Saving Images now")
                            
                            
                            let UserInfoNSData = GetUserInfo(email)
                            
                            DispatchQueue.main.async(execute: {
                               // print("Creating Local Inventory Data")
                                CreateLocalInventory(UserInfoNSData)
                                
                            })
                            
                            
                            }, completion: {
                                
                                DispatchQueue.main.async(execute: {
                                    //self.GetMyHUD.removeFromSuperview()
                                    //  self.tableView.reloadData()
                                 //   print("DISPATCH ASYNC - Finished Getting User's Info")
                                })
                                // print("Done Getting Steal Turns")
                                //   self.kolodaView.resetCurrentCardNumber()
                        })
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                } else {
                    
                    
                    /*
                    if self.isMission {
                        

                        
                      print("PICK UP MISSION ITEM")
                        
                         NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMissionNotification"), object: nil, userInfo: ["missionID":"\(self.missionID)","lat":"\(self.itemLong)","long":"\(self.itemLat)","status":"complete","objective":"\(self.missionObjective)","xp":"\(self.missionXP)","action":"updateStatus","imageName":"\(self.missionMapURL)"])
                        
                      //  UpdateMission(self.email, id: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, objective: NSString, xp: NSString, action: NSString)
                        
                        
                    } else {
                        */
                    
                    let PickUpSuccess =  PickUpItem(Myusername, id: itemID)
                  //  print("Item Pick Up Success = \(PickUpSuccess)")
                    
                    
                    
                    if PickUpSuccess{
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = "You Picked up the \(itemName)"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                    }
                    
               // }
                
                }
                //self.SubmitPic()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
                
            }
            
            
            actionSheetController.addAction(nextAction)
            actionSheetController.addAction(cancelAction)
            
            var v1Ctrl = MapViewController()
            
            v1Ctrl.present(actionSheetController, animated: true, completion: nil)
            
        } else  {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "You're not close enough!"
            alertView.message = "You need to get closer to pick up this item"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    
    
    
    class func setTitle(_ title: String) {
        //titleLBL.text = title
    }
    
  
   // class func instanceFromNib(title: String, itemImage: UIImage) -> ItemAnnotationView
    
    
    
    class func instanceFromNib(_ title: String, itemImage: UIImage, itemType: String, itemLat: Double, itemLong: Double, itemCode: String, itemID: String, amount: String, PinType: String, attackUsername: String, attackUserImage: UIImage, attackUserID: String, attackUserHealth: String, missionTitle: String, missionObjective: String, missionLevel: String, missionXP: String, missionID: String, missionMapURL: String, missionObjectURL: String, count: String, level: String, health: String, stamina: String, ammoCount: String, speed: String, power: String, range: String, viewrange: String, isMission: Bool, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, attackUserAlt: Double) -> ItemAnnotationView {
   // class func instanceFromNib(title: String) -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = ItemAnnotationView()
       // var itemTitle: String!
       // itemTitle = title
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
      //  Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ItemAnnotationView
        
        //print("ITEM PIN TYPE: \(PinType)")
        
        print("Item Ant View from Nib")
        
        Nib.missionID = missionID
        Nib.missionTitle = missionTitle
        Nib.missionObjective = missionObjective
        Nib.missionLevel = missionLevel
        Nib.missionCoordinate = CLLocationCoordinate2D(latitude: itemLat, longitude: itemLong)
        Nib.missionXP = missionXP
        Nib.missionImage = itemImage
        Nib.missionObjectURL = missionObjectURL
        Nib.missionMapURL = missionMapURL
        Nib.homeImage = itemImage
        Nib.isMission = isMission
        
        //Attributes INFO------
        Nib.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        
        //other stats info------
        Nib.killcount = killcount
        Nib.killedcount = killedcount
        
        
        if isMission {
            Nib.missionIcon.isHidden = false
        } else {
            Nib.missionIcon.isHidden = true
        }
        
        print("ITEM LEVEL: \(level)")
        
        switch PinType {
            
           case "camera":
            Nib.BGView.isHidden = true
            Nib.BGViewEnemy.isHidden = true
            Nib.BGViewMission.isHidden = true
            Nib.BGViewCameraOther.isHidden = true
            Nib.BGViewHome.isHidden = true
            Nib.BGViewCamera.isHidden = false
            
           case "othercamera":
            Nib.BGView.isHidden = true
            Nib.BGViewEnemy.isHidden = true
            Nib.BGViewMission.isHidden = true
            Nib.BGViewCameraOther.isHidden = false
            Nib.BGViewHome.isHidden = true
            Nib.BGViewCamera.isHidden = true
            
           case "player":
            Nib.BGView.isHidden = true
            Nib.BGViewEnemy.isHidden = false
            Nib.BGViewMission.isHidden = true
            Nib.BGViewCameraOther.isHidden = true
            Nib.BGViewHome.isHidden = true
            Nib.BGViewCamera.isHidden = true
            
           case "item":
            Nib.BGView.isHidden = false
            Nib.BGViewEnemy.isHidden = true
            Nib.BGViewMission.isHidden = true
            Nib.BGViewCameraOther.isHidden = true
            Nib.BGViewHome.isHidden = true
            Nib.BGViewCamera.isHidden = true
            Nib.levelLBL.text = "Level: \(level)"
            
        
           case "home":
            Nib.BGView.isHidden = true
            Nib.BGViewEnemy.isHidden = true
            Nib.BGViewMission.isHidden = true
            Nib.BGViewCameraOther.isHidden = true
            Nib.BGViewHome.isHidden = false
            Nib.BGViewCamera.isHidden = true
            Nib.homelevelLBL.text = "Level: \(level)"
            Nib.homebaseImage.image = itemImage
            
           case "mission":
            Nib.BGView.isHidden = true
            Nib.BGViewEnemy.isHidden = true
            Nib.BGViewMission.isHidden = false
            Nib.BGViewCameraOther.isHidden = true
            Nib.BGViewHome.isHidden = true
            Nib.BGViewCamera.isHidden = true
            

            let MissionPoint = MissionLabel(title: missionTitle, objective: missionObjective, discipline: "", level: missionLevel, coordinate: Nib.missionCoordinate, image: itemImage, PinType: "mission", xp: missionXP, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: true, missionID: missionID, missionLevel: missionLevel, imageName: missionMapURL, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: attackUserAlt)
            
            Nib.missionMapView.addAnnotation(MissionPoint)
            Nib.missionObjectiveLBL.text = missionObjective
            
            
          //  Nib.FocusOnMissionLocation(itemLat, missionLong: itemLong)
            
        default:
            break
        }
        /*
        if PinType == "player" {
            Nib.BGView.hidden = true
            Nib.BGViewEnemy.hidden = false
        } else {
            Nib.BGView.hidden = false
            Nib.BGViewEnemy.hidden = true
        }
        */
        
        Nib.playerNameLBL.text = attackUsername
        Nib.playerGoldLBL.text = "Gold: $\(amount)"
        Nib.titleLBL.text = title
        Nib.itemImage.image = itemImage
        Nib.itemID = itemID
        Nib.itemLong = itemLong
        Nib.itemLat = itemLat
        Nib.itemType = itemType
        Nib.itemID = itemID
        Nib.itemCode = itemCode
        Nib.PinType = PinType
        Nib.itemAlt = attackUserAlt
        
        
        //print("ITEM INVENTORY - LAT : \(itemLat) LONG: \(itemLong)")
        
        Nib.attackUserName = attackUsername
        //var itemType = String()
        Nib.attackUserLat = itemLat
        Nib.attackUserLong = itemLong
        Nib.attackUserID = attackUserID
        Nib.attackUserHealth = attackUserHealth
        Nib.attackUserImage = attackUserImage
        Nib.attackUserAlt = attackUserAlt
        
        
        if Nib.attackUserHealth != "NA" {
        let attackUserHealthTemp = Double(Nib.attackUserHealth)!
        
        
        Nib.healthLBL.text = attackUserHealth
        let UserHealthProgress = attackUserHealthTemp / 100
        print("FROM INSTANCE - ENEMY USER HEALTH = \(UserHealthProgress.description)")
        // healthprogress = 0.8
        Nib.healthprogress = Float(UserHealthProgress)
        Nib.staminaprogress = 1.0
        
            Nib.staminaProgressView.setProgress(Nib.staminaprogress, animated: true)
        //  self.healthProgressView.setProgress(healthprogress, animated: true)
        // dispatch_async(dispatch_get_main_queue(), {
        Nib.healthProgressView.setProgress(Nib.healthprogress, animated: true)
        
        }
        
        var CanPickUp = false
        Nib.CanPickUp = false
        var dist = Double()
        
        
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
       // print("My current location = \(mylocnow)")
        
        var itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
        
      // print("Item location = \(itemLocation)")
        
        var distance = mylocnow.distance(from: itemLocation)
     //   print("start nib distance: \(distance)")
        var miles = distance / 1609.34
        
        
    //   print("ITEM start nib miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
            
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
            //    print("foot: \(distance)")
                Nib.distanceLBL.text = "\(dist.description) foot"
                CanPickUp = true
                 Nib.CanPickUp = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanPickUp = true
                    Nib.CanPickUp = true
                  Nib.distanceLBL.text = "\(dist.description) feet"
                } else {
                    
                  dist = Double(round(100*(miles))/100)
                  Nib.distanceLBL.text = "\(dist.description) mile"
                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
            if dist < 1 {
            Nib.distanceLBL.text = "\(dist.description) mile"
                
            } else {
             Nib.distanceLBL.text = "\(dist.description) miles"
                
            }
            // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
         //Nib.distanceLBL.text = "Unknown distance"
        
        Nib.itemDistance = dist
        
        print("ITEM DISTANCE: \(dist)")
        
        
       // Nib.titleLBL.text = title
      //  self.setTitle(title)
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let point = point
        let viewPoint = superview?.convert(point, to: self) ?? point
        
        let isInsideView = self.point(inside: viewPoint, with: event)
        
        let view = super.hitTest(viewPoint, with: event)
        
        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.contains(point)
    }
    
    
    
    func FocusOnMissionLocation(_ missionLat: Double, missionLong: Double) {
        

        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: missionLat, longitude: missionLong).coordinate, latitudinalMeters: 5000.0, longitudinalMeters: 5000.0)

        missionMapView.setRegion(coordinateRegion, animated: true)
        
        
        
    }
    
    @IBAction func startMissionBTN(_ sender: AnyObject) {
        
        
        
        let IsDead = prefs.bool(forKey: "AmIDead")
        
        if IsDead {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Seek Medical Help"
            alertView.message = "You're too weak to attempt a mission, you need urgent medical attention."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        } else {
        
        
            NotificationCenter.default.post(name: Notification.Name(rawValue: "StartMissionNotification"), object: nil, userInfo: ["username":"\(username)","missionID":"\(missionID)","itemLat":"\(itemLat)","itemLong":"\(itemLong)","missionLevel":"\(missionLevel)","missionObjective":"\(missionObjective)","missionXP":"\(missionXP)","missionObjectURL":"\(missionObjectURL)","missionMapURL":"\(missionMapURL)"])
            
        }
        
        
    }
    
    
}

extension Float {
    
    /*
    var asLocaleCurrency:String {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        //let returnNum: NSNumber = NSNumber(_)
        
        return formatter.string(from: NSNumber(_))!
       // return formatter.string(from: NSNumber(self))!
    }
    
    */
    
    
    public func asLocaleCurrency(_ decimals: Float) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        formatter.locale = Locale.current
        //formatter.maximumFractionDigits = decimals
        return formatter.string(from: NSNumber(value: decimals))!
    }

}

/*
public func asLocaleCurrency(_ decimals: Float) -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    formatter.locale = Locale.current
    //formatter.maximumFractionDigits = decimals
    return formatter.string(from: NSNumber(value: decimals))!
}
*/


class PlayerAnnotationView: UIView {
    
    var dist = Double()
    var CanAttack = Bool()
    var prefs:UserDefaults = UserDefaults.standard

    
    var isOpen = Bool()
    
    @IBOutlet weak var attackBTN: UIButton!
    @IBOutlet weak var statsBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    
     @IBOutlet weak var healthProgressView: VerticalProgressView!
    
    
    var healthprogress = Float()
    @IBOutlet weak var healthLBL: UILabel!
   
    
    
    var username = NSString()
    var email = NSString()
    var itemID = String()
    
    var attackUserName = String()
    //var itemType = String()
    var attackUserLat = Double()
    var attackUserLong = Double()
    var attackUserID = String()
    var attackUserHealth = String()
    var attackUserImage = UIImage()
    var attackUserDistance = Double()
    var attackUserAlt = Double()
    
    
   
    
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        healthprogress = 0.8
        
        // self.healthProgressView.setProgress(progress, animated: true)
        self.healthProgressView.progress = 0.8
        
         DispatchQueue.main.async(execute: {
        
        if self.healthprogress > 0.5 {
            self.healthLBL.text = (self.healthprogress * 100).description
            self.healthLBL.textColor = UIColor.white
            self.healthProgressView.fillDoneColor = UIColor.green
        } else {
            self.healthLBL.text = (self.healthprogress * 100).description
            self.healthLBL.textColor = UIColor.darkGray
            if self.healthprogress < 0.3 {
                self.healthProgressView.fillDoneColor = UIColor.red
            } else {
                self.healthProgressView.fillDoneColor = UIColor.orange
            }
        }
        
            })
        
        self.healthProgressView.layer.borderColor = UIColor.darkGray.cgColor
        self.healthProgressView.layer.borderWidth = 1
        self.healthProgressView.fillDoneColor = UIColor.red
        self.healthProgressView.filledView?.backgroundColor = UIColor.white.cgColor
        self.healthProgressView.layer.cornerRadius = 5
        
        
        
        
        BGView.layer.cornerRadius = 10
        BGView.clipsToBounds = true
        BGView.layer.masksToBounds = true
        BGView.layer.borderWidth = 2
        BGView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1).cgColor
        
        attackBTN.layer.cornerRadius = 5
        attackBTN.clipsToBounds = true
        attackBTN.layer.masksToBounds = true
        
      //  print("Attack btn enabled = \(attackBTN.enabled)")
        
        statsBTN.layer.cornerRadius = 5
        statsBTN.clipsToBounds = true
        statsBTN.layer.masksToBounds = true
        
        
        /*
         print("view 5 y awake = \(self.view5.center.y)")
         
         // self.view5.center.y = self.view5.center.y - 46
         self.view5B.constant = 46
         self.view5H.constant = 0
         self.view5W.constant = 0
         
         //self.view4.center.y = self.view4.center.y - 46
         self.view4B.constant = -60
         self.view4R.constant = -40
         self.view4H.constant = 0
         self.view4W.constant = 0
         
         self.view3B.constant = -60
         self.view3R.constant = -40
         self.view3H.constant = 0
         self.view3W.constant = 0
         
         
         buttonView.layer.cornerRadius = buttonView.frame.height / 2
         buttonView.clipsToBounds = true
         
         //buttonView.backgroundColor = UIColor.NewColors.Header
         
         view5BG.layer.cornerRadius = view5BG.frame.height / 2
         view5BG.clipsToBounds = true
         //view5BG.backgroundColor = UIColor.NewColors.Header
         
         view4BG.layer.cornerRadius = view4BG.frame.height / 2
         view4BG.clipsToBounds = true
         //view4BG.backgroundColor = UIColor.NewColors.Header
         
         view3BG.layer.cornerRadius = view3BG.frame.height / 2
         view3BG.clipsToBounds = true
         // view3BG.backgroundColor = UIColor.NewColors.Header
         
         
         view4BUTTON.imageView?.tintColor = UIColor.whiteColor()
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
       // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
       // print("awake is mission = \(isMission)")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.frame = bounds
        
        self.frame = CGRect(x: -75, y: -150, width: 200, height: 150)
        self.attackBTN.frame = CGRect(x: 8, y: 112, width: 70, height: 30)
       
       
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func ViewStats(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Stats"
        alertView.message = "Stats Coming Soon."
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    
     @IBAction func AttackPlayer(_ sender: AnyObject) {
        /*
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Attack Player?"
        alertView.message = "Attack Player Coming Soon."
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
       // alertView.show()
 */
        
   //     print("Attacking Player now")
        
        AttackPlayerNow(self.attackUserName, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, attackUserAlt: self.attackUserAlt)
        
        
       // NSNotificationCenter.defaultCenter().postNotificationName("AttackPlayer", object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)"])
        
    }
    
    func AttackPlayerNow(_ attackUserName: String, attackUserLat: Double, attackUserLong: Double, attackUserID: String, attackUserHealth: String, attackUserAlt: Double) {
        
        
        
     //   print("Item Lat = \(attackUserLat.description)")
     //   print("Item Long = \(attackUserLong.description)")
        
        var email = NSString()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
         //   print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        
        
        CanAttack = false
        var curLoc = CLLocation()
        let curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        let mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        let myaltnow = curLoc.altitude
        let attackUserLocation = CLLocation(latitude: attackUserLat,longitude: attackUserLong)
        
        let distance = mylocnow.distance(from: attackUserLocation)
        print("distance: \(distance)")
        let miles = distance / 1609.34
        print("miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
            print("Dist = \(dist)")
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
                print("foot: \(distance)")
                CanAttack = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanAttack = true                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
            // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
        
        //NEED TO UPDATE THIS, no reason to have to be close to enemy, if you an see him then you can attack
        CanAttack = true
        
        if CanAttack {
            
            print("dist descp2: \(dist.description)")
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackPlayer"), object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)","enemyDistanceAway":"\(dist.description)"])
            
            
            /*
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Attack Player?", message: "Are you sure you want to attck this player?", preferredStyle: .Alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Do some stuff
            }
            
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
                
                //  self.AttackingPlayer = user
                //   self.AttackingPlayersHealth = health
                
                // print("Picking up Item = \(self.itemname)")
                
                //self.performSegueWithIdentifier("goto_attack", sender: self)
                
                NSNotificationCenter.defaultCenter().postNotificationName("AttackPlayer", object: nil, userInfo: ["attackUserName":"\(self.attackUserName)","attackUserHealth":"\(self.attackUserHealth)","attackUserID":"\(self.attackUserID)"])
                    
                    
                   // let PickUpSuccess =  PickUpItem(Myusername, id: itemID)
                  //  print("Item Pick Up Success = \(PickUpSuccess)")
                    
                    
                
                //self.SubmitPic()
             //   NSNotificationCenter.defaultCenter().postNotificationName("UpdateMap", object: nil)
                
            }
            
            
            actionSheetController.addAction(nextAction)
            actionSheetController.addAction(cancelAction)
            
            var v1Ctrl = MapViewController()
            
            v1Ctrl.presentViewController(actionSheetController, animated: true, completion: nil)
 
 */
            
        } else  {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "You're not close enough!"
            alertView.message = "You need to get closer to pick up this item"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
        
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    

    
    
    
    class func instanceFromNib(_ attackUsername: String, attackUserImage: UIImage, attackUserID: String, attackUserLat: Double, attackUserLong: Double, attackUserHealth: String, attackUserAlt: Double) -> PlayerAnnotationView {
        // class func instanceFromNib(title: String) -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = PlayerAnnotationView()
        // var itemTitle: String!
        // itemTitle = title
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        //  Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        Nib = UINib(nibName: "PlayerAnnotationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PlayerAnnotationView
        
        
       
        
        
        Nib.attackUserName = attackUsername
        //var itemType = String()
        Nib.attackUserLat = attackUserLat
        Nib.attackUserLong = attackUserLong
        Nib.attackUserID = attackUserID
        Nib.attackUserHealth = attackUserHealth
        Nib.attackUserImage = attackUserImage
        Nib.attackUserAlt = attackUserAlt
        //Nib.attackUserDistance = attack
        
        
        
        Nib.bounds = bounds
        return Nib

    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class WeaponMenu: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewSmall: UICollectionView!
    
    
    var prefs:UserDefaults = UserDefaults.standard
    
    var TestImage = UIImage()
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        RetrieveImages()
        
        
        
        
        let imageName = "Gun100"
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        
        TestImage = UIImage(data:theImageData!)!
        
        
        
        
        /*
         print("view 5 y awake = \(self.view5.center.y)")
         
         // self.view5.center.y = self.view5.center.y - 46
         self.view5B.constant = 46
         self.view5H.constant = 0
         self.view5W.constant = 0
         
         //self.view4.center.y = self.view4.center.y - 46
         self.view4B.constant = -60
         self.view4R.constant = -40
         self.view4H.constant = 0
         self.view4W.constant = 0
         
         self.view3B.constant = -60
         self.view3R.constant = -40
         self.view3H.constant = 0
         self.view3W.constant = 0
         
         
         buttonView.layer.cornerRadius = buttonView.frame.height / 2
         buttonView.clipsToBounds = true
         
         //buttonView.backgroundColor = UIColor.NewColors.Header
         
         view5BG.layer.cornerRadius = view5BG.frame.height / 2
         view5BG.clipsToBounds = true
         //view5BG.backgroundColor = UIColor.NewColors.Header
         
         view4BG.layer.cornerRadius = view4BG.frame.height / 2
         view4BG.clipsToBounds = true
         //view4BG.backgroundColor = UIColor.NewColors.Header
         
         view3BG.layer.cornerRadius = view3BG.frame.height / 2
         view3BG.clipsToBounds = true
         // view3BG.backgroundColor = UIColor.NewColors.Header
         
         
         view4BUTTON.imageView?.tintColor = UIColor.whiteColor()
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        //   self.collectionView.registerNib(UINib(nibName: "itemCollectionViewCell"), bundle: nil) forCellWithReuseIdentifier: <#T##String#>)
        
        
        let columnHeaderViewNIB = UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIB, forCellWithReuseIdentifier: "ItemCell")
        
        self.collectionView.backgroundColor = UIColor.clear
        
        
        let columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        self.collectionViewSmall?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        self.collectionViewSmall.backgroundColor = UIColor.clear
        
        
       // self.collectionView.isHidden = true
        
        self.collectionViewSmall.isHidden = true
        
        // self.collectionView?.registerNib(columnHeaderViewNIB, forSupplementaryViewOfKind: columnHeaderViewIdentifier, withReuseIdentifier: columnHeaderViewIdentifier)
        //[self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
                print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                let ItemCategory = items.value(forKey: "category") as! String
                let ItemOrder = items.value(forKey: "itemOrder") as! String
                
                
                let itemname = items.value(forKey: "name") as! String
                let imageURL = items.value(forKey: "imageURL") as! String
                let category = items.value(forKey: "category") as! String
                let power = items.value(forKey: "power") as! String
                let speed = items.value(forKey: "speed") as! String
                let range = items.value(forKey: "range") as! String
                let health = items.value(forKey: "health") as! String
                let stamina = items.value(forKey: "stamina") as! String
                let imageURL100 = items.value(forKey: "imageURL100") as! String
                let itemOrder = items.value(forKey: "itemOrder") as! String
                let viewRange = items.value(forKey: "viewRange") as! String
                let subCategory = items.value(forKey: "subCategory") as! String
                
                if (category == "weapon") && (itemOrder != "0") {
                    
                    
                    TotalItemsInventoryArray.append(ItemInventorySorted(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, viewRange: viewRange, subCategory: subCategory, unlocked: true))
                    
                }
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sort { (lhs: ItemInventorySorted, rhs: ItemInventorySorted) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        let lastviewtopulse = "weapon"
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowNewMessageView"), object: nil, userInfo: ["ViewToPulse":"\(lastviewtopulse)"])
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "WeaponMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        if collectionView != collectionViewSmall {
            
            print("TotalItems Inventory Count = \(TotalItemsInventoryArray.count)")
            return TotalItemsInventoryArray.count
            
        } else {
            
            return TotalItemsInventoryArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != collectionViewSmall {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clear
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            let imageName = itemTemp.imageURL100
            let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = try? Data(contentsOf: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            
            var NotifyUser = Bool()
            
            if prefs.bool(forKey: "\(itemTemp.name)AlertLocation") != nil {
                
                NotifyUser = prefs.bool(forKey: "\(itemTemp.name)AlertLocation")
   
            } else {
                NotifyUser = true
                prefs.setValue(true, forKey: "\(itemTemp.name)AlertLocation")
            }
            
            print("notify user: \(NotifyUser)")
            if NotifyUser {
                cell.alertBTN.setImage(UIImage(named: "AlertOn.png"), for: .normal)
            } else {
             cell.alertBTN.setImage(UIImage(named: "AlertOff.png"), for: .normal)
            }
            cell.alertBTN.tag = indexPath.row
            cell.alertBTN.addTarget(self, action: #selector(WeaponMenu.ChangeItemAlert(_:)), for: UIControl.Event.touchUpInside)
            cell.alertBTN.isHidden = false
            
            print("\(imageName) unlocked = \(itemTemp.unlocked)")
            
            if itemTemp.unlocked {
            cell.lockedView.isHidden = true
            } else {
            cell.lockedView.isHidden = false
            }
            return cell
            
        } else {
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellSmall", for: indexPath) as! ItemsCollectionViewCellSmall
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clear
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            let imageName = itemTemp.imageURL100
            let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = try? Data(contentsOf: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            
            
            
            if itemTemp.category != "weapon" {
                if indexPath.row > 0 {
                    cell.lockView.isHidden = false
                } else {
                    cell.lockView.isHidden = true
                }
            } else {
                cell.lockView.isHidden = true
            }
            
            
            //  cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            //  cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            //  cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            return cell
            
            
            
        }
    }
    

    
    @objc func ChangeItemAlert (_ sender: AnyObject) {
            
         
            
            let row = sender.tag
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[row!]
     
            
            
            
            
            var SearchItemName = itemTemp.name
            
               print("Clicked change alert item: \(SearchItemName)")
            
            var AlertForItem = Bool()
            
            if prefs.bool(forKey: "\(SearchItemName)AlertLocation") != nil {
                

                AlertForItem = prefs.bool(forKey: "\(SearchItemName)AlertLocation")
                
                if AlertForItem {
                    prefs.setValue(false, forKey: "\(SearchItemName)AlertLocation")
                    print("Set to false")
                } else {
                    prefs.setValue(true, forKey: "\(SearchItemName)AlertLocation")
                    print("Set to true")
                }
                
                
            }
            
            self.collectionView.reloadData()
           // SearchItemImageName = itemTemp.imageName
           // SearchItemLocation = itemTemp.Location
            
           // self.isHidden = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != collectionViewSmall {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            self.removeFromSuperview()
            
        } else {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected Small"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            self.removeFromSuperview()
            
            
        }
    }
    
    /*
     
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     let itemsPerRow:CGFloat = 4
     let hardCodedPadding:CGFloat = 5
     let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
     let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
     return CGSize(width: itemWidth, height: itemHeight)
     }
     */
    
    
    
    
}



class MiscItemsMenu: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewSmall: UICollectionView!
    
    
    
    
    var TestImage = UIImage()
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    

    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        RetrieveImages()
        
        
        
        
        let imageName = "Gun100"
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        
        TestImage = UIImage(data:theImageData!)!
        
        

        
        let columnHeaderViewNIB = UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIB, forCellWithReuseIdentifier: "ItemCell")
        
        self.collectionView.backgroundColor = UIColor.clear
        
        
        let columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        self.collectionViewSmall?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        self.collectionViewSmall.backgroundColor = UIColor.clear
        
        
        self.collectionView.isHidden = true
        
        // self.collectionView?.registerNib(columnHeaderViewNIB, forSupplementaryViewOfKind: columnHeaderViewIdentifier, withReuseIdentifier: columnHeaderViewIdentifier)
        //[self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
                print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                let ItemCategory = items.value(forKey: "category") as! String
                let ItemOrder = items.value(forKey: "itemOrder") as! String
                
                
                let itemname = items.value(forKey: "name") as! String
                let imageURL = items.value(forKey: "imageURL") as! String
                let category = items.value(forKey: "category") as! String
                let power = items.value(forKey: "power") as! String
                let speed = items.value(forKey: "speed") as! String
                let range = items.value(forKey: "range") as! String
                let health = items.value(forKey: "health") as! String
                let stamina = items.value(forKey: "stamina") as! String
                let imageURL100 = items.value(forKey: "imageURL100") as! String
                let itemOrder = items.value(forKey: "itemOrder") as! String
                let viewRange = items.value(forKey: "viewRange") as! String
                let subCategory = items.value(forKey: "subCategory") as! String
                
                if (category == "misc") && (itemOrder != "0") {
                    
                    
                    TotalItemsInventoryArray.append(ItemInventorySorted(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, viewRange: viewRange, subCategory: subCategory, unlocked: true))
                    
                }
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sort { (lhs: ItemInventorySorted, rhs: ItemInventorySorted) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
  
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        let lastviewtopulse = "miscitems"
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowNewMessageView"), object: nil, userInfo: ["ViewToPulse":"\(lastviewtopulse)"])
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MiscItemsMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
      
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        if collectionView != collectionViewSmall {
            
            print("TotalItems Inventory Count = \(TotalItemsInventoryArray.count)")
            return TotalItemsInventoryArray.count
            
        } else {
            
            return TotalItemsInventoryArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != collectionViewSmall {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clear
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            let imageName = itemTemp.imageURL100
            let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = try? Data(contentsOf: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            return cell
            
        } else {
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellSmall", for: indexPath) as! ItemsCollectionViewCellSmall
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clear
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            let imageName = itemTemp.imageURL100
            let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = try? Data(contentsOf: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            
            
            
            if itemTemp.category != "weapon" {
                if indexPath.row > 0 {
                    cell.lockView.isHidden = false
                } else {
                    cell.lockView.isHidden = true
                }
            } else {
                cell.lockView.isHidden = true
            }
            
            
            //  cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            //  cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            //  cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            return cell
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != collectionViewSmall {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            self.removeFromSuperview()
            
        } else {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected Small"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            self.removeFromSuperview()
            
            
        }
    }
    
    /*
     
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     let itemsPerRow:CGFloat = 4
     let hardCodedPadding:CGFloat = 5
     let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
     let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
     return CGSize(width: itemWidth, height: itemHeight)
     }
     */
    
    
    
    
}


class CaptureTerritoryView: UIView, CLLocationManagerDelegate {
    
    @IBOutlet weak var pointSaveView1: UIView!
    @IBOutlet weak var pointSaveView2: UIView!
    @IBOutlet weak var pointSaveView3: UIView!
    @IBOutlet weak var pointSaveView4: UIView!
    @IBOutlet weak var currentLocView: UIView!
    @IBOutlet weak var SaveTerritoryBTNView: UIView!
    
    @IBOutlet weak var pointSaveLBL1: UILabel!
    @IBOutlet weak var pointSaveLBL2: UILabel!
    @IBOutlet weak var pointSaveLBL3: UILabel!
    @IBOutlet weak var pointSaveLBL4: UILabel!
    
    
    var email = NSString()
     var SavedPoint1 = Bool()
     var SavedPoint2 = Bool()
     var SavedPoint3 = Bool()
     var SavedPoint4 = Bool()
    
    @IBOutlet weak var latitudeLBL: UILabel!
    
    @IBOutlet weak var longitudeLBL: UILabel!
    
  //  @IBOutlet weak var collectionView: UICollectionView!
    
  //  @IBOutlet weak var collectionViewSmall: UICollectionView!
     var prefs:UserDefaults = UserDefaults.standard
    
    var LocManager = CLLocationManager()
    var mylat = Double()
    var mylong = Double()
    var myalt = Double()
    var myloc = CLLocation()
    
    var TestImage = UIImage()
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    var TrackingOn = Bool()
    
    
    var buttonClicked = Bool()
    
    
    
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
    
    
    override func awakeFromNib() {
        
        
        email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        
        self.SaveTerritoryBTNView.isHidden = true
        
        if !prefs.bool(forKey: "TRACKINGON") {
            TrackingOn = checkLocationAuthorizationStatus(LocManager, status: CLLocationManager.authorizationStatus() )
        } else {
            TrackingOn = prefs.bool(forKey: "TRACKINGON")
        }
        
        
        if Reachability.isConnectedToNetwork() {
            
            if TrackingOn {
                //mapView.showsUserLocation = true
              //  var mtype = mapView.mapType
              //  mtype = MKMapType.Hybrid
                
                LocManager.desiredAccuracy = kCLLocationAccuracyBest
                
                // LocManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                
                LocManager.delegate = self
                LocManager.startUpdatingLocation()
                myloc = LocManager.location!
                mylat = myloc.coordinate.latitude
                mylong = myloc.coordinate.longitude
                //myalt = myloc.coordinate.al

            }
            
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Network Error"
            alertView.message = "Please Confirm your network settings"
            alertView.delegate = self
            
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        /*
        RetrieveImages()

        var imageName = "Gun100"
        let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
        let theImageData = NSData(contentsOfURL: url)
        
        TestImage = UIImage(data:theImageData!)!
        */
        
        
 
        currentLocView.layer.cornerRadius = 5
        currentLocView.layer.masksToBounds = true
        currentLocView.clipsToBounds = true
        
        
        pointSaveView1.layer.borderWidth = 1
        pointSaveView1.layer.borderColor = UIColor.white.cgColor
        pointSaveView1.layer.cornerRadius = 40
        pointSaveView1.layer.masksToBounds = true
        pointSaveView1.clipsToBounds = true
        
        
        pointSaveView2.layer.borderWidth = 1
        pointSaveView2.layer.borderColor = UIColor.white.cgColor
        pointSaveView2.layer.cornerRadius = 40
        pointSaveView2.layer.masksToBounds = true
        pointSaveView2.clipsToBounds = true
        
        pointSaveView3.layer.borderWidth = 1
        pointSaveView3.layer.borderColor = UIColor.white.cgColor
        pointSaveView3.layer.cornerRadius = 40
        pointSaveView3.layer.masksToBounds = true
        pointSaveView3.clipsToBounds = true
        
        pointSaveView4.layer.borderWidth = 1
        pointSaveView4.layer.borderColor = UIColor.white.cgColor
        pointSaveView4.layer.cornerRadius = 40
        pointSaveView4.layer.masksToBounds = true
        pointSaveView4.clipsToBounds = true
        
        
        SaveTerritoryBTNView.layer.cornerRadius = 40
        SaveTerritoryBTNView.layer.masksToBounds = true
        SaveTerritoryBTNView.clipsToBounds = true
        
        hideBTN.layer.borderWidth = 1
        hideBTN.layer.borderColor = UIColor.white.cgColor
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
       // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
    }
    
    @IBAction func SavePoint1(_ sender: AnyObject) {
        
        let latTemp = mylat
        let longTemp = mylong
        let altTemp = myalt
        
        self.pointSaveView1.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
        SavedPoint1 = true
        
        prefs.set(latTemp, forKey: "NewPoint1Lat")
        prefs.set(longTemp, forKey: "NewPoint1Long")
        prefs.set(altTemp, forKey: "NewPoint1Alt")
        
        let mylattemp = Double(round(latTemp * 1000)/1000)
        let mylongtemp = Double(round(longTemp * 1000)/1000)
        
        
        pointSaveLBL1.text = "{\(mylattemp.description), \(mylongtemp.description)}"
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlotPointNew"), object: nil, userInfo: ["lat":latTemp,"long":longTemp])
        
        
    }
    
    @IBAction func SavePoint2(_ sender: AnyObject) {
        
        let latTemp = mylat
        let longTemp = mylong
        let altTemp = myalt
        if SavedPoint1 {
        self.pointSaveView2.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
            SavedPoint2 = true
            
            prefs.set(latTemp, forKey: "NewPoint2Lat")
            prefs.set(longTemp, forKey: "NewPoint2Long")
            prefs.set(altTemp, forKey: "NewPoint2Alt")
            
            let mylattemp = Double(round(latTemp * 1000)/1000)
            let mylongtemp = Double(round(longTemp * 1000)/1000)
            
            
            pointSaveLBL2.text = "{\(mylattemp.description), \(mylongtemp.description)}"
            
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "PlotPointNew"), object: nil, userInfo: ["lat":latTemp,"long":longTemp])
            
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Coordinate 1?"
            alertView.message = "You need to save Coordinate 1 first."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
    }
    
    @IBAction func SavePoint3(_ sender: AnyObject) {
        let latTemp = mylat
        let longTemp = mylong
        let altTemp = myalt
        if SavedPoint2 {
            self.pointSaveView3.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
            SavedPoint3 = true
            
            prefs.set(latTemp, forKey: "NewPoint3Lat")
            prefs.set(longTemp, forKey: "NewPoint3Long")
            prefs.set(altTemp, forKey: "NewPoint3Alt")
            
            let mylattemp = Double(round(latTemp * 1000)/1000)
            let mylongtemp = Double(round(longTemp * 1000)/1000)
            
            
            pointSaveLBL3.text = "{\(mylattemp.description), \(mylongtemp.description)}"
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "PlotPointNew"), object: nil, userInfo: ["lat":latTemp,"long":longTemp])
            
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Coordinate 2?"
            alertView.message = "You need to save Coordinate 2 first."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
    }
    
    @IBAction func SavePoint4(_ sender: AnyObject) {
        
        let latTemp = mylat
        let longTemp = mylong
        let altTemp = myalt
        
        if SavedPoint3 {
            self.pointSaveView4.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
            SavedPoint4 = true
            
            prefs.set(latTemp, forKey: "NewPoint4Lat")
            prefs.set(longTemp, forKey: "NewPoint4Long")
            prefs.set(altTemp, forKey: "NewPoint4Alt")
            
            let mylattemp = Double(round(latTemp * 1000)/1000)
            let mylongtemp = Double(round(longTemp * 1000)/1000)
            
            
            pointSaveLBL4.text = "{\(mylattemp.description), \(mylongtemp.description)}"
            
            self.SaveTerritoryBTNView.isHidden = false
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "PlotPointNew"), object: nil, userInfo: ["lat":latTemp,"long":longTemp])
            
        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Coordinate 3?"
            alertView.message = "You need to save Coordinate 3 first."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
        
        
    }

    
    @IBAction func SaveTerritory(_ sender: AnyObject) {
        
        let PointLat1 = prefs.value(forKey: "NewPoint1Lat") as! NSString
        let PointLong1 = prefs.value(forKey: "NewPoint1Long") as! NSString
        
        let PointLat2 = prefs.value(forKey: "NewPoint2Lat") as! NSString
        let PointLong2 = prefs.value(forKey: "NewPoint2Long") as! NSString
        
        let PointLat3 = prefs.value(forKey: "NewPoint3Lat") as! NSString
        let PointLong3 = prefs.value(forKey: "NewPoint3Long") as! NSString
        
        let PointLat4 = prefs.value(forKey: "NewPoint4Lat") as! NSString
        let PointLong4 = prefs.value(forKey: "NewPoint4Long") as! NSString
        
        
        let PointAlt1 = prefs.value(forKey: "NewPoint1Alt") as! NSString
        let PointAlt2 = prefs.value(forKey: "NewPoint2Alt") as! NSString
        let PointAlt3 = prefs.value(forKey: "NewPoint3Alt") as! NSString
        let PointAlt4 = prefs.value(forKey: "NewPoint4Alt") as! NSString

        
        if SavedPoint4 {
            
            
          let SuccessAdd = AddTerritory(self.email, id: "", pointLat1: ((PointLat1 as AnyObject).description as NSString), pointLong1: (PointLong1.description as NSString), pointLat2: (PointLat2.description as NSString), pointLong2: (PointLong2.description as NSString), pointLat3: (PointLat3.description as NSString), pointLong3: (PointLong3.description as NSString), pointLat4: (PointLat4.description as NSString), pointLong4: (PointLong4.description as NSString), pointLat5: (PointLat4.description as NSString), pointLong5: (PointLong4.description as NSString), action: "add", pointAlt1: (PointAlt1.description as NSString), pointAlt2: (PointAlt2.description as NSString), pointAlt3: (PointAlt3.description as NSString), pointAlt4: (PointAlt4.description as NSString), pointAlt5: (PointAlt4.description as NSString))
            
            if SuccessAdd {
                
                
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Success"
                alertView.message = "New Territory Captured!"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateCaptureTerritoryBool"), object: nil)
                
               self.isHidden = true
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Error"
                alertView.message = "There was an error saving your new Territory"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
            
            
            
        } else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Coordinate 3?"
            alertView.message = "You need to save Coordinate 3 first."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
        // let location = locations.
        
        
        
        
        
        
        myloc = LocManager.location!
        mylat = myloc.coordinate.latitude
        mylong = myloc.coordinate.longitude
        
        prefs.setValue(mylat.description, forKey: "MYCURRENTLAT")
        prefs.setValue(mylong.description, forKey: "MYCURRENTLONG")
        
        let mylattemp = Double(round(mylat * 1000)/1000)
        let mylongtemp = Double(round(mylong * 1000)/1000)
        
        self.latitudeLBL.text = "\(mylattemp.description)"
        self.longitudeLBL.text = "\(mylongtemp.description)"
        
        
        let annotation = MKPointAnnotation()
        
       // let newLocation = locations.loca
        
        annotation.coordinate = (manager.location?.coordinate)!
        
        
        // println("updated mylat = \(mylat)")
        // println("updated mylong = \(mylong)")
        
        // println("Did Update Location items")
        
    }
    
    /*
    
    func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newLocation.coordinate
        
        
        /*
        // let currentZoom = mapView.zoomLevel
        //print("Current Zoom in location manager = \(currentZoom)")
        
        // Also add to our map so we can remove old values later
        locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = locations.first!
            locations.removeAtIndex(0)
            
            // Also remove from the map
          //  mapView.removeAnnotation(annotationToRemove)
        }
        
        */
        
        if UIApplication.shared.applicationState == .active {
         //   mapView.showAnnotations(locations, animated: true)
        } else {
            NSLog("App is backgrounded. New location is %@", newLocation)
        }
    }
    
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        
    NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateCaptureTerritoryBool"), object: nil)
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "CaptureTerritoryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor

            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    
    /*
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    */
    
    
   
    
}

class ShieldMenu: UIView {
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "ShieldMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class MyCharacterMenu: UIView {
    
    var isOpen = Bool()
    
    var Shirt_Hidden = Bool()
    var Armor_Chest_Hidden = Bool()
    
    
    var W_Chest = UIImage(named: "ItemsCharacter_Chest.png")!
    var W_ArmLeft = UIImage(named: "ItemsCharacter_Arm_Left.png")!
    var W_ArmRight = UIImage(named: "ItemsCharacter_Arm_Right.png")!
    var W_LegLeft = UIImage(named: "ItemsCharacter_Left_Left.png")!
    var W_LegRight = UIImage(named: "ItemsCharacter_Leg_Right.png")!
  //  var W_HandLeft = UIImage(named: "ItemsCharacter_Hand_Left.png")!
 //   var W_HandRight = UIImage(named: "ItemsCharacter_Hand_Right.png")!
    var W_Head = UIImage(named: "ItemsCharacter_Head.png")!
    var W_Hair_Brown = UIImage(named: "ItemsCharacter_Hair_Brown.png")!
    var W_Mouth = UIImage(named: "ItemsCharacter_Mouth.png")!
    
    
    var B_Chest = UIImage(named: "ItemsCharacter_Chest_African.png")!
    var B_ArmLeft = UIImage(named: "ItemsCharacter_Arm_Left_African.png")!
    var B_ArmRight = UIImage(named: "ItemsCharacter_Arm_Right_African.png")!
    var B_LegLeft = UIImage(named: "ItemsCharacter_Leg_Left_African.png")!
    var B_LegRight = UIImage(named: "ItemsCharacter_Leg_Right_African.png")!
  //  var B_HandLeft = UIImage(named: "ItemsCharacter_Hand_Left_African.png")!
 //   var B_HandRight = UIImage(named: "ItemsCharacter_Hand_Right_African.png")!
    var B_Head = UIImage(named: "ItemsCharacter_Head_African.png")!
    var B_Hair_Brown = UIImage(named: "ItemsCharacter_Hair_African.png")!
    var B_Mouth = UIImage(named: "ItemsCharacter_Mouth_African.png")!
    
    var EyesBlack = UIImage(named: "ItemsCharacter_Eyes_Black.png")!
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
        @IBOutlet weak var Body_Chest: UIImageView!
        @IBOutlet weak var Body_Head: UIImageView!
        @IBOutlet weak var Body_Hair: UIImageView!
        @IBOutlet weak var Body_Eyes: UIImageView!
        @IBOutlet weak var Body_Underwear: UIImageView!
        @IBOutlet weak var Body_Leg_Left: UIImageView!
        @IBOutlet weak var Body_Leg_Right: UIImageView!
        @IBOutlet weak var Body_Arm_Left: UIImageView!
        @IBOutlet weak var Body_Arm_Right: UIImageView!
        @IBOutlet weak var Body_Boots_Left: UIImageView!
        @IBOutlet weak var Body_Boots_Right: UIImageView!
        @IBOutlet weak var Body_Mouth: UIImageView!
        @IBOutlet weak var Body_Shirt: UIImageView!
        @IBOutlet weak var Body_Pants: UIImageView!
        @IBOutlet weak var Body_Belt: UIImageView!
    
    
        @IBOutlet weak var Armor_Chest: UIImageView!
    
    @IBOutlet weak var Armor_Boot_Right: UIImageView!
    
    @IBOutlet weak var Armor_Boot_Left: UIImageView!
    
    @IBOutlet weak var SkinBTN_W: UIButton!
    @IBOutlet weak var SkinBTN_B: UIButton!
    
    

    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        SkinBTN_W.layer.cornerRadius = 15
        SkinBTN_W.layer.borderWidth = 1
        SkinBTN_W.layer.borderColor = UIColor.black.cgColor
        
        
        SkinBTN_B.layer.cornerRadius = 15
        SkinBTN_B.layer.borderWidth = 1
        SkinBTN_B.layer.borderColor = UIColor.black.cgColor
        
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        Armor_Boot_Left.transform = self.Armor_Boot_Left.transform.scaledBy(x: -1, y: 1)
        Armor_Chest.isHidden = true
        Armor_Chest_Hidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func hideShirt(_ sender: AnyObject) {
        
        if Shirt_Hidden {
            self.Body_Shirt.isHidden = false
            self.Shirt_Hidden = false
        } else {
            self.Body_Shirt.isHidden = true
            self.Shirt_Hidden = true
        }
        //self.removeFromSuperview()
    }
    
    @IBAction func hideArmor(_ sender: AnyObject) {
        
        if Armor_Chest_Hidden {
            self.Armor_Chest.isHidden = false
            self.Armor_Boot_Left.isHidden = false
            self.Armor_Boot_Right.isHidden = false
            self.Armor_Chest_Hidden = false
        } else {
            self.Armor_Chest.isHidden = true
            self.Armor_Boot_Left.isHidden = true
            self.Armor_Boot_Right.isHidden = true
            self.Armor_Chest_Hidden = true
        }
        //self.removeFromSuperview()
    }
    
    
    
    @IBAction func SetSkinBlack(_ sender: AnyObject) {
        
        SetSkinTone("black")
    }
    
    @IBAction func SetSkinWhite(_ sender: AnyObject) {
        
        SetSkinTone("white")
    }
    
    func SetSkinTone(_ skinColor: String) {
        
        switch skinColor {
         case "white":
            
            self.Body_Chest.image = W_Chest
            self.Body_Head.image = W_Head
            self.Body_Hair.image = W_Hair_Brown
            self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = W_LegLeft
            self.Body_Leg_Right.image = W_LegRight
            self.Body_Arm_Left.image = W_ArmLeft
            self.Body_Arm_Right.image = W_ArmRight
          //  self.Body_Hand_Left.image = W_HandLeft
          //  self.Body_Hand_Right.image = W_HandRight
            self.Body_Mouth.image = W_Mouth



            
        case "black":
            
            self.Body_Chest.image = B_Chest
            self.Body_Head.image = B_Head
            self.Body_Hair.image = B_Hair_Brown
            self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = B_LegLeft
            self.Body_Leg_Right.image = B_LegRight
            self.Body_Arm_Left.image = B_ArmLeft
            self.Body_Arm_Right.image = B_ArmRight
            //self.Body_Hand_Left.image = B_HandLeft
            //self.Body_Hand_Right.image = B_HandRight
            self.Body_Mouth.image = B_Mouth
            
            
            
        default:
            break
        }
        
        
        
    }
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MyCharacterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

struct MissedItemsInfo {
    
    var itemName: String
    var itemImage: UIImage
    
}

class MissedItemsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    var MissedItemsArray = [NearbyItem]()
    
    var SearchItemLocation = CLLocationCoordinate2D()
    //var SearchItemLong = Double()
    var SearchItemName = String()
    var SearchItemImageName = String()
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        TableView.register(UINib(nibName: "MissedItemsCell", bundle: nil), forCellReuseIdentifier: "MissedCell")
        
        self.TableView.backgroundColor = UIColor.clear
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(_ MissedItemsArrayTemp: [NearbyItem]) -> MissedItemsView {
        let bounds = UIScreen.main.bounds
        var Nib = MissedItemsView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MissedItemsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MissedItemsView
        
        
        Nib.MissedItemsArray = MissedItemsArrayTemp
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    /*
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MissedItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "MissedCell"

        var ItemSelected: NearbyItem
        ItemSelected = MissedItemsArray[indexPath.row]
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "MissedCell") as! MissedItemsCell
        

      //  let cell = tableView.dequeueReusableCellWithReuseIdentifier("MissedCell", forIndexPath: indexPath) as! MissedItemsCell
        
        cell.backgroundColor = UIColor.clear
        cell.BGView.layer.cornerRadius = 5
        cell.BGView.layer.masksToBounds = true
        cell.BGView.clipsToBounds = true
        
        cell.itemLBL.text = ItemSelected.name
        
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(ItemSelected.imageName).png")
        let theImageData = try? Data(contentsOf: url)


        cell.itemImage.image = UIImage(data:theImageData!)!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.findItemBTN.tag = indexPath.row
        cell.findItemBTN.addTarget(self, action: #selector(MissedItemsView.LocateItemBTN(_:)), for: UIControl.Event.touchUpInside)
        
        return cell

        
    }
    
    @objc func LocateItemBTN (_ sender: AnyObject) {
        
        let row = sender.tag
        
        var ItemSelected: NearbyItem
        ItemSelected = MissedItemsArray[row!]

        
        SearchItemName = ItemSelected.name
        SearchItemImageName = ItemSelected.imageName
        SearchItemLocation = ItemSelected.Location
        
        self.isHidden = true
        
        /*
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "Will place on map item: \(SearchItemName) at Location: \(SearchItemLocation)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        */
        
        let msgTitletemp = "Item Alert"
        let msgMSGtemp = "It may still be available...directions to this item?"
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowMessage"), object: nil, userInfo: ["msgTitle":"\(msgTitletemp)","msgMSG":"\(msgMSGtemp)","name":"\(SearchItemName)","lat":"\(SearchItemLocation.latitude)","long":"\(SearchItemLocation.longitude)"])
        
        
        
    }
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class MessageInfoView: UIView {
    
    var isOpen = Bool()
    @IBOutlet weak var messageLBL: UILabel!
    
    // @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        BGView.layer.cornerRadius = 5
        
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            // self.messageLBL.alpa
            self.alpha = 0.0
            DispatchQueue.main.async(execute: {
                self.isHidden = true
            })
            
        })
        //BGView.layer.border
        
        // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(_ message: String) -> MessageInfoView {
        let bounds = UIScreen.main.bounds
        var Nib = MessageInfoView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MessageInfoView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MessageInfoView
        
        
        Nib.messageLBL.text = message
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class MissionStatusView: UIView {
    
    var isOpen = Bool()
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    @IBOutlet weak var MessageLBL: UILabel!
   
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var missionStatusLBL: UILabel!
    
    @IBOutlet weak var missionHolderView: UIView!
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    var imageName = String()
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        //BGView.layer.cornerRadius = 5
        
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        /*
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
           // self.messageLBL.alpa
            self.alpha = 0.0
             DispatchQueue.main.async(execute: {
            self.isHidden = true
            })
            
        })
        
        */
        //BGView.layer.border
        
       // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        self.missionHolderView.layer.cornerRadius = 10
        self.missionHolderView.layer.masksToBounds = true
        self.missionHolderView.clipsToBounds = true
        
        self.hideBTN.layer.cornerRadius = 25
        self.hideBTN.layer.masksToBounds = true
        self.hideBTN.clipsToBounds = true
        
        self.itemImage.contentMode = UIView.ContentMode.scaleAspectFit
       // self.itemImage.content = .aspect
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
   
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        self.alpha = 1.0
        
         UIView.animate(withDuration: 0.5, animations: { () -> Void in
             self.alpha = 0.0
            self.isHidden = true
            
         })
        
        //self.removeFromSuperview()
    }
    
    
    /*
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    */
    
    
    class func instanceFromNib(_ message: String, imageName: String, contentMessage: String) -> MissionStatusView {
        let bounds = UIScreen.main.bounds
        var Nib = MissionStatusView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MissionStatusView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MissionStatusView
        
        
        
        Nib.imageName = imageName
        let url = URL(fileURLWithPath: Nib.dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        let theItemImage = UIImage(data:theImageData!)!
        
        Nib.missionStatusLBL.text = message
        Nib.itemImage.image = theItemImage
        Nib.MessageLBL.text = contentMessage
        //Nib.messageLBL.text = message
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    

}

class UnderAttackView: UIView {
    
    var isOpen = Bool()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "ShieldMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class ItemOptionsView: UIView {
  
    
    var isOpen = Bool()
    var ItemCategory = String()
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    @IBOutlet weak var View2_2: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var View3_2: UIView!
    @IBOutlet weak var View1X: NSLayoutConstraint!
    
    @IBOutlet weak var View2BTN: UIButton!
    @IBOutlet weak var View2LBL: UILabel!
    @IBOutlet weak var View2_2LBL: UILabel!
    
    @IBOutlet weak var View2LBLamount: UILabel!
    @IBOutlet weak var View2_2LBLamount: UILabel!
    
    @IBOutlet weak var View3LBL: UILabel!
    @IBOutlet weak var View3_2LBL: UILabel!
    
    
    @IBOutlet weak var closeViewTap: UITapGestureRecognizer!
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
       
        
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
        View1.clipsToBounds = true
        
        View2.layer.cornerRadius = 5
        View2.layer.masksToBounds = true
        View2.clipsToBounds = true
        
        View3.layer.cornerRadius = 5
        View3.layer.masksToBounds = true
        View3.clipsToBounds = true
        
        View3_2.layer.cornerRadius = 5
        View3_2.layer.masksToBounds = true
        View3_2.clipsToBounds = true
        View3_2.layer.borderWidth = 1
        View3_2.layer.borderColor = UIColor.darkGray.cgColor
        
        
        View2_2.layer.cornerRadius = 5
        View2_2.layer.masksToBounds = true
        View2_2.clipsToBounds = true
        
        View3LBL.layer.cornerRadius = 5
        View2LBL.layer.cornerRadius = 5
        View3LBL.layer.masksToBounds = true
        View2LBL.layer.masksToBounds = true
        View2LBL.clipsToBounds = true
        View3LBL.clipsToBounds = true
        
        View3_2LBL.layer.cornerRadius = 5
        View2_2LBL.layer.cornerRadius = 5
        View3_2LBL.layer.masksToBounds = true
        View2_2LBL.layer.masksToBounds = true
        View2_2LBL.clipsToBounds = true
        View3_2LBL.clipsToBounds = true
 
        View2_2LBL.layer.cornerRadius = 5
        View2_2LBL.layer.masksToBounds = true
        View2_2LBL.clipsToBounds = true
        
        View2BTN.layer.cornerRadius = 5
        
        View1.layer.borderWidth = 1
        View1.layer.borderColor = UIColor.darkGray.cgColor
        
        View2.layer.borderWidth = 1
        View2.layer.borderColor = UIColor.darkGray.cgColor
        
        View2_2.layer.borderWidth = 1
        View2_2.layer.borderColor = UIColor.darkGray.cgColor
        
        View3.layer.borderWidth = 1
        View3.layer.borderColor = UIColor.darkGray.cgColor
        
      //  BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View1.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View2.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View2_2.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View3.alpha = 1.0
        })
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View3_2.alpha = 1.0
        })
        
        
        
        
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    func HideViews() {
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View1.alpha = 0.0
            })
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View2.alpha = 0.0
            })
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View2_2.alpha = 0.0
            })
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View3.alpha = 0.0
            })
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View3_2.alpha = 0.0
            })
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.BGView.alpha = 0.0
            })
            
            
        })
        
        
    }
    
    
    @IBAction func InfoBTN(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "...In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func closeViewTap(_ sender: AnyObject) {
        HideViews()
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
       self.isHidden = true
            
        })

       
        
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(_ NumViews: Int, IsUpgrading: Bool, itemCategory: String, upgradeAmount: String, upgradeNowAmount: String) -> ItemOptionsView {
        let bounds = UIScreen.main.bounds
       // var Nib = UIView()
        var Nib = ItemOptionsView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "ItemOptionsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ItemOptionsView
        
        Nib.ItemCategory = itemCategory
        
        //if 3 then -100, if 1 then 0
        
        switch NumViews{
        case 1:
            Nib.View1X.constant = 0
            Nib.View2.isHidden = true
            Nib.View2_2.isHidden = true
            Nib.View3.isHidden = true
            Nib.View3_2.isHidden = true
            
        case 2:
            Nib.View1X.constant = -50
            
            Nib.View3.isHidden = true
            Nib.View3_2.isHidden = true
            
            
            if IsUpgrading {
                Nib.View2.isHidden = true
                Nib.View2_2.isHidden = false
            }
            
        case 3:
            Nib.View1X.constant = -100
            
            switch itemCategory{
                
            case "GoldProduction":
                Nib.View3.isHidden = true
                Nib.View3_2.isHidden = false
                Nib.View3_2LBL.text = "Collect"
            case "HQSafe":
                Nib.View3.isHidden = true
                Nib.View3_2.isHidden = false
                Nib.View3_2LBL.text = "Transfer"
            case "GoldPurse":
                 Nib.View3.isHidden = false
                 Nib.View3_2.isHidden = true
                
            default:
                break
            }
        
        default:
            Nib.View1X.constant = 0
            Nib.View2_2.isHidden = true
            Nib.View3.isHidden = true
        }
        
        
      //  let upgradeAmountFloat = Float(upgradeAmount)
      //  let upgradeAmountString = upgradeAmountFloat?.asLocaleCurrency
        
        Nib.View2LBLamount.text = "$\(upgradeAmount)"
        //Nib.View2LBLamount.text = "$\(upgradeAmount)"
        
        Nib.View2_2LBLamount.text = upgradeNowAmount
        Nib.View2_2.isHidden = true
        
        Nib.View1.alpha = 0.0
        Nib.View2.alpha = 0.0
        Nib.View3.alpha = 0.0
        Nib.View2_2.alpha = 0.0
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    @IBAction func UpgradeBTN(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "...In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
        
        
    }
    
    @IBAction func TransferBTN(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "...In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    
    @IBAction func UpgradeNowBT(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon"
        alertView.message = "...In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    
     @IBAction func CollectGoldBTN(_ sender: AnyObject) {
        
        switch ItemCategory {
        
            
            case "GoldProduction":
        HideViews()
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "CollectGoldNotification"), object: nil)
            self.isHidden = true
            
        })
            
            case "HQSafe":
                HideViews()
                
                let seconds = 0.5
                let secondsLoad = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "HQTransferMoneyNotification"), object: nil)
                    self.isHidden = true
                    
                })
    
        default:
        break
    }
    }
}



class PotionMenu: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myGoldAmount = Int()
    var username = NSString()
    var email = NSString()
    
    var isOpen = Bool()
    var TotalItems = Int()
    var prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   // var TotalPotionArray = [PotionStruct]()
    
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySortedPotion]()
    
    var SavedItemsInventory = [NSManagedObject]()
    
    @IBOutlet weak var potionLBL2: UILabel!
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    @IBOutlet weak var potionView2: UIView!
    @IBOutlet weak var potionView1: UIView!
    
    @IBOutlet weak var potionCount1: UILabel!
    
    @IBOutlet weak var potionCount2: UILabel!
    
     let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
  
    
    var buttonClicked = Bool()
    
    
    override func awakeFromNib() {
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        myGoldAmount = Int(prefs.value(forKey: "GOLDAMOUNT") as! String)!

        RetrieveImages()
        

        let columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        self.collectionView.backgroundColor = UIColor.clear
        
        
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true

        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            //self.Off()
            buttonClicked = false
        } else {
          //  self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "PotionMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        
        Nib.bounds = bounds
        
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    @objc func BuyMorePotion(_ sender: AnyObject) {
    
    
    let itemTag = sender.tag
    let useItem: ItemInventorySortedPotion
    
    useItem = TotalItemsInventoryArray[itemTag!]
        
        
        let Cost = useItem.Cost
       
        let countTemp = useItem.Count
        let Max = useItem.Max
        
        print("Potion Count: \(countTemp)")
        print("Potion Max: \(Max)")
        
        if countTemp < Max {
        
        
        if self.myGoldAmount >= Cost {
        
            
        let NewGoldAmount = myGoldAmount - Cost
            
        //let New
        
        let itemname = useItem.name
        let imageURL = useItem.imageURL
        let category = useItem.category
        let power = useItem.power
        let speed = useItem.speed
        let range = useItem.range
        let health = useItem.health
        let stamina = useItem.stamina
        let imageURL100 = useItem.imageURL100
        let itemOrder = useItem.itemOrder
        let viewRange = useItem.viewRange
        let subCategory = useItem.subCategory
        
        //prefs.integerForKey("HealthPotionCount")
        var Count = useItem.Count + 1
      
        
        if Count > Max {
            Count == Max
        }
        
            
            var potionType = String()
            
            
            print("ITEM NAME: \(itemname)")
            
            switch itemname {
            case "Health Potion":
                potionType = "health"
                prefs.set(Count.description, forKey: "UserHealthPotionCount")
            case "Stamina Potion":
                potionType = "stamina"
                prefs.set(Count.description, forKey: "UserStaminaPotionCount")
            default:
                break
            }
            
        TotalItemsInventoryArray.remove(at: itemTag!)
            TotalItemsInventoryArray.insert(ItemInventorySortedPotion(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, Count: Count, Max: Max, Cost: Cost, viewRange: viewRange, subCategory: subCategory, unlocked: true), at: itemTag!)
            
            
           // let UpdateGoldSuccess =  UpdateUserGold(self.username, email: self.email, amount: newAmount.description)
            
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMoney"), object: nil, userInfo: ["previousAmount":"\(myGoldAmount.description)","newAmount":"\(Cost.description)","setting":"subtract"])
            
        let UpdatePotionSuccess = UpdateUserPotions(self.username, email: self.email, amount: "\(Count.description)" as NSString, type: "\(potionType)", info: "count")
            
            
            
            
            print("Updated Users's Potion Type: \(potionType) = \(UpdatePotionSuccess)")
            
        
        let UpdateGoldSuccess =  UpdateUserGold(self.username, email: self.email, amount: NewGoldAmount.description as NSString)
            
            
        } else {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Insufficient Gold"
            alertView.message = "You don't have enough gold"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
             alertView.show()
        }
            
        } else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Potion Limit"
            alertView.message = "You can't carry any more potions, upgrade your store space."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
    
    print("Buy More Potion: \(useItem.name)")
    self.collectionView.reloadData()
    
    }
    
    @objc func UsePotion(_ sender: AnyObject) {
        
    let itemTag = sender.tag
    let useItem: ItemInventorySortedPotion
        
    
        
       useItem = TotalItemsInventoryArray[itemTag!]
        
        
        let itemname = useItem.name
        let imageURL = useItem.imageURL
        let category = useItem.category
        let power = useItem.power
        let speed = useItem.speed
        let range = useItem.range
        let health = useItem.health
        let stamina = useItem.stamina
        let imageURL100 = useItem.imageURL100
        let itemOrder = useItem.itemOrder
        let Cost = useItem.Cost
        let viewRange = useItem.viewRange
        let subCategory = useItem.subCategory
        //prefs.integerForKey("HealthPotionCount")
        var Count = useItem.Count - 1
        var Max = useItem.Max
        
        if Count < 0 {
            Count == 0
        }
        
        
        var potionType = String()
        
        switch itemname {
            case "Health Potion":
            potionType = "health"
            prefs.set(Count.description, forKey: "UserHealthPotionCount")
            
            prefs.set(false, forKey: "AmIDead")
            
            
            case "Stamina Potion":
            potionType = "stamina"
            prefs.set(Count.description, forKey: "UserStaminaPotionCount")
            
            prefs.set(false, forKey: "AmITired")
        default:
            break
        }

        TotalItemsInventoryArray.remove(at: itemTag!)
        TotalItemsInventoryArray.insert(ItemInventorySortedPotion(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, Count: Count, Max: Max, Cost: Cost, viewRange: viewRange, subCategory: subCategory, unlocked: true), at: itemTag!)
        
         let UpdatePotionSuccess = UpdateUserPotions(self.username, email: self.email, amount: "\(Count.description)" as NSString, type: "\(potionType)", info: "count")
        
       // let NewCountTemp = useItem.Count - 1
        
        print("Using Potion: \(useItem.name)")
    
       
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateHealthStamina"), object: nil, userInfo: ["potionType":"\(potionType)","potionAction":"add","potionAmount":"100"])
        
       self.collectionView.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        
       return TotalItemsInventoryArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellSmall", for: indexPath) as! ItemsCollectionViewCellSmall
        
        
        var itemTemp : ItemInventorySortedPotion
        
        itemTemp = TotalItemsInventoryArray[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        //cell.imageView.image = UIImage(named: "knife.png")
        
        
        print("test")
        
        let imageName = itemTemp.imageURL100
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        // print("url for image = \(url)")
        let theImageData = try? Data(contentsOf: url)
        
        //TestImage = UIImage(data:theImageData!)!
        
        print("Image Name = \(imageName)")
        cell.levelLBL.text = "Count: \(itemTemp.Count.description)/\(itemTemp.Max.description)"
        
        switch itemTemp.name {
            case "Stamina Potion":
              cell.ammoLBL.text = "Stamina: 100"
            case "Health Potion":
              cell.ammoLBL.text = "Health: 100"
            
            
            
        default:
            break
        }
        cell.ammoLBL.text = "Health: 100"
        cell.imageView.image  = UIImage(data: theImageData!)!
        cell.itemName.text = itemTemp.name
        
        cell.costLBL.text = "$\(itemTemp.Cost.description)"
        cell.costViewLBL.text = "Buy More"
        cell.costViewBTN.tag = indexPath.row
        cell.costViewBTN.addTarget(self, action: #selector(PotionMenu.BuyMorePotion(_:)), for: UIControl.Event.touchUpInside)
        
        
        cell.useBTN.tag = indexPath.row
        cell.useBTN.addTarget(self, action: #selector(PotionMenu.UsePotion(_:)), for: UIControl.Event.touchUpInside)
        
        
        if itemTemp.Count <= 0 {
            cell.useBTN.isEnabled = false
            cell.useView.backgroundColor = UIColor(red: 216/255, green: 38/255, blue: 27/255, alpha: 1.0)
            cell.useLBL.text = "Empty"
            cell.useView.isHidden = true
        } else  {
            cell.useBTN.isEnabled = true
            cell.useView.backgroundColor = UIColor(red: 9/255, green: 166/255, blue: 81/255, alpha: 1.0)
            cell.useLBL.text = "Use Potion"
            cell.useView.isHidden = false
        }
        //  cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
        //  cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
        //  cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
        cell.upgradeTimerLBL.isHidden = true
        
        if itemTemp.category != "weapon" {
            if indexPath.row > 0 {
                //HIDES LOCK FROM
                cell.lockView.isHidden = true
                
              //  cell.lockView.hidden = false
            } else {
                cell.lockView.isHidden = true
            }
        } else {
            cell.lockView.isHidden = true
        }
        
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Item Selected Small"
        alertView.message = "Item \(indexPath.row) Selected"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
       // alertView.show()
        
      //  self.removeFromSuperview()
        
        
        
    }
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
                // print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                let ItemCategory = items.value(forKey: "category") as! String
                let ItemOrder = items.value(forKey: "itemOrder") as! String
                
                
                let itemname = items.value(forKey: "name") as! String
                let imageURL = items.value(forKey: "imageURL") as! String
                let category = items.value(forKey: "category") as! String
                let power = items.value(forKey: "power") as! String
                let speed = items.value(forKey: "speed") as! String
                let range = items.value(forKey: "range") as! String
                let health = items.value(forKey: "health") as! String
                let stamina = items.value(forKey: "stamina") as! String
                let imageURL100 = items.value(forKey: "imageURL100") as! String
                let itemOrder = items.value(forKey: "itemOrder") as! String
                let itemViewRange = items.value(forKey: "viewRange") as! String
                let subCategory = items.value(forKey: "subCategory") as! String
                //prefs.integerForKey("HealthPotionCount")
                var Count = Int()
                var Max = Int()
                var Cost = Int()
                
                print("Item Name: \(itemname)")
                
                switch itemname {
                    
                 case "Health Potion":
                    let Maxtemp = prefs.value(forKey: "UserHealthPotionMax") as! String
                    Max = Int(Maxtemp)!
                    let Counttemp = prefs.value(forKey: "UserHealthPotionCount") as! String
                    Count = Int(Counttemp)!
                    Cost = 1500
                 case "Stamina Potion":
                    let Maxtemp = prefs.value(forKey: "UserStaminaPotionMax") as! String
                    Max = Int(Maxtemp)!
                    let Counttemp = prefs.value(forKey: "UserStaminaPotionCount") as! String
                    Count = Int(Counttemp)!
                    Cost = 1000
                 default:
                    break
                    
                }
                
                if (category == "potion") && (itemOrder != "0") {
                    
                    
                    TotalItemsInventoryArray.append(ItemInventorySortedPotion(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, Count: Count, Max: Max, Cost: Cost, viewRange: itemViewRange, subCategory: subCategory, unlocked: true))
                    
                }
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sort { (lhs: ItemInventorySortedPotion, rhs: ItemInventorySortedPotion) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            //  print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    

    
}


class AbilitiesView: UIView {
    
    var isOpen = Bool()
    var ViewingAbilties = Bool()
    var device = UIScreen.main.bounds
   // var width = self.device.size.width
   // var height = self.device.size.height
   // var width = CGFloat()
   // var height
    var ShowingAbilities = Bool()
    
    
    @IBOutlet weak var abilitiesLayoutView: UIView!
    
    
    @IBOutlet weak var AbilityBTN: UIButton!
    @IBOutlet weak var buttonViewX: NSLayoutConstraint!
    
    @IBOutlet weak var buttonViewY: NSLayoutConstraint!
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewH: NSLayoutConstraint!
    @IBOutlet weak var topViewW: NSLayoutConstraint!
    
    @IBOutlet weak var topViewLEAD: NSLayoutConstraint!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewH: NSLayoutConstraint!
    @IBOutlet weak var bottomViewW: NSLayoutConstraint!

    @IBOutlet weak var bottomViewTRAIL: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var buttonViewW: NSLayoutConstraint!
    
    @IBOutlet weak var buttonViewH: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var abilityView1: UIView!
    
    @IBOutlet weak var abilityLBL1: UILabel!
    @IBOutlet weak var abilityView1H: NSLayoutConstraint!
    @IBOutlet weak var abilityView1W: NSLayoutConstraint!
    
    var prefs:UserDefaults = UserDefaults.standard
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
    
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    
    
    override func awakeFromNib() {
        
        
       
        
        
        
        buttonView.layer.cornerRadius = 40
        buttonView.clipsToBounds = true
        buttonView.layer.masksToBounds = true
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.black.cgColor
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        abilitiesLayoutView.isHidden = true
        self.frame = bounds
        
        print("Device bounds = \(device)")
        
        self.topViewW.constant = device.width
        self.bottomViewW.constant = device.width
        
        
        
        let seconds = 0.1
        let secondsLoad = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeNext = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)

        
         DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                self.topView.center.x = self.topView.center.x + self.device.width
                self.topViewLEAD.constant = 0
                
                self.bottomView.center.x = self.bottomView.center.x - self.device.width
                self.bottomViewTRAIL.constant = 0
                
             //   self.buttonView.center.y = self.buttonView.center.y + (self.device.height / 2)
               
               let moveY = (self.device.height / 2)
               // self.buttonViewW.constant = 100
               // self.buttonViewH.constant = 100
                
                //self.ScaleViewSize(self.buttonView, scale: 2.0, moveX: 0, moveY: moveY)
                
                let toY = (self.device.height / 2)
                let toX = (self.device.width / 4)
                
                print("Device bounds H / 2 = \(toY)")
                print("Device bounds W / 4 = \(toX)")
                
                self.buttonView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.buttonView.transform = CGAffineTransform(translationX: 0, y: toY)
                
                self.buttonViewW.constant = 100
                self.buttonViewH.constant = 100
                self.buttonView.layer.cornerRadius = 50
                
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTimeNext, execute: {
                    // self.buttonView.layer.cornerRadius = 50
                   // self.buttonViewW.constant = 100
                  //  self.buttonViewH.constant = 100
                   // self.buttonViewY.constant = (self.device.height / 2) - 50
                })
                
                
               // self.buttonViewW.constant = 100
              //  self.buttonViewH.constant = 100
              //  self.AbilityBTN.frame.size.width = 80
              //  self.AbilityBTN.frame.size.height = 80
                
               // self.buttonViewY.constant = (self.device.height / 2) - 40
                    //= self.buttonView.frame.size.width =
                
                self.expandView()
                
            })

        })
        
       
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    
    func CollapseLayout() {
        
        prefs.set(false, forKey: "VIEWINGABILITIES")
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)

        
        print("Viewing abilites after collapse = \(prefs.bool(forKey: "VIEWINGABILITIES"))")
        
        
        self.collapseView()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.alpha = 0.0
            self.topView.center.x = self.topView.center.x - self.device.width
            self.topViewLEAD.constant = self.device.width * -1
            
            self.bottomView.center.x = self.bottomView.center.x + self.device.width
            self.bottomViewTRAIL.constant = self.device.width
            
          //  self.buttonView.center.y = self.buttonView.center.y - (self.device.height / 2)
            
           
            let moveY = 0 - (self.device.height / 2)
            
            //self.ScaleViewSize(self.buttonView, scale: 1.0, moveX: 0, moveY: moveY)
            
            
            
            self.buttonView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.buttonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            self.buttonView.layer.cornerRadius = 10
            self.buttonViewW.constant = 20
            self.buttonViewH.constant = 20
            
            
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
           // self.buttonViewW.constant = 20
          //  self.buttonViewH.constant = 20
            //  self.AbilityBTN.frame.size.width = 80
            //  self.AbilityBTN.frame.size.height = 80
            
            self.buttonViewY.constant = -40
            })
          //  */
            //= self.buttonView.frame.size.width =
            
            
            
        })
        /*
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
        self.buttonViewW.constant = 20
        self.buttonViewH.constant = 20
        self.buttonViewY.constant = -40
        })
        
        */
        
    }
    
    
    func ScaleViewSize(_ theView: UIView, scale: CGFloat, moveX: CGFloat, moveY: CGFloat) {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            theView.transform = CGAffineTransform(scaleX: scale, y: scale)
            theView.center.x = theView.center.x + moveX
            theView.center.y = theView.center.y + moveY
        })
        
        /*
        UIView.animateWithDuration(1, animations: { () -> Void in
            theView.transform = CGAffineTransformMakeScale(scale, scale)
        }) { (finished: Bool) -> Void in
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                theView.transform = CGAffineTransformIdentity
            })}
        
        */
        
    }
    
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        //self.hidden = true
        CollapseLayout()
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
        self.removeFromSuperview()
        })
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "AbilitiesView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func ShowAbilities(){
        
       
        if !ShowingAbilities {
            expandView()
            self.ShowingAbilities = true
        } else {
            collapseView()
            self.ShowingAbilities = false
        }
        
    }
    
    func expandView() {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.abilitiesLayoutView.alpha = 1.0
            // abilitiesLayoutView.hidden = false
        })
        
        
    }
    
    func collapseView() {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.abilitiesLayoutView.alpha = 0.0
      // abilitiesLayoutView.hidden = true
        })
        
    }
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
         
         /*
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

class ArmorMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    var categories = ["Gloves", "Boots", "Body", "Helmet"]
    
    
    // @IBOutlet weak var collectionViewGloves: UICollectionView!
    
    //  @IBOutlet weak var collectionViewSmall: UICollectionView!
    
    
    var isOpen = Bool()
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    //  var isOpen = Bool()
    
    // @IBOutlet weak var hideBTN: UIButton!
    // @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        /*
         print("view 5 y awake = \(self.view5.center.y)")
         
         // self.view5.center.y = self.view5.center.y - 46
         self.view5B.constant = 46
         self.view5H.constant = 0
         self.view5W.constant = 0
         
         //self.view4.center.y = self.view4.center.y - 46
         self.view4B.constant = -60
         self.view4R.constant = -40
         self.view4H.constant = 0
         self.view4W.constant = 0
         
         self.view3B.constant = -60
         self.view3R.constant = -40
         self.view3H.constant = 0
         self.view3W.constant = 0
         
         
         buttonView.layer.cornerRadius = buttonView.frame.height / 2
         buttonView.clipsToBounds = true
         
         //buttonView.backgroundColor = UIColor.NewColors.Header
         
         view5BG.layer.cornerRadius = view5BG.frame.height / 2
         view5BG.clipsToBounds = true
         //view5BG.backgroundColor = UIColor.NewColors.Header
         
         view4BG.layer.cornerRadius = view4BG.frame.height / 2
         view4BG.clipsToBounds = true
         //view4BG.backgroundColor = UIColor.NewColors.Header
         
         view3BG.layer.cornerRadius = view3BG.frame.height / 2
         view3BG.clipsToBounds = true
         // view3BG.backgroundColor = UIColor.NewColors.Header
         
         
         view4BUTTON.imageView?.tintColor = UIColor.whiteColor()
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        //  var columnHeaderViewNIB = UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
        //  self.collectionView?.registerNib(columnHeaderViewNIB, forCellWithReuseIdentifier: "ItemCell")
        
        //  self.collectionView.backgroundColor = UIColor.clearColor()
        
        
        //  var columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        //   self.collectionViewGloves?.registerNib(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        //   self.collectionViewGloves.backgroundColor = UIColor.clearColor()
        
        
        // self.collectionView.hidden = true
        
        // self.collectionView?.registerNib(columnHeaderViewNIB, forSupplementaryViewOfKind: columnHeaderViewIdentifier, withReuseIdentifier: columnHeaderViewIdentifier)
        //[self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
        
        
        TableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "CellOne")
        
        TableView.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "CellTwo")
        
        TableView.register(UINib(nibName: "TableViewCell3", bundle: nil), forCellReuseIdentifier: "CellThree")
        
        TableView.register(UINib(nibName: "TableViewCell4", bundle: nil), forCellReuseIdentifier: "CellFour")
        
        self.TableView.backgroundColor = UIColor.clear
        
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    /*
     
     func RetrieveImages() {
     
     let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     
     
     let managedContextGroups = appDelegate.managedObjectContext
     let fetchGroups = NSFetchRequest(entityName: "Items")
     let errorGroups: NSError?
     
     do {
     let fetchedResultsGroups =  try managedContextGroups!.executeFetchRequest(fetchGroups) as? [NSManagedObject]
     
     if let resultsGroups = fetchedResultsGroups {
     SavedItemsInventory = resultsGroups
     print("Saved items = \(SavedItemsInventory)")
     } else {
     //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
     }
     
     for items in SavedItemsInventory as [NSManagedObject] {
     TotalItems += 1
     // ItemsInventoryArray.append(CurNumGroups)
     
     let ItemNameURL = items.valueForKey("imageURL") as! String
     let ItemCategory = items.valueForKey("category") as! String
     let ItemOrder = items.valueForKey("itemOrder") as! String
     
     
     let itemname = items.valueForKey("name") as! String
     let imageURL = items.valueForKey("imageURL") as! String
     let category = items.valueForKey("category") as! String
     let power = items.valueForKey("power") as! String
     let speed = items.valueForKey("speed") as! String
     let range = items.valueForKey("range") as! String
     let imageURL100 = items.valueForKey("imageURL100") as! String
     let itemOrder = items.valueForKey("itemOrder") as! String
     
     
     if (category == "armorgloves") && (itemOrder != "0") {
     
     
     TotalItemsInventoryArray.append(ItemInventorySorted(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!))
     
     }
     }
     
     //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
     
     
     
     TotalItemsInventoryArray.sortInPlace { (lhs: ItemInventorySorted, rhs: ItemInventorySorted) -> Bool in
     // you can have additional code here
     return lhs.itemOrderNum < rhs.itemOrderNum
     }
     
     
     
     print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
     
     
     // print("Current items IMAGE URL =\(TotalItemsArray)")
     
     
     
     if self.SavedItemsInventory.count > 0 {
     //  GroupInfoLBL.hidden = true
     } else {
     //  GroupInfoLBL.hidden = false
     }
     
     
     } catch {
     print(error)
     }
     
     
     }
     
     */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        
        let lastviewtopulse = "armor"
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowNewMessageView"), object: nil, userInfo: ["ViewToPulse":"\(lastviewtopulse)"])
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
        
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            //  self.Off()
            buttonClicked = false
        } else {
            //    self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "ArmorMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        
        
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "CellOne"
        let identifier1 = "CellTwo"
        let identifier2 = "CellThree"
        let identifier3 = "CellFour"
        
        print("TABLEVIEW INDEX = \(indexPath.row)")
        
        let section = indexPath.section
        print("Section = \(section)")
        
        switch indexPath.section {
        case 0:
            
            
            print("SHOULD GET CELL TYPE 1")
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier0)") as! TableViewCell1
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 1:
            print("SHOULD GET CELL TYPE 2")
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier1)") as! TableViewCell2
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            print("SHOULD GET CELL TYPE 3")
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier2)") as! TableViewCell3
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 3:
            print("SHOULD GET CELL TYPE 4")
            let  cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier3)") as! TableViewCell4
            cell.backgroundColor = UIColor.clear
            return cell
            
            
        default:
            break
            
            let cell = UITableViewCell()
            return cell
            // return cell
        }
        
        
        
        let cell = UITableViewCell()
        return cell
        
    }
    
    
    
    
}

class TreasureView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    var categories = ["Diamonds"]
    
    
   // @IBOutlet weak var collectionViewGloves: UICollectionView!
    
  //  @IBOutlet weak var collectionViewSmall: UICollectionView!
    
    
    var isOpen = Bool()
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
  //  var isOpen = Bool()
    
   // @IBOutlet weak var hideBTN: UIButton!
   // @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    /*
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var view5H: NSLayoutConstraint!
    @IBOutlet weak var view5W: NSLayoutConstraint!
    @IBOutlet weak var view5R: NSLayoutConstraint!
    @IBOutlet weak var view5B: NSLayoutConstraint!
    @IBOutlet weak var view5BG: UIView!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view4H: NSLayoutConstraint!
    @IBOutlet weak var view4W: NSLayoutConstraint!
    @IBOutlet weak var view4R: NSLayoutConstraint!
    @IBOutlet weak var view4B: NSLayoutConstraint!
    @IBOutlet weak var view4BG: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view3H: NSLayoutConstraint!
    @IBOutlet weak var view3W: NSLayoutConstraint!
    @IBOutlet weak var view3R: NSLayoutConstraint!
    @IBOutlet weak var view3B: NSLayoutConstraint!
    @IBOutlet weak var view3BG: UIView!
    
    
    @IBOutlet weak var buttonViewW: NSLayoutConstraint!
    
    @IBOutlet weak var buttonViewH: NSLayoutConstraint!
    
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
    
    
    @IBOutlet weak var view4BUTTON: UIButton!
    @IBOutlet weak var view3LBL: UILabel!
    @IBOutlet weak var view4LBL: UILabel!
    
    @IBOutlet weak var view5LBL: UILabel!
    
    */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
       
        
        TableView.register(UINib(nibName: "TreasureTableViewCell", bundle: nil), forCellReuseIdentifier: "TreasureTableCell")
        
        
        self.TableView.backgroundColor = UIColor.clear
       // self.TableView.s
        
        hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        //BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
    }
    
    /*
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest(entityName: "Items")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.executeFetchRequest(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
                print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.valueForKey("imageURL") as! String
                let ItemCategory = items.valueForKey("category") as! String
                let ItemOrder = items.valueForKey("itemOrder") as! String
                
                
                let itemname = items.valueForKey("name") as! String
                let imageURL = items.valueForKey("imageURL") as! String
                let category = items.valueForKey("category") as! String
                let power = items.valueForKey("power") as! String
                let speed = items.valueForKey("speed") as! String
                let range = items.valueForKey("range") as! String
                let imageURL100 = items.valueForKey("imageURL100") as! String
                let itemOrder = items.valueForKey("itemOrder") as! String
                
                
                if (category == "armorgloves") && (itemOrder != "0") {
                    
                    
                    TotalItemsInventoryArray.append(ItemInventorySorted(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!))
                    
                }
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sortInPlace { (lhs: ItemInventorySorted, rhs: ItemInventorySorted) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
          //  self.Off()
            buttonClicked = false
        } else {
        //    self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = UIView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "TreasureView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        Nib.bounds = bounds
        
        
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    

    
    /*
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // var cell = UITableViewCell()
        
        let identifier0 = "TreasureTableCell"
        
        print("SHOULD GET CELL TYPE 1")
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier0)") as! TreasureTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    
    }
    

    
    
}


class MapPin: MKAnnotationView {
    class var reuseIdentifier:String {
        return "mapPin"
    }
    //private var calloutView:UIView?
    
    fileprivate var calloutViewPlayer:PlayerAnnotationView?
    fileprivate var hitOutside:Bool = true
    
    open var attackUserName: String!
    open var attackUserID: String!
    open var attackUserLat: Double!
    open var attackUserLong: Double!
    open var attackUserHealth: String!
    //  public var itemID: String!
    //  public var amount: String!
    open var attackUserImage: UIImage!
    open var attackUserAlt: Double!
    
    open var PinType: String!
    
    ///
    fileprivate var calloutView:ItemAnnotationView?
   // private var hitOutside:Bool = true
    
    //GAME ITEM INFO-------
    open var itemName: String!
    open var itemType: String!
    open var itemLat: Double!
    open var itemLong: Double!
    open var itemCode: String!
    open var itemID: String!
    open var amount: String!
    open var itemImage: UIImage!
    
    
    open var category: String!
    open var count: String!
    open var level: String!
    open var health: String!
    open var stamina: String!
    open var ammoCount: String!
    open var speed: String!
    open var power: String!
    open var range: String!
    open var viewrange: String!
    
    
    //MISSION INFO--------
    open var missionTitle: String!
    open var missionObjective: String!
    open var missionLevel: String!
    open var missionXP: String!
    open var missionID: String!
    open var missionMapURL: String!
    open var missionObjectURL: String!
    
    
    //Attributes INFO------
    open var TotalPlayerAttributesTemp: TotalPlayerAttributes!
    
    //other stats info------
    open var killcount: String!
    open var killedcount: String!
    
    
    open var isMission: Bool!
    
    var preventDeselection:Bool {
      //  print("hitOutside Map Pin = \(hitOutside)")
        return !hitOutside
    }
    
    
    
    
    convenience init(annotation:MKAnnotation!) {
        self.init(annotation: annotation, reuseIdentifier: MapPin.reuseIdentifier)
        canShowCallout = false;
    }
    
    func GetVariables(_ itemName: String, itemType: String, itemLat: String, itemLong: String, itemCode: String, itemID: String, amount: String) {
        
      //  print("Variables = ")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let calloutViewAdded = calloutView?.superview != nil
        
      //  print("hitOutside Map Pin - set selected = \(hitOutside)")
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        if (calloutView == nil) {
            
           // print("Should add item annotation view now")
            //calloutView = ItemAnnotationView.instanceFromNib(((annotation?.title)!)!)
            //calloutView = ItemAnnotationView.instanceFromNib()
            
            
            /*
            let bounds = UIScreen.mainScreen().bounds
            var Nib = UIView()
            // var itemTitle: String!
            // itemTitle = title
            
            let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
            // Nib.titleLBL.text = title
            //  self.setTitle(title)
            
            Nib.bounds = bounds
            
            calloutView =  Nib
            */
            
            print("PIN TYPE map pin = \(self.PinType)")
            
            /*
            if 1 == 0 {
                
                    calloutViewPlayer = PlayerAnnotationView.instanceFromNib(attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserHealth: self.attackUserHealth)
            } else {
                
                */
            
           // calloutView().setTitl
           // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, )
        
            
       // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth)
            
            print("attack user alt: \(attackUserAlt)")
            
            
            calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, missionTitle: self.missionTitle , missionObjective: self.missionObjective, missionLevel: self.missionLevel, missionXP: self.missionXP, missionID: self.missionID, missionMapURL: self.missionMapURL, missionObjectURL: self.missionObjectURL, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: self.isMission, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, attackUserAlt: self.attackUserAlt)
            
        //    }
           // calloutView?.itemImageIMG = self.itemImage
            calloutView!.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
          
            //calloutView = ItemAnnotationView.instanceFromNib(annotation.title?, itemImage: nil)
            
        }
        
        if (self.isSelected && !calloutViewAdded) {
           // calloutView = ItemAnnotationView.instanceFromNib()
            
            addSubview(calloutView!)
        }
        
        if (!self.isSelected) {
          //  print("Should remove item annotation view now")
            calloutView?.removeFromSuperview()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, with: event)
        
      //  print("Hit Test")
        
        if let callout = calloutView {
            if (hitView == nil && self.isSelected) {
                hitView = callout.hitTest(point, with: event)
                
             //   print("Item Hit View selected")
            }
        }
        
      //  print("hitOutside Map Pin - nil? = \(hitOutside)")
        hitOutside = hitView == nil
        
        return hitView;
    }
    
    
   
    
}
class CameraViewPin: MKAnnotationView {
    
    class var reuseIdentifier:String {
        return "CameraViewPin"
    }
    
    
    fileprivate var calloutViewPlayer:PlayerAnnotationView?
    fileprivate var hitOutside:Bool = true
    
    open var attackUserName: String!
    open var attackUserID: String!
    open var attackUserLat: Double!
    open var attackUserLong: Double!
    open var attackUserHealth: String!
    open var attackUserAlt: Double!
    //  public var itemID: String!
    //  public var amount: String!
    open var attackUserImage: UIImage!
    
    open var isMission: Bool!
    
    
    open var PinType: String!
    
    ///
    fileprivate var calloutView:ItemAnnotationView?
    // private var hitOutside:Bool = true
    
    //GAME ITEM INFO-------
    open var itemName: String!
    open var itemType: String!
    open var itemLat: Double!
    open var itemLong: Double!
    open var itemCode: String!
    open var itemID: String!
    open var amount: String!
    open var itemImage: UIImage!
    
    
    open var category: String!
    open var count: String!
    open var level: String!
    open var health: String!
    open var stamina: String!
    open var ammoCount: String!
    open var speed: String!
    open var power: String!
    open var range: String!
    open var viewrange: String!
    
    
    //MISSION INFO--------
    open var missionTitle: String!
    open var missionObjective: String!
    open var missionLevel: String!
    open var missionXP: String!
    open var missionID: String!
    open var missionMapURL: String!
    open var missionObjectURL: String!
    
    //Attributes INFO------
    open var TotalPlayerAttributesTemp: TotalPlayerAttributes!
    
    //other stats info------
    open var killcount: String!
    open var killedcount: String!
    
    
    var preventDeselection:Bool {
        //  print("hitOutside Map Pin = \(hitOutside)")
        return !hitOutside
    }
    
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
        
        
        addHalo()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addHalo() {
        let pulsator = Pulsator()
        
        let theCenter = CGPoint(x: 25, y: 25)
        //pulsator.position = center
        pulsator.position = theCenter
        pulsator.numPulse = 2
        pulsator.radius = 40
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor(red: 0, green: 0.455, blue: 0.756, alpha: 1).cgColor
        layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    
    
    
    func GetVariables(_ itemName: String, itemType: String, itemLat: String, itemLong: String, itemCode: String, itemID: String, amount: String) {
        
        //  print("Variables = ")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let calloutViewAdded = calloutView?.superview != nil
        
        //  print("hitOutside Map Pin - set selected = \(hitOutside)")
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        if (calloutView == nil) {
            
            // print("Should add item annotation view now")
            //calloutView = ItemAnnotationView.instanceFromNib(((annotation?.title)!)!)
            //calloutView = ItemAnnotationView.instanceFromNib()
            
            
            /*
             let bounds = UIScreen.mainScreen().bounds
             var Nib = UIView()
             // var itemTitle: String!
             // itemTitle = title
             
             let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
             Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
             // Nib.titleLBL.text = title
             //  self.setTitle(title)
             
             Nib.bounds = bounds
             
             calloutView =  Nib
             */
            
            print("PIN TYPE = \(self.PinType)")
            
            /*
             if 1 == 0 {
             
             calloutViewPlayer = PlayerAnnotationView.instanceFromNib(attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserHealth: self.attackUserHealth)
             } else {
             
             */
            
            // calloutView().setTitl
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, )
            
            
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth)
            
            
            
            calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, missionTitle: self.missionTitle , missionObjective: self.missionObjective, missionLevel: self.missionLevel, missionXP: self.missionXP, missionID: self.missionID, missionMapURL: self.missionMapURL, missionObjectURL: self.missionObjectURL, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: self.isMission, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, attackUserAlt: self.attackUserAlt)
            
            //    }
            // calloutView?.itemImageIMG = self.itemImage
            calloutView!.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            
            //calloutView = ItemAnnotationView.instanceFromNib(annotation.title?, itemImage: nil)
            
        }
        
        if (self.isSelected && !calloutViewAdded) {
            // calloutView = ItemAnnotationView.instanceFromNib()
            
            addSubview(calloutView!)
        }
        
        if (!self.isSelected) {
            //  print("Should remove item annotation view now")
            calloutView?.removeFromSuperview()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, with: event)
        
        //  print("Hit Test")
        
        if let callout = calloutView {
            if (hitView == nil && self.isSelected) {
                hitView = callout.hitTest(point, with: event)
                
                //   print("Item Hit View selected")
            }
        }
        
        //  print("hitOutside Map Pin - nil? = \(hitOutside)")
        hitOutside = hitView == nil
        
        return hitView;
    }
}

class OtherCameraViewPin: MKAnnotationView {
    
    class var reuseIdentifier:String {
        return "OtherCameraViewPin"
    }
    
    open var isMission: Bool!
    
    fileprivate var calloutViewPlayer:PlayerAnnotationView?
    fileprivate var hitOutside:Bool = true
    
    open var attackUserName: String!
    open var attackUserID: String!
    open var attackUserLat: Double!
    open var attackUserLong: Double!
    open var attackUserHealth: String!
    //  public var itemID: String!
    //  public var amount: String!
    open var attackUserImage: UIImage!
    open var attackUserAlt: Double!
    
    
    open var PinType: String!
    
    ///
    fileprivate var calloutView:ItemAnnotationView?
    // private var hitOutside:Bool = true
    
    //GAME ITEM INFO-------
    open var itemName: String!
    open var itemType: String!
    open var itemLat: Double!
    open var itemLong: Double!
    open var itemCode: String!
    open var itemID: String!
    open var amount: String!
    open var itemImage: UIImage!
    
    
    open var category: String!
    open var count: String!
    open var level: String!
    open var health: String!
    open var stamina: String!
    open var ammoCount: String!
    open var speed: String!
    open var power: String!
    open var range: String!
    open var viewrange: String!
    
    
    //MISSION INFO--------
    open var missionTitle: String!
    open var missionObjective: String!
    open var missionLevel: String!
    open var missionXP: String!
    open var missionID: String!
    open var missionMapURL: String!
    open var missionObjectURL: String!
    
    //Attributes INFO------
    open var TotalPlayerAttributesTemp: TotalPlayerAttributes!
    
    //other stats info------
    open var killcount: String!
    open var killedcount: String!
    
    
    var preventDeselection:Bool {
        //  print("hitOutside Map Pin = \(hitOutside)")
        return !hitOutside
    }
    
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
        
        
        addHalo()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addHalo() {
        let pulsator = Pulsator()
        
        let theCenter = CGPoint(x: 25, y: 25)
        //pulsator.position = center
        pulsator.position = theCenter
        pulsator.numPulse = 2
        pulsator.radius = 40
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor.red.cgColor
        layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    
    
    
    func GetVariables(_ itemName: String, itemType: String, itemLat: String, itemLong: String, itemCode: String, itemID: String, amount: String) {
        
        //  print("Variables = ")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let calloutViewAdded = calloutView?.superview != nil
        
        //  print("hitOutside Map Pin - set selected = \(hitOutside)")
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        if (calloutView == nil) {
            
            // print("Should add item annotation view now")
            //calloutView = ItemAnnotationView.instanceFromNib(((annotation?.title)!)!)
            //calloutView = ItemAnnotationView.instanceFromNib()
            
            
            /*
             let bounds = UIScreen.mainScreen().bounds
             var Nib = UIView()
             // var itemTitle: String!
             // itemTitle = title
             
             let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
             Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
             // Nib.titleLBL.text = title
             //  self.setTitle(title)
             
             Nib.bounds = bounds
             
             calloutView =  Nib
             */
            
            print("PIN TYPE = \(self.PinType)")
            
            /*
             if 1 == 0 {
             
             calloutViewPlayer = PlayerAnnotationView.instanceFromNib(attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserHealth: self.attackUserHealth)
             } else {
             
             */
            
            // calloutView().setTitl
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, )
            
            
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth)
            
            
            
            calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, missionTitle: self.missionTitle , missionObjective: self.missionObjective, missionLevel: self.missionLevel, missionXP: self.missionXP, missionID: self.missionID, missionMapURL: self.missionMapURL, missionObjectURL: self.missionObjectURL, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: self.isMission, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, attackUserAlt: self.attackUserAlt)
            
            //    }
            // calloutView?.itemImageIMG = self.itemImage
            calloutView!.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            
            //calloutView = ItemAnnotationView.instanceFromNib(annotation.title?, itemImage: nil)
            
        }
        
        if (self.isSelected && !calloutViewAdded) {
            // calloutView = ItemAnnotationView.instanceFromNib()
            
            addSubview(calloutView!)
        }
        
        if (!self.isSelected) {
            //  print("Should remove item annotation view now")
            calloutView?.removeFromSuperview()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, with: event)
        
        //  print("Hit Test")
        
        if let callout = calloutView {
            if (hitView == nil && self.isSelected) {
                hitView = callout.hitTest(point, with: event)
                
                //   print("Item Hit View selected")
            }
        }
        
        //  print("hitOutside Map Pin - nil? = \(hitOutside)")
        hitOutside = hitView == nil
        
        return hitView;
    }
}

class HomePin: MKAnnotationView {
    
    class var reuseIdentifier:String {
        return "OtherCameraViewPin"
    }
    
    open var isMission: Bool!
    
    fileprivate var calloutViewPlayer:PlayerAnnotationView?
    fileprivate var hitOutside:Bool = true
    
    open var attackUserName: String!
    open var attackUserID: String!
    open var attackUserLat: Double!
    open var attackUserLong: Double!
    open var attackUserHealth: String!
    //  public var itemID: String!
    //  public var amount: String!
    open var attackUserImage: UIImage!
    open var attackUserAlt: Double!
    
    
    open var PinType: String!
    
    ///
    fileprivate var calloutView:ItemAnnotationView?
    // private var hitOutside:Bool = true
    
    //GAME ITEM INFO-------
    open var itemName: String!
    open var itemType: String!
    open var itemLat: Double!
    open var itemLong: Double!
    open var itemCode: String!
    open var itemID: String!
    open var amount: String!
    open var itemImage: UIImage!
    
    
    open var category: String!
    open var count: String!
    open var level: String!
    open var health: String!
    open var stamina: String!
    open var ammoCount: String!
    open var speed: String!
    open var power: String!
    open var range: String!
    open var viewrange: String!
    
    
    //MISSION INFO--------
    open var missionTitle: String!
    open var missionObjective: String!
    open var missionLevel: String!
    open var missionXP: String!
    open var missionID: String!
    open var missionMapURL: String!
    open var missionObjectURL: String!
    
    //Attributes INFO------
    open var TotalPlayerAttributesTemp: TotalPlayerAttributes!
    
    //other stats info------
    open var killcount: String!
    open var killedcount: String!
    
    
    var preventDeselection:Bool {
        //  print("hitOutside Map Pin = \(hitOutside)")
        return !hitOutside
    }
    
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = false
    
        
        addHalo()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addHalo() {
        let pulsator = Pulsator()
        
        let theCenter = CGPoint(x: 25, y: 25)
        //pulsator.position = center
        pulsator.position = theCenter
        pulsator.numPulse = 5
        pulsator.radius = 60
        pulsator.animationDuration = 3
       // pulsator.backgroundColor = UIColor.red.cgColor
        pulsator.backgroundColor = UIColor(red: 0.29803922, green: 0.068627451, blue: 0.31372549, alpha: 1.0).cgColor
        layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    
    
    
    func GetVariables(_ itemName: String, itemType: String, itemLat: String, itemLong: String, itemCode: String, itemID: String, amount: String) {
        
        //  print("Variables = ")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let calloutViewAdded = calloutView?.superview != nil
        
        //  print("hitOutside Map Pin - set selected = \(hitOutside)")
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        if (calloutView == nil) {
            
            // print("Should add item annotation view now")
            //calloutView = ItemAnnotationView.instanceFromNib(((annotation?.title)!)!)
            //calloutView = ItemAnnotationView.instanceFromNib()
            
            
            /*
             let bounds = UIScreen.mainScreen().bounds
             var Nib = UIView()
             // var itemTitle: String!
             // itemTitle = title
             
             let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
             Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
             // Nib.titleLBL.text = title
             //  self.setTitle(title)
             
             Nib.bounds = bounds
             
             calloutView =  Nib
             */
            
            print("PIN TYPE = \(self.PinType)")
            
            /*
             if 1 == 0 {
             
             calloutViewPlayer = PlayerAnnotationView.instanceFromNib(attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserHealth: self.attackUserHealth)
             } else {
             
             */
            
            // calloutView().setTitl
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, )
            
            
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth)
            
            
            
            calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount, PinType: self.PinType, attackUsername: self.attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserHealth: self.attackUserHealth, missionTitle: self.missionTitle , missionObjective: self.missionObjective, missionLevel: self.missionLevel, missionXP: self.missionXP, missionID: self.missionID, missionMapURL: self.missionMapURL, missionObjectURL: self.missionObjectURL, count: count, level: level, health: health, stamina: stamina, ammoCount: ammoCount, speed: speed, power: power, range: range, viewrange: viewrange, isMission: self.isMission, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, attackUserAlt: self.attackUserAlt)
            
            //    }
            // calloutView?.itemImageIMG = self.itemImage
            calloutView!.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            
            //calloutView = ItemAnnotationView.instanceFromNib(annotation.title?, itemImage: nil)
            
        }
        
        if (self.isSelected && !calloutViewAdded) {
            // calloutView = ItemAnnotationView.instanceFromNib()
            
            addSubview(calloutView!)
        }
        
        if (!self.isSelected) {
            //  print("Should remove item annotation view now")
            calloutView?.removeFromSuperview()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, with: event)
        
        //  print("Hit Test")
        
        if let callout = calloutView {
            if (hitView == nil && self.isSelected) {
                hitView = callout.hitTest(point, with: event)
                
                //   print("Item Hit View selected")
            }
        }
        
        //  print("hitOutside Map Pin - nil? = \(hitOutside)")
        hitOutside = hitView == nil
        
        return hitView;
    }
}

class MapPinPlayer: MKAnnotationView {
    class var reuseIdentifier:String {
        return "mapPinPlayer"
    }
    //private var calloutView:UIView?
    fileprivate var calloutViewPlayer:PlayerAnnotationView?
    fileprivate var hitOutside:Bool = true
    
    open var attackUserName: String!
    open var attackUserID: String!
    open var attackUserLat: Double!
    open var attackUserLong: Double!
    open var attackUserHealth: String!
  //  public var itemID: String!
  //  public var amount: String!
    open var attackUserImage: UIImage!
    open var attackUserAlt: Double!
    
    
    
    var preventDeselection:Bool {
       // print("hitOutside Map Pin Playe r= \(hitOutside)")
        return !hitOutside
    }
    
    
    
    
    convenience init(annotation:MKAnnotation!) {
        self.init(annotation: annotation, reuseIdentifier: MapPinPlayer.reuseIdentifier)
        
        canShowCallout = false;
    }
    
    func GetVariables(_ itemName: String, itemType: String, itemLat: String, itemLong: String, itemCode: String, itemID: String, amount: String) {
        
       // print("Variables = ")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let calloutViewAdded = calloutViewPlayer?.superview != nil
      //  print("hitOutside Map Pin Player - set selected = \(hitOutside)")
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        if (calloutViewPlayer == nil) {
            
         //   print("Should add item annotation view now")
            //calloutView = ItemAnnotationView.instanceFromNib(((annotation?.title)!)!)
            //calloutView = ItemAnnotationView.instanceFromNib()
            
            
            /*
             let bounds = UIScreen.mainScreen().bounds
             var Nib = UIView()
             // var itemTitle: String!
             // itemTitle = title
             
             let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
             Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
             // Nib.titleLBL.text = title
             //  self.setTitle(title)
             
             Nib.bounds = bounds
             
             calloutView =  Nib
             */
            
            
            
            // calloutView().setTitl
            // calloutView = ItemAnnotationView.instanceFromNib(itemName, itemImage: self.itemImage, )
            
           // calloutView = PlayerAnnotationView.instanceFromNib()
            
            
        //    print("call out view for player \(attackUserName)")
            
            calloutViewPlayer = PlayerAnnotationView.instanceFromNib(attackUserName, attackUserImage: self.attackUserImage, attackUserID: self.attackUserID, attackUserLat: self.attackUserLat, attackUserLong: self.attackUserLong, attackUserHealth: self.attackUserHealth, attackUserAlt: self.attackUserAlt)
            
            
            
            
            //itemName, itemImage: self.itemImage, itemType: self.itemType, itemLat: self.itemLat, itemLong: self.itemLong, itemCode: self.itemCode, itemID: self.itemID, amount: self.amount)
            
            // calloutView?.itemImageIMG = self.itemImage
            calloutViewPlayer!.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
            
            //calloutView = ItemAnnotationView.instanceFromNib(annotation.title?, itemImage: nil)
            
        }
        
        if (self.isSelected && !calloutViewAdded) {
            // calloutView = ItemAnnotationView.instanceFromNib()
            
            addSubview(calloutViewPlayer!)
        }
        
        if (!self.isSelected) {
         //   print("Should remove item annotation view now")
            calloutViewPlayer?.removeFromSuperview()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, with: event)
        
     //   print("Player Hit Test Started")
        
        if let callout = calloutViewPlayer {
            if (hitView == nil && self.isSelected) {
                hitView = callout.hitTest(point, with: event)
                  print("Player Hit View selected")
            }
        }
        
     //   print("hitOutside Map Pin Player - nil?= \(hitOutside)")
        hitOutside = hitView == nil
        
        return hitView;
    }
}




func animateMyViews(_ viewToHide: UIView, viewToShow: UIView) {
    let animationDuration = 0.35
    
    UIView.animate(withDuration: animationDuration, animations: { () -> Void in
        viewToHide.transform = viewToHide.transform.scaledBy(x: 0.001, y: 0.001)
    }, completion: { (completion) -> Void in
        
        viewToHide.isHidden = true
        viewToShow.isHidden = false
        
        viewToShow.transform = viewToShow.transform.scaledBy(x: 0.001, y: 0.001)
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            viewToShow.transform = CGAffineTransform.identity
        })
    }) 
}



class TeamInfoView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var isOpen = Bool()
    
    
    @IBOutlet weak var joinBTN: UIButton!
    
    @IBOutlet weak var teamNameLBL: UILabel!
    
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    var ThisTeamInfo: TeamInfo!
    
    var SearchItemLocation = CLLocationCoordinate2D()
    //var SearchItemLong = Double()
    var SearchItemName = String()
    var SearchItemImageName = String()
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        //hideBTN.layer.cornerRadius = 5
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        TableView.register(UINib(nibName: "MissedItemsCell", bundle: nil), forCellReuseIdentifier: "MissedCell")
        
        self.TableView.backgroundColor = UIColor.clear
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        self.joinBTN.layer.cornerRadius = 25
        self.joinBTN.layer.masksToBounds = true
        self.joinBTN.clipsToBounds = true
        
        self.teamNameLBL.text = ThisTeamInfo.teamname
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(_ ThisTeamInfoTemp: TeamInfo) -> TeamInfoView {
        let bounds = UIScreen.main.bounds
        var Nib = TeamInfoView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "TeamInfoView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TeamInfoView
        
        
        Nib.ThisTeamInfo = ThisTeamInfoTemp
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    /*
     
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return categories[section]
     }
     
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return categories.count
     }
     
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThisTeamInfo.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "MissedCell"
        
        var ItemSelected: String
        ItemSelected = ThisTeamInfo.members[indexPath.row]
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "MissedCell") as! MissedItemsCell
        
        
        //  let cell = tableView.dequeueReusableCellWithReuseIdentifier("MissedCell", forIndexPath: indexPath) as! MissedItemsCell
        
        cell.backgroundColor = UIColor.clear
        cell.BGView.layer.cornerRadius = 5
        cell.BGView.layer.masksToBounds = true
        cell.BGView.clipsToBounds = true
        
        
        
        cell.itemLBL.text = ItemSelected as! String
        cell.itemImage.isHidden = true
        cell.findItemBTN.isHidden = true
         /*
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(ItemSelected.imageName).png")
        let theImageData = try? Data(contentsOf: url)
        
        
        cell.itemImage.image = UIImage(data:theImageData!)!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.findItemBTN.tag = indexPath.row
        cell.findItemBTN.addTarget(self, action: #selector(MissedItemsView.LocateItemBTN(_:)), for: UIControl.Event.touchUpInside)
        
        */
        
        return cell
        
        
    }
    
    func LocateItemBTN (_ sender: AnyObject) {
        
        /*
        let row = sender.tag
        
        var ItemSelected: NearbyItem
        ItemSelected = ThisTeamInfo[row!]
        
        
        SearchItemName = ItemSelected.name
        SearchItemImageName = ItemSelected.imageName
        SearchItemLocation = ItemSelected.Location
        
        self.isHidden = true
        
        /*
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Coming Soon"
         alertView.message = "Will place on map item: \(SearchItemName) at Location: \(SearchItemLocation)"
         alertView.delegate = self
         alertView.addButton(withTitle: "OK")
         alertView.show()
         */
        
        let msgTitletemp = "Item Alert"
        let msgMSGtemp = "It may still be available...directions to this item?"
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowMessage"), object: nil, userInfo: ["msgTitle":"\(msgTitletemp)","msgMSG":"\(msgMSGtemp)","name":"\(SearchItemName)","lat":"\(SearchItemLocation.latitude)","long":"\(SearchItemLocation.longitude)"])
        
        */
        
    }
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    @IBAction func SendJoinRequest(_ sender: Any) {
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Request Sent"
        alertView.message = "Coming Soon."
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
         alertView.show()
        
    }
    
}

