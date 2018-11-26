//
//  CustomPlayerAttackView.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/27/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation
import QuartzCore
import SceneKit

class PlayerAttackView: UIView, SCNPhysicsContactDelegate, UIGestureRecognizerDelegate, SCNSceneRendererDelegate {
    
    var randomMovemovementInt = [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0]
    
    
    var grassArea: SCNMaterial!
    var waterArea: SCNMaterial!
    
    let EnemyNodeScene = EnemyCharacter()
    
    var enemyDistanceZ = Float()
    
    var username = NSString()
    var email = NSString()
    var MyAltitude = Double()
    
    var alreadyHit = Bool()
    var EnemyDead = Bool()
    var ClosingView = Bool()
    
    var showBlood = Bool()
    
    var EnemyHealth = Int()
    var EnemyHealthStart = Int()
    var EnemyShouldNotMove = Bool()
    var EnemyMoveDirection = String()
    var EnemyHitWall = Bool()
    
    var EnemyRunningAway = Bool()
    var EnemyWalkingAway = Bool()
    var startScene = Bool()
    
    var EnemyTarget: String = "noone"
    
    var contactDelegate: SCNPhysicsContactDelegate?
    var lookGesture: UIPanGestureRecognizer!
    var walkGesture: UIPanGestureRecognizer!
    var moveItemGesture: UIPanGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    var fireGesture: FireGestureRecognizer!
    
    var AttackingPlayer = String()
    var AttackingPlayersHealth = String()
    var AttackingPlayerID = String()
    var StaminaUsed = Int()
    var NewStaminaAmount = Int()
    var AttackPower = Int()
    var AttackStatus = String()
    var UpdatedAttackPower = Int()
    var AttackPowerTemp = Double()
    
    var AttackStaminaAmountStart = String()
    var AttackGoldAmountStart = String()
    
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
    
    let attackScene = SCNScene(named: "PlayerAttackScene.scn")!
    
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
    
    
    var bulletNodeStart = SCNNode()
    var gunTipTemp = SCNNode()
    var heroHandsHolder = SCNNode()
    
    var heroNode = SCNNode()
    var heroHands = SCNNode()
    var heroHandRight = SCNNode()
    var heroWeapon = SCNNode()
    
    var RandomTarget = SCNNode()
    
    var enemyNode = SCNNode()
    var enemyNodeHolder = SCNNode()
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
    
    var EnemyDumpFront = Bool()
    var EnemyDumpBack = Bool()
    var EnemyDumpLeft = Bool()
    var EnemyDumpRight = Bool()
    
    var randomLoc = [SCNNode]()
    
    var ActiveLocations = [SCNNode]()
    
    
    
    let autofireTapTimeThreshold = 0.5
    let maxRoundsPerSecond = 30
    let bulletRadius = 1
    //let bulletRadius = 0.5
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
    var elevationBullet: Float = 0
    
    var enemyWalkAnimation = CAAnimation()
    var enemyHitAnimation = CAAnimation()
    var enemyHitBellyAnimation = CAAnimation()
    var enemyHitLegLAnimation = CAAnimation()
    var enemyHitLegRAnimation = CAAnimation()
    var enemyFallAnimation = CAAnimation()
    var enemyFlailAnimation = CAAnimation()
    var enemyDeadAnimation = CAAnimation()
    
    
    var HeroHandsRest = CAAnimation()
   // var HeroHandsPunch = CAAnimation()
    
    var HeroHandsAttack = CAAnimation()
    
    var PlayingEnemySound = Bool()
    
    
    var currentWeapon = String()
    var skinTone = String()
    
    var targetNode = SCNNode()
    
    override func awakeFromNib() {

       
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString)
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
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
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
        
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
        
    }
    
    
    
    func UpdateAttackingHealth(_ notification:Notification) {
        
       // MoneyChangeCount = 0
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        let previousAmountTemp = userInfo!["previousAmount"] as! String
        let previousAmount = Int(previousAmountTemp)
        let newAmountTemp = userInfo!["newAmount"] as! String
        let settingTemp = userInfo!["setting"] as! String
        
        var newAmount = Int()
        //   print("Update Money New Amount?: \(newAmount)")
        let differenceAmount = newAmount - previousAmount!
        
        
       // print("UPDATE MONEY TYPE = \(settingTemp)")
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        if settingTemp == "add" {
            //self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! + previousAmount!
        } else {
            //self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
            newAmount = Int(newAmountTemp)! - previousAmount!
        }
        
        
        let newAmountDouble = Double(newAmount)
        let tc = Double(100)
        
        let tempP = newAmountDouble / tc
        
       // let hitprogress = Float(tempP)
        
        
        let newAmountProgress = Float(tempP)
        
        DispatchQueue.main.async(execute: {
            //print("generating Map now")
            self.healthProgressView.setProgress(newAmountProgress, animated: true)
            
            self.healthattackingView.isHidden = true
            self.enemyNode.removeAnimation(forKey: "enemyHit")
            //self.GenerateMap(EditedImage)
        })
      //  self.healthProgressView.setProgress(newAmountProgress, animated: true)
       // self.healthProgressView.progress = newAmountProgress
        let animationDuration = 0.5
    
        
        
     //   healthTimer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(MapViewController.HealthUpdateTimer(_:)), userInfo: ["differenceAmount":"\(differenceAmount.description)","newAmount":"\(newAmount.description)","previousAmount":"\(previousAmountTemp)","setting":"\(settingTemp)"], repeats: true)
  
        
    }
    
    
    override func willRemoveSubview(_ subview: UIView) {
        
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
        
        ShootView.layer.cornerRadius = 25
        ShootView.layer.borderColor = UIColor.blue.cgColor
        ShootView.layer.borderWidth = 1
        
        closeBTN.layer.cornerRadius = 15
        closeBTN.layer.masksToBounds = true
        closeBTN.clipsToBounds = true
        
        innerShootView.layer.cornerRadius = 20
        innerShootView.layer.backgroundColor = UIColor.blue.cgColor
        
        
        lookGesture = UIPanGestureRecognizer(target: self, action: #selector(self.lookGestureRecognized(_:)))
        lookGesture.delegate = self
        self.addGestureRecognizer(lookGesture)
        
        //walk gesture
        walkGesture = UIPanGestureRecognizer(target: self, action: #selector(self.walkGestureRecognized(_:)))
        walkGesture.delegate = self
        self.addGestureRecognizer(walkGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapGesture.delegate = self
        self.sceneHolder.addGestureRecognizer(tapGesture)
        
        fireGesture = FireGestureRecognizer(target: self, action: #selector(self.fireGestureRecognized(_:)))
        fireGesture.delegate = self
        
        
        
        
        print("Attacking: My Altitude = \(MyAltitude)")
        
        
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
     
//         self.EnemyShouldNotMove = true
//        
//    self.enemyNode.addAnimation(enemyWalkAnimation, forKey: "walk")
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
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
    
     func SetUpScene() {
        
       self.EnemyShouldNotMove = true
        
        
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
        
        let scene = SCNScene(named: "PlayerAttackScene.scn")!
        
       // heroNode = attackSceneTemp.rootNode.childNode(withName: "hero", recursively: true)!
        
        //var heroNode = SCNNode()
        
        
        //-----------------
        
        self.heroNode = scene.rootNode.childNode(withName: "hero", recursively: true)!
        
        heroNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNCylinder(radius: 0.2, height: 3.7), options: nil))
        heroNode.physicsBody?.isAffectedByGravity = false
        heroNode.physicsBody?.angularDamping = 0.9999999
        heroNode.physicsBody?.damping = 0.9999999
        heroNode.physicsBody?.rollingFriction = 0
        heroNode.physicsBody?.friction = 0
        heroNode.physicsBody?.restitution = 0
        //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
        heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        heroNode.physicsBody?.categoryBitMask = CollisionCategory.Hero
        heroNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet ^ CollisionCategory.HeroHands
        if #available(iOS 9.0, *) {
            heroNode.physicsBody?.contactTestBitMask = ~0
        }
        
        
        MyAltitude = MyAltitude - 30
        
        
        switch MyAltitude {
            
        case _ where MyAltitude <= 10.0:
             heroNode.position = SCNVector3(x: -13, y: 3.5, z: -11)
           //heroNode.position = SCNVector3(x: 0, y: 3.5, z: 0)
        case _ where ((MyAltitude >= 10.000001) && (MyAltitude < 20.0)):
           heroNode.position = SCNVector3(x: -19.5, y: 13.5, z: -18)
            
        case _ where ((MyAltitude >= 20.000001) && (MyAltitude < 30.0)):
            heroNode.position = SCNVector3(x: -19.5, y: 23.5, z: -18)
            
        case _ where ((MyAltitude >= 30.000001) && (MyAltitude < 40.0)):
            heroNode.position = SCNVector3(x: -19.5, y: 33.5, z: -18)
            
            
        default:
            heroNode.position = SCNVector3(x: 0, y: 3.5, z: -18)
           // heroNode.position = SCNVector3(x: -13, y: 3.5, z: -11)
        }
        
        
        
        
        //if MyAltitude
        
        
      //  let heroHandsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")
        
        //-----------------
        
        var BodyGeometryNode = SCNNode()
        
       // let bodyNodeGeom = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0)//SCNPlane(width: 0.5, height: 1)
       // BodyGeometryNode = SCNNode(geometry: bodyNodeGeom)
        
        
        //IMPORT OBJECT FROM FILE*****
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
        

        
        enemyNode = SCNNode()
        enemyNode = EnemyNodeScene.node
        enemyNodeHolder = scene.rootNode.childNode(withName: "enemy", recursively: true)!
      //  enemyNode.position = SCNVector3(x: 0.0, y: 1.0, z: -8.0)
        EnemyNodeScene.lookAround()
        
        enemyNodeHolder.addChildNode(enemyNode)
        
        let RandomRotationX = arc4random_uniform(360) + 1
        // characterTopLevelNode.rotation.x = 180
        enemyNodeHolder.rotation.x = Float(RandomRotationX)
       // enemyNodeHolder
        
        
      // self.sceneHolder.scene?.rootNode.addChildNode(enemyNode)
      // enemyNode.position = SCNVector3(x: 0.0, y: 0.2, z: -8.0)
        
        
        
        
        
        
        
        
        
        heroHandsHolder = heroNode.childNode(withName: "camera", recursively: true)!.childNode(withName: "bulletStart", recursively: true)!
        
        targetNode = heroNode.childNode(withName: "camera", recursively: true)!.childNode(withName: "gunTarget", recursively: true)!
        
        bulletNodeStart = heroNode.childNode(withName: "camera", recursively: true)!.childNode(withName: "bulletStart", recursively: true)!
        
       // GunTipStart = f_index.01.R
        
        //scene.rootNode.addChildNode(enemyNode)

        
        
        var weaponScene = SCNScene()
        
        //*****CREATE PLAYER HANDS*****
        
        var handsScene = SCNScene()
        
              switch currentWeapon {
                case "Fist":
                handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                
                
                 self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle_R", recursively: true))!
                
                
                let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                knifeTemp.isHidden = true
                
                let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                gunTemp.isHidden = true
                
        
               
                HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Punch.dae")!
                HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Punch.dae")!
                
                
                
                
                // let handGeom = SCNSphere(radius: 0.01)
                //  let headGeom = SCNSphere(radius: 0.1)
                let weaponGeom = SCNSphere(radius: 1)
                let weaponPlane = SCNNode(geometry: weaponGeom)
                
                weaponPlane.physicsBody = SCNPhysicsBody.kinematic()
                weaponGeom.firstMaterial?.diffuse.contents = UIColor.red
                 weaponPlane.opacity = CGFloat(0)
                weaponPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: weaponPlane.geometry!, options: nil))
                weaponPlane.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                weaponPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    weaponPlane.physicsBody?.contactTestBitMask = ~0
                }
                weaponPlane.name = "fistPlane"
                heroHandRight.addChildNode(weaponPlane)
                
                
                // self.targetNode.isHidden = true
                
                case "Knife":
                // handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_Knife.dae")!
                
                print("Knife is current weapon from switch")
                
                handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                
                
                self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle_R", recursively: true))!
                
                let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                knifeTemp.isHidden = false
                
                let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                
               
                gunTemp.isHidden = true
                
                
                // self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle.R", recursively: true))!
                
                // weaponScene = SCNScene(named: "animate.scnassets/InfantryKnife3D.dae")!
                
                
                // let weaponScene = LoadAttackItems(weaponName: "InfantryKnife3D")
                
                //self.heroWeapon = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                
                
                HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Knife.dae")!
                
                HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Knife.dae")!
                
                
                
                
                let weaponGeom = SCNSphere(radius: 1)
                let weaponPlane = SCNNode(geometry: weaponGeom)
                
                weaponPlane.physicsBody = SCNPhysicsBody.kinematic()
                weaponGeom.firstMaterial?.diffuse.contents = UIColor.red
                weaponPlane.opacity = CGFloat(0)
                weaponPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: weaponPlane.geometry!, options: nil))
                weaponPlane.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                weaponPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    weaponPlane.physicsBody?.contactTestBitMask = ~0
                }
                weaponPlane.name = "knifePlane"
                //heroHandRight.addChildNode(handPlane)
                
                knifeTemp.addChildNode(weaponPlane)
                
                
                // self.targetNode.isHidden = true
                
                case "Gun":
                //handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_Gun.dae")!
                
                handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                
                
//                for child1 in handsScene.rootNode.childNodes {
//                    print("Child1 Name: \(child1.name)")
//                    for child2 in child1.childNodes {
//                        print("Child2 Name: \(child2.name)")
//                        for child3 in child2.childNodes {
//                            print("Child3 Name: \(child3.name)")
//                            for child4 in child3.childNodes {
//                                print("Child4 Name: \(child3.name)")
//                                for child5 in child4.childNodes {
//                                    print("Child5 Name: \(child5.name)")
//                                    for child6 in child5.childNodes {
//                                        print("Child6 Name: \(child6.name)")
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
                
                self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle_R", recursively: true))!
                
                
              //  self.heroHandRight = (handsScene.rootNode.childNode(withName: "hand.R", recursively: true))!
                
                let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                knifeTemp.isHidden = true
                
                let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                gunTemp.isHidden = false
                
               
                
                // weaponScene = SCNScene(named: "animate.scnassets/Gun3D.dae")!
                // let weaponScene = LoadAttackItems(weaponName: "InfantryKnife3D")
                
                self.heroWeapon = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                
                gunTemp.geometry?.firstMaterial?.diffuse.contents = UIColor.black
                
                
                HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Gun.dae")!
                HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Gun.dae")!
                
                //    self.targetNode.isHidden = false
                
                default:
                
                handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                
                
                self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle_R", recursively: true))!
                
                let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                knifeTemp.isHidden = true
                
                let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                gunTemp.isHidden = true
                
                

              
                
                
                let weaponGeom = SCNSphere(radius: 0.5)
                let weaponPlane = SCNNode(geometry: weaponGeom)
                
                weaponPlane.physicsBody = SCNPhysicsBody.kinematic()
                weaponGeom.firstMaterial?.diffuse.contents = UIColor.red
                 weaponPlane.opacity = CGFloat(0)
                weaponPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: weaponPlane.geometry!, options: nil))
                weaponPlane.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                weaponPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    weaponPlane.physicsBody?.contactTestBitMask = ~0
                }
                weaponPlane.name = "fistPlane"
              //  heroHandRight.addChildNode(weaponPlane)
                
                
                HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Punch.dae")!
                HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Punch.dae")!
                
                
                // self.targetNode.isHidden = true
        }
        
        
        //let handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_SMALL.dae")!
        heroHands = (handsScene.rootNode.childNode(withName: "basicRig", recursively: true))!
        
        gunTipTemp = (handsScene.rootNode.childNode(withName: "f_index_01_R", recursively: true))!
        
        let handModels = (handsScene.rootNode.childNode(withName: "basicRig_Body", recursively: true))!
        
        heroHands.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: handModels.geometry!, options: nil))
        
        heroHands.physicsBody?.categoryBitMask = CollisionCategory.HeroHands
        heroHands.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet ^ CollisionCategory.Hero
        if #available(iOS 9.0, *) {
            heroHands.physicsBody?.contactTestBitMask = ~0
        }
        
        heroHands.name = "heroHands"

        
        
        switch skinTone {
                case "white":
                        handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
        
                case "brown":
                        // handModels.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
                        self.heroHands.physicsBody?.isAffectedByGravity = false
        
                default:
                        handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
        }
        
        
        //heroHands.position = SCNVector3(x: 0, y: -0.5, z: -0.5)

        heroNode.addChildNode(handModels)
        //heroHands.addChildNode(handModels)
        heroHands.rotation = SCNVector4(0,4,2.6,M_PI)
        heroHands.rotation.y = 10
        
        //heroNode.addChildNode(heroHands)
        heroHandsHolder.addChildNode(heroHands)
        
        heroHands.position = SCNVector3(x: 0, y: -0.5, z: -1.0)
        
        HeroHandsRest.isRemovedOnCompletion = false
        self.heroHands.addAnimation(self.HeroHandsRest, forKey: "handsRest")
        
        
        
        
        
        
        
        
        
        
       //  -------ADD WALK ANIMATION
        enemyWalkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Walk.dae")!
       // enemyNode.addAnimation(walkAnimation, forKey: "walk")
        
        enemyHitAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch.dae")!
        enemyFallAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Falling.dae")!
        
        enemyFlailAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Flailing.dae")!
        
        enemyHitBellyAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch_Belly.dae")!
        
         enemyHitLegLAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Hit_Leg_L.dae")!
        enemyHitLegRAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Hit_Leg_R.dae")!
        
        enemyDeadAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Dead.dae")!
        
       
        
        
    
        
        HeroHandsRest.isRemovedOnCompletion = false
        self.heroHands.addAnimation(self.HeroHandsRest, forKey: "handsRest")
        

        
        //-----------------SET SKY AND FLOOR----------
        
        Sky = scene.rootNode.childNode(withName: "sky", recursively: true)!
        Floor = scene.rootNode.childNode(withName: "floor", recursively: true)!
        
        //self.heroHands = scene.rootNode.childNode(withName: "hands", recursively: true)!
        
      
        
        Loc1 = scene.rootNode.childNode(withName: "loc1", recursively: true)!
        Loc2 = scene.rootNode.childNode(withName: "loc2", recursively: true)!
        Loc3 = scene.rootNode.childNode(withName: "loc3", recursively: true)!
        Loc4 = scene.rootNode.childNode(withName: "loc4", recursively: true)!
        Loc5 = scene.rootNode.childNode(withName: "loc5", recursively: true)!
        
      
       
        //-----------------
        let grassMaterial = SCNMaterial()
        grassMaterial.diffuse.contents = UIImage(named: "grassTexture2.jpg")

        let GrassHolder = scene.rootNode.childNode(withName: "grassTiles", recursively: true)!
        
        
        //*****SET UP GRASS*****
        for GrassTiles in GrassHolder.childNodes {
            
           // if SceneTiles.name? == "
            
            switch GrassTiles.name {
                
                
                case "grass"?:
                  //  print("Grass scene tile found")
                GrassTiles.physicsBody?.categoryBitMask = CollisionCategory.grass
                GrassTiles.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet ^ CollisionCategory.EnemyEyes ^ CollisionCategory.EnemySense
                GrassTiles.geometry?.firstMaterial = grassMaterial
                GrassTiles.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: GrassTiles.geometry!, options: nil))
                GrassTiles.physicsBody?.isAffectedByGravity = false
               // GrassTiles.position =
                /*
                Grass = scene.rootNode.childNode(withName: "grass", recursively: true)!
                Grass.physicsBody?.collisionBitMask = CollisionCategory.All
                let grassMaterial = SCNMaterial()
                grassMaterial.diffuse.contents = UIImage(named: "grassTexture2.jpg")
                // Floor.geometry?.firstMaterial = grassMaterial
                Grass.geometry?.firstMaterial = grassMaterial
                */
                
                GrassNodes.append(GrassTiles)
                default:
                break
                
            }
            
        }
        
        
        //*****SET UP BUILDINGS*****
        
        
        
        
        let BuildingHolder = scene.rootNode.childNode(withName: "buildingHolder", recursively: true)!
        
        for buildings in BuildingHolder.childNodes {
          
            
            switch buildings.name {
                
                
            case "building"?:
                //  print("Fence scene tile found")
                //FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.Fence
                //FenceTiles.geometry = SCNPlane(width: 0.5, hieght, 0.5)
                //SCNCylinder(radius: 0.15, height: 0.6)
                
                
                // FenceTiles.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: FenceTiles.geometry!, options: nil))
                buildings.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: buildings.geometry!, options: nil))
                buildings.physicsBody?.mass = 10000
                buildings.physicsBody?.categoryBitMask = CollisionCategory.Building
                buildings.physicsBody?.collisionBitMask = CollisionCategory.Enemy | CollisionCategory.Hero | CollisionCategory.Bullet | CollisionCategory.BulletEnemy
               // buildings.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.grass
                buildings.physicsBody?.isAffectedByGravity = false
                buildings.name = "building"
                if #available(iOS 9.0, *) {
                    buildings.physicsBody?.contactTestBitMask = ~0
                }
                
            case "building1"?:
                //  print("Fence scene tile found")
                //FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.Fence
                //FenceTiles.geometry = SCNPlane(width: 0.5, hieght, 0.5)
                //SCNCylinder(radius: 0.15, height: 0.6)
                
                
                // FenceTiles.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: FenceTiles.geometry!, options: nil))
                buildings.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: buildings.geometry!, options: nil))
                buildings.physicsBody?.mass = 10000
                buildings.physicsBody?.categoryBitMask = CollisionCategory.Building
                buildings.physicsBody?.collisionBitMask = CollisionCategory.Enemy | CollisionCategory.Hero | CollisionCategory.Bullet | CollisionCategory.BulletEnemy
                // buildings.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.grass
                buildings.physicsBody?.isAffectedByGravity = false
                buildings.name = "building"
                if #available(iOS 9.0, *) {
                    buildings.physicsBody?.contactTestBitMask = ~0
                }
                
                // FenceTiles.physicsBody?.
                
                //BuildingNodes.append(buildings)
                
            default:
                break
                
            }
            
            
            
        }

        
        //-----------------
        //SET UP FENCE collisionBitMask
        let FenceHolder = scene.rootNode.childNode(withName: "fenceHolder", recursively: true)!
        
        for FenceTiles in FenceHolder.childNodes {
  
            switch FenceTiles.name {
                
                
            case "fence"?:
              //  print("Fence scene tile found")
                //FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.Fence
                //FenceTiles.geometry = SCNPlane(width: 0.5, hieght, 0.5)
                //SCNCylinder(radius: 0.15, height: 0.6)
                
                
               // FenceTiles.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: FenceTiles.geometry!, options: nil))
                FenceTiles.physicsBody?.categoryBitMask = CollisionCategory.Fence
                FenceTiles.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                FenceTiles.physicsBody?.isAffectedByGravity = true
               // FenceTiles.physicsBody?.
                
                FenceNodes.append(FenceTiles)
                
            default:
                break
                
            }
            
        }
        
        
        //*****SET UP BUILDINGS*****
        
        
        
        
        
        
//        //-----------------
//        let tempBox = scene.rootNode.childNode(withName: "box", recursively: true)!
//       
//        tempBox.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: tempBox.geometry!, options: nil))
//        tempBox.physicsBody?.categoryBitMask = CollisionCategory.Fence
//        tempBox.physicsBody?.collisionBitMask = CollisionCategory.All
//        //tempBox.physicsBody?.isAffectedByGravity = true

        
        
        //-----------------
        let skyMaterial = SCNMaterial()
        skyMaterial.diffuse.contents = UIImage(named: "skyTexture.jpg")
 
        
        //-----------------
        
        camNode = heroNode.childNode(withName: "camera", recursively: true)!
        
        
       
        //*****ADD CAMERA*****
        let cameraNode = SCNNode()

        let camera = SCNCamera()
        camera.zNear = 0.01
            // camera.zFar = Double(max(map.width, map.height))
        camera.zFar = Double(max(1000, 1000))
        camNode.camera = camera
        heroNode.addChildNode(camNode)
        
        
    
        

        
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
       
        
        
        // Bob.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
        
        //let scnView = self.view as! SCNView
        self.sceneHolder.scene = scene
       
        scene.rootNode.addChildNode(heroNode)
      
        
        
        
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
        
        
        self.ActiveLocations.append(Loc1)
        self.ActiveLocations.append(Loc2)
        //self.attackScene.dele
        
        
        
        randomLoc.append(Loc5)
        randomLoc.append(Loc5)
        randomLoc.append(Loc5)
        randomLoc.append(Loc5)
        randomLoc.append(Loc5)
        randomLoc.append(Loc5)
        randomLoc.append(Loc4)
        randomLoc.append(Loc3)
        randomLoc.append(Loc3)
        
        
    }
    
    
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {

        print("CONTACT INFO: \(contact)")
        
        
        let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        
        let contactMask2 = contact.nodeB.physicsBody!.categoryBitMask | contact.nodeA.physicsBody!.categoryBitMask
        
        
        if contact.nodeA.name != "" && contact.nodeB.name != "" {
        print("contact occurred: \(contactMask)")
        print("NODE A: \(contact.nodeA.name)")
         print("contact occurred: \(contactMask2)")
        print("NODE B: \(contact.nodeB.name)")
        }
        
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
            
            
           // EnemyWalkingAway = true
            
            
            if !alreadyHit {
                alreadyHit = true
                let type: NSString = "willAttack"
                
                let yesSuccess =  AttackNotice(self.username, username: self.AttackingPlayer as NSString, attackpower: self.AttackPower, type: type, attackedID: AttackingPlayerID as NSString)
                print("***Atttack Notice sent = \(yesSuccess)")
                
               // self.enemyNode.addAnimation(self.enemyFlailAnimation, forKey: "flail")
                
               // EnemyNodeScene.GotHit(location: "head")
                
            }
            
           // let CurrentHealthAmount = 100
            var NewHealthAmount = Int()
            
         //   NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateAttackingHealth"), object: nil, userInfo: ["previousAmount":"\(CurrentHealthAmount.description)","newAmount":"\(NewHealthAmount.description)","setting":"subtract"])
            
            let audioSource = SCNAudioSource(fileNamed: "animate.scnassets/male_uh.mp3")!
            let audioPlayer = SCNAudioPlayer(source: audioSource)
            //enemyNode.addAudioPlayer(audioPlayer)
            
            switch contact.nodeA.name {
                case "headFrontPlane"?:
                NewHealthAmount = 50
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "headFront")
                    //self.enemyNode.addAnimation(self.enemyFallAnimation, forKey: "enemyDied")
                case "headBackPlane"?:
                NewHealthAmount = 50
                EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "headBack")
                
                case "bodyPlane"?:
                    EnemyWalkingAway = true
                    NewHealthAmount = 10
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "body")
                
                
                case "legRPlane"?:
                EnemyWalkingAway = false
                NewHealthAmount = 2
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "legR")
                
                
                case "legLPlane"?:
                EnemyWalkingAway = false
                NewHealthAmount = 2
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "legL")
                
                
                case "spineFPlane"?:
                EnemyWalkingAway = true
                NewHealthAmount = 10
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "spineFront")
                
                case "spineBPlane"?:
                EnemyWalkingAway = true
                NewHealthAmount = 10
                EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "spineBack")
                
                
                default:
                NewHealthAmount = 10
                    EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "spineFront")
            }
            
            enemyHitAnimation.repeatCount = 1
            //enemyNode.addAnimation(enemyHitAnimation, forKey: "enemyHit")
            
            //self.enemyFlailAnimation.re
         
           
        
            if !PlayingEnemySound {
                self.PlayingEnemySound = true
            let uhsound = SCNAction.playAudio(audioSource, waitForCompletion: true)
            //enemyNode.runAction(uhsound)
            
            enemyNode.removeAudioPlayer(audioPlayer)
            }
            
           // enemyNode.
            
            updateUserHealth(current: self.EnemyHealth, new: NewHealthAmount, setting: "substract", nodeName: contact.nodeA.name!)
            
           // enemyNode.
            
            
        }
        
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Fence) || contactMask2 == (CollisionCategory.Fence | CollisionCategory.Bullet)){
            print("Bullet Collided with Fence")
        }
        
        if (contactMask == (CollisionCategory.Enemy | CollisionCategory.Fence) || contactMask2 == (CollisionCategory.Fence | CollisionCategory.Enemy)){
            print("Enemy Collided with Fence")
        }
        
        if (contactMask == (CollisionCategory.Enemy | CollisionCategory.Building) || contactMask2 == (CollisionCategory.Building | CollisionCategory.Enemy)){
            print("Enemy Collided with Building")
        }
        
        if (contactMask == (CollisionCategory.EnemySense | CollisionCategory.Building) || contactMask2 == (CollisionCategory.Building | CollisionCategory.EnemySense)){
            print("Enemy Sense Hit Building")
            
            
            var bumpedLocation = String()
            
            switch contact.nodeA.name {
            case "enemyBSense"?:
                
                bumpedLocation = "back"
                EnemyDumpBack = true
            case "enemyFSense"?:
                
                bumpedLocation = "front"
                EnemyDumpFront = true
            case "enemyLSense"?:
                
                bumpedLocation = "left"
            case "enemyRSense"?:
                
                bumpedLocation = "right"
            default:
                
                bumpedLocation = "front"
               
                break
                //EnemyHit(NewHealthAmount: NewHealthAmount, EnemyHealthTemp: EnemyHealth, hitLocation: "spineFront")
            }

            
            
            print("Bumped Location: \(bumpedLocation)")
            
            if EnemyWalkingAway {
                
                print("Enemy Walking and hit wall")
                
                let direction = characterDirection(towards: "test", adjustAngle: "\(bumpedLocation)")
                
                self.EnemyNodeScene.TurnWalkDirection(bumpedLocation: bumpedLocation)
                
               // EnemyWalkingAway = false
                
            } else {
                print("Enemy NOT Walking and hit wall")
                
            }
            
           
            EnemyWalkingAway = false
            
            
            
        }
        
        if (contactMask == (CollisionCategory.EnemyEyes | CollisionCategory.Hero) || contactMask2 == (CollisionCategory.Hero | CollisionCategory.EnemyEyes)){
            EnemyWalkingAway = true
        }
        
        
    }
    
    
    func EnemyHit(NewHealthAmount: Int, EnemyHealthTemp: Int, hitLocation: String) {
        
        
        if (EnemyHealthTemp - NewHealthAmount) <= 0 {
            if self.showBlood {
                self.addBloodSpatter()
            }
            self.enemyFallAnimation.repeatCount = 1
            self.enemyFallAnimation.duration = 5.0
            
            EnemyWalkingAway = false
            
            EnemyHitLocation(location: hitLocation, isDead: true, stopWalking: true)
            
            //self.enemyNode.addAnimation(self.enemyFallAnimation, forKey: "enemyDied")
            print("Should add enmy died animation")
            
        } else {
           // EnemyWalkingAway = false
            print("***ENEMY GOT HIT - LOCATION: \(hitLocation)")
            EnemyHitLocation(location: hitLocation, isDead: false, stopWalking: false)
            
            /*
            switch hitLocation {
                
                case "head":
                    enemyHitAnimation.repeatCount = 1
                    // enemyNode.addAnimation(enemyHitBellyAnimation, forKey: "enemyHitBelly")
                    EnemyNodeScene.GotHit(location: "head")
                    EnemyHitLocation(location: hitLocation)
                
                case "legL":
                    enemyHitLegLAnimation.repeatCount = 1
                    // enemyNode.addAnimation(enemyHitBellyAnimation, forKey: "enemyHitBelly")
                    EnemyNodeScene.GotHit(location: "legL")
                
                case "legR":
                    enemyHitLegRAnimation.repeatCount = 1
                    // enemyNode.addAnimation(enemyHitBellyAnimation, forKey: "enemyHitBelly")
                    EnemyNodeScene.GotHit(location: "legR")
                
                case "body":
                    enemyHitBellyAnimation.repeatCount = 1
                    // enemyNode.addAnimation(enemyHitBellyAnimation, forKey: "enemyHitBelly")
                    EnemyNodeScene.GotHit(location: "body")
                
                case "spine":
                    enemyHitBellyAnimation.repeatCount = 1
                    EnemyNodeScene.GotHit(location: "spine")
                
            default:
                enemyHitBellyAnimation.repeatCount = 1
                // enemyNode.addAnimation(enemyHitBellyAnimation, forKey: "enemyHitBelly")
                EnemyNodeScene.GotHit(location: "body")
                
            }
            */
        }
    }
    
    
    func EnemyHitLocation(location: String, isDead: Bool, stopWalking: Bool) {
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.EnemyNodeScene.GotHit(location: "\(location)", isDead: isDead, stopWalking: stopWalking)
            
        }, completion: { finish in
            
            UIView.animate(withDuration: 0.1, delay: 0.4, options: UIViewAnimationOptions.curveEaseIn, animations: {
                print("Completion complete: EnemyWalkingAway is now true")
                //DO 2ND ANIMATION
                self.EnemyWalkingAway = true
                
            }, completion: nil)
            
        })
        
    }
    
    func updateEnemy() {

        let randomIndex = Int(arc4random_uniform(UInt32(ActiveLocations.count)))
        
       // print(ActiveLocations[randomIndex])
        let MoveToLoc = ActiveLocations[randomIndex]
       // let MoveToLoc = ActiveLocations[0]
        
        
        var targetPosition = MoveToLoc.presentation.position
        
    
        
       
        
        //let targetPosition = heroNode.presentation.position
        let currentPosition = enemyNode.position
        
        var diffX = currentPosition.x - targetPosition.x
        var diffY = currentPosition.y - targetPosition.y
        var diffZ = currentPosition.z - targetPosition.z
        
        
       // print("diff X: \(diffX)")
       // print("diff Y: \(diffY)")
       // print("diff Z: \(diffZ)")
        
        // print("ENEMY CURRENT POSITION: \(currentPosition)")
        // print("TARGET POSITION: \(targetPosition)")
        
       // let AtanTemp = atan2(currentPosition.z - targetPosition.z, currentPosition.x - targetPosition.x)
        
        let AtanTemp = atan2(currentPosition.z - 0, currentPosition.x - 1)
        
        
        
        //print("AtanTemp: \(AtanTemp)")
        
        let AtanTemp2 = CGFloat(AtanTemp)
        //let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
        let angle = AtanTemp2 + CGFloat(M_PI)
        //print("Angle: \(angle)")
        
       // let rotateAction = SCNAction.rotateTo(x: angle + CGFloat(M_PI*0.5), y: 0, z: angle + CGFloat(M_PI*0.5), duration: 0.0)
        
        
       
        
        
        
     
           
            let rotateAction = SCNAction.rotateTo(x: angle + CGFloat(M_PI*0.5), y: 0, z: 0, duration: 0.0)
            // enemyNode.runAction(rotateAction)
            //enemyNode.rotate.y =
          //  enemyNode.rotation.x = Float(angle + CGFloat(M_PI*0.5))
            
       
        let velocityXtemp = EnemySpeed * cos(angle)
        let velocityX = Float(velocityXtemp)
        let velocityYtemp = EnemySpeed * sin(angle)
        
        let velocityY = Float(velocityYtemp)
       
        //   let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
        //let newVelocity = SCNVector3(x: velocityX, y: velocityY, z: 0)
        let newVelocity = SCNVector3(x: velocityX, y: 0, z: velocityY)
        
       // print("New Velocity: \(newVelocity)")
       // print("enemy node phyiscsbody: \(enemyNode.physicsBody!)")
       // print("enemy node phyiscsbody velocity: \(enemyNode.physicsBody!.velocity)")
       // enemyNode.physicsBody!.velocity = newVelocity;
        
       // enemyNode.physicsBody!.velocity = newVelocity;
      //  enemyBody.
        
        
        
        
        
        
       // let enemyAngle = enemyNode.presentation.rotation.w * enemyNode.presentation.rotation.y
        
//        print("enemy Angle: \(enemyAngle)")
//        //let enemyAngle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
//        var enemyImpulse = SCNVector3(x: max(-1, min(1, Float(Loc1.position.x) / 50)), y: 0, z: max(-1, min(1, Float(-Loc1.position.y) / 50)))
//        
//        enemyImpulse = SCNVector3(
//            x: enemyImpulse.x * cos(enemyAngle) - enemyImpulse.z * sin(enemyAngle),
//            y: 0,
//            z: enemyImpulse.x * -sin(enemyAngle) - enemyImpulse.z * cos(enemyAngle)
//        )
//        
//        
//        print("enemy Impulse: \(enemyImpulse)")
//        //create Item Vector
//        print("enemy should move")
//        
//        enemyRootNode.physicsBody?.applyForce(enemyImpulse, asImpulse: true)
        
      //  print("EnemyNode Position: \(enemyNode.position)")
       
        
        
        var moveLeft = SCNAction.moveBy(x: -0.1, y: 0, z: 0, duration: 0.0)
        var moveRight = SCNAction.moveBy(x: 0.1, y: 0, z: 0, duration: 0.0)
        
//        switch enemyNode.position.x {
//            
//            
//        //case <-30:
//        case _ where enemyNode.position.x < -30:
//            
//            moveRight.timingMode = SCNActionTimingMode.easeInEaseOut;
//            moveRight.speed = 0.1
//            enemyNode.runAction(moveRight)
//            
//        case _ where enemyNode.position.x > 30:
//            
//            
//            moveLeft.timingMode = SCNActionTimingMode.easeInEaseOut;
//            moveLeft.speed = 0.1
//            enemyNode.runAction(moveLeft)
//            
//            
//        default:
//            moveLeft.timingMode = SCNActionTimingMode.easeInEaseOut;
//            moveLeft.speed = 0.1
//            enemyNode.runAction(moveLeft)
//            
//            
//        }
        
        
        
        if enemyNode.position.x > 30 {
        
            EnemyMoveDirection = "left"
            
             enemyNode.rotation.x = 180
            // enemyNode.rotation.z = -90
            
        } else if enemyNode.position.x < -30 {
            EnemyMoveDirection = "right"
            
            enemyNode.rotation.x = 180
          //  enemyNode.rotation.z = 90
        }
        
        if !EnemyShouldNotMove {
        
        switch EnemyMoveDirection {
            
        case "right":
        
        moveRight.timingMode = SCNActionTimingMode.easeInEaseOut;
        moveRight.speed = 0.1
        enemyNode.runAction(moveRight)
          //  enemyNode.transform = SCNMatrix4Mult(enemyNode.transform, SCNMatrix4MakeRotation(Float(M_PI), 0, 1, 0))
        
        case "left":
            
           
            
            moveLeft.timingMode = SCNActionTimingMode.easeInEaseOut;
            moveLeft.speed = 0.1
            enemyNode.runAction(moveLeft)
           // enemyNode.transform = SCNMatrix4Mult(enemyNode.transform, SCNMatrix4MakeRotation(Float(M_PI), 1, 0, 0))
            
        default:
            break
        }
            
        }
        
    }
    
    
    
    func updateUserHealth(current: Int, new: Int, setting: String, nodeName: String) {
        
        
       
        
        var newAmount = Int()
        //   print("Update Money New Amount?: \(newAmount)")
      //  let differenceAmount = newAmount - previousAmount!
        
        
        // print("UPDATE MONEY TYPE = \(settingTemp)")
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        if setting == "add" {
            //self.GoldCollectedAmountLBL.text = "+\(newAmountTemp)"
            newAmount =  current + new
            if newAmount > 100 {
                newAmount = 100
            }
        } else {
            //self.GoldCollectedAmountLBL.text = "-\(newAmountTemp)"
            newAmount = current - new
            
            if newAmount < 0 {
                newAmount = 0
            }
        }
        
        
        self.EnemyHealth = newAmount
        
        let newAmountDouble = Double(newAmount)
        let tc = Double(100)
      
        let tempP = newAmountDouble / tc
        
        // let hitprogress = Float(tempP)
        
        
        let newAmountProgress = Float(tempP)
        print("new amount progress: \(newAmountProgress)")
        
        
        DispatchQueue.main.async(execute: {
            //print("generating Map now")
            self.healthProgressView.setProgress(newAmountProgress, animated: true)
            self.PlayingEnemySound = false
            
            if newAmount == 0 {
                
                self.sceneHolder.isPlaying = false
                
                self.AttackStaminaAmountStart = "50"
                self.AttackGoldAmountStart = "50"
                
                 self.prefs.set(["attackStatus":"complete", "attackStamina":"\(self.AttackStaminaAmountStart)", "attackGold":"\(self.AttackGoldAmountStart)"], forKey: "AttackCompletedDictionary")
                
                
                self.EnemyDead = true
                self.EnemyShouldNotMove = true
//                if self.showBlood {
//                    self.addBloodSpatter()
//                }
                
//                self.enemyFallAnimation.repeatCount = 1
//                self.enemyNode.addAnimation(self.enemyFallAnimation, forKey: "enemyDied")
                
                
                
                let seconds = 0.5
                let secondsLoad = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
                
                
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    // self.buttonViewW.constant = 20
                    //  self.buttonViewH.constant = 20
                    //  self.AbilityBTN.frame.size.width = 80
                    //  self.AbilityBTN.frame.size.height = 80
                    
                    // self.buttonViewY.constant = -40
                    
                    //self.removeFromSuperview()
                    
                    self.enemyDeadAnimation.repeatCount = 1
                    self.enemyDeadAnimation.autoreverses = true
                    self.enemyDeadAnimation.duration = 10.0
                   // self.enemyNode.addAnimation(self.enemyDeadAnimation, forKey: "enemyDead")
                    print("Should add enemy died animation")
                    
                  //  prefs.set(["attackStatus":"complete", "attackStamina":"\(self.AttackStaminaAmount)", "attackGold":"\(self.AttackGoldAmount)"], forKey: "AttackCompletedDictionary")
                    
                   // DispatchQueue.main.async(execute: {
                   // self.removeFromSuperview()
                    //self.targetEliminated()
                   // })
                      if !self.ClosingView {
                        
                       self.ClosingView = true
                    DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    
                        
                        DispatchQueue.main.async(execute: {
                          //  self.removeFromSuperview()
                            
                           
                            self.TargetEliminated()
                            
                            
                        })
                        
                    })
                        
                    }
                    
                    
                })
                
                
                self.enemyDeadAnimation.repeatCount = 1
               
                
                
            }
           // self.healthattackingView.isHidden = true
            //self.GenerateMap(EditedImage)
        })
        
        //healthProgressView.setProgress(newAmountProgress, animated: true)
        
        let animationDuration = 0.5
        
        if newAmount == 0 {
            
            print("Target eliminated")
            
            
            
            
        }

        
    }
    
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
        elevationBullet = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + vAngle))
        
        //LIMIT CAMERA TILT DOWN
//        if elevation < -0.11 {
//            elevation = -0.11
//            print("tilted too low")
//        }
        
        
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
    
    private func characterDirection(towards: String, adjustAngle: String) -> float3 {
        
        var Direction = String()
        var shouldAdjustAngle = Bool()
        
        var adjustX: Float = 0.0
        var adjustZ: Float = 0.0
        
        if adjustAngle != "" {
            switch adjustAngle {
                
              case "front":
                Direction = "left"
                shouldAdjustAngle = true
                adjustX = 0.5
                adjustZ = 0.5
              default:
                break
            }
        }
        
        //let controllerDirection = SCNVector3(x: 10, y: 1, z: -20)
        
        var cd_x = 10 + adjustX
        var cd_z = -20 + adjustZ
        
        let controllerDirection = SCNVector3(x: cd_x, y: 1, z: cd_z)

        // let controllerDirection = self.controllerDirection()
        var direction = float3(controllerDirection.x, 0.0, controllerDirection.y)
        
        
        
        if towards != "hero" {
            
            
            var currentPosition = EnemyNodeScene.node.position
            var targetPosition = Loc5.presentation.position
            
            print("ENEMY CURRENT POSITION: \(currentPosition)")
            print("TARGET POSITION: \(targetPosition)")
            
            
            let location = Loc5.position
            
            //Aim
            let dx = location.x - currentPosition.x
            let dy = location.y - currentPosition.y
            let angle = CGFloat(atan2(dy, dx))
            
            //+ CGFloat(M_PI)
            
            //let angle = CGFloat(atan2(dy, dx))
            //let angle = AtanTemp2 + CGFloat(M_PI)
            
            
            //Seek
            let vx = cos(angle) * EnemySpeed
            let vy = sin(angle) * EnemySpeed
            
            currentPosition.x += Float(vx)
            currentPosition.y += Float(vy)
            
            
            
            //let heroDirection = float3(x: heroNode!.presentation.position.x, y: 0, z: heroNode!.presentation.position.z)
            let heroDirection = float3(x: targetPosition.x - currentPosition.x, y: 0, z: targetPosition.z - currentPosition.z)
            
            print("Direction Towards: \(heroDirection)")
            
            if let pov = sceneHolder.pointOfView {
                let p1 = pov.presentation.convertPosition(SCNVector3(heroDirection), to: nil)
                let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
                
//                if shouldAdjustAngle {
//                  direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
//                } else {
//                  direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
//                }
                
               // direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
                
                if direction.x != 0.0 || direction.z != 0.0 {
                    direction = normalize(direction)
                }
            }
            
            
            
//            if let pov = sceneHolder.pointOfView {
//                let p1 = pov.presentation.convertPosition(SCNVector3(direction), to: nil)
//                let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
//                
//                direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
//                
//                if direction.x != 0.0 || direction.z != 0.0 {
//                    direction = normalize(direction)
//                }
//            }
            
        } else {
            
            
            var currentPosition = EnemyNodeScene.node.position
            var targetPosition = heroNode.presentation.position
            
            
            print("ENEMY CURRENT POSITION: \(currentPosition)")
            print("TARGET POSITION: \(targetPosition)")
            
            
            let location = heroNode.position
            
            //Aim
            let dx = location.x - currentPosition.x
            let dy = location.y - currentPosition.y
            let angle = CGFloat(atan2(dy, dx))
            
            //+ CGFloat(M_PI)
            
            //let angle = CGFloat(atan2(dy, dx))
            //let angle = AtanTemp2 + CGFloat(M_PI)
            
            
            //Seek
            let vx = cos(angle) * EnemySpeed
            let vy = sin(angle) * EnemySpeed
            
            currentPosition.x += Float(vx)
            currentPosition.y += Float(vy)
            
            
            
            //let heroDirection = float3(x: heroNode!.presentation.position.x, y: 0, z: heroNode!.presentation.position.z)
            
            
            
            
            
            
            
            
            
            
            
            
            let heroDirection = float3(x: targetPosition.x - currentPosition.x, y: 0, z: targetPosition.z - currentPosition.z)
            
            print("Away from Hero...Direction Towards: \(heroDirection)")
            
            if let pov = sceneHolder.pointOfView {
                let p1 = pov.presentation.convertPosition(SCNVector3(heroDirection), to: nil)
                let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
                
                print("X SUM = \(Float(p1.x - p0.x + adjustX))")
                print("Z SUM = \(Float(p1.z - p0.z + adjustZ))")
                
              //  direction = float3(Float(p1.x - p0.x + adjustX), 0.0, Float(p1.z - p0.z + adjustZ))
                
                direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
                
                if direction.x != 0.0 || direction.z != 0.0 {
                    direction = normalize(direction)
                }
            }
            
            
        }
        
        print("Direction: \(direction)")
        return direction
    }
    
    
    func groundTypeFromMaterial(_ material: SCNMaterial) -> GroundType {
        /*
         if material == grassArea {
         return .grass
         }
         if material == waterArea {
         return .water
         }
         else {
         return .rock
         }
         */
        return .grass
    }
    
    func updateCameraWithCurrentGround(_ node: SCNNode) {
        
        /*
         if gameIsComplete {
         return
         }
         
         if currentGround == nil {
         currentGround = node
         return
         }
         
         // Automatically update the position of the camera when we move to another block.
         if node != currentGround {
         currentGround = node
         
         if var position = groundToCameraPosition[node] {
         if node == mainGround && EnemyNodeScene.node.position.x < 2.5 {
         position = SCNVector3(-0.098175, 3.926991, 0.0)
         }
         
         let actionY = SCNAction.rotateTo(x: 0, y: CGFloat(position.y), z: 0, duration: 3.0, usesShortestUnitArc: true)
         actionY.timingMode = .easeInEaseOut
         
         let actionX = SCNAction.rotateTo(x: CGFloat(position.x), y: 0, z: 0, duration: 3.0, usesShortestUnitArc: true)
         actionX.timingMode = .easeInEaseOut
         
         //cameraYHandle.runAction(actionY)
         //cameraXHandle.runAction(actionX)
         }
         }
         
         */
    }
    
    
    func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        
        var HeroEnemyDistance = heroNode.position.distance(vector: EnemyNodeScene.node.position)
        
        
        if HeroEnemyDistance < 1 {
            print("Start fire weapon")
            EnemyNodeScene.fireWeapon()
        }
        
        HeroEnemyDistance = 20
        
        
        //  if startScene {
        
        if EnemyWalkingAway {
            
            
            let randomIndex = Int(arc4random_uniform(UInt32(randomLoc.count)))
            
            // print(ActiveLocations[randomIndex])
            RandomTarget = randomLoc[randomIndex]
            EnemyNodeScene.StartMoving(action: "run")
           // EnemyNodeScene.
            
                        // self.EnemyRandomMovements(time: time)
            
            var adjustAngle = String()
            
//            if EnemyDumpFront {
//                adjustAngle = "front"
//            }
//            
//            EnemyDumpFront = false
            
                        let direction = characterDirection(towards: EnemyTarget, adjustAngle: adjustAngle)
            
            
                     //   let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneHolder.scene!, groundTypeFromMaterial:groundTypeFromMaterial, action: "walk", target: EnemyTarget, heroDistance: HeroEnemyDistance)
            
             let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneHolder.scene!, action: "run", target: EnemyTarget, heroDistance: HeroEnemyDistance)
            
            // let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneHolder.scene!, groundTypeFromMaterial: groundTypeFromMaterial, action: "run", target: EnemyTarget, heroDistance: HeroEnemyDistance)
            
            
                        if let groundNode = groundNode {
                            updateCameraWithCurrentGround(groundNode)
                        }
                        
                        // EnemyNodeScene.lookAround()
            
            
            
        }
        
        
        if !EnemyRunningAway {
            
//            // self.EnemyRandomMovements(time: time)
//            
//            let direction = characterDirection(towards: EnemyTarget)
//            
//            
//            let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneHolder.scene!, groundTypeFromMaterial:groundTypeFromMaterial, action: "walk", target: EnemyTarget, heroDistance: HeroEnemyDistance)
//            
//            // let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial: GroundType.grass)
//            
//            
//            if let groundNode = groundNode {
//                updateCameraWithCurrentGround(groundNode)
//            }
//            
//            // EnemyNodeScene.lookAround()
            
            
        }
        
        
        
        
        if !self.EnemyDead {
            
            
            // UPDATE RESPONSE ATTACK 130K SCRIPTS RAN ERROR
            
            
            /*
             UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID, response: "", action: "read") {
             (result, attackResponse) in
             //  if let AttackResponseUpdated = result {
             // print("Response Updated: \(result), response: \(attackResponse)")
             
             
             if attackResponse == "run" {
             self.EnemyShouldNotMove = false
             self.enemyNode.removeAnimation(forKey: "flail")
             self.enemyNode.addAnimation(self.enemyWalkAnimation, forKey: "walk")
             // self.enemyNode.addAnimation(self.enemyFlailAnimation, forKey: "flail")
             }
             
             }
             
             */
            
            
        }
        
        //}
        
       // print("ENEMY ROOT NODE POSITION: \(enemyRootNode.position)")
       // print("ENEMY NODE POSITION: \(enemyNode.position)")
        
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
                let angleBullet = bulletNodeStart.presentation.rotation.w * bulletNodeStart.presentation.rotation.y
                print("HERO ANGLE: \(angle)")
                print("BULLET ANGLE: \(angleBullet)")
                
                var direction = SCNVector3(x: -sin(angle), y: 0, z: -cos(angle))
                var directionBullet = SCNVector3(x: -sin(angleBullet), y: 0, z: -cos(angleBullet))
                
               // print("HERO Direction: \(direction)")
               // print("BULLET Direction: \(directionBullet)")
                
                
               // print("HERO Direction1: \(direction)")
               // print("BULLET Direction1: \(directionBullet)")
                //get elevation
                direction = SCNVector3(x: cos(elevation) * direction.x, y: sin(elevation), z: cos(elevation) * direction.z)
                directionBullet = SCNVector3(x: cos(elevation) * directionBullet.x, y: sin(elevation), z: cos(elevation) * directionBullet.z)
                
                
               // print("HERO Direction2: \(direction)")
               // print("BULLET Direction2: \(directionBullet)")
                
                
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
                    
              // bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
               
               let bulletGeom = SCNSphere(radius: CGFloat(bulletRadius))
                
                //bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
                
                bulletNode.geometry = bulletGeom
                
                
                bulletNode.name = "bullet"
                
                let GoldBullet = UIColor(red: CGFloat(190/255), green: CGFloat(198/255), blue: CGFloat(95/255), alpha: 1.0)
                
                
                
                bulletNode.geometry?.firstMaterial?.diffuse.contents = GoldBullet
               // bulletNode.geometry = bulletGeometryTest.geometry
                
                // 0.4 Height
                
                
                
                // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
                
              //  bulletNode.position = SCNVector3(x: heroNode.presentation.position.x + 0.2, y: 2.5, z: heroNode.presentation.position.z - 1.25)
                
                  bulletNode.position = SCNVector3(x: heroNode.presentation.position.x + 0.2, y: heroNode.presentation.position.y - 1, z: heroNode.presentation.position.z - 0.25)
                
               // bulletNode.position = SCNVector3(x: gunTipTemp.presentation.position.x, y: 0.0, z: gunTipTemp.presentation.position.z)
                
                
               // print("hero node z: \(heroNode.presentation.position.z - 2)")
               // print("gunTipTemp Z: \(gunTipTemp.presentation.position.z)")
                    
                
               // bulletNode.position = SCNVector3(x: bulletNodeStart.presentation.position.x, y: 2.5, z: bulletNodeStart.presentation.position.z - 0.5)
                
               // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 2.5, z: bulletNodeStart.presentation.position.z - 0.5)
                
                
                
              //   bulletNode.position = SCNVector3(x: camNode.presentation.position.x, y: 2.5, z: camNode.presentation.position.z + 1)
                
                
                //bulletNode.position = SCNVector3(x: bulletNodeStart.position.x + 0.2, y: 2.5, z: bulletNodeStart.position.z + 1)
                
                
                
                
                
               // bulletNode.rotation  = SCNVector4(x: 6, y: 80, z: 31, w: elevation)
                
                bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                
                //bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                bulletNode.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Hero ^ CollisionCategory.HeroHands ^ CollisionCategory.EnemySense
                //bulletNode.physicsBody?.collisionBitMask = CollisionCategory.Enemy
               // bulletNode.physicsBody?.gra
                //ANGLED VELOCITY (UP)
                //bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1.5, z: 1)
                bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1, z: 1)
                
                //BULLET PHYSICS
                bulletNode.physicsBody?.angularDamping = 0.9999999
               // bulletNode.physicsBody?.damping = 0.9999999
                bulletNode.physicsBody?.damping = 0
                bulletNode.physicsBody?.rollingFriction = 0
                bulletNode.physicsBody?.friction = 0
                bulletNode.physicsBody?.restitution = 0
                
//                  bulletNode.physicsBody?.angularDamping = 0.05
//                  bulletNode.physicsBody?.damping = 0.9999999
//                  bulletNode.physicsBody?.rollingFriction = 0
//                  bulletNode.physicsBody?.friction = 0
//                  bulletNode.physicsBody?.restitution = 0
                
                
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
                
                let bi_x = direction.x * Float(bulletImpulse)
                let bi_y = direction.y * Float(bulletImpulse)
                let bi_z = direction.z * Float(bulletImpulse)
                
                //apply impulse
                let impulse = SCNVector3(x: direction.x * Float(bulletImpulse), y: direction.y * Float(bulletImpulse), z: direction.z * Float(bulletImpulse))
   
//                print("Elevation: \(elevation)")
//                print("Bullet impulse x: \(bi_x)")
//                print("Bullet impulse y: \(bi_y)")
//                print("Bullet impulse z: \(bi_z)")
                
                
                bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
               // bulletNode.physicsBody?.isAffectedByGravity = false
                
                bulletNode.physicsBody?.mass = 1
                let rotate = SCNAction.rotate(by: CGFloat(M_PI), around:SCNVector3Make(0, 1, 0), duration: TimeInterval(10.0))
                
                let repeatAction = SCNAction.repeatForever(rotate)
                // bulletNode.runAction(repeatAction)

                let rad = Double(bulletNode.eulerAngles.y)
                var angleInDegrees = fmodf(360.0 + -Float(rad) * (180.0 / Float(M_PI)), 360.0)
             //   print("eulerAngles.y rad:\(rad) degree:\(angleInDegrees)")

                    
                self.HeroHandsAttack.speed = 2.0
                self.HeroHandsAttack.repeatCount = 1
                self.heroHands.addAnimation(self.HeroHandsAttack, forKey: "handsPunch")
                    
                    
                default:
                    
                    
                    self.HeroHandsAttack.speed = 2.0
                    self.HeroHandsAttack.repeatCount = 1
                    self.heroHands.addAnimation(self.HeroHandsAttack, forKey: "handsPunch")
                
                
                    
        }

                //update timestamp
                lastFired = now

            }
        }
        
        
        
        //Update the Bad Guys
       // updateZombies()
       // updateEnemy()
        
       

    
    }
    
    
    @IBAction func shootBTN(_ sender: AnyObject) {
        
        //  DoubleTapGesture.enabled = false
        
        
        
        if !OutOfAmmo {
            
            let now = CFAbsoluteTimeGetCurrent()
            if now - lastTappedFire < autofireTapTimeThreshold {
                tapCount += 1
            } else {
                tapCount = 1
            }
            lastTappedFire = now
            
            
           // NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateAmmoNotification"), object: nil)
            
        } else {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Out Of Ammo"
            alertView.message = "You're out of ammo!"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
        //     DoubleTapGesture.enabled = true
        
    }
    
    
    func AttackComplete() {
        
        
        
        UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID, response: "", action: "write") {
            (result, attackResponse) in
            print("Attack Complete Response Updated To Nil: \(result), attackResponse: \(attackResponse)")
        }
        
        
        
        print("ATTACK COMPLETE NOW")
        
         //AttackPowerTemp = prefs.value(forKey: "CURRENTATTACKINGPERCENT") as! Double
        AttackPowerTemp = Double(self.EnemyHealth)
        
         NewStaminaAmount = prefs.integer(forKey: "MYSTAMINA") - StaminaUsed
        /*
         
          prefs.set(["attackStatus":"complete", "attackStamina":"\(AttackStaminaAmount)", "attackGold":"\(AttackGoldAmount)"], forKey: "AttackCompletedDictionary")
         
         */
        

        if prefs.value(forKey: "AttackCompletedDictionary") != nil {
            
            print("Attack Dictinoary not nil")
            
            let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
            
            
            let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
            let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
            
            print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
            print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Attack Complete"
            // alertView.message = "Info(My Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount), Attack Power: \(AttackPower), Attacking Player Name: \(AttackingPlayer), Attacking PlayerID: \(AttackingPlayerID), Attacking Player's Health: \(AttackingPlayersHealth)"
            
            //let NewPlayersHealth = Int(AttackingPlayersHealth as String)! - UpdatedAttackPower
            
            let NewPlayersHealth = self.EnemyHealth
            
            var AttackMessage = String()
            
            if NewPlayersHealth <= 0 {
                AttackMessage = "You Killed \(AttackingPlayer)!"
            } else {
                
                
                if AttackPower >= 1 {
                    if AttackPower > 1 {
                        AttackMessage = "You were able to inflict \(AttackPower) points of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                    } else {
                        AttackMessage = "You were only able to inflict \(AttackPower) point of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                    }
                } else {
                    AttackMessage = "You didn't hurt \(AttackingPlayer) at all. \(AttackingPlayer)'s health is still at \(NewPlayersHealth)"
                    
                }
                
            }
            
            alertView.message = "\(AttackMessage)"
            
            
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            //alertView.show()
            print("Attacking players health :\(AttackingPlayersHealth)")
            
            prefs.set(["attackStatus":"complete", "attackStamina":"\(NewStaminaAmount)", "attackGold":"\(AttackGoldAmount)","attackPlayer":"\(AttackingPlayer)","attackPlayerID":"\(AttackingPlayerID)","attackPower":"\(AttackPowerTemp.description)","attackStartHealth":"\(AttackingPlayersHealth)","attackNewHealth":"\(NewPlayersHealth)"], forKey: "AttackCompletedDictionary")
            
            
        }
        
        
       
        
        print("ATTACK COMPLETE END")
    }
    
    func TargetEliminated() {
        
        
        AttackComplete()
        
        CloseAttackGame()
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        

        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            // self.buttonViewW.constant = 20
            //  self.buttonViewH.constant = 20
            //  self.AbilityBTN.frame.size.width = 80
            //  self.AbilityBTN.frame.size.height = 80
            
            // self.buttonViewY.constant = -40
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "EnableTabBarItems"), object: nil)
            
            self.removeFromSuperview()
            
            //self.removeFromSuperview(
            
            
           // DispatchQueue.main.async(execute: {
                 NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackCompleteStats"), object: nil)
           // })
            
          
            
           // self.removeFromSuperview(com)
            
        })
        
        
        
        
    }
    
    
    func CloseAttackGame() {
        print("received close notification")
        
        let AttackPowerNew = EnemyHealthStart - EnemyHealth
        // DispatchQueue.main.async(execute: {
        //DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let yesSuccess =  Attack(self.username, attackingID: self.email, attackedName: self.AttackingPlayer as NSString, attackedID: self.AttackingPlayerID as NSString, attackpower: AttackPowerNew)
            print("Attack Success = \(yesSuccess)")
    
       // })
     
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
        
        self.sceneHolder.isPlaying = false
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "EnableTabBarItems"), object: nil)
        
        
        UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID, response: "", action: "write") {
            (result, attackResponse) in
            //print("Response Updated: \(result), attackResponse: \(attackResponse)")
        }
        
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
            
            UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID, response: "", action: "write") {
                (result, attackResponse) in
                //print("Response Updated: \(result), attackResponse: \(attackResponse)")
            }
            
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
    
    
    class func instanceFromNib(characterInfo: CharacterInfo, AttackingPlayer: String, AttackingPlayersHealth: String, AttackingPlayerID: String, StaminaUsed: Int, AttackPower: Int, AttackStatus: String, startDistance: Float, altitude: Double) -> PlayerAttackView {
        
        let bounds = UIScreen.main.bounds
        var Nib = PlayerAttackView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "PlayerAttackView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PlayerAttackView
        
        print("Current Weapon: \(characterInfo.currentWeapon)")
        
        Nib.enemyDistanceZ = startDistance
        Nib.AttackingPlayer = AttackingPlayer
        Nib.AttackingPlayersHealth = AttackingPlayersHealth
        Nib.AttackingPlayerID = AttackingPlayerID
        Nib.StaminaUsed = StaminaUsed
        Nib.AttackPower = AttackPower
        Nib.AttackStatus = AttackStatus
        
        
        
        Nib.MyAltitude = altitude
       
        Nib.EnemyMoveDirection = "left"
        
        
       // Nib.attackBTNText = "Punch"
        Nib.skinTone = characterInfo.skinTone
        Nib.currentWeapon = characterInfo.currentWeapon

        Nib.CurrentHealthAmount = 100
        Nib.EnemyHealth = Int(AttackingPlayersHealth)!
        Nib.EnemyHealthStart = Int(AttackingPlayersHealth)!
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
    
    
    func addBloodSpatter() {
        
        var bloodNode = SCNNode()
        
        bloodNode = self.heroNode.childNode(withName: "camera", recursively: true)!.childNode(withName: "blood", recursively: true)!
        
       // bloodNode = (self.sceneHolder.scene?.rootNode.childNode(withName: "blood", recursively: true))!
      //  bloodNode.scale = self.sceneHolder.scene?.scl
        
        
        let vibrateScreenUP = SCNAction.scale(to: 1.05, duration: 0.5)
        let vibrateScreenDOWN = SCNAction.scale(to: 1.0, duration: 0.5)
        self.sceneHolder.scene?.rootNode.childNode(withName: "background", recursively: true)?.runAction(vibrateScreenUP, completionHandler: ({
            self.sceneHolder.scene?.rootNode.childNode(withName: "background", recursively: true)?.runAction(vibrateScreenDOWN)
        }))
        
        bloodNode.isHidden = false
        
        
    }
    
}



extension CAAnimation {
    class func animationWithSceneNamed(_ name: String) -> CAAnimation? {
        var animation: CAAnimation?
       // print("Trying to find animation scene")
        if let scene = SCNScene(named: name) {
            
          //  print("Scene named \(name) found")
            scene.rootNode.enumerateChildNodes({ (child, stop) in
                
                //print("Going through child nodes")
                if child.animationKeys.count > 0 {
               //     print("animation found with name: \(child.animationKeys.first!)")
                    animation = child.animation(forKey: child.animationKeys.first!)
                    stop.initialize(to: true)
                }
            })
        }
        return animation
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * M_PI / 180 }
}


struct CharacterInfo {
    
    var name: String
    var skinTone: String
    var health: String
    var currentWeapon: String
    
    
}
