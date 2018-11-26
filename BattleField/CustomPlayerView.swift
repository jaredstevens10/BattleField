//
//  CustomPlayerView.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/8/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation


import QuartzCore
import SceneKit

class MyPlayerView: UIView, SCNPhysicsContactDelegate, UIGestureRecognizerDelegate, SCNSceneRendererDelegate, UITableViewDelegate,  UITableViewDataSource {
    
    var theViewToPulse = UIView()
    var lastPulsingView = String()
    
     @IBOutlet weak var TableView: UITableView!
    
    
    var EyesComplete = Bool()
    var HairComplete = Bool()
    var BodyComplete = Bool()
    var SkillsComplete = Bool()
    var AttributesComplete = Bool()
    var AgentProfileComplete = Bool()
    
    
    var isViewingEyes = Bool()
    var isViewingHair = Bool()
    var isViewingBody = Bool()
    var isViewingEditBody = Bool()
    
    @IBOutlet weak var bodySubViewHolder: UIView!
    @IBOutlet weak var bodySubViewHolderBOTTOM: NSLayoutConstraint!
    
    
    @IBOutlet weak var bodyView1: UIView!
    @IBOutlet weak var bodyView2: UIView!
    
    @IBOutlet weak var bodyView3: UIView!
    
    @IBOutlet weak var attributesView: UIView!
    @IBOutlet weak var attributesViewLBL: UILabel!
    @IBOutlet weak var attributesViewIMG: UIImageView!
    //@IBOutlet weak var itemTimerView4: UIView!
    //@IBOutlet weak var item4TimerLBL: UILabel!
    @IBOutlet weak var attributesViewBTN: UIButton!
    
    @IBOutlet weak var availableAttributePointsLBL: UILabel!
    
    
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View2LBL: UILabel!
    @IBOutlet weak var View2IMG: UIImageView!
    //@IBOutlet weak var itemTimerView4: UIView!
    //@IBOutlet weak var item4TimerLBL: UILabel!
    @IBOutlet weak var View2BTN: UIButton!
    
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View3LBL: UILabel!
    @IBOutlet weak var View3IMG: UIImageView!
    @IBOutlet weak var View3BTN: UIButton!
    
    @IBOutlet weak var View4: UIView!
    @IBOutlet weak var View4LBL: UILabel!
    @IBOutlet weak var View4IMG: UIImageView!
    @IBOutlet weak var View4BTN: UIButton!
    
    @IBOutlet weak var View5: UIView!
    @IBOutlet weak var View5LBL: UILabel!
    @IBOutlet weak var View5IMG: UIImageView!
    @IBOutlet weak var View5BTN: UIButton!
    
    var showBlood = Bool()
    
    var EnemyHealth = Int()
    
    var EnemyMoveDirection = String()
    
    var contactDelegate: SCNPhysicsContactDelegate?
    var lookGesture: UIPanGestureRecognizer!
    var walkGesture: UIPanGestureRecognizer!
    var moveItemGesture: UIPanGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    var fireGesture: FireGestureRecognizer!
    var RotatePlayerGesture: UIPanGestureRecognizer!
    var pinchGesture: UIPinchGestureRecognizer!

    
    var currentAngleY: Float = 0.0
    var currentAngleX: Float = 0.0

    
    @IBOutlet weak var attackBTNLBL: UILabel!
    var attackBTNText = String()
    let EnemySpeed: CGFloat = 1.0
    
    @IBOutlet weak var gunTargetView: UIView!
    @IBOutlet weak var gunTargetImage: UIImageView!
    
    @IBOutlet weak var healthattackingView: UIView!
    
    @IBOutlet weak var usernameLBL: UILabel!
    
    @IBOutlet weak var healthProgressView: UIProgressView!
    
    
    
    @IBOutlet weak var gunTargetViewX: NSLayoutConstraint!
    @IBOutlet weak var gunTargetViewY: NSLayoutConstraint!
    
    @IBOutlet weak var closeBTN: UIButton!
    
    var CurrentHealthAmount = Int()
    
    var device = UIScreen.main.bounds
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var sceneHolder: SCNView!
    
    @IBOutlet weak var innerShootView: UIView!
    //@IBOutlet weak var itemsHitView: UIView!
    @IBOutlet weak var ShootView: UIView!
    
    var prefs:UserDefaults = UserDefaults.standard
    var buttonClicked = Bool()
    
    let attackScene = SCNScene(named: "MyPlayerScene.scn")!
    
    //var cameraNode = SCNNode()
    
    //let enemyScene = SCNScene(named: "animate.scnassets/Army_Man1.dae")
    
    //@IBOutlet weak var sceneHolder: UIView!
    
    @IBOutlet weak var viewHolder: UIView!
    
    
    //------------ SET UP ENEMY NODES
    var enemyEyeBrow = SCNNode()
    var enemyEyeLash = SCNNode()
    var enemyEyes = SCNNode()
    var enemySuit = SCNNode()
    var enemySkin = SCNNode()
    var enemyMuscle = SCNNode()
    var enemyShoes = SCNNode()
    var enemyHair = SCNNode()
    var enemyTeeth = SCNNode()
    var enemyTongue = SCNNode()
    
    var enemyHead = SCNNode()
    var enemyBody = SCNNode()
    var bodyPlane = SCNNode()
    
    var enemyRootNodeString = String()
    var enemyEyeBrowString = String()
    var enemyEyeLashString = String()
    var enemyEyesString = String()
    var enemySuitString = String()
    var enemyMuscleString = String()
    var enemyShoesString = String()
    var enemyHairString = String()
    var enemyTeethString = String()
    var enemyTongueString = String()
    
    var enemyEyeBrowTexture = String()
    var enemyEyeLashTexture = String()
    var enemyEyesTexture = String()
    var enemySuitTexture = String()
    var enemyMuscleTexture = String()
    var enemyShoesTexture = String()
    var enemyHairTexture = String()
    var enemyTeethTexture = String()
    var enemyTongueTexture = String()
    
    
    
    
    var heroNode = SCNNode()
    var heroHands = SCNNode()
    var heroHandRight = SCNNode()
    var heroWeapon = SCNNode()
    
    var enemyNode = SCNNode()
    var enemyRootNode = SCNNode()
    var HeroX = Float()
    var HeroY = Float()
    var HeroZ = Float()
    
    var HeroPosition = SCNVector3()
    var HeroRotation = SCNVector4()
    
    
    var Floor = SCNNode()
    var Sky = SCNNode()
    var Grass = SCNNode()
    var camNode = SCNNode()
    var camCamera = SCNCamera()
    var lastWidthRatio: Float = 0
    var lastHeightRatio: Float = 0.2
    var widthRatio: Float = 0
    var heightRatio: Float = 0.2
    var maxWidthRatioRight: Float = 0.2
    var maxWidthRatioLeft: Float = -0.2
    var maxHeightRatioXDown: Float = 0.02
    var maxHeightRatioXUp: Float = 0.4
    
    
    var Loc1 = SCNNode()
    var Loc2 = SCNNode()
    var Loc3 = SCNNode()
    var Loc4 = SCNNode()
    var Loc5 = SCNNode()
    
    var ActiveLocations = [SCNNode]()
    
    
    
    let autofireTapTimeThreshold = 0.2
    let maxRoundsPerSecond = 30
    let bulletRadius = 0.25
    let bulletImpulse = 50
    let grenadeImpulse = 15
    let maxBullets = 20
    var OutOfAmmo = Bool()
    
    var ammoRemaining = Int()
    var enemyHitCount = Int()
    
    var tapCount = 0
    var lastTappedFire: TimeInterval = 0
    var lastFired: TimeInterval = 0
    var bullets = [SCNNode]()
    
    var elevation: Float = 0
    
    var enemyWalkAnimation = CAAnimation()
    var enemyHitAnimation = CAAnimation()
    var enemyHitBellyAnimation = CAAnimation()
    var enemyFallAnimation = CAAnimation()
    var enemyDeadAnimation = CAAnimation()
    
    
    var HeroHandsRest = CAAnimation()
    var HeroHandsPunch = CAAnimation()
    
    var PlayingEnemySound = Bool()
    
    
    var currentWeapon = String()
    var skinTone = String()
    
    var targetNode = SCNNode()
    
    
    func ShowMessageView(title: String, message: String, reference: String){
        
//        let subViews = self.subviews
//        for subview in subViews{
//            if subview.tag == 1000 {
//                // self.CapturingTerritory = false
//                subview.removeFromSuperview()
//            }
//        }
        
        DispatchQueue.main.async(execute: {
            let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
            view.tag = 1000
            self.addSubview(view)
        })
        
    }
    
//}

    override func awakeFromNib() {
        
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        // UIDevice.current.setValue(value, forKey: "orientation")
        
        //  self.isUserInteractionEnabled = true
        
        
        /*
         buttonView.layer.cornerRadius = 40
         buttonView.clipsToBounds = true
         buttonView.layer.masksToBounds = true
         buttonView.layer.borderWidth = 1
         buttonView.layer.borderColor = UIColor.black.cgColor
         */
        
        bodySubViewHolder.tag = 900
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
        
        TableView.register(UINib(nibName: "EditBodyCell", bundle: nil), forCellReuseIdentifier: "EditBodyCell")
        
        
        
        self.TableView.backgroundColor = UIColor.clear
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        /*
         lookGesture = UIPanGestureRecognizer(target: self, action: #selector(self.lookGestureRecognized(_:)))
         lookGesture.delegate = self
         self.addGestureRecognizer(lookGesture)
         
         //walk gesture
         walkGesture = UIPanGestureRecognizer(target: self, action: #selector(self.walkGestureRecognized(_:)))
         walkGesture.delegate = self
         // self.addGestureRecognizer(walkGesture)
         
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         tapGesture.delegate = self
         self.sceneHolder.addGestureRecognizer(tapGesture)
         
         fireGesture = FireGestureRecognizer(target: self, action: #selector(self.fireGestureRecognized(_:)))
         fireGesture.delegate = self
         */
        
        //   self.SetUpScene()
        //  NotificationCenter.default.addObserver(self, selector: #selector(self.UpdateAttackingHealth(_:)), name: NSNotification.Name(rawValue: "UpdateAttackingHealth"),  object: nil)
        
        //  self.healthProgressView.setProgress(1, animated: true)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.UpdateEditBodyLayout(_:)), name: NSNotification.Name(rawValue: "UpdateEditBodyLayout"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.UpdatePulsing(_:)), name: NSNotification.Name(rawValue: "UpdatePulsing"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ShowNewMessageView(_:)), name: NSNotification.Name(rawValue: "ShowNewMessageView"),  object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.UpdateGestureRecognizers(_:)), name: NSNotification.Name(rawValue: "UpdateGestureRecognizers"),  object: nil)
        
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            
           let fullname =  prefs.value(forKey: "FULLNAME") as! String
            
            self.ShowMessageView(title: "Hello", message: "So...\(fullname) you think you have what it takes?  We'll see...let's start by completing your profile", reference: "eyes")
            
           
            
        }
        
        var attPointDouble = Double()
        
        if prefs.double(forKey: "MyAttributePoints") != nil {
        attPointDouble = prefs.double(forKey: "MyAttributePoints")
        } else {
            attPointDouble = 10.0
            prefs.set(10.0, forKey: "MyAttributePoints")
        }
        
        let attPointCount = Int(attPointDouble)
        
        availableAttributePointsLBL.text = attPointCount.description
        
        if attPointCount == 0 {
            availableAttributePointsLBL.isHidden = true
        } else {
            availableAttributePointsLBL.isHidden = false
        }
        
        
        
       
        
        
        
        
    }
    
    
    @IBAction func hideEditBTN(_ sender: Any) {
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            
        switch lastPulsingView {
            
            case "eyes":
                theViewToPulse = bodyView2
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            
            case "hair":
                theViewToPulse = bodyView3
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            case "body":
                theViewToPulse = attributesView
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            case "attributes":
                theViewToPulse = View4
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            case "skills":
                theViewToPulse = View2
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            case "armor":
                theViewToPulse = View3
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 5)
            
        default:
            break
        }
            
          //  self.ShowMessageView(title: "Hello", message: "So...\(fullname) you think you have what it takes?  We'll see...let's start by completing your profile", reference: "na")
            
        }
        
        prefs.set(true, forKey: "NewAgentBodyComplete")
        
        self.isViewingHair = false
        self.isViewingEyes = false
        self.isViewingBody = false
        self.isViewingEditBody = false
        let animationDuration = 0.35
        
        //self.prefs.set(value: "body", forKey: "EditCharacterInfo")
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.bodySubViewHolder.center.y = self.bodySubViewHolder.center.y + 500
            self.bodySubViewHolderBOTTOM.constant = 500
            
        })
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
        
    }
    
    func UpdateGestureRecognizers(_ notification: Notification) {
        
     self.RotatePlayerGesture.isEnabled = true
    }
    
    func ShowNewMessageView(_ notification: Notification) {
        
        
        print("SHOWING NEW MESSAGE VIEW NOTIFICATION")
        
        var info = notification.userInfo
        let ViewToPulse = info!["ViewToPulse"] as! String
        
        var message = String()
        var title = String()
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            
            switch ViewToPulse {
                
            case "eyes":
               message = "Update your eye color"
                title = "Eyes"
            case "hair":
                message = "Update your hair color"
                title = "Hair"
            case "body":
                message = "Update your body type"
                title = "Body"
            case "attributes":
                message = "Review and update your attribute points"
                title = "Attributes"
            case "skills":
                message = "Review your current skills"
                title = "Skills"
            case "armor":
                message = "Review your current armor"
                title = "Armor"
                
            case "weapon":
                message = "Review your current weapons"
                title = "Weapons"
                

            default:
                break
            }
            
            
            self.ShowMessageView(title: "\(title)", message: "\(message)", reference: "\(ViewToPulse)")
            
            // NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"true"])
            
            
        }
        
    }
    
    
    
    func UpdatePulsing(_ notification: Notification) {
        
        print("UPDATING PULSE VIEW NOTIFICATION")
        
        var info = notification.userInfo
        let lastPulsingViewTemp = info!["lastPulsingView"] as! String
        
        
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            
            switch lastPulsingViewTemp {
                
        
                
                case "eyes":
                theViewToPulse = bodyView2
                
//                self.ShowMessageView(title: "Hello", message: "you think you have what it takes?  We'll see...let's start by completing your profile", reference: "hair")
                
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
            case "hair":
                theViewToPulse = bodyView3
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
            case "body":
                theViewToPulse = attributesView
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
            case "attributes":
                theViewToPulse = View4
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
            case "skills":
                theViewToPulse = View2
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
            case "armor":
                theViewToPulse = View3
                View2.layer.removeAllAnimations()
                pulseView(theView: theViewToPulse)
                shakeView(theViewToPulse, repeatCount: 7)
                
            case "weapon":
                View3.layer.removeAllAnimations()
                AgentProfileComplete = true
                
                
//            case "eyes":
//                theViewToPulse = bodyView1
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//                
//            case "hair":
//                theViewToPulse = bodyView2
//                
//                //                self.ShowMessageView(title: "Hello", message: "you think you have what it takes?  We'll see...let's start by completing your profile", reference: "hair")
//                
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//            case "body":
//                theViewToPulse = bodyView3
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//            case "attributes":
//                theViewToPulse = attributesView
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//            case "skills":
//                theViewToPulse = View4
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//            case "armor":
//                theViewToPulse = View2
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
//            case "weapon":
//                theViewToPulse = View3
//                View2.layer.removeAllAnimations()
//                pulseView(theView: theViewToPulse)
//                shakeView(theViewToPulse, repeatCount: 7)
                
//            case "weapon":
//                View3.layer.removeAllAnimations()
//                AgentProfileComplete = true
                
                
                //NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"true"])
            
                
            default:
                break
            }
        }
        
    }
    
    
    func UpdateEditBodyLayout(_ notification: Notification){
    
        
        self.isViewingHair = false
        self.isViewingEyes = false
        self.isViewingBody = false
        self.isViewingEditBody = false
        let animationDuration = 0.35
        
        //self.prefs.set(value: "body", forKey: "EditCharacterInfo")
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.bodySubViewHolder.center.y = self.bodySubViewHolder.center.y + 500
            self.bodySubViewHolderBOTTOM.constant = 500
            
        })

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "EditBodyCell"
        let identifier1 = "CellTwo"
        let identifier2 = "CellThree"
        let identifier3 = "CellFour"
        
        print("TABLEVIEW INDEX = \(indexPath.row)")
        
        let section = indexPath.section
        print("Section = \(section)")
      
            
            
           // print("SHOULD GET CELL TYPE 1")
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(identifier0)") as! EditBodyCell
        
            //cell.BodyC
        
            cell.backgroundColor = UIColor.clear
           // return cell
            
       
        
        
        //let cell = UITableViewCell()
        return cell
        
    }
    
    
    
//    func UpdateAttackingHealth(_ notification:Notification) {
//        
//        // MoneyChangeCount = 0
//        
//        let userInfo = notification.userInfo
//        //  print("Money UserInfo = \(userInfo)")
//        
//        let previousAmountTemp = userInfo!["previousAmount"] as! String
//        let previousAmount = Int(previousAmountTemp)
//        let newAmountTemp = userInfo!["newAmount"] as! String
//        let settingTemp = userInfo!["setting"] as! String
//        
//        var newAmount = Int()
//        //   print("Update Money New Amount?: \(newAmount)")
//        let differenceAmount = newAmount - previousAmount!
//        
//        
//        // print("UPDATE MONEY TYPE = \(settingTemp)")
//        
//        let seconds = 2.0
//        let secondsLoad = 2.0
//        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
//        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
//        
//        
//        if settingTemp == "add" {
//            //self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
//            newAmount = Int(newAmountTemp)! + previousAmount!
//        } else {
//            //self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
//            newAmount = Int(newAmountTemp)! - previousAmount!
//        }
//        
//        
//        let newAmountDouble = Double(newAmount)
//        let tc = Double(100)
//        
//        let tempP = newAmountDouble / tc
//        
//        // let hitprogress = Float(tempP)
//        
//        
//        let newAmountProgress = Float(tempP)
//        
//        DispatchQueue.main.async(execute: {
//            //print("generating Map now")
//            self.healthProgressView.setProgress(newAmountProgress, animated: true)
//            
//            self.healthattackingView.isHidden = true
//            self.enemyNode.removeAnimation(forKey: "enemyHit")
//            //self.GenerateMap(EditedImage)
//        })
//        //  self.healthProgressView.setProgress(newAmountProgress, animated: true)
//        // self.healthProgressView.progress = newAmountProgress
//        let animationDuration = 0.5
//        
//        
//        
//        //   healthTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(MapViewController.HealthUpdateTimer(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmountTemp)","setting":"\(settingTemp)"], repeats: true)
//        
//        
//    }
    
    
    override func willRemoveSubview(_ subview: UIView) {
        
        if subview.gestureRecognizers != nil {
            for gesture in subview.gestureRecognizers! {
                if let recognizer = gesture as? UISwipeGestureRecognizer {
                    subview.removeGestureRecognizer(recognizer)
                }
                
                if let recognizer = gesture as? UIPanGestureRecognizer {
                //subview.removeGestureRecognizer(recognizer)
                }
                if let recognizer = gesture as? UITapGestureRecognizer {
                   // subview.removeGestureRecognizer(recognizer)
                }
            }
        }
        
        
    }
    
    func ClearGestures(subview: UIView) {
        
        if subview.gestureRecognizers != nil {
            for gesture in subview.gestureRecognizers! {
                if let recognizer = gesture as? UISwipeGestureRecognizer {
                    subview.removeGestureRecognizer(recognizer)
                }
                
                if let recognizer = gesture as? UIPanGestureRecognizer {
                    subview.removeGestureRecognizer(recognizer)
                }
                if let recognizer = gesture as? UITapGestureRecognizer {
                    subview.removeGestureRecognizer(recognizer)
                }
            }
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //abilitiesLayoutView.isHidden = true
        self.frame = bounds
        
        self.bodySubViewHolderBOTTOM.constant = 500
        
        //print("Device bounds = \(device)")
        
        switch currentWeapon {
        case "Fist":
            attackBTNLBL.text = "Punch"
        case "Gun":
            attackBTNLBL.text = "Fire"
        case "Knife":
            attackBTNLBL.text = "Attack"
            
            
        default:
            attackBTNLBL.text = "Attack"
            
        }
        
        attributesView.layer.cornerRadius = 40
        attributesView.clipsToBounds = true
        attributesView.layer.masksToBounds = true
        attributesView.layer.borderWidth = 1
        
        availableAttributePointsLBL.layer.cornerRadius = 10
        availableAttributePointsLBL.clipsToBounds = true
        availableAttributePointsLBL.layer.masksToBounds = true
        
        View2.layer.cornerRadius = 40
        View2.clipsToBounds = true
        View2.layer.masksToBounds = true
        View2.layer.borderWidth = 1
        
        View3.layer.cornerRadius = 40
        View3.clipsToBounds = true
        View3.layer.masksToBounds = true
        View3.layer.borderWidth = 1
        
        
//        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
//        
//        if (isLoggedIn != 1) {
//            View3.isHidden = true
//            View2.isHidden = true
//        }
        
        View4.layer.cornerRadius = 40
        View4.clipsToBounds = true
        View4.layer.masksToBounds = true
        View4.layer.borderWidth = 1
        
        View5.layer.cornerRadius = 40
        View5.clipsToBounds = true
        View5.layer.masksToBounds = true
        View5.layer.borderWidth = 1
        
        bodyView1.layer.cornerRadius = 25
        bodyView1.clipsToBounds = true
        bodyView1.layer.masksToBounds = true
        bodyView1.layer.borderWidth = 1
        
        bodyView2.layer.cornerRadius = 25
        bodyView2.clipsToBounds = true
        bodyView2.layer.masksToBounds = true
        bodyView2.layer.borderWidth = 1
        
        bodyView3.layer.cornerRadius = 25
        bodyView3.clipsToBounds = true
        bodyView3.layer.masksToBounds = true
        bodyView3.layer.borderWidth = 1
        
        ShootView.layer.cornerRadius = 25
        ShootView.layer.borderColor = UIColor.blue.cgColor
        ShootView.layer.borderWidth = 1
//
//        closeBTN.layer.cornerRadius = 15
//        closeBTN.layer.masksToBounds = true
//        closeBTN.clipsToBounds = true
//        
        innerShootView.layer.cornerRadius = 20
        innerShootView.layer.backgroundColor = UIColor.blue.cgColor
        
        
        lookGesture = UIPanGestureRecognizer(target: self, action: #selector(self.lookGestureRecognized(_:)))
        lookGesture.delegate = self
        //self.addGestureRecognizer(lookGesture)
        
        //walk gesture
        walkGesture = UIPanGestureRecognizer(target: self, action: #selector(self.walkGestureRecognized(_:)))
        walkGesture.delegate = self
        // self.addGestureRecognizer(walkGesture)
        
        RotatePlayerGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognized(_:)))
        RotatePlayerGesture.delegate = self
        self.addGestureRecognizer(RotatePlayerGesture)
        //panGestureRecognized
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture(_:)))
        pinchGesture.delegate = self
        self.addGestureRecognizer(pinchGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapGesture.delegate = self
        self.sceneHolder.addGestureRecognizer(tapGesture)
        
        fireGesture = FireGestureRecognizer(target: self, action: #selector(self.fireGestureRecognized(_:)))
        fireGesture.delegate = self
        
        
        
        
        
        self.SetUpScene()
        
        // self.lookGesture.isEnabled = false
        // self.walkGesture.isEnabled = false
        
        let seconds = 0.1
        let secondsLoad = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeNext = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                
                //   self.buttonView.center.y = self.buttonView.center.y + (self.device.height / 2)
                
                let moveY = (self.device.height / 2)
                // self.buttonViewW.constant = 100
                // self.buttonViewH.constant = 100
                
                //self.ScaleViewSize(self.buttonView, scale: 2.0, moveX: 0, moveY: moveY)
                
                let toY = (self.device.height / 2)
                let toX = (self.device.width / 4)
                
                
                
                /*
                 self.buttonView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                 self.buttonView.transform = CGAffineTransform(translationX: 0, y: toY)
                 
                 self.buttonViewW.constant = 100
                 self.buttonViewH.constant = 100
                 self.buttonView.layer.cornerRadius = 50
                 */
                
                
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
                
                // self.expandView()
                
            })
            
        })
        
        //  ClearGestures(subview: self)
        self.healthProgressView.setProgress(1, animated: true)
        
        self.enemyNode.addAnimation(enemyWalkAnimation, forKey: "walk")
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
        
        
        
        
        
        
        
        
    }
    @IBAction func attributeBTN(_ sender: Any) {
        
        RotatePlayerGesture.isEnabled = false
        
        var PlayerAttributesInfo: TotalPlayerAttributes?
            //= TotalPlayerAttributes(Awareness: prefs.Double(forKey: "MyAttributeAwarness"), )
       // PlayerAttributesInfo = TotalPlayerAttributes(Awareness: 5.0, Charisma: 5.0, Credibility: 5.0, Endurance: 5.0, Intelligence: 5.0, Speed: 5.0, Strength: 5.0, Vision: 5.0)
        
        PlayerAttributesInfo = TotalPlayerAttributes(Awareness: prefs.double(forKey: "MyAttributeAwareness"), Charisma: prefs.double(forKey: "MyAttributeCharisma"), Credibility: prefs.double(forKey: "MyAttributeCredibility"), Endurance: prefs.double(forKey: "MyAttributeEndurance"), Intelligence: prefs.double(forKey: "MyAttributeIntelligence"), Speed: prefs.double(forKey: "MyAttributeSpeed"), Strength: prefs.double(forKey: "MyAttributeStrength"), Vision: prefs.double(forKey: "MyAttributeVision"))
        
        DispatchQueue.main.async(execute: {
            
            
            let subViews = self.subviews
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
                self.addSubview(view)
                
            })
            
        })
        
    }
    
    
    @IBAction func viewSkillsBTN(_ sender: Any) {
        
       
        RotatePlayerGesture.isEnabled = false
        
        let subViews = self.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                // self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = SkillsView.instanceFromNib(title: "test")
            view.tag = 1000
            self.addSubview(view)
        })
        
        
    }
    
    
    @IBAction func viewArmorBTN(_ sender: Any) {
        
        
        RotatePlayerGesture.isEnabled = false
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            
            
            let title = "CLASSIFIED"
            let message = "All Information on Armor specifications is CLASSIFIED for non-Agents.  You will be give access once you enlist."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            
            
        } else {
        
        
        
        
        let subViews = self.subviews
        for subview in subViews{
            if subview.tag == 1000 {
               // self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = ArmorMenu.instanceFromNib()
            view.tag = 1000
            self.addSubview(view)
        })
        
    }
    }
    
    @IBAction func viewWeaponBTN(_ sender: Any) {
        
        
        RotatePlayerGesture.isEnabled = false
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            
            
            
            
            
            let title = "CLASSIFIED"
            let message = "All Information on Weapon specifications is CLASSIFIED for non-Agents.  You will be give access once you enlist."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            
            
            
        } else {
        
        let subViews = self.subviews
        for subview in subViews{
            if subview.tag == 1000 {
               // self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            let view = WeaponMenu.instanceFromNib()
            view.tag = 1000
            self.addSubview(view)
         })
        }
        
    }
    
    @IBAction func miscItemsBTN(_ sender: Any) {
        
        RotatePlayerGesture.isEnabled = false
        
        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            
            
            
            
            
            let title = "CLASSIFIED"
            let message = "All Information on Agent item specifications is CLASSIFIED for non-Agents.  You will be give access once you enlist."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            
            
            
        } else {
            
            let subViews = self.subviews
            for subview in subViews{
                if subview.tag == 1000 {
                    // self.CapturingTerritory = false
                    subview.removeFromSuperview()
                }
            }
            
            DispatchQueue.main.async(execute: {
                let view = MiscItemsMenu.instanceFromNib()
                view.tag = 1000
                self.addSubview(view)
            })
        }
        
    }
    
    //func LoadAttackItems(weaponName: String) {
    func LoadAttackItems(weaponName: String) -> SCNScene {
        
        
        var TempScene = SCNScene()
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(weaponName).dae")
        
        //let theImageData = try? Data(contentsOf: url)
        
        print("TempSCene: \(url)")
        TempScene = try! SCNScene(url: url, options: nil)
        
        //   TempScene = SCNScene(named: "\(url)")!
        // let url = NSURL.fileURLWithPath(path)
        //let ItemImage = UIImage(data: theImageData!)
        
        return TempScene
    }
    
    func LoadWeaponImage(weaponName: String) -> UIImage {
        
        
        var TempImage = UIImage()
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(weaponName).png")
        
        let theImageData = try? Data(contentsOf: url)
        
        TempImage = UIImage(data: theImageData!)!
        
        return TempImage
    }
    
    func pinchGesture(_ gesture: UIPinchGestureRecognizer) {
        let zoom = gesture.scale
//        var z = camNode.position.z  * Float(1.0 / zoom)
////        z = fmaxf(zoomLimits.min, z)
////        z = fminf(zoomLimits.max, z)
//        z = fmaxf(1.0, z)
//        z = fminf(4.0, z)
//        
//        camNode.position.z = z
        
        print("Zoom amount: \(zoom)")
        
        let cam = camNode.camera
        cam!.xFov = cam!.xFov -  Double(Float( 1.0 / zoom))
        cam!.yFov = cam!.yFov - Double(Float( 1.0 / zoom))
        
        print("should move camera")
        
        
       // let cam = camNode.camera
//        // self.attackScene.pointoFView!.camera.xFov = camCamera.xFov - 100
//        // camCamera.xFov = camCamera.xFov - 100
//        //camCamera.yFov = camCamera.yFov - 100
//
//        cam!.zNear = cam!.zNear * Double(1.0 / zoom)
        self.sceneHolder.pointOfView!.camera?.xFov = cam!.xFov - 100
        
        //  let cam = self.sceneHolder.scene.camera
       // cam!.xFov = cam!.xFov - 100
       // cam!.yFov = cam!.yFov - 100
        
        
    }
    
    
    func panGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        
        
        
        //let translation = gesture.translation(in: self.view)
        let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
        let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        
        
        //rotate hero
       // enemyNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: hAngle), asImpulse: true)
       // enemyNode.rotation.y = hAngle
        
        
        var newAngleX = (Float)(translation.y)*(Float)(M_PI)/180.0
        newAngleX += currentAngleX
        var newAngleY = (Float)(translation.x)*(Float)(M_PI_2)/180.0
        newAngleY += currentAngleY
        
        //enemyNode.eulerAngles.x = newAngleX
        enemyNode.eulerAngles.y = newAngleY
        
        if(gesture.state == UIGestureRecognizerState.ended) {
            currentAngleX = newAngleX
            currentAngleY = newAngleY
        }
        
    }
    
    func SetUpScene() {
        print("SETTING UP SCENE")
        //-------------------------
        //let scene = SCNScene(named: "art.scnassets/CampusField1.dae")!
        //let scene = attackScene
        
        var FenceNodes = [SCNNode]()
        var GrassNodes = [SCNNode]()
        
        // let src = SCNSceneSource(URL: yourSceneURL, options: nil)
        // let node = src.entryWithIdentifier("Bob", withClass: SCNNode.self) as SCNNode
        // let animation = node.entryWithIdentifier("yourAnimationID", withClass: CAAnimation.self) as CAAnimation
        //--------------------------
        
        let scene = SCNScene(named: "MyPlayerScene.scn")!
        
        // heroNode = attackSceneTemp.rootNode.childNode(withName: "hero", recursively: true)!
        
        //var heroNode = SCNNode()
        
        
        //-----------------
        
//        self.heroNode = scene.rootNode.childNode(withName: "hero", recursively: true)!
//        
//        heroNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNCylinder(radius: 0.2, height: 3.7), options: nil))
//        heroNode.physicsBody?.isAffectedByGravity = false
//        heroNode.physicsBody?.angularDamping = 0.9999999
//        heroNode.physicsBody?.damping = 0.9999999
//        heroNode.physicsBody?.rollingFriction = 0
//        heroNode.physicsBody?.friction = 0
//        heroNode.physicsBody?.restitution = 0
//        //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
//        heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
//        heroNode.physicsBody?.categoryBitMask = CollisionCategory.Hero
//        heroNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet
//        if #available(iOS 9.0, *) {
//            heroNode.physicsBody?.contactTestBitMask = ~0
//        }
//        
//        
//        heroNode.position = SCNVector3(x: 0, y: 3.0, z: 0)
//        
//        
//        let heroHandsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")
        
        //-----------------
        
        var BodyGeometryNode = SCNNode()
        
        /*
         if let filePath = Bundle.main.path(forResource: "Army_Man1", ofType: "dae", inDirectory: "animate.scnassets") {
         // ReferenceNode path -> ReferenceNode URL
         let referenceURL = NSURL(fileURLWithPath: filePath)
         
         if #available(iOS 9.0, *) {
         print("Loading SCNReferenceNode")
         // Create reference node
         let referenceNode = SCNReferenceNode(url: referenceURL as URL)
         referenceNode?.load()
         
         //let MainNode = referenceNode.entrey
         print("referenceNode Name: \(referenceNode?.name)")
         for child in (referenceNode?.childNodes)! {
         print("Child Name: \(child.name)")
         for child2 in child.childNodes {
         print("Child2 Name: \(child2.name)")
         if child2.name == "Armature" {
         //scene.rootNode.addChildNode(child2)
         enemyNode = child2
         
         // child2.position = SCNVector3(x: 0, y: 1, z: -3)
         // child2.scale = SCNVector3(x: 3, y: 3, z: 3)
         }
         if child2.name == "MDL_Obj" {
         //  EnemyGeometryTest = child2
         }
         }
         }
         // referenceNode?.position = SCNVector3(x: 0, y: 1, z: -3)
         // referenceNode?.scale = SCNVector3(x: 3, y: 3, z: 3)
         // scene.rootNode.addChildNode(referenceNode!)
         }
         }
         
         */
        
        
        //-----------------
        
        
        
        // let enemyScene = SCNScene(named: "Army_Man_Rest.dae")
        // let enemyScene = SCNScene(named: "animate.scnassets/Army_Man1.dae")
        //let enemyScene = SCNScene(named: "animate.scnassets/Army_Man1.dae")
        
        //let enemyScene = SCNScene(named: "animate.scnassets/Man_White3.dae")
        let enemyScene = SCNScene(named: "animate.scnassets/Man_Rest20.dae")
        
        
        //var EnemyNodeTest = (enemyScene?.rootNode.childNode(withName: "Armature", recursively: true))!
        // enemyNode = (enemyScene?.rootNode.childNode(withName: "Armature", recursively: true))!
        // EnemyGeometryTest = (enemyScene?.rootNode.childNode(withName: "MDL_Obj", recursively: true))!
        
        // EnemyGeometryTest = (enemyScene?.rootNode.childNode(withName: "male_white-male_casualsuit06", recursively: true))!
        
        
        let material = SCNMaterial()
        // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
        material.diffuse.contents = UIImage(named: "animate.scnassets/middleage_lightskinned_male_diffuse.png")
        
        
        
        enemyHead = (enemyScene?.rootNode.childNode(withName: "head", recursively: true))!
        enemyBody = (enemyScene?.rootNode.childNode(withName: "spine02", recursively: true))!
        
        var BodyGeometry = SCNGeometry()
        
        
        
        for enemyChild in enemyRootNode.childNodes {
            
            for c in enemyChild.childNodes {
                c.removeFromParentNode()
            }
            
            enemyChild.removeFromParentNode()
        }
        
        for enemyC in enemyNode.childNodes {
            enemyC.removeFromParentNode()
        }
        
        //enemyRootNode.addChildNode((enemyScene?.rootNode)!)
        
        
        
        for nodes in (enemyScene?.rootNode.childNodes)! {
            
            
            switch nodes.name {
            case "Armature"?:
                print("armature")
                
                
            case "\(enemyRootNodeString)"?:
                enemyNode = nodes
                
                
                
                for nodes2 in nodes.childNodes {
                    //   print("nodes2 name: \(nodes2.name)")
                }
                
                
                
            case "\(enemyShoesString)"?:
                print("Shoes found")
                //   print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyShoesTexture).png")
                
                enemyRootNode.addChildNode(nodes)
                
                
                
                
            case "\(enemyMuscleString)"?:
                //case "male_white-male_muscle_13290"?:
                print("Skin found")
                print("GEOMETRY: \(nodes.geometry)")
                
                //  BodyGeometryNode = nodes
                BodyGeometry = nodes.geometry!
                //enemyNode.geometry?.materials.first =
                // enemyNode.addChildNode(nodes)
                
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyMuscleTexture).png")
                
                
                BodyGeometry = nodes.geometry!
                // nodes.addChildNode(bodyPlane)
                
                
                enemyRootNode.addChildNode(nodes)
                //enemyRootNode.addChildNode(enemySkin)
                //enemyNode.addChildNode(nodes)
                
            case "\(enemySuitString)"?:
                //case "male_white-male_casualsuit06"?:
                
                print("casual suit found")
                
                
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemySuitTexture).png")
                
                
                enemyRootNode.addChildNode(nodes)
                // enemyNode.addChildNode(EnemyGeometryTest)
                
            case "\(enemyHairString)"?:
                print("Hair found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyHairTexture).png")
                
                
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyTeethString)"?:
                print("teeth found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyTeethTexture).png")
                
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyTongueString)"?:
                print("tongue found")
                // print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyTongueTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyeBrowString)"?:
                print("tongue found")
                //    print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyEyeBrowTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyeLashString)"?:
                print("tongue found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyEyeLashTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyesString)"?:
                print("tongue found")
                //   print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyEyesTexture).png")
                enemyRootNode.addChildNode(nodes)
                
                
                
            case "MDL_Obj"?:
                print("test")
            case "Default_Camera"?:
                print("\(nodes.name)")
            case "Lamp"?:
                print("\(nodes.name)")
            case "Camera"?:
                print("\(nodes.name)")
            case "Infinite_Light_1"?:
                print("\(nodes.name)")
            case "Image_Based_Light_1"?:
                print("\(nodes.name)")
                
            default:
                print("Adding \(nodes.name) by default")
                //enemyRootNode.addChildNode(nodes)
            }
            /*
             if nodes.name == "Armature" {
             enemyNode = nodes
             } else {
             
             enemyRootNode.addChildNode(nodes)
             }
             */
        }
        
        
        
        
        
        
        let bodyGeom = SCNPlane(width: 0.3, height: 1)
        bodyPlane = SCNNode(geometry: bodyGeom)
        
        bodyPlane.rotation = SCNVector4(0,4,4,M_PI)
        bodyPlane.physicsBody = SCNPhysicsBody.kinematic()
       // bodyGeom.firstMaterial?.diffuse.contents = UIColor.red
        bodyPlane.opacity = CGFloat(0)
        bodyPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: bodyPlane.geometry!, options: nil))
        
        bodyPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        bodyPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            bodyPlane.physicsBody?.contactTestBitMask = ~0
        }
        bodyPlane.name = "bodyPlane"
        
        
        
        
        enemyBody.physicsBody?.angularDamping = 0.9999999
        enemyBody.physicsBody?.damping = 0.9999999
        enemyBody.physicsBody?.rollingFriction = 0
        enemyBody.physicsBody?.friction = 0
        enemyBody.physicsBody?.restitution = 0
        enemyBody.physicsBody?.velocityFactor = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        enemyBody.name = "enemyHead"
        enemyBody.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        enemyBody.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyBody.physicsBody?.contactTestBitMask = ~0
        }
        
        
        enemyBody.addChildNode(bodyPlane)
        
        
        
        
        let headGeom = SCNSphere(radius: 0.01)
        let headPlane = SCNNode(geometry: headGeom)
        
        //bodyPlane.rotation = SCNVector4(1,0,2,M_PI)
        // headPlane.physicsBody = SCNPhysicsBody.dynamic()
        headPlane.physicsBody = SCNPhysicsBody.kinematic()
        headGeom.firstMaterial?.diffuse.contents = UIColor.red
        // headPlane.opacity = CGFloat(0)
        headPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: headPlane.geometry!, options: nil))
        //        headPlane.physicsBody?.angularDamping = 0.9999999
        //        headPlane.physicsBody?.damping = 0.9999999
        //        headPlane.physicsBody?.rollingFriction = 0
        //        headPlane.physicsBody?.friction = 0
        //        headPlane.physicsBody?.restitution = 0
        //        headPlane.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        headPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        headPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            headPlane.physicsBody?.contactTestBitMask = ~0
        }
        headPlane.name = "headPlane"
        
        
        // enemyHead.physicsBody = SCNPhysicsBody.kinematic()
        // enemyHead.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: headPlane.geometry!, options: nil))
        
        
        enemyHead.physicsBody?.angularDamping = 0.9999999
        enemyHead.physicsBody?.damping = 0.9999999
        enemyHead.physicsBody?.rollingFriction = 0
        enemyHead.physicsBody?.friction = 0
        enemyHead.physicsBody?.restitution = 0
        enemyHead.physicsBody?.velocityFactor = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        enemyHead.name = "enemyHead"
        enemyHead.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        enemyHead.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyHead.physicsBody?.contactTestBitMask = ~0
        }
        
        
        
        enemyHead.addChildNode(headPlane)
        
        
        
        
        
        
        let cnode = SCNCylinder(radius: 0.5, height: 4.0)
        //enemyNode.geometry? = cnode
        enemyNode.geometry = BodyGeometryNode.geometry
        // enemyNode.physicsBody = SCNPhysicsBody.kinematic()
        //enemyNode.physicsBody = SCNPhysicsBody.kinematic()
        
        enemyNode.geometry?.firstMaterial = material
        
        // BodyGeometryNode.scale = SCNVector3(x: 0.15, y: 0.15, z: 0.15)
        enemyNode.physicsBody? = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: BodyGeometryNode.geometry!, options: nil))
        // enemyNode.physicsBody? = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: BodyGeometryNode.geometry!, options: nil))
        
        
        enemyNode.physicsBody?.angularDamping = 0.9999999
        enemyNode.physicsBody?.damping = 0.9999999
        enemyNode.physicsBody?.rollingFriction = 0
        enemyNode.physicsBody?.friction = 0
        enemyNode.physicsBody?.restitution = 0
        //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
        enemyNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        // enemyNode.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        // enemyNode.physicsBody?.collisionBitMask = CollisionCategory.All
        //^ CollisionCategory.Bullet
        enemyNode.name = "Player Node"
        if #available(iOS 9.0, *) {
            enemyNode.physicsBody?.contactTestBitMask = ~0
        }
        //        print("Enemy Node position: \(enemyNode.position)")
        
        
        
        enemyNode.rotation.x = 180
        
        enemyNode.position = SCNVector3(x: 0, y: 0, z: 0.5)
       // enemyNode.scale = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
        
        // enemyRootNode.position = SCNVector3(x: 0, y: 1, z: -7)
        // enemyRootNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        
        
       // enemyRootNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        //enemyRootNode.scale = SCNVector3(x: 0.06, y: 0.06, z: 0.06)
        
        
        //enemySkin.physicsBody?.isAffectedByGravity = false
        enemyNode.physicsBody?.isAffectedByGravity = true
        enemyRootNode.physicsBody?.isAffectedByGravity = false
        
        // for nodes in
        
        
        for items in enemyRootNode.childNodes {
            items.physicsBody?.isAffectedByGravity = true
            
            print("Root Items Name: \(items.name)")
        }
        
        //enemyRootNode.addChildNode(enemyNode)
        
        
        
        scene.rootNode.addChildNode(enemyNode)
        scene.rootNode.addChildNode(enemyRootNode)
        
        
        camNode = SCNNode()
        camNode.camera = SCNCamera()
        camNode.camera?.usesOrthographicProjection = false
        camNode.camera?.orthographicScale = 2
        //let constraint = SCNLookAtConstraint(target: sphere)
        //constraint.gimbalLockEnabled = true
        //self.cameraNode.constraints = [constraint]
       // camNode.position = SCNVector3Make(20, 20, 20)
        
        camNode.position = SCNVector3Make(0.208, 0.394, 3.05)
        //camNode.position = SCNVector3Make(1, 1, 1)
        camNode.eulerAngles = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(camNode)
        //self.view.al
        
//        targetNode = heroNode.childNode(withName: "camera", recursively: true)!.childNode(withName: "gunTarget", recursively: true)!
        
        
        
        //scene.rootNode.addChildNode(enemyNode)
        
        
        //HANDS REST
        
        
        var weaponScene = SCNScene()
        
        
        var handsScene = SCNScene()
        
//        switch currentWeapon {
//        case "Fist":
//            handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
//            HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest.dae")!
//            HeroHandsPunch = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Punch.dae")!
//            
//            self.targetNode.isHidden = true
//            
//        case "Knife":
//            handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_Knife.dae")!
//            
//            let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
//            
//            knifeTemp.isHidden = true
//            
//            self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle_R", recursively: true))!
//            
//            
//            weaponScene = SCNScene(named: "animate.scnassets/InfantryKnife3D.dae")!
//            
//            
//            // let weaponScene = LoadAttackItems(weaponName: "InfantryKnife3D")
//            
//            self.heroWeapon = (weaponScene.rootNode.childNode(withName: "Layer_0", recursively: true))!
//            
//            self.heroWeapon.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
//            
//            
//            heroWeapon.physicsBody = SCNPhysicsBody.kinematic()
//            heroWeapon.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: bodyPlane.geometry!, options: nil))
//            
//            heroWeapon.physicsBody?.categoryBitMask = CollisionCategory.Bullet
//            heroWeapon.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
//            if #available(iOS 9.0, *) {
//                heroWeapon.physicsBody?.contactTestBitMask = ~0
//            }
//            
//            let weaponName = "InfantryKnife100"
//            
//            let WeaponImage = LoadWeaponImage(weaponName: weaponName)
//            
//            let weaponMaterial = SCNMaterial()
//            // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
//            weaponMaterial.diffuse.contents = WeaponImage
//            
//            self.heroWeapon.geometry?.firstMaterial = weaponMaterial
//            
//            //self.heroWeapon.rotation = SCNVector4(0,0,0,M_PI)
//            self.heroWeapon.position = SCNVector3(x: -0.2, y: 0.2, z: 0)
//            self.heroWeapon.scale = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
//            //self.heroWeapon.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            
//            self.heroHandRight.addChildNode(self.heroWeapon)
//            
//            
//            HeroHandsPunch = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Knife_Thrust.dae")!
//            
//            self.targetNode.isHidden = true
//            
//        case "Gun":
//            handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_Gun.dae")!
//            
//            
//            
//            
//            // let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
//            
//            //knifeTemp.isHidden = true
//            
//            self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle.R", recursively: true))!
//            
//            
//            weaponScene = SCNScene(named: "animate.scnassets/Gun3D.dae")!
//            
//            
//            // let weaponScene = LoadAttackItems(weaponName: "InfantryKnife3D")
//            
//            self.heroWeapon = (weaponScene.rootNode.childNode(withName: "Layer_0", recursively: true))!
//            
//            self.heroWeapon.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
//            
//            
//            heroWeapon.physicsBody = SCNPhysicsBody.kinematic()
//            heroWeapon.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: bodyPlane.geometry!, options: nil))
//            
//            heroWeapon.physicsBody?.categoryBitMask = CollisionCategory.Bullet
//            heroWeapon.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
//            if #available(iOS 9.0, *) {
//                heroWeapon.physicsBody?.contactTestBitMask = ~0
//            }
//            
//            //self.heroWeapon.rotation = SCNVector4(0,0,0,M_PI)
//            self.heroWeapon.position = SCNVector3(x: -0.3, y: 0.2, z: 0)
//            //self.heroWeapon.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
//            self.heroWeapon.scale = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
//            
//            let weaponName = "Gun100"
//            
//            let WeaponImage = LoadWeaponImage(weaponName: weaponName)
//            
//            let weaponMaterial = SCNMaterial()
//            // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
//            weaponMaterial.diffuse.contents = WeaponImage
//            
//            self.heroWeapon.geometry?.firstMaterial = weaponMaterial
//            
//            
//            self.heroHandRight.addChildNode(self.heroWeapon)
//            
//            HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Gun.dae")!
//            HeroHandsPunch = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Gun_Fire.dae")!
//            
//            self.targetNode.isHidden = false
//            
//        default:
//            
//            handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
//            HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest.dae")!
//            HeroHandsPunch = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Punch.dae")!
//            
//            self.targetNode.isHidden = true
//        }
        
//        self.heroHands = (handsScene.rootNode.childNode(withName: "basicRig", recursively: true))!
//        let handModels = (handsScene.rootNode.childNode(withName: "basicRig_Body", recursively: true))!
//        
//        handModels.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: handModels.geometry!, options: nil))
//        
//        
//        switch skinTone {
//        case "white":
//            handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
//            
//        case "brown":
//            // handModels.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//            self.heroHands.physicsBody?.isAffectedByGravity = false
//            
//        default:
//            handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
//        }
        
//        
//        //heroHands.position = SCNVector3(x: 0, y: 0, z: -1.4)
//        heroHands.position = SCNVector3(x: 0, y: -0.5, z: -1.0)
//        heroHands.scale = SCNVector3(x: 0.09, y: 0.09, z: 0.09)
//        
//        // handModels.addChildNode(heroWeapon)
//        
//        self.heroHands.addChildNode(handModels)
//        self.heroHands.rotation = SCNVector4(0,4,2.6,M_PI)
//        
//        self.heroHands.rotation.y = 10
//        //self.heroHands.rotation.x = 10
//        
//        heroNode.addChildNode(heroHands)
//        //scene.rootNode.addChildNode(heroHands)
        
        
        
        
        
        
        //  -------ADD WALK ANIMATION
//        enemyWalkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Walk.dae")!
//        // enemyNode.addAnimation(walkAnimation, forKey: "walk")
//        
//        enemyHitAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch.dae")!
//        enemyFallAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Falling.dae")!
//        
//        enemyHitBellyAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch_Belly.dae")!
//        enemyDeadAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Dead.dae")!
//        
        
        
        
        
        
//        HeroHandsRest.isRemovedOnCompletion = false
//        self.heroHands.addAnimation(self.HeroHandsRest, forKey: "handsRest")
        
        
        
        //-----------------
        
       // Sky = scene.rootNode.childNode(withName: "sky", recursively: true)!
       // Floor = scene.rootNode.childNode(withName: "floor", recursively: true)!
        
        //self.heroHands = scene.rootNode.childNode(withName: "hands", recursively: true)!
        
        
        
//        Loc1 = scene.rootNode.childNode(withName: "loc1", recursively: true)!
//        Loc2 = scene.rootNode.childNode(withName: "loc2", recursively: true)!
//        Loc3 = scene.rootNode.childNode(withName: "loc3", recursively: true)!
//        Loc4 = scene.rootNode.childNode(withName: "loc4", recursively: true)!
//        Loc5 = scene.rootNode.childNode(withName: "loc5", recursively: true)!
        
        //-----------------
        let grassMaterial = SCNMaterial()
        grassMaterial.diffuse.contents = UIImage(named: "grassTexture2.jpg")
        
//        let GrassHolder = scene.rootNode.childNode(withName: "grassTiles", recursively: true)!
//        
//        for GrassTiles in GrassHolder.childNodes {
//            
//            // if SceneTiles.name? == "
//            
//            switch GrassTiles.name {
//                
//                
//            case "grass"?:
//                //  print("Grass scene tile found")
//                GrassTiles.physicsBody?.collisionBitMask = CollisionCategory.All
//                GrassTiles.geometry?.firstMaterial = grassMaterial
//                GrassTiles.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: GrassTiles.geometry!, options: nil))
//                GrassTiles.physicsBody?.isAffectedByGravity = false
//                // GrassTiles.position =
//                /*
//                 Grass = scene.rootNode.childNode(withName: "grass", recursively: true)!
//                 Grass.physicsBody?.collisionBitMask = CollisionCategory.All
//                 let grassMaterial = SCNMaterial()
//                 grassMaterial.diffuse.contents = UIImage(named: "grassTexture2.jpg")
//                 // Floor.geometry?.firstMaterial = grassMaterial
//                 Grass.geometry?.firstMaterial = grassMaterial
//                 */
//                
//                GrassNodes.append(GrassTiles)
//            default:
//                break
//                
//            }
//            
//        }
//        
//        
//        //-----------------
//        //SET UP FENCE collisionBitMask
//        let FenceHolder = scene.rootNode.childNode(withName: "fenceHolder", recursively: true)!
//        
//        for FenceTiles in FenceHolder.childNodes {
//            
//            switch FenceTiles.name {
//                
//                
//            case "fence"?:
//                //  print("Fence scene tile found")
//                //FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.Fence
//                //FenceTiles.geometry = SCNPlane(width: 0.5, hieght, 0.5)
//                //SCNCylinder(radius: 0.15, height: 0.6)
//                FenceTiles.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: FenceTiles.geometry!, options: nil))
//                FenceTiles.physicsBody?.categoryBitMask = CollisionCategory.Fence
//                FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
//                FenceTiles.physicsBody?.isAffectedByGravity = true
//                FenceNodes.append(FenceTiles)
//                
//            default:
//                break
//                
//            }
//            
//        }
//        
//        
//        //-----------------
//        let tempBox = scene.rootNode.childNode(withName: "box", recursively: true)!
//        
//        tempBox.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: tempBox.geometry!, options: nil))
//        tempBox.physicsBody?.categoryBitMask = CollisionCategory.Fence
//        tempBox.physicsBody?.collisionBitMask = CollisionCategory.All
        //tempBox.physicsBody?.isAffectedByGravity = true
        
        
        
        //-----------------
        let skyMaterial = SCNMaterial()
        skyMaterial.diffuse.contents = UIImage(named: "skyTexture.jpg")
        
        
        
       // camCamera = attackScene.camera
        
      //  camNode = (attackScene.rootNode.childNode(withName: "camera", recursively: true))!
        
//        let camNodeTemp = (attackScene.rootNode.childNode(withName: "camNode", recursively: true))!
//        //camNode = (camNodeTemp.childNode(withName: "camera", recursively: true))!
//        camNode = (attackScene.rootNode.childNode(withName: "camera", recursively: true))!
//       // camCamera = camNode.camera!
//        
//        for items in camNodeTemp.childNodes {
//            print("CAMNODE CHILD NODE NAME: \(items.name)")
//        }
        
        //    (attackScene.rootNode.childNode(withName: "camera", recursively: true))!
        //-----------------
        
//      //  camNode = heroNode.childNode(withName: "camera", recursively: true)!
//        
//        
//        
//        
//        let cameraNode = SCNNode()
//        
        
        
        
//        let camera = SCNCamera()
//        camera.zNear = 0.01
//        // camera.zFar = Double(max(map.width, map.height))
//        camera.zFar = Double(max(1000, 1000))
//        camNode.camera = camera
//       // heroNode.addChildNode(camNode)
//        
//        camNode.position = SCNVector3(x: 0, y: 10, z: 10)
//        scene.rootNode.addChildNode(camNode)
        
        
        
        
        
        //-----------------------------------------------
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        //-----------------------------------------------
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        //----------------------------------------------
        //_ = scene.rootNode.childNodeWithName("Bob", recursively: true)!
        // _ = scene.rootNode.childNodeWithName("CampusField1", recursively: true)!
        
        //--------------------------------------------------------
        // Bob.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
        
        //let scnView = self.view as! SCNView
        self.sceneHolder.scene = scene
        self.sceneHolder.pointOfView?.camera = camNode.camera
        
       // scene.rootNode.addChildNode(heroNode)
        
        
        //  scene.rootNode.addChildNode(heroHandsScene)
        //scene.rootNode.addChildNode(enemyNode)
        
        /*
         enemyScene?.rootNode.addChildNode(heroNode)
         enemyScene?.rootNode.addChildNode(enemyNode)
         
         enemyScene?.rootNode.addChildNode(lightNode)
         enemyScene?.rootNode.addChildNode(ambientLightNode)
         enemyScene?.rootNode.addChildNode(Sky)
         
         //enemyScene?.rootNode.addChildNode(camNode)
         //enemyScene?.rootNode.addChildNode(Floor)
         
         for Fence in FenceNodes {
         enemyScene?.rootNode.addChildNode(Fence)
         }
         
         for Grass in GrassNodes {
         enemyScene?.rootNode.addChildNode(Grass)
         }
         
         */
        
        
        // self.sceneHolder.scene = enemyScene
        //scnView.scene = scene
        
        /*
         scnView.allowsCameraControl = true
         scnView.showsStatistics = false
         scnView.backgroundColor = UIColor.whiteColor()
         */
        
        self.sceneHolder.allowsCameraControl = true
        self.sceneHolder.showsStatistics = true
        self.sceneHolder.backgroundColor = UIColor.white
        
        self.sceneHolder.scene?.physicsWorld.contactDelegate = self
        self.sceneHolder.delegate = self
        self.sceneHolder.isPlaying = true
        
        
//        self.ActiveLocations.append(Loc1)
//        self.ActiveLocations.append(Loc2)
        //self.attackScene.dele
    }
    
    
    func updateSkinTone(SkinTone: String) {
        
        
        var SkinString = String()
        
        switch SkinTone {
            
            case "brown":
            SkinString = "middleage_darkskinned_male_diffuse"
            
            case "white":
            SkinString = "middleage_lightskinned_male_diffuse"
            
        default:
            break
        }
        
 
        
       // male_white-male_muscle_13290
        
        //enemyScene?.rootNode.
        
        let SkinNode = enemyRootNode.childNode(withName: "male_white-male_muscle_13290", recursively: true)!
            //.childNode(withName: "gunTarget", recursively: true)!
        
        SkinNode.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(SkinString).png")

        
    }
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        print("CONTACT INFO: \(contact)")
        
        
        let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        
        let contactMask2 = contact.nodeB.physicsBody!.categoryBitMask | contact.nodeA.physicsBody!.categoryBitMask
        
        print("contact occurred: \(contactMask)")
        print("NODE A: \(contact.nodeA.name)")
        print("contact occurred: \(contactMask2)")
        print("NODE B: \(contact.nodeB.name)")
        
        for childNodes in contact.nodeB.childNodes {
            print("Did Contact Child Node: \(childNodes.name)")
        }
        
        
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Enemy) || contactMask2 == (CollisionCategory.Bullet | CollisionCategory.Enemy)){
            print("Bullet Collided with Enemy")
            //   enemyHitCount += 1
            //    print("EnemyHit count = \(enemyHitCount.description)")
            //    self.countLBL.text = "Hits:\(enemyHitCount.description)"
            
            //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateCountNotification", object: nil)
            //, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(self.GoldProductionAmount.description)"])
            
            // let CurrentHealthAmount = 100
            var NewHealthAmount = Int()
            
            //   NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateAttackingHealth"), object: nil, userInfo: ["previousAmount":"\(CurrentHealthAmount.description)","newAmount":"\(NewHealthAmount.description)","setting":"subtract"])
            
            let audioSource = SCNAudioSource(fileNamed: "animate.scnassets/male_uh.mp3")!
            let audioPlayer = SCNAudioPlayer(source: audioSource)
            enemyNode.addAudioPlayer(audioPlayer)
            
            switch contact.nodeA.name {
            case "headPlane"?:
                
          print("head")
                
            case "bodyPlane"?:
                
              print("body")
                
            default:
                
                break
            }
            
            
        }
        
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Fence) || contactMask2 == (CollisionCategory.Fence | CollisionCategory.Bullet)){
            print("Bullet Collided with Fence")
        }
        
        
    }
    
    
    

    
    
    
//    func updateUserHealth(current: Int, new: Int, setting: String, nodeName: String) {
//        
//        
//        
//        
//        var newAmount = Int()
//        //   print("Update Money New Amount?: \(newAmount)")
//        //  let differenceAmount = newAmount - previousAmount!
//        
//        
//        // print("UPDATE MONEY TYPE = \(settingTemp)")
//        
//        let seconds = 2.0
//        let secondsLoad = 2.0
//        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
//        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
//        
//        
//        if setting == "add" {
//            //self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
//            newAmount =  current + new
//            if newAmount > 100 {
//                newAmount = 100
//            }
//        } else {
//            //self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
//            newAmount = current - new
//            
//            if newAmount < 0 {
//                newAmount = 0
//            }
//        }
//        
//        
//        self.EnemyHealth = newAmount
//        
//        let newAmountDouble = Double(newAmount)
//        let tc = Double(100)
//        
//        let tempP = newAmountDouble / tc
//        
//        // let hitprogress = Float(tempP)
//        
//        
//        let newAmountProgress = Float(tempP)
//        print("new amount progress: \(newAmountProgress)")
//        
//        
//        DispatchQueue.main.async(execute: {
//            //print("generating Map now")
//            self.healthProgressView.setProgress(newAmountProgress, animated: true)
//            self.PlayingEnemySound = false
//            
//            if newAmount == 0 {
//                
//                //                if self.showBlood {
//                //                    self.addBloodSpatter()
//                //                }
//                
//                //                self.enemyFallAnimation.repeatCount = 1
//                //                self.enemyNode.addAnimation(self.enemyFallAnimation, forKey: "enemyDied")
//                
//                
//                
//                let seconds = 0.5
//                let secondsLoad = 2.0
//                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//                let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
//                let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
//                let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
//                
//                
//                
//                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
//                    // self.buttonViewW.constant = 20
//                    //  self.buttonViewH.constant = 20
//                    //  self.AbilityBTN.frame.size.width = 80
//                    //  self.AbilityBTN.frame.size.height = 80
//                    
//                    // self.buttonViewY.constant = -40
//                    
//                    //self.removeFromSuperview()
//                    
//                    self.enemyDeadAnimation.repeatCount = 1
//                    self.enemyDeadAnimation.autoreverses = true
//                    self.enemyDeadAnimation.duration = 10.0
//                    self.enemyNode.addAnimation(self.enemyDeadAnimation, forKey: "enemyDead")
//                    
//                    // DispatchQueue.main.async(execute: {
//                    // self.removeFromSuperview()
//                    //self.targetEliminated()
//                    // })
//                    
//                    
//                    DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
//                        
//                        
//                        DispatchQueue.main.async(execute: {
//                            //  self.removeFromSuperview()
//                            self.TargetEliminated()
//                        })
//                        
//                    })
//                    
//                    
//                })
//                
//                
//                self.enemyDeadAnimation.repeatCount = 1
//                
//                
//                
//            }
//            // self.healthattackingView.isHidden = true
//            //self.GenerateMap(EditedImage)
//        })
//        
//        //healthProgressView.setProgress(newAmountProgress, animated: true)
//        
//        let animationDuration = 0.5
//        
//        if newAmount == 0 {
//            
//            print("Target eliminated")
//            
//            
//            
//            
//        }
//        
//        
//    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        print("PHYSICS DID END")
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
        // print("PHYSICS DID UPDATE")
        
        // updateEnemy()
        
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        /*
         switch gestureRecognizer {
         case lookGesture:
         return touch.locationInView(view).x > view.frame.size.width / 2
         case walkGesture:
         print("touch view x:\(touch.locationInView(view).x)")
         print("frame width / 2: \(view.frame.size.width / 2)")
         return touch.locationInView(view).x < view.frame.size.width / 2
         case moveItemGesture:
         print("Moving item")
         
         
         default:
         break
         }
         return true
         
         */
        
        // print("Walking")
        
        /*
         if gestureRecognizer == lookGesture {
         return touch.location(in: view).x > view.frame.size.width / 2
         } else if gestureRecognizer == walkGesture {
         print("touch view x:\(touch.location(in: view).x)")
         print("frame width / 2: \(view.frame.size.width / 2)")
         return touch.location(in: view).x < view.frame.size.width / 2
         }
         */
        
        
        if gestureRecognizer == lookGesture {
            // print("look gesture")
            return touch.location(in: self).x > self.frame.size.width / 2
        } else if gestureRecognizer == walkGesture {
            
            //print("is walking")
            //print("touch view x:\(touch.location(in: self).x)")
            //print("frame width / 2: \(self.frame.size.width / 2)")
            return touch.location(in: self).x < self.frame.size.width / 2
        }
        
        
        
        return true
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func lookGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        //  print("Look Gesture recognized")
        
        //get translation and convert to rotation
        
        
        /*
         widthRatio = Float(translation.x) / Float(gestureRecognize.view!.frame.size.width) + lastWidthRatio
         heightRatio = Float(translation.y) / Float(gestureRecognize.view!.frame.size.height) + lastHeightRatio
         
         //  HEIGHT constraints
         if (heightRatio >= maxHeightRatioXUp ) {
         heightRatio = maxHeightRatioXUp
         }
         if (heightRatio <= maxHeightRatioXDown ) {
         heightRatio = maxHeightRatioXDown
         }
         
         
         //  WIDTH constraints
         if(widthRatio >= maxWidthRatioRight) {
         widthRatio = maxWidthRatioRight
         }
         if(widthRatio <= maxWidthRatioLeft) {
         widthRatio = maxWidthRatioLeft
         }
         */
        
        // self.cameraOrbit.eulerAngles.y = Float(-2 * M_PI) * widthRatio
        // self.cameraOrbit.eulerAngles.x = Float(-M_PI) * heightRatio
        
        
        
        
        let translation = gesture.translation(in: self)
        // let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
        // let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        
        // print("Translation X: \(translation.x)")
        // print("Translation Y: \(translation.y)")
        
        
        
        
        let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
        let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        print("hAngle: \(hAngle)")
        print("vAngle: \(vAngle)")
        
        
        //rotate hero
        heroNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: hAngle), asImpulse: true)
        
        //tilt camera
        
        elevation = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + vAngle))
        
        if elevation < -0.11 {
            
            elevation = -0.11
            print("tilted too low")
            
        }
        print("Elevation: \(elevation)")
        camNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
        
        //reset translation
        gesture.setTranslation(CGPoint.zero, in: self)
    }
    
    
    
    func walkGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.ended || gesture.state == UIGestureRecognizerState.cancelled {
            
            
            gesture.setTranslation(CGPoint.zero, in: self)
            
            
            // self.HeroX = heroNode.position.x
            //  self.HeroZ = heroNode.position.z
            
            //  print("HeroX = \(HeroX)")
            //   print("HeroZ = \(HeroZ)")
            
            // print("CGPointZero = \(CGPointZero)")
            let pos = heroNode.position
            print("Hero position: \(pos)")
            
        }
    }
    
    func fireGestureRecognized(_ gesture: FireGestureRecognizer) {
        
        //update timestamp
        
        //enemyRootNode.addAnimation(walkAnimation, forKey: "walk")
        
        
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTappedFire < autofireTapTimeThreshold {
            tapCount += 1
        } else {
            tapCount = 1
        }
        lastTappedFire = now
        
        
        
        
        // self.heroWeapon.rotation.z += 1
        //self.heroWeapon.rotation.y = 150
        // self.heroWeapon.rotation.x = 200
        
        
        // NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateAmmoNotification"), object: nil)
        
        
        //        var moveUp = SCNAction.moveBy(x: 0, y: 1, z: 0, duration: 1)
        //        moveUp.timingMode = SCNActionTimingMode.easeInEaseOut;
        //        var moveDown = SCNAction.moveBy(x: 0, y: -1, z: 0, duration: 1)
        //        moveDown.timingMode = SCNActionTimingMode.easeInEaseOut;
        //        var moveSequence = SCNAction.sequence([moveUp,moveDown])
        //        var moveLoop = SCNAction.repeatForever(moveSequence)
        //        enemyNode.runAction(moveLoop)
        
        
        
        
    }
    
    func handleTap(_ gesture: UITapGestureRecognizer) {
        
        //func handleTap(gestureRecognize: UIGestureRecognizer) {
        
        print("Tap Gesture started")
        //let scnView = self.view as! SCNView
        let p = gesture.location(in: self.sceneHolder)
        // let p = gestureRecognize.locationInView(self.sceneHolder)
        //let hitResults = scnView.hitTest(p, options: nil)
        let hitResults = self.sceneHolder.hitTest(p, options: nil)
        if hitResults.count > 0 {
            print("Hit test result is working")
            
            let result: AnyObject! = hitResults[0]
            
            print("Node Hit = \(result.node!.name)")
            
            
            /*
             let result: AnyObject! = hitResults[0]
             let material = result.node!.geometry!.firstMaterial!
             SCNTransaction.begin()
             SCNTransaction.animationDuration = 0.5
             //SCNTransaction.setAnimationDuration(0.5)
             SCNTransaction.completionBlock = {
             /*
             // SCNTransaction.setCompletionBlock {
             SCNTransaction.begin(),
             //SCNTransaction.setAnimationDuration(0.5)
             SCNTransaction.animationDuration = 0.5,
             material.emission.contents = UIColor.black,
             SCNTransaction.commit()
             */
             }
             material.emission.contents = UIColor.yellow
             SCNTransaction.commit()
             
             */
        }
    }
    
    
    func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        
        //print("ENEMY ROOT NODE POSITION: \(enemyRootNode.position)")
        //print("ENEMY NODE POSITION: \(enemyNode.position)")
        
        //print("Rendering now")
        //get walk gesture translation
        
        let translation = walkGesture.translation(in: self)
        
        //print("Translation = \(translation)")
        //create impulse vector for hero
        let angle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
        var impulse = SCNVector3(x: max(-1, min(1, Float(translation.x) / 50)), y: 0, z: max(-1, min(1, Float(-translation.y) / 50)))
        
        
        
        
        self.HeroX = heroNode.presentation.position.x
        self.HeroZ = heroNode.presentation.position.z
        self.HeroY = heroNode.presentation.position.y
        // self.HeroZ = self.HeroY + impulse.z
        
        // print("HeroX = \(HeroX.description)")
        //print("HeroZ = \(HeroY.description)")
        
        // print("Hero X = \(self.HeroX)")
        //  print("Hero Z = \(self.HeroZ)")
        
        // print("Impulse Vector Start = \(impulse)")
        //  print("Impulse Vector End = \(impulse)")
        
        
        impulse = SCNVector3(
            x: impulse.x * cos(angle) - impulse.z * sin(angle),
            y: 0,
            z: impulse.x * -sin(angle) - impulse.z * cos(angle)
        )
        
        
        heroNode.physicsBody?.applyForce(impulse, asImpulse: true)
        
        
        /*
         if MovingObject {
         
         print("Moving Object, adding impulse now")
         let moveItemTranslation = moveItemGesture.translation(in: self.view)
         
         let angleItem = TouchingNode.presentation.rotation.w * TouchingNode.presentation.rotation.y
         var impulseItem = SCNVector3(x: max(-1, min(1, Float(moveItemTranslation.x) / 50)), y: 0, z: max(-1, min(1, Float(-moveItemTranslation.y) / 50)))
         
         /*
         impulse = SCNVector3(
         x: impulse.x * cos(angle) - impulse.z * sin(angle),
         y: 0,
         z: impulse.x * -sin(angle) - impulse.z * cos(angle)
         )
         */
         
         // impulseItem = SCNVector3(x: impulseItem.x * cos(angleItem) - impulseItem.z * sin(angleItem), y: 0, z: impulseItem.x * -sin(angleItem) - impulseItem.z * cos(angleItem))
         
         TouchingNode.position = SCNVector3(x: TouchingNode.presentation.position.x, y: 0.3, z: TouchingNode.position.z)
         
         print("new Touching Node position = \(SCNVector3(x: TouchingNode.presentation.position.x, y: 0.3, z: TouchingNode.position.z))")
         
         //TouchingNode.physicsBody?.applyForce(impulseItem, impulse: true)
         }
         */
        
        self.HeroPosition = SCNVector3(x: heroNode.presentation.position.x, y: heroNode.presentation.position.y, z: heroNode.presentation.position.z)
        self.HeroRotation = SCNVector4(x: heroNode.presentation.rotation.x, y: heroNode.presentation.rotation.y, z: heroNode.presentation.rotation.z, w: heroNode.presentation.rotation.w)
        
        
        // self.HeroX = heroNode.position.x
        //    self.HeroZ = heroNode.position.z
        
        //print("HeroX = \(HeroX)")
        //print("HeroZ = \(HeroZ)")
        
        //handle firing
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTappedFire < autofireTapTimeThreshold {
            let fireRate = min(Double(maxRoundsPerSecond), Double(tapCount) / autofireTapTimeThreshold)
            if now - lastFired > 1 / fireRate {
                
                //get hero direction vector
                let angle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
                var direction = SCNVector3(x: -sin(angle), y: 0, z: -cos(angle))
                
                //get elevation
                direction = SCNVector3(x: cos(elevation) * direction.x, y: sin(elevation), z: cos(elevation) * direction.z)
                
                
                
                switch self.currentWeapon {
                    
                    
                case "Gun":
                    //create or recycle bullet node
                    var bulletNode: SCNNode = {
                        if self.bullets.count < self.maxBullets {
                            
                            //  NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                            
                            return SCNNode()
                        } else {
                            
                            //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                            
                            //    ammoRemaining--
                            //    self.ammoLBL.text = "ammo:\(ammoRemaining.description)"
                            return self.bullets.remove(at: 0)
                        }
                    }()
                    if ammoRemaining > 0 {
                        bullets.append(bulletNode)
                        
                        // NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                        
                    } else {
                        //self.overlayView.alpha = 1
                        //overlayLBL.text = "You're out of ammo!"
                    }
                    
                    
                    
                    let bulletScene = SCNScene(named: "bullet.dae")
                    // let enemyScene = SCNScene(named: "ArmyUser3D_Test.dae")
                    var bulletNodeTest = (bulletScene?.rootNode.childNode(withName: "Bullet", recursively: true))!
                    //   let bulletGeometryTest = (bulletScene?.rootNode.childNode(withName: "Circle.005", recursively: true))!
                    let bulletMaterial = SCNMaterial()
                    // bulletMaterial.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
                    // bulletNode = bulletNodeTest
                    
                    print("Creating bullet")
                    
                    bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
                    bulletNode.name = "bullet"
                    // bulletNode.geometry = bulletGeometryTest.geometry
                    
                    // 0.4 Height
                    // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
                    
                    bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 2.5, z: heroNode.presentation.position.z)
                    // bulletNode.rotation  = SCNVector4(x: 6, y: 80, z: 31, w: elevation)
                    
                    bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                    
                    //bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                    bulletNode.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                    bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Hero
                    
                    //ANGLED VELOCITY (UP)
                    //bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1.5, z: 1)
                    bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1, z: 1)
                    
                    //BULLET PHYSICS
                    //  bulletNode.physicsBody?.angularDamping = 0.9999999
                    //  bulletNode.physicsBody?.damping = 0.9999999
                    //  bulletNode.physicsBody?.rollingFriction = 0
                    //  bulletNode.physicsBody?.friction = 0
                    //  bulletNode.physicsBody?.restitution = 0
                    
                    
                    //  print("HeroRotation:\(HeroRotation)")
                    
                    
                    // bulletNode.rotation = SCNVector4Make(0.0, HeroRotation.y - 0.5, 0.0, elevation)
                    // bulletNode.rotation = SCNVector4Make(0.0, HeroRotation.y - 90, 0.0, elevation)
                    
                    // bulletNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: elevation), asImpulse: true)
                    
                    
                    // print("BulletRotation:\(bulletNode.rotation)")
                    // print("BulletRotation (Presentation):\(bulletNode.presentation.rotation)")
                    
                    // let rotate = SCNAction.rotate(by: CGFloat(M_PI), around:SCNVector3Make(0, 1, 0), duration: TimeInterval(10.0))
                    // let repeatAction = SCNAction.repeatForever(rotate)
                    
                    bulletNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
                    
                    let BulletHeroDifTemp = Double(bulletNode.rotation.y) - Double(HeroRotation.y)
                    
                    let BulletHeroDif = CGFloat(BulletHeroDifTemp)
                    
                    //  print("ButtetDif = \(BulletHeroDif)")
                    
                    //  bulletNode.runAction(SCNAction.rotateBy(x: 0.0, y: BulletHeroDif, z: 0.0, duration: 0.1))
                    // let CenterBullet = SCNAction.rotateTo(x: 0.0, y: BulletHeroDif, z: 0.0, duration: 0.1, usesShortestUnitArc: true)
                    
                    let CenterBullet = SCNAction.rotateBy(x: 0.0, y: BulletHeroDif, z: 0.0, duration: 0.1)
                    
                    //  bulletNode.rotation.y = 90.0
                    
                    // bulletNode.runAction(SCNAction.rotateTo(x: 0.0, y: BulletHeroDif, z: 0.0, duration: 0.1, usesShortestUnitArc: true))
                    
                    // bulletNode.runAction(SCNAction.repeatForever(CenterBullet))
                    //  bulletNode.runAction(SCNAction.)
                    
                    
                    // bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
                    
                    
                    
                    
                    
                    // self.attackScene.rootNode.addChildNode(bulletNode)
                    self.sceneHolder.scene?.rootNode.addChildNode(bulletNode)
                    
                    
                    //bulletNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: heroNode.presentation.rotation.w), asImpulse: true)
                    
                    //tilt camera
                    //elevation = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + 0))
                    bulletNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
                    
                    
                    
                    //apply impulse
                    let impulse = SCNVector3(x: direction.x * Float(bulletImpulse), y: direction.y * Float(bulletImpulse), z: direction.z * Float(bulletImpulse))
                    
                    
                    bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
                    
                    let rotate = SCNAction.rotate(by: CGFloat(M_PI), around:SCNVector3Make(0, 1, 0), duration: TimeInterval(10.0))
                    let repeatAction = SCNAction.repeatForever(rotate)
                    // bulletNode.runAction(repeatAction)
                    
                    let rad = Double(bulletNode.eulerAngles.y)
                    var angleInDegrees = fmodf(360.0 + -Float(rad) * (180.0 / Float(M_PI)), 360.0)
                    //   print("eulerAngles.y rad:\(rad) degree:\(angleInDegrees)")
                    
                    
                    self.HeroHandsPunch.speed = 2.0
                    self.HeroHandsPunch.repeatCount = 1
                    self.heroHands.addAnimation(self.HeroHandsPunch, forKey: "handsPunch")
                    
                    
                default:
                    
                    
                    self.HeroHandsPunch.speed = 2.0
                    self.HeroHandsPunch.repeatCount = 1
                    self.heroHands.addAnimation(self.HeroHandsPunch, forKey: "handsPunch")
                    
                    
                    
                }
                
                //update timestamp
                lastFired = now
                
            }
        }
        
      
        
        
    }
    
    

    
    
    
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
            let moveY = 0 - (self.device.height / 2)
            
            //self.ScaleViewSize(self.buttonView, scale: 1.0, moveX: 0, moveY: moveY)
            
            
            /*
             self.buttonView.transform = CGAffineTransform(translationX: 0, y: 0)
             self.buttonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             
             self.buttonView.layer.cornerRadius = 10
             self.buttonViewW.constant = 20
             self.buttonViewH.constant = 20
             */
            
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                // self.buttonViewW.constant = 20
                //  self.buttonViewH.constant = 20
                //  self.AbilityBTN.frame.size.width = 80
                //  self.AbilityBTN.frame.size.height = 80
                
                // self.buttonViewY.constant = -40
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
        
        
        
    }
    
    @IBAction func closeBTN(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "EnableTabBarItems"), object: nil)
        self.removeFromSuperview()
        // self.isHidden = true
    }
    
    
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        //self.hidden = true
        //CollapseLayout()
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "EnableTabBarItems"), object: nil)
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
    
    
    
    
    
    
    
    class func instanceFromNib(characterInfo: CharacterInfo) -> MyPlayerView {
        let bounds = UIScreen.main.bounds
        var Nib = MyPlayerView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MyPlayerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MyPlayerView
        
        print("Current Weapon: \(characterInfo.currentWeapon)")
        
        
        
        Nib.EnemyMoveDirection = "left"
        
        
        // Nib.attackBTNText = "Punch"
        Nib.skinTone = characterInfo.skinTone
        Nib.currentWeapon = characterInfo.currentWeapon
        
        Nib.CurrentHealthAmount = 100
        Nib.EnemyHealth = 100
        Nib.enemyEyeBrowString = "male_white-eyebrow001"
        Nib.enemyEyeLashString = "male_white-eyelashes01"
        Nib.enemyEyesString = "male_white-highpolyeyes"
        Nib.enemySuitString = "male_white-male_casualsuit06"
        Nib.enemyMuscleString = "male_white-male_muscle_13290"
        Nib.enemyShoesString = "male_white-shoes03"
        Nib.enemyHairString = "male_white-short04"
        Nib.enemyTeethString = "male_white-teeth_base"
        Nib.enemyTongueString = "male_white-tongue01"
        
        Nib.enemyEyeBrowTexture = "eyebrow001"
        Nib.enemyEyeLashTexture = "eyelashes01"
        Nib.enemyEyesTexture = "brown_eye"
        Nib.enemySuitTexture = "male_casualsuit06_diffuse"
        Nib.enemyMuscleTexture = "middleage_lightskinned_male_diffuse"
        Nib.enemyShoesTexture = "shoes03_diffuse"
        Nib.enemyHairTexture = "short04_diffuse"
        Nib.enemyTeethTexture = "teeth"
        Nib.enemyTongueTexture = "tongue01_diffuse"
        
        Nib.enemyRootNodeString = "male_white"
        
        let shouldShowBlood = UserDefaults.standard.bool(forKey: "ShowBlood")
        
        Nib.showBlood = shouldShowBlood
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func ShowAbilities(){
        
        /*
         if !ShowingAbilities {
         expandView()
         self.ShowingAbilities = true
         } else {
         collapseView()
         self.ShowingAbilities = false
         }
         */
        
    }
    
    func expandView() {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            // self.abilitiesLayoutView.alpha = 1.0
            // abilitiesLayoutView.hidden = false
        })
        
        
    }
    
    func collapseView() {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //  self.abilitiesLayoutView.alpha = 0.0
            // abilitiesLayoutView.hidden = true
        })
        
    }
    
    
    func On() {
        
        
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
        
        
        
        
    }
    
    
    @IBAction func updateAppearance(_ sender: Any) {
        
        
        
        updateSkinTone(SkinTone: "black")
        
        
    }
    
   
    @IBAction func hairBTN(_ sender: Any) {
        
       
        
        if !isViewingEditBody {
        
            self.isViewingHair = true
            self.isViewingEditBody = true
            let animationDuration = 0.35
            
            self.bodyView2.layer.removeAllAnimations()
            self.lastPulsingView = "hair"
            
            self.prefs.setValue("hair", forKey: "EditCharacterInfo")
            
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.bodySubViewHolder.center.y = self.bodySubViewHolder.center.y - 500
            self.bodySubViewHolderBOTTOM.constant = 0
            
        })
        
    }
        
    }
    
    @IBAction func eyeBTN(_ sender: Any) {
        
       
        
        if !isViewingEditBody {
        
            self.isViewingEyes = true
            self.isViewingEditBody = true
            let animationDuration = 0.35
            
            self.prefs.setValue("eyes", forKey: "EditCharacterInfo")
            
            self.bodyView1.layer.removeAllAnimations()
            self.lastPulsingView = "eyes"
            
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.bodySubViewHolder.center.y = self.bodySubViewHolder.center.y - 500
            self.bodySubViewHolderBOTTOM.constant = 0
            
        })
        
        let cam = camNode.camera
         //   self.attackScene.po
       // self.attackScene.pointoFView!.camera.xFov = camCamera.xFov - 100
       // camCamera.xFov = camCamera.xFov - 100
        //camCamera.yFov = camCamera.yFov - 100
            print("should move camera")
            
            //cam!.zNear = cam!.zNear - 0.5
           // cam!.z
      //  let cam = self.sceneHolder.scene.camera
        //  cam!.xFov = cam!.xFov - 10
        //  cam!.yFov = cam!.yFov - 4
            self.sceneHolder.pointOfView!.camera?.xFov = (self.sceneHolder.pointOfView!.camera?.xFov)! - 2
            
        }
        
    }
    
    
    @IBAction func bodyBTN(_ sender: Any) {
        
     
        
        if !isViewingEditBody {
        
            self.isViewingBody = true
            self.isViewingEditBody = true
            let animationDuration = 0.35
            
            self.prefs.setValue("body", forKey: "EditCharacterInfo")
            
            self.bodyView3.layer.removeAllAnimations()
            self.lastPulsingView = "body"
            
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.bodySubViewHolder.center.y = self.bodySubViewHolder.center.y - 500
            self.bodySubViewHolderBOTTOM.constant = 0
            
        })
        
    }
    }
    
    
}
