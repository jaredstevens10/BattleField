//
//  AttackMapViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import Foundation


struct CollisionCategory {
    
    static let None: Int = 0b00000000
    
    static let grass: Int = 0b00000001
    static let Building: Int = 0b11111000
    static let Fence: Int = 0b11110000
    static let Wall: Int = 0b11100000
    static let Unlock: Int = 0b11000000
    
    static let All: Int = 0b11111111
    static let Map: Int = 0b00000001
    static let Hero: Int = 0b00000010
    static let HeroHands: Int = 0b00000011
    static let Enemy: Int = 0b00000100
    static let EnemySense: Int = 0b00000101
    static let EnemyEyes: Int = 0b00001001
    static let Bullet: Int = 0b00001000
    static let Monster: Int = 0b00010000
    static let Box: Int = 0b00100000
    static let missionItem: Int = 0b01000000

    static let Fist: Int = 0b10001000
    static let BulletEnemy: Int = 0b10000001
    
    
}

struct PlaceItemInfo {
    var itemCount = Int()
    var itemImage = UIImage()
    var itemOBJReference = String()
    var itemNODEReference = String()
    var itemMaterialReference = String()
    var itemName = String()
    var itemScale = Float()
}

class AttackMapViewController: UIViewController, UIGestureRecognizerDelegate, SCNSceneRendererDelegate, SCNPhysicsContactDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var EnemyTarget: String = "noone"
    
    
    var randomMovemovementInt = [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0]
    
    var startScene = Bool()
    var currentWeapon = String()
    var enemyWeapon = String()
    
    var grassArea: SCNMaterial!
    var waterArea: SCNMaterial!
    
   // var enemyNode = SCNNode()
    
    let EnemyNodeScene = EnemyCharacter()
    var EnemyDead = Bool()
    var EnemyShouldNotMove = Bool()
    var EnemyRunningAway = Bool()
    var EnemyAlreadyHit = Bool()
    var PlayingEnemySound = Bool()
    
    let HeroNodeScene = HeroCharacter()
    
    
    var heroHandRight = SCNNode()
    var heroWeapon = SCNNode()
    
    var HeroHandsRest = CAAnimation()
    var HeroHandsAttack = CAAnimation()
    
    
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
    
    
    var enemyRootNode = SCNNode()
    
    var enemyWalkAnimation = CAAnimation()
    var enemyHitAnimation = CAAnimation()
    var enemyHitBellyAnimation = CAAnimation()
    var enemyFallAnimation = CAAnimation()
    var enemyFlailAnimation = CAAnimation()
    var enemyDeadAnimation = CAAnimation()
    
    
    
    var isFixing = Bool()
    
    var enemies: [SCNNode] = []
    
    @IBOutlet weak var mapView: UIView!
    
    var ServerURLMaps = String()
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    var startMap = UIImage()
    
    var UserObjective = String()
    var MissionID = String()
    var MissionLevel = String()
    var MissionObjective = String()
    var MissionXP = String()
    var MissionMapURL = String()
    var MissionObjectURL = String()
    
    
   // var EnemyWalkAnimation = CAAnimation()
    var EnemyWalkingAnimations = [CAAnimation]()
    var EnemyNodesToAnimate = [SCNNode]()
    
    var OutOfAmmo = Bool()
    var OutOfAmmoEnemy = Bool()
    
    var AttackPercent = Double()
    var prefs:UserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var TotalItemsToHitLBL: UILabel!
    
    @IBOutlet weak var hitProgressView: UIProgressView!
    
    @IBOutlet weak var myHealthProgressView: UIProgressView!
    
    @IBOutlet weak var enemyUsernameLBL: UILabel!
    @IBOutlet weak var myUsernameLBL: UILabel!
    @IBOutlet weak var myHealthLBL: UILabel!
    
    
    var MyHealthInt = Int()
    var MyHealth = String()
    
    @IBOutlet weak var myHealthHolder: UIView!
    
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerLBL: UILabel!
    
    var CylindersHitArray = [String]()
    var TotalCylinders = Int()
    var attackTimer = Timer()
    var attackTimerEnd = TimeInterval()
   
    //    var BootsStartTime = NSTimeInterval()
    
    //SET TIMER FOR ATTACK COUNT DOWN
    var attackTimerStartTime: TimeInterval = 20.0
    var attackTimerTimeCount: TimeInterval = 20.0
    var attackTimerTimeInterval: TimeInterval = 0.05
    
   // var BootsUpgradeCost = Int()
    
    @IBOutlet weak var AttackingPlayersHealthLBL: UILabel!
    
    var AttackingPlayerID = NSString()
    var AttackingPlayer = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackingPlayersHealthInt = Int()
    var AttackPower = Int()
    var AttackStatus = NSString()
    
    var AttackStaminaAmountStart = String()
    var AttackGoldAmountStart = String()
    
    var username = NSString()
    var email = NSString()
    
    @IBOutlet weak var closePlaceItemViewBTN: UIButton!
    
    @IBOutlet weak var ItemsHitProgressLBL: UILabel!
    
    var PlaceItemInventory = [PlaceItemInfo]()
    
    let reuseIdentifier = "BasicCollectionCell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var deleteItemViewY: NSLayoutConstraint!
    @IBOutlet weak var deleteItemViewX: NSLayoutConstraint!
    
    
    var canDeleteObject = Bool()
    @IBOutlet weak var deleteItemView: UIView!
    @IBOutlet weak var placeItemView: UIView!
    
    var AddItemX = Float()
    var AddItemY = Float()
    var AddItemZ = Float()
    
    var TouchScreenX = CGFloat()
    var TouchScreenY = CGFloat()
    
    var AddingObject = Bool()
    var MovingObject = Bool()
    var ObjectStartPoint = CGPoint()
    var ObjectEndPoint = CGPoint()
    
    var TouchingNode  = SCNNode()
    let PlacePosition = SCNVector3()
    
    var NotStartingPoint = Bool()
    
    @IBOutlet weak var overlayLBL: UILabel!
    
    @IBOutlet weak var mapImageView: UIImageView!
    var HeroX = Float()
    var HeroY = Float()
    var HeroZ = Float()
    
    var HeroPosition = SCNVector3()
    var HeroRotation = SCNVector4()
    
    
    var contactDelegate: SCNPhysicsContactDelegate?
    
    @IBOutlet weak var innerShootView: UIView!
    
    @IBOutlet weak var itemsHitView: UIView!
    
    @IBOutlet weak var ShootView: UIView!
    
    @IBOutlet weak var closeBTN: UIButton!
    @IBOutlet weak var targetIMG: UIImageView!
    
    var ammoRemaining = Int()
    var ammoRemainingEnemy = Int()
    @IBOutlet weak var ammoLBL: UILabel!
    var enemyHitCount = Int()
    
    //MARK: config
    let autofireTapTimeThreshold = 0.2
    let maxRoundsPerSecond = 30
    let bulletRadius = 0.05
    let bulletImpulse = 30
    let grenadeImpulse = 15
    let maxBullets = 20
    
    
    let autofireTapTimeThresholdEnemy = 0.2
    let maxRoundsPerSecondEnemy = 30
    var maxBulletsEnemy = 20
    let bulletRadiusEnemy = 0.03
    let bulletImpulseEnemy = 30
    let grenadeImpulseEney = 15
    
    @IBOutlet var sceneView: SCNView!
    @IBOutlet var overlayView: UIView!
    
    var lookGesture: UIPanGestureRecognizer!
    var walkGesture: UIPanGestureRecognizer!
    var moveItemGesture: UIPanGestureRecognizer!
    var fireGesture: FireGestureRecognizer!
    
    
  //  @IBOutlet var deleteNodeGesture: UISwipeGestureRecognizer!
    var deleteNodeGesture = UISwipeGestureRecognizer()
    
    var DoubleTapGesture = UITapGestureRecognizer()
    var DismissAddItemGesture = UITapGestureRecognizer()
   // var placeItemGesture: placeItemGestureRecognizer!
    
    @IBOutlet var placeItemGesture: UILongPressGestureRecognizer!
    
    var heroNode: SCNNode!
    var heroHands = SCNNode()
    var handNode: SCNNode!
    var EnemyNode: SCNNode!
    
    let EnemySpeed: CGFloat = 0.50
    
    
    
    var camNode: SCNNode!
    var elevation: Float = 0
    var mapNode: SCNNode!
    var map: Map!
    
    var tapCount = 0
    var lastTappedFire: TimeInterval = 0
    var lastFired: TimeInterval = 0
    var bullets = [SCNNode]()
    
    var tapCountEnemy = 0
    var lastTappedFireEnemy: TimeInterval = 0
    var lastFiredEnemy: TimeInterval = 0
    var bulletsEnemy = [SCNNode]()
    
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var countLBL: UILabel!
    
    
    @IBOutlet weak var hitLBL: UILabel!
    
    
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EndAttack" {
            if let AttackLoadingViewController = segue.destination as? AttackLoadingViewController {
                //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
              //  AttackLoadingViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
              //  AttackLoadingViewController.popoverPresentationController!.delegate = self
                //AttackLoadingViewController.UserObjective = UserObjective
                AttackLoadingViewController.isAttacking = false
              //  AttackLoadingViewController.myLong = self.mylong.description
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString)
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        //currentWeapon = "Fist"
        
        enemyUsernameLBL.text = self.AttackingPlayer as String
        
        AttackingPlayersHealthLBL.text = self.AttackingPlayersHealth as String
        AttackingPlayersHealthInt = Int(AttackingPlayersHealth as String)!
        
        myHealthLBL.text = self.MyHealth as String
        MyHealthInt = Int(MyHealth as String)!
        
        
        ServerURLMaps = prefs.value(forKey: "ServerURLMaps") as! String
        
        self.hitProgressView.progress = 0
        TotalCylinders = 0
        timerView.layer.cornerRadius = 5
        timerView.layer.masksToBounds = true
        timerView.clipsToBounds = true
        
        mapView.layer.cornerRadius = 5
        mapView.layer.borderColor = UIColor.white.cgColor
        mapView.layer.borderWidth = 1
        mapView.layer.masksToBounds = true
        mapView.clipsToBounds = true
        
        //DismissAddItemGesture.enabled = false
        
        closePlaceItemViewBTN.layer.borderWidth = 1
        closePlaceItemViewBTN.layer.borderColor = UIColor.white.cgColor
        closePlaceItemViewBTN.layer.cornerRadius = 15
        closePlaceItemViewBTN.layer.masksToBounds = true
        closePlaceItemViewBTN.clipsToBounds = true
        
        PlaceItemInventory.append(PlaceItemInfo(itemCount: 2, itemImage: UIImage(named: "barrelExplosive.png")!, itemOBJReference: "barrelExplosive.dae", itemNODEReference: "barrel_barrel_Barrel", itemMaterialReference: "barrelTexture.png", itemName: "Barrel", itemScale: 0.22))
        PlaceItemInventory.append(PlaceItemInfo(itemCount: 3, itemImage: UIImage(named: "CrateIcon.png")!, itemOBJReference: "box2.dae", itemNODEReference: "objMesh", itemMaterialReference: "DEFbox1.png", itemName: "Crate", itemScale: 0.1))
        
        
      //   self.collectionView?.registerNib(columnHeaderViewNIB, forCellWithReuseIdentifier: "ItemCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        placeItemView.layer.cornerRadius = 5
        placeItemView.layer.masksToBounds = true
        placeItemView.clipsToBounds = true
        deleteItemView.isHidden = true
        placeItemView.isHidden = true
        
        //Double Tap Gesture
        // DoubleTapGesture = UITapGestureRecognizer(target: self, action: "doubletapGestureRecognized:")
        DoubleTapGesture.numberOfTapsRequired = 2
        DoubleTapGesture.addTarget(self, action: #selector(AttackMapViewController.doubletapped(_:)))
        DismissAddItemGesture.delegate = self
        view.isUserInteractionEnabled = true
        
        //view.addGestureRecognizer(DoubleTapGesture)
        
        //IF THIS IS A MISSION THEN------------
        switch UserObjective {
            
            case "mission":
            
                ShootView.isHidden = true
                countView.isHidden = true
                itemsHitView.isHidden = true
                /*
                 let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(MissionMapURL).png")
                 
                 print("IMAGE URL: \(url)")
                 if let theImageData = NSData(contentsOfURL: url) {
                 startMap = UIImage(named:"\(MissionMapURL)")!
                 }
                 */
                
                
                
                if let url = URL(string: "\(ServerURLMaps)\(MissionMapURL).png") {
                    
                    print("URL: \(url)")
                    
                    if let data = try? Data(contentsOf: url) {
                        startMap = UIImage(data: data)!
                    }        
                }
                mapImageView.image = startMap
            
            
            case "training":
            
                
                //self.view.addGestureRecognizer(DoubleTapGesture)
                ShootView.isHidden = false
                countView.isHidden = false
                itemsHitView.isHidden = false
                startMap = UIImage(named:"Map3")!
                myHealthHolder.isHidden = false
                //self.placeItemGesture.isEnabled = false
            //self.view.addGestureRecognizer(placeItemGesture)
            
            
            case "fixing":
            
            
            self.view.addGestureRecognizer(DoubleTapGesture)
            self.view.addGestureRecognizer(placeItemGesture)
            
            ShootView.isHidden = false
            countView.isHidden = false
            itemsHitView.isHidden = true
            myHealthHolder.isHidden = true
            
            startMap = UIImage(named:"Map3")!
            
            
            
        default:
            
            ShootView.isHidden = false
            countView.isHidden = false
            itemsHitView.isHidden = false
            startMap = UIImage(named:"Map3")!
            myHealthHolder.isHidden = false
        }
        
        
        /*
        if UserObjective == "mission" {
            ShootView.isHidden = true
            countView.isHidden = true
            itemsHitView.isHidden = true
            /*
            let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(MissionMapURL).png")
            
            print("IMAGE URL: \(url)")
            if let theImageData = NSData(contentsOfURL: url) {
            startMap = UIImage(named:"\(MissionMapURL)")!
            }
            */
            
            
            
            if let url = URL(string: "\(ServerURLMaps)\(MissionMapURL).png") {
                
                print("URL: \(url)")
                
                if let data = try? Data(contentsOf: url) {
                    startMap = UIImage(data: data)!
                }        
            }
            mapImageView.image = startMap
            
            
        } else {
            ShootView.isHidden = false
            countView.isHidden = false
            itemsHitView.isHidden = true
            startMap = UIImage(named:"Map2")!
        }
        */
        
        
        
        
        
        ShootView.layer.cornerRadius = 25
        ShootView.layer.borderColor = UIColor.blue.cgColor
        ShootView.layer.borderWidth = 1
        
        innerShootView.layer.cornerRadius = 20
        innerShootView.layer.backgroundColor = UIColor.blue.cgColor
     
        
        
        overlayLBL.text = "Tap to get started"
      //  self.contactDelegate = self
        ammoRemaining = maxBullets
        ammoLBL.text = "Ammo: \(ammoRemaining.description)"
        
        enemyHitCount = 0
        
        hitLBL.text = "Hits: \(enemyHitCount.description)"
        self.countView.layer.cornerRadius = 5
        self.closeBTN.layer.cornerRadius = 5
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
       
        
        
        
        
        
        GenerateMap(startMap)
        
        
        NotStartingPoint = true
        
        //look gesture
        lookGesture = UIPanGestureRecognizer(target: self, action: #selector(AttackMapViewController.lookGestureRecognized(_:)))
        lookGesture.delegate = self
        view.addGestureRecognizer(lookGesture)
        
        //walk gesture
        walkGesture = UIPanGestureRecognizer(target: self, action: #selector(AttackMapViewController.walkGestureRecognized(_:)))
        walkGesture.delegate = self
        view.addGestureRecognizer(walkGesture)
        
        //move item gesture
        
        
        
        //place item gesture
        placeItemGesture = UILongPressGestureRecognizer(target: self, action: #selector(AttackMapViewController.selectItemGestureRecognized(_:)))
        placeItemGesture.delegate = self
        //view.addGestureRecognizer(placeItemGesture)
        
        //move item gesture
        moveItemGesture = UIPanGestureRecognizer(target: self, action: #selector(AttackMapViewController.moveItemGestureRecognized(_:)))
        moveItemGesture.delegate = self
        view.addGestureRecognizer(moveItemGesture)
        
        
        
        //Dismiss Add Item View
        DismissAddItemGesture.numberOfTapsRequired = 1
        DismissAddItemGesture.addTarget(self, action: #selector(AttackMapViewController.dismissAddItemTapped(_:)))
        DismissAddItemGesture.delegate = self
        DismissAddItemGesture.isEnabled = false
       // view.addGestureRecognizer(DismissAddItemGesture)
        
        //Delete Node Swipe
        deleteNodeGesture.addTarget(self, action: #selector(AttackMapViewController.deleteNodeSwipeGesture(_:)))
        deleteNodeGesture.delegate = self
        deleteNodeGesture.direction = .right
        view.addGestureRecognizer(deleteNodeGesture)
        
        
        //fire gesture
        fireGesture = FireGestureRecognizer(target: self, action: #selector(AttackMapViewController.fireGestureRecognized(_:)))
        fireGesture.delegate = self
     //   view.addGestureRecognizer(fireGesture)
        
       // var gestureRecognizers = [UIGestureRecognizer]()
       // gestureRecognizers.append(tapGesture)
        
       
        
      //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AttackMapViewController.handleTap(_:)))
      //  tapGesture.numberOfTapsRequired = 3
      //  view.addGestureRecognizer(tapGesture)
        
          NotificationCenter.default.addObserver(self, selector: #selector(AttackMapViewController.AttackUpdateCountNotification(_:)), name: NSNotification.Name(rawValue: "AttackUpdateCountNotification"),  object: nil)
        
        
          NotificationCenter.default.addObserver(self, selector: #selector(AttackMapViewController.AttackUpdateAmmoNotification(_:)), name: NSNotification.Name(rawValue: "AttackUpdateAmmoNotification"),  object: nil)
        
        
       // self.becomeFirstResponder()
        
    }
    
    func AttackUpdateCountNotification(_ notification: Notification) {
        print("Update Count called by notification")
        
      //  enemyHitCount += 1
     //   print("EnemyHit count = \(enemyHitCount.description)")
    //    self.hitLBL.text = "Hits: \(enemyHitCount.description)"
        
        
        
        DispatchQueue.main.async(execute: {
        
        self.ItemsHitProgressLBL.text = "\(self.enemyHitCount)"
        print("EnemyHit count = \(self.enemyHitCount.description)")
        self.hitLBL.text = "Hits: \(self.enemyHitCount.description)"
            
        let ehc = Double(self.enemyHitCount)
        let tc = Double(self.TotalCylinders)
            
        let tempP = ehc / tc
            
        let hitprogress = Float(tempP)
            
        let hitprogressTemp = Double(self.enemyHitCount / self.TotalCylinders)
            
            print("Hit progress temp = \(hitprogressTemp)")
       // let hitprogress = Float(hitprogressTemp)
            print("Hit Progress = \(hitprogress)")
        self.hitProgressView.setProgress(hitprogress, animated: true)
      //  let AttackPerTemp = tempP * 100
      //      print("Attack Percent Temp = \(AttackPerTemp.description)")
        
         self.AttackPercent = round(tempP * 100)
            
        self.prefs.setValue(self.AttackPercent, forKey: "CURRENTATTACKINGPERCENT")
         print("Attack percent: \(self.AttackPercent)")
            
        print("Should have updated LBL: Hits: \(self.enemyHitCount.description)")
        
            
        })
       // var info = notification.userInfo
        
       // let itemLattemp = info!["itemLat"] as! String
    }
    
    
    func AttackUpdateAmmoNotification(_ notification: Notification) {
        
        
        
        ammoRemaining -= 1
        
        if ammoRemaining <= 0 {
            self.OutOfAmmo = true
        } else  {
            self.OutOfAmmo = false
        }
        print("Ammo count = \(ammoRemaining.description)")
        self.ammoLBL.text = "ammo:\(ammoRemaining.description)"

        // var info = notification.userInfo
        
        // let itemLattemp = info!["itemLat"] as! String
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlaceItemInventory.count
    }
    
    func SelectedPlaceItem(_ sender: AnyObject) {
        
        var ItemToPlace: PlaceItemInfo!
        let itemTag = sender.tag
        ItemToPlace = PlaceItemInventory[itemTag!]
        
        let ItemImage = ItemToPlace.itemImage
        let ItemObjReference = ItemToPlace.itemOBJReference
        let ItemNodeReference = ItemToPlace.itemNODEReference
        print("Item Node Reference: \(ItemNodeReference)")
        let ItemMaterialReference = ItemToPlace.itemMaterialReference
        print("Item Material Reference: \(ItemMaterialReference)")
        let ItemName = ItemToPlace.itemName
        let ItemScale = ItemToPlace.itemScale
        
        print("Item to Place Info - \(ItemToPlace)")
        
        
         var PlaceItemNode = SCNNode()
         
         let PlaceItemScene = SCNScene(named: "\(ItemObjReference)")
         // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
         
         PlaceItemNode = (PlaceItemScene?.rootNode.childNode(withName: "\(ItemNodeReference)", recursively: true))!
         
         print("Box Scene Nodes = \(PlaceItemScene?.rootNode.childNodes)")
        
        
        
        /*
        
        
        */
         //EnemyNode.geometry? =
         //MilitaryModel?.position
         // EnemyNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
         
         PlaceItemNode.position = SCNVector3(x: AddItemX, y: 0.3, z: AddItemZ)
         
         print("\(ItemName) Position = \(PlaceItemNode.position)")
        // EnemyNode.geometry = SCN
         //EnemyNode.geometry = SCNCylinder(radius: 0.50, height: 0.8)
         PlaceItemNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: PlaceItemNode.geometry!, options: nil))
         PlaceItemNode.physicsBody?.categoryBitMask = CollisionCategory.Monster
         PlaceItemNode.physicsBody?.collisionBitMask = CollisionCategory.All
         PlaceItemNode.name = "\(ItemName)"
         PlaceItemNode.scale = SCNVector3(x: ItemScale, y: ItemScale, z: ItemScale)
       // PlaceItemNode.scale = SCNVector3(x: 0.9, y: 0.9, z: 0.9)
        
        if ItemMaterialReference == "" {
            
        } else {
            let PlaceItemMaterial = SCNMaterial()
            PlaceItemMaterial.diffuse.contents = UIImage(named: "\(ItemMaterialReference)")
            //  material.specular.contents = UIColor.whiteColor()
            //MilitaryModel?.geometry?.firstMaterial = material
            PlaceItemNode.geometry?.firstMaterial = PlaceItemMaterial
            
        }
        
         
         if #available(iOS 9.0, *) {
         PlaceItemNode.physicsBody?.contactTestBitMask = ~0
         }
        self.sceneView.scene?.rootNode.addChildNode(PlaceItemNode)
        
        
        
        AddingObject = false
        self.lookGesture.isEnabled = true
        self.walkGesture.isEnabled = true
        
        self.placeItemView.isHidden = true
        
       // self.DismissAddItemGesture.enabled = false
        
        
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionViewCell
        
        var ItemToPlace: PlaceItemInfo!
        
        ItemToPlace = PlaceItemInventory[indexPath.row]
        cell.countLBL.layer.cornerRadius = 10
        cell.countLBL.layer.masksToBounds = true
        cell.countLBL.clipsToBounds = true
        cell.backgroundColor = UIColor.clear
        cell.itemIMG.image = ItemToPlace.itemImage
        cell.itemIMG.contentMode = UIViewContentMode.scaleAspectFit
        cell.countLBL.text = "\(ItemToPlace.itemCount.description)"
        cell.selectItemBTN.tag = indexPath.row
        cell.selectItemBTN.addTarget(self, action: #selector(AttackMapViewController.SelectedPlaceItem(_:)), for: UIControlEvents.touchUpInside)
        //cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    
    func PlayEnemyWalkAnimation() {
        
        
      //  let enemyScene = SCNScene(named: "Army_Man1.dae")
        //let enemyScene = SCNScene(named: "Army3D_Test4.dae")
      //  EnemyNode = (enemyScene?.rootNode.childNode(withName: "Armature", recursively: true))!
        
        /*
        let urlOfScene = Bundle.main.url(forResource: "Army_Man1", withExtension: "dae")
        //mainBundle.URLforResources("Army", withExtension: "dae")
        let source = SCNSceneSource(URL: urlOfScene, options: nil)
        let armature = source.entryWithIdentifier("Armature", withClass: SCNNode.self) as SCNNode
        
        let animation = armature.entryWithIdentifier("your bone id", withClass: CAAnimation.self) as CAAnimation
        */
    }
    
    func playWalkAnimation(theNodes: [SCNNode], theAnimations: [CAAnimation]) {
        print("Should Walk Now.  Nodes Count: \(theNodes.count) Animation Count: \(theAnimations.count)")
        var i: Int = 0
        
        for theNode in theNodes {
            theNode.addAnimation(theAnimations[i], forKey: "\(theNode.name)Walk")
            i += 1
        }
        
        //theNode.addAnimation(EnemyWalkAnimation, forKey: "EnemyWalk")
    }

    
    func GenerateMap(_ mapImage: UIImage) {
       // map = Map(image: UIImage(named:"Map2")!)
        
        print("Not Starting Point = \(NotStartingPoint)")
        
        
        
        
        map = Map(image: mapImage)
        //create a new scene
        let scene = SCNScene()
       // SCNView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
        scene.physicsWorld.gravity = SCNVector3(x: 0, y: -9, z: 0)
        scene.physicsWorld.timeStep = 1.0/360
        scene.physicsWorld.contactDelegate = self
    
        let lights = self.makeAmbientLight()
        scene.rootNode.addChildNode(lights)
        
        //add entities
        for entity in map.entities {
            switch entity.type {
            case .hero:
                
                heroNode = SCNNode()
               // heroNode = HeroNodeScene.node
                
                
                heroNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNCylinder(radius: 0.2, height: 1.7), options: nil))
                heroNode.physicsBody?.angularDamping = 0.9999999
                heroNode.physicsBody?.damping = 0.9999999
                heroNode.physicsBody?.rollingFriction = 0
                heroNode.physicsBody?.friction = 0
                heroNode.physicsBody?.restitution = 0
                //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
                heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
                heroNode.physicsBody?.categoryBitMask = CollisionCategory.Hero
                heroNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    heroNode.physicsBody?.contactTestBitMask = ~0
                }
                
                heroNode.name = "heroNode"
                
                print("Not Starting Point Test 2 = \(NotStartingPoint)")
                if NotStartingPoint {
                //heroNode.position = SCNVector3(x: self.HeroX, y: 0.5, z: self.HeroZ)
                    
                heroNode.position = HeroPosition
                heroNode.rotation = HeroRotation
                print("Hero should start at \(heroNode.position)")
                
                } else {
                heroNode.position = SCNVector3(x: entity.x, y: 0.5, z: entity.y)
                print("Not Starting Point: Hero should start at \(heroNode.position)")
                }
                
               // self.HeroX = entity.x
              //  self.HeroY = entity.y

                scene.rootNode.addChildNode(heroNode)
                
                var handsScene = SCNScene()
                var weaponScene = SCNScene()
                
                
                print("***CURRENT WEAPON IS \(currentWeapon)")
                
                //currentWeapon = "Fist"
                
                switch currentWeapon {
                case "Fist":
                    handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                    
                    
                    
                    let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                    knifeTemp.isHidden = true
                    
                    let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                    gunTemp.isHidden = true
                    
                    
                    self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle.R", recursively: true))!
                    
                    HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Punch.dae")!
                    HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Punch.dae")!
                    
                    
                    
                    
                   // let handGeom = SCNSphere(radius: 0.01)
                    //  let headGeom = SCNSphere(radius: 0.1)
                    let weaponGeom = SCNSphere(radius: 1)
                    let weaponPlane = SCNNode(geometry: weaponGeom)
                    
                    weaponPlane.physicsBody = SCNPhysicsBody.kinematic()
                    weaponGeom.firstMaterial?.diffuse.contents = UIColor.red
                    // headPlane.opacity = CGFloat(0)
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
                    // headPlane.opacity = CGFloat(0)
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

                    let knifeTemp = (handsScene.rootNode.childNode(withName: "knife", recursively: true))!
                    knifeTemp.isHidden = true
                    
                    let gunTemp = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                    gunTemp.isHidden = false
                    
                    self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle.R", recursively: true))!
                    
                   // weaponScene = SCNScene(named: "animate.scnassets/Gun3D.dae")!
                   // let weaponScene = LoadAttackItems(weaponName: "InfantryKnife3D")
                    
                    self.heroWeapon = (handsScene.rootNode.childNode(withName: "gun", recursively: true))!
                    
                    gunTemp.geometry?.firstMaterial?.diffuse.contents = UIColor.black
            
                    
                    HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Gun.dae")!
                    HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Gun.dae")!
                    
                //    self.targetNode.isHidden = false
                    
                default:
                    
                    handsScene = SCNScene(named: "animate.scnassets/Hand_Rest.dae")!
                    HeroHandsRest = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Rest_Punch.dae")!
                    HeroHandsAttack = CAAnimation.animationWithSceneNamed("animate.scnassets/Hand_Attack_Punch.dae")!
                    
                     self.heroHandRight = (handsScene.rootNode.childNode(withName: "palm_middle.R", recursively: true))!
                    
                    let weaponGeom = SCNSphere(radius: 1)
                    let weaponPlane = SCNNode(geometry: weaponGeom)
                    
                    weaponPlane.physicsBody = SCNPhysicsBody.kinematic()
                    weaponGeom.firstMaterial?.diffuse.contents = UIColor.red
                    // headPlane.opacity = CGFloat(0)
                    weaponPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: weaponPlane.geometry!, options: nil))
                    weaponPlane.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                    weaponPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                    if #available(iOS 9.0, *) {
                        weaponPlane.physicsBody?.contactTestBitMask = ~0
                    }
                    weaponPlane.name = "fistPlane"
                    heroHandRight.addChildNode(weaponPlane)
                    
                   // self.targetNode.isHidden = true
                }
                
                
                //let handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_SMALL.dae")!
                heroHands = (handsScene.rootNode.childNode(withName: "basicRig", recursively: true))!
                
                let handModels = (handsScene.rootNode.childNode(withName: "basicRig_Body", recursively: true))!
                
                heroHands.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: handModels.geometry!, options: nil))
                
                heroHands.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                heroHands.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    heroHands.physicsBody?.contactTestBitMask = ~0
                }
                
                  heroHands.name = "heroHands"
                
//                handModels.name = "heroHands"
//                
//                handModels.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: handModels.geometry!, options: nil))
//                
//                handModels.physicsBody?.categoryBitMask = CollisionCategory.Bullet
//                handModels.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
//                if #available(iOS 9.0, *) {
//                    handModels.physicsBody?.contactTestBitMask = ~0
//                }
                
                
                
                
                let skinTone = "white"
                
                switch skinTone {
                case "white":
                    heroHands.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
                    
                case "brown":
                     handModels.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
                    heroHands.physicsBody?.isAffectedByGravity = false
                    
                default:
                    handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
                }
                
                
                heroHands.position = SCNVector3(x: 0, y: -1, z: -0.5)
                //heroHands.position = SCNVector3(x: 0, y: -0.5, z: -1.0)
                //  heroHands.scale = SCNVector3(x: 0.09, y: 0.09, z: 0.09)
                // handModels.addChildNode(heroWeapon)
                
                heroNode.addChildNode(handModels)
                //heroHands.addChildNode(handModels)
                heroHands.rotation = SCNVector4(0,4,2.6,M_PI)
                heroHands.rotation.y = 10
                
                heroNode.addChildNode(heroHands)
                
                HeroHandsRest.isRemovedOnCompletion = false
                self.heroHands.addAnimation(self.HeroHandsRest, forKey: "handsRest")
         
                
                
                
                
             
            case .enemy:
            //case .monster:
                
                let monsterNode = SCNNode()
                monsterNode.position = SCNVector3(x: entity.x, y: 0.2, z: entity.y)
                monsterNode.geometry = SCNCylinder(radius: 0.5, height: 1.6)
                monsterNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: monsterNode.geometry!, options: nil))
                monsterNode.physicsBody?.categoryBitMask = CollisionCategory.Monster
                monsterNode.physicsBody?.collisionBitMask = CollisionCategory.All
                //monsterNode.name = "BLOCK"
                monsterNode.setValuesForKeys(["tag":"1boxtest"])
               // monsterNode.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGrayColor()
               // monsterNode.u
                if #available(iOS 9.0, *) {
                    monsterNode.physicsBody?.contactTestBitMask = ~0
                }
                
                self.TotalCylinders += 1
                TotalItemsToHitLBL.text = "\(TotalCylinders.description)"
                monsterNode.name = "BLOCK\(TotalCylinders.description)"
                print("Cylinder name: \(monsterNode.name)")
                
                print("Total Cylinders = \(TotalCylinders.description)")
                if !self.isFixing {
                scene.rootNode.addChildNode(monsterNode)
                }
                
            case .monster:
            //case .enemy:
                
                EnemyNode = SCNNode()
                
//                let EnemyNodeScene = EnemyCharacter()

                
                EnemyNode = EnemyNodeScene.node
                
                EnemyNode.position = SCNVector3(x: entity.x, y: 0.0, z: entity.y)
                

                
                
                if #available(iOS 9.0, *) {
                    EnemyNode.physicsBody?.contactTestBitMask = ~0
                }
                
                 if !self.isFixing {
                enemies.append(EnemyNode)
                scene.rootNode.addChildNode(EnemyNode)
                //scene.rootNode.addChildNode(EnemyNode)
                scene.rootNode.addChildNode(enemyRootNode)
                     print("Add Enemy Node")
                }
               
 
                
              
                
            case .missionItem:
                print("Adding Mission item, from Generate map")
                var MissionItemNode = SCNNode()
                
                let MissionItemScene = SCNScene(named: "hammer.dae")
               // MissionItemNode.geometry =  SCNC
              //  let BoxScene = SCNScene(named: "\(MissionObjectURL).dae")
                
                //let BoxScene = SCNScene(named: "box2.dae")
                // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
                
                //                BoxNode = (BoxScene?.rootNode.childNodeWithName("objMesh", recursively: true))!
                MissionItemNode = (MissionItemScene?.rootNode.childNode(withName: "Part1", recursively: true))!
                
                print("MissionItem Nodes = \(MissionItemScene?.rootNode.childNodes)")
                
                let material = SCNMaterial()
            //    material.diffuse.contents = UIImage(named: "metal.jpg")
                
            //    let materialTwo = SCNMaterial()
            //    materialTwo.diffuse.contents = UIImage(named: "wood.jpg")
                
                
               // var materials = [SCNMaterial]()
                  material.diffuse.contents = UIImage(named: "hammertex1280000.png")
               // materials.append(material)
               // materials.append(materialTwo)
                //  material.specular.contents = UIColor.whiteColor()
                MissionItemNode.geometry?.firstMaterial = material
                
                
                //UNCOMMENT FOR FIRST MATERIAL----------
               // BoxNode.geometry?.firstMaterial = material
                
                
              //  MissionItemNode.geometry?.materials = materials
                //EnemyNode.geometry? =
                //MilitaryModel?.position
                
                /*
                 PlaceItemInventory.append(PlaceItemInfo(itemCount: 2, itemImage: UIImage(named: "barrelExplosive.png")!, itemOBJReference: "barrelExplosive.dae", itemNODEReference: "barrel_barrel_Barrel", itemMaterialReference: "barrelTexture.png", itemName: "Barrel", itemScale: 0.3))
                 */
                
                // EnemyNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
                
                MissionItemNode.position = SCNVector3(x: entity.x, y: 1.1, z: entity.y)
                //EnemyNode.geometry = SCNCylinder(radius: 0.50, height: 0.8)
                MissionItemNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: MissionItemNode.geometry!, options: nil))
                MissionItemNode.physicsBody?.categoryBitMask = CollisionCategory.missionItem
                MissionItemNode.physicsBody?.collisionBitMask = CollisionCategory.All
                MissionItemNode.name = "MissionItem"
                
                MissionItemNode.scale = SCNVector3(x: 0.2, y: 0.2, z: 0.2)
                
                if #available(iOS 9.0, *) {
                    MissionItemNode.physicsBody?.contactTestBitMask = ~0
                }
                scene.rootNode.addChildNode(MissionItemNode)
                print("Add Mission Item Node")

                
            case .box:
                
                var BoxNode = SCNNode()
                
                let BoxScene = SCNScene(named: "barrelExplosive.dae")
                
                //let BoxScene = SCNScene(named: "box2.dae")
                // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
                
//                BoxNode = (BoxScene?.rootNode.childNodeWithName("objMesh", recursively: true))!
                 BoxNode = (BoxScene?.rootNode.childNode(withName: "barrel_barrel_Barrel", recursively: true))!
                
                print("Box Scene Nodes = \(BoxScene?.rootNode.childNodes)")
                
                let material = SCNMaterial()
                material.diffuse.contents = UIImage(named: "barrelTexture.png")
                
             //   material.diffuse.contents = UIImage(named: "DEFbox1.png")
                
                //  material.specular.contents = UIColor.whiteColor()
                //MilitaryModel?.geometry?.firstMaterial = material
                
                BoxNode.geometry?.firstMaterial = material
                //EnemyNode.geometry? =
                //MilitaryModel?.position
                
                /*
  PlaceItemInventory.append(PlaceItemInfo(itemCount: 2, itemImage: UIImage(named: "barrelExplosive.png")!, itemOBJReference: "barrelExplosive.dae", itemNODEReference: "barrel_barrel_Barrel", itemMaterialReference: "barrelTexture.png", itemName: "Barrel", itemScale: 0.3))
 */
                
                // EnemyNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
                
                BoxNode.position = SCNVector3(x: entity.x, y: 0.0, z: entity.y)
                //EnemyNode.geometry = SCNCylinder(radius: 0.50, height: 0.8)
                BoxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: BoxNode.geometry!, options: nil))
                BoxNode.physicsBody?.categoryBitMask = CollisionCategory.Box
                BoxNode.physicsBody?.collisionBitMask = CollisionCategory.All
                BoxNode.name = "Box"
                
                //BoxNode.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)
                
                if #available(iOS 9.0, *) {
                    BoxNode.physicsBody?.contactTestBitMask = ~0
                }
                scene.rootNode.addChildNode(BoxNode)
                print("Add Box Node")
                
                
            }
        }
        
        //add a camera node
        camNode = SCNNode()
        camNode.position = SCNVector3(x: 0, y: 0, z: 0)
       // camNode.addChildNode(heroHands)
        heroNode.addChildNode(camNode)
        
        
        
//        let handScene = SCNScene(named: "RightHand2.dae")
//        //let enemyScene = SCNScene(named: "Army3D_Test4.dae")
//        handNode = (handScene?.rootNode.childNode(withName: "basicRig", recursively: true))!
//        let handSceneGeometry = (handScene?.rootNode.childNode(withName: "basicRig_Body", recursively: true))!
//        handNode.geometry = handSceneGeometry.geometry
//        //handNode.position = SCNVector3(x: heroNode.position.x, y: heroNode.position.y, z: heroNode.position.z)
//        handNode.position = SCNVector3(x: 1, y: 0.5, z: 1)
//        heroNode.addChildNode(handNode)
        
        //add camera
        let camera = SCNCamera()
        camera.zNear = 0.01
        camera.zFar = Double(max(map.width, map.height))
        camNode.camera = camera
        
        //create map node
        mapNode = SCNNode()
        
        //add walls
        for tile in map.tiles {
            
            if tile.type == .grass {
                
                let grassNode = SCNNode()
                //grassNode.geometry = SCNPlane(width: CGFloat(map.width), height: CGFloat(map.height))
                grassNode.geometry = SCNPlane(width: CGFloat(tile.x), height: CGFloat(tile.y))
                grassNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-M_PI_2))
                //grassNode.position = SCNVector3(x: Float(map.width)/2, y: 0, z: Float(map.height)/2)
                grassNode.position = SCNVector3(x: Float(tile.x), y: 0, z: Float(tile.y))
                
                let grassMaterial = SCNMaterial()
                grassMaterial.diffuse.contents = UIImage(named: "grasstexture.png")
                grassNode.geometry?.firstMaterial = grassMaterial
               // mapNode.addChildNode(grassNode)
                
                
            }
            
            if tile.type == .wall {
                
              //f  print("Creating walls")
                
                //create walls
                if tile.visibility.contains(.Top) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 2.8)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y))
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Wall
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    wallNode.name = "WallTop"
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Right) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 2.8)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 1, y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Wall
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    
                     wallNode.name = "WallRight"
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Bottom) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 2.8)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 0)
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y) + 1)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Wall
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                     wallNode.name = "WallBottom"
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Left) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 2.8)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(-M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x), y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Wall
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                     wallNode.name = "WallLeft"
                    mapNode.addChildNode(wallNode)
                }
            }
            if tile.type == .unlock {
                
                //create walls
                if tile.visibility.contains(.Top) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y))
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "WoodFence.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Unlock
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                     wallNode.name = "UnlockTop"
                     mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Right) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 1, y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "WoodFence.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Unlock
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    
                    wallNode.name = "UnlockRight"
                    
                     mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Bottom) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 0)
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y) + 1)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "WoodFence.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Unlock
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    wallNode.name = "UnlockBottom"
                      mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Left) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(-M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x), y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "WoodFence.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    wallNode.physicsBody?.categoryBitMask = CollisionCategory.Unlock
                    wallNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    wallNode.name = "UnlockLeft"
                      mapNode.addChildNode(wallNode)
                }
            }
        }
        
        //add floor
        let floorNode = SCNNode()
        floorNode.geometry = SCNPlane(width: CGFloat(map.width), height: CGFloat(map.height))
        floorNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-M_PI_2))
        floorNode.position = SCNVector3(x: Float(map.width)/2, y: 0, z: Float(map.height)/2)
        //floorNode.name
        
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "buildingLightTexture.png")
        //  material.specular.contents = UIColor.whiteColor()
        //MilitaryModel?.geometry?.firstMaterial = material
        
        floorNode.geometry?.firstMaterial = floorMaterial
        
        floorNode.name = "floor"
        mapNode.addChildNode(floorNode)
        
        
        
       
        
        
        //add ceiling
        let ceilingNode = SCNNode()
        ceilingNode.geometry = SCNPlane(width: CGFloat(map.width), height: CGFloat(map.height))
        ceilingNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI_2))
        //1 Y Height
       // ceilingNode.position = SCNVector3(x: Float(map.width)/2, y: 1, z: Float(map.height)/2)
        
        ceilingNode.position = SCNVector3(x: Float(map.width)/2, y: 2, z: Float(map.height)/2)
        
        //Low Ceiling
        //ceilingNode.position = SCNVector3(x: Float(map.width)/2, y: 1, z: Float(map.height)/2)
        
        let ceilingMaterial = SCNMaterial()
        ceilingMaterial.diffuse.contents = UIImage(named: "ceilingTexture.png")
        //  material.specular.contents = UIColor.whiteColor()
        //MilitaryModel?.geometry?.firstMaterial = material
        ceilingNode.name = "ceiling"
        ceilingNode.geometry?.firstMaterial = ceilingMaterial
        mapNode.addChildNode(ceilingNode)
        
        //set up map physics
        mapNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: mapNode, options: [SCNPhysicsShape.Option.keepAsCompound: true]))
        mapNode.physicsBody?.categoryBitMask = CollisionCategory.Map
        mapNode.physicsBody?.collisionBitMask = CollisionCategory.All
        if #available(iOS 9.0, *) {
            mapNode.physicsBody?.contactTestBitMask = ~0
        }
        scene.rootNode.addChildNode(mapNode)
        
        //set the scene to the view
       // sceneView.frame = CGRect(x: 0, y: 0, width: 800, height: 600)
        sceneView.scene = scene
        //sceneView.backgroun
    
        sceneView.delegate = self
        
        //show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        //configure the view
        //sceneView.backgroundColor = UIColor.blackColor()
        sceneView.backgroundColor = UIColor(red: 19/255, green: 92/255, blue: 241/255, alpha: 1.0)
    }
    
    func updateZombies() {
        //let targetPosition = heroNode!.position
        let targetPosition = heroNode!.presentation.position
        //print("Updating Zombies")
        
    //var zombies: [SKSpriteNode] = []
        for zombie in enemies {
            
            let currentPosition = EnemyNode.position
            
           // print("ENEMY CURRENT POSITION: \(currentPosition)")
           // print("TARGET POSITION: \(targetPosition)")
        
            //let AtanTemp = atan2(currentPosition.z - targetPosition.z, currentPosition.x - targetPosition.x)
            
            let AtanTemp = atan2(currentPosition.z - 0, currentPosition.x - 1)
            
            
        
            //print("AtanTemp: \(AtanTemp)")
            let AtanTemp2 = CGFloat(AtanTemp)
            //  print("AtanTemp2: \(AtanTemp2)")
            //let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
           let angle = AtanTemp2 + CGFloat(M_PI)
            //print("Angle: \(angle)")

            let rotateAction = SCNAction.rotateTo(x: angle + CGFloat(M_PI*0.5), y: 0, z: angle + CGFloat(M_PI*0.5), duration: 0.0)

            // zombie.runAction(rotateAction)

            let velocityXtemp = EnemySpeed * cos(angle)
            let velocityX = Float(velocityXtemp)
            let velocityYtemp = EnemySpeed * sin(angle)
        
            let velocityY = Float(velocityYtemp)
            
         //   let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
        //let newVelocity = SCNVector3(x: velocityX, y: velocityY, z: 0)
          let newVelocity = SCNVector3(x: velocityX, y: 0, z: velocityY)
            
          zombie.physicsBody!.velocity = newVelocity;
            

            
       }
    }
    
    func makeAmbientLight() -> SCNNode{
        let lightNode = SCNNode()
        let light = SCNLight()
        light.type = SCNLight.LightType.ambient
        light.color = SKColor(white: 0.1, alpha: 1)
        lightNode.light = light
        return lightNode
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 1
        }) 
        
        self.lookGesture.isEnabled = false
        self.walkGesture.isEnabled = false
        
        
        switch UserObjective {
        case "mission":
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "User Mission"
            alertView.message = "Mission Objective: \(MissionObjective)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        case "training":
            print("update for training")
            
        case "fixing":
            print("update for fixing")
            
        default:
            break
            
        }
        
        
        
        let hitprogress = Float(Double(self.AttackingPlayersHealthInt / 100))
        
        let myprogress = Float(Double(self.MyHealthInt / 100))
        
        self.hitProgressView.setProgress(hitprogress, animated: true)
        
        
        self.myHealthProgressView.setProgress(myprogress, animated: true)
        
        
    }
    
    @IBAction func hideOverlay() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
        })
        
        self.startScene = true
        
        self.lookGesture.isEnabled = true
        self.walkGesture.isEnabled = true
        
        switch UserObjective {
        
            case "mission":
            print("mission hide overlay")
            
            case "training":
            print("training hide overlay")
            
            default:
            AttackTimerBegin()
            
        }
        
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
        
        if gestureRecognizer == lookGesture {
            return touch.location(in: view).x > view.frame.size.width / 2
        } else if gestureRecognizer == walkGesture {
            print("touch view x:\(touch.location(in: view).x)")
            print("frame width / 2: \(view.frame.size.width / 2)")
            return touch.location(in: view).x < view.frame.size.width / 2
        }
        
        
        return true
        
 
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func lookGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        //get translation and convert to rotation
        let translation = gesture.translation(in: self.view)
        let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
        let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        //rotate hero
        heroNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: hAngle), asImpulse: true)
        
        //tilt camera
        elevation = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + vAngle))
        
//        if elevation < -0.11 {
//            
//            elevation = -0.11
//            print("tilted too low")
//            
//        }
        
        camNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
        //heroHands.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
        
      //  heroHands.rotation = SCNVector4(0,4,2.6,elevation)
        
        //reset translation
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
    

    
    func walkGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.ended || gesture.state == UIGestureRecognizerState.cancelled {
            
            
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            
           // self.HeroX = heroNode.position.x
          //  self.HeroZ = heroNode.position.z
            
          //  print("HeroX = \(HeroX)")
         //   print("HeroZ = \(HeroZ)")
            
           // print("CGPointZero = \(CGPointZero)")
            let pos = heroNode.position
           print("Hero position: \(pos)")
            
        }
    }
    
    func moveItemGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
     //   var startPoint = CGPoint()
     //   var endPoint = CGPoint()
        
        if gesture.state == UIGestureRecognizerState.began {
            
           ObjectStartPoint =  gesture.location(in: self.view)
            
        }
        
        if gesture.state == UIGestureRecognizerState.ended {
            
            ObjectEndPoint =  gesture.location(in: self.view)
            
            let ObjectChangePoint = ObjectStartPoint.x - ObjectEndPoint.x
            
            print("object start = \(ObjectStartPoint)")
            print("object end = \(ObjectEndPoint)")
            
            print("object change = \(ObjectChangePoint)")
            
            TouchingNode.position = SCNVector3(x: TouchingNode.position.x + Float(ObjectChangePoint), y: TouchingNode.position.y, z: TouchingNode.position.z)
            
            ObjectStartPoint = CGPoint(x: 0,y: 0)
            ObjectEndPoint = CGPoint(x: 0,y: 0)
            
        }
        
        
        
        //get translation and convert to rotation
    //    let translation = gesture.translationInView(self.view)
    //    let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
    //    let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        //rotate hero
        
     //   TouchingNode.physicsBody?.app
        
        
      //  heroNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: hAngle), impulse: true)
        
        //tilt camera
     //   elevation = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + vAngle))
     //   camNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
        
        //reset translation
      //  gesture.setTranslation(CGPointZero, inView: self.view)
        
     //   if MovingObject {
        print("is Moving Object from Move item Gesture")
        if gesture.state == UIGestureRecognizerState.ended || gesture.state == UIGestureRecognizerState.cancelled {
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            
            print("Moving item translation setting: \(gesture.translation(in: self.view))")
            
            print("Move Item CGPointZero = \(CGPoint.zero)")
            let pos = heroNode.position
            //   print("Hero position: \(pos)")
            
      //  }

        }
        
        
    }
    
    
    @IBAction func deleteNodeGesture(_ sender: AnyObject) {
        
        
        
    }
    
    func shootBTNEnemy() {
        
        
        if !OutOfAmmoEnemy {
            
            let nowEnemy = CFAbsoluteTimeGetCurrent()
            if nowEnemy - lastTappedFireEnemy < autofireTapTimeThresholdEnemy {
                tapCountEnemy += 1
            } else {
                tapCountEnemy = 1
            }
            lastTappedFireEnemy = nowEnemy
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateAmmoNotification"), object: nil)
            
        }
        
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
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateAmmoNotification"), object: nil)

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
    
    
    
    
    @IBAction func AddItemButton(_ sender: AnyObject) {
        
        
        
        let monsterNode = SCNNode()
        monsterNode.position = SCNVector3(x: AddItemX, y: 0.3, z: AddItemZ)
        monsterNode.geometry = SCNCylinder(radius: 0.15, height: 0.6)
        monsterNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: monsterNode.geometry!, options: nil))
        monsterNode.physicsBody?.categoryBitMask = CollisionCategory.Monster
        monsterNode.physicsBody?.collisionBitMask = CollisionCategory.All
        monsterNode.name = "BLOCK"
        monsterNode.setValuesForKeys(["tag":"1boxtest"])
        // monsterNode.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGrayColor()
        // monsterNode.u
        if #available(iOS 9.0, *) {
            monsterNode.physicsBody?.contactTestBitMask = ~0
        }
      //  scene.rootNode.addChildNode(monsterNode)
        
        
        /*
        var BoxNode = SCNNode()
        
        let BoxScene = SCNScene(named: "box1.dae")
        // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
        
        BoxNode = (BoxScene?.rootNode.childNodeWithName("objMesh", recursively: true))!
        
        print("Box Scene Nodes = \(BoxScene?.rootNode.childNodes)")
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "DEFbox1.png")
        //  material.specular.contents = UIColor.whiteColor()
        //MilitaryModel?.geometry?.firstMaterial = material
        BoxNode.geometry?.firstMaterial = material
        //EnemyNode.geometry? =
        //MilitaryModel?.position
        // EnemyNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
        
        BoxNode.position = SCNVector3(x: AddItemX, y: 0.3, z: AddItemY)
        
        print("Box Position = \(BoxNode.position)")
        
        //EnemyNode.geometry = SCNCylinder(radius: 0.50, height: 0.8)
        BoxNode.physicsBody = SCNPhysicsBody(type: .Dynamic, shape: SCNPhysicsShape(geometry: BoxNode.geometry!, options: nil))
        BoxNode.physicsBody?.categoryBitMask = CollisionCategory.Box
        BoxNode.physicsBody?.collisionBitMask = CollisionCategory.All
        BoxNode.name = "Box"
        BoxNode.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)
        
        if #available(iOS 9.0, *) {
            BoxNode.physicsBody?.contactTestBitMask = ~0
        }

        
        */
        
        self.sceneView.scene?.rootNode.addChildNode(monsterNode)
        
        AddingObject = false
        self.lookGesture.isEnabled = true
        self.walkGesture.isEnabled = true

        self.placeItemView.isHidden = true
    }
    
    
    func deleteNodeSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        
        print("Swipe gesture started")
        
        if gesture.direction == .right {
        
        if canDeleteObject {
            
            TouchingNode.removeFromParentNode()
            
            print("swiping right, would delete the Touching Node Now")
            
        } else {
            print("Does nothing, no item to delete seleted")
        }
            
        }
        
    }
    
    @IBAction func ClosePlaceItemView(_ sender: AnyObject) {
        
        if AddingObject {
            
            self.placeItemView.isHidden = true
            self.AddingObject = false
            self.lookGesture.isEnabled = true
            self.walkGesture.isEnabled = true
            
        }
        
    }
    
    func dismissAddItemTapped(_ gesture: UITapGestureRecognizer) {
        
        if AddingObject {
            
        self.placeItemView.isHidden = true
        self.AddingObject = false
        self.lookGesture.isEnabled = true
        self.walkGesture.isEnabled = true
            
        }
    }
    
    func doubletapped(_ gesture: UITapGestureRecognizer) {
        //print("Double Tapped")
        
        //playWalkAnimation(theNodes: EnemyNodesToAnimate, theAnimations: EnemyWalkingAnimations)
        
       // var nodeMaterial: SCNMaterial?
        
        if !AddingObject {
          //  DismissAddItemGesture.enabled = false
            self.lookGesture.isEnabled = false
            self.walkGesture.isEnabled = false
            
           // if gesture.state == .Began {
                self.placeItemView.isHidden = false
                print("Double Tap Gesture, show add objet view")
            
            
            
            let location = gesture.location(in: self.sceneView)
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            
            if let tap = NodeArray.first?.node {
                
               
                //print(nodeMaterial.description)
                
               let tappNode = tap
               // myScene?.cameraNode.position = tappNode.position
           print("TappNode: \(tappNode.position)")
                print("tappNode Name: \(tappNode.name)")
                }
            
            
            //print("Node Array Info: \(NodeArray)")
            if NodeArray.count > 0 {
                
                for theNodes in NodeArray {
                    print("NodeArray Child Name: \(theNodes.node.name)")
                }
               // print("Node array = \(NodeArray[0])")
                let result: SCNHitTestResult = NodeArray[0]
                print("Double Tap result name = \(result.node.name)")
                
                // print("result dictionary values = \(result.dictionaryWithValuesForKeys(["tag"]))")
                
                
               // if result.node.name == "BLOCK" {
                    
                    
                 //   let ItemMapX = floor(result.worldCoordinates.x)
                 //   let ItemMapY = floor(result.worldCoordinates.z)
                
                let ItemMapX = result.worldCoordinates.x
                let ItemMapY = result.worldCoordinates.y
                let ItemMapZ = result.worldCoordinates.z
                
                
                AddItemX = ItemMapX
                AddItemZ = ItemMapZ
                AddItemY = ItemMapY
                
                print("Double tap Item Map x = \(ItemMapX)")
                print("Double tap Item Map y = \(ItemMapY)")
                print("Double tap Item Map Z = \(ItemMapZ)")
                
            
            }
            
          //  }
          //  DismissAddItemGesture.enabled = true
            AddingObject = true
            
        } else {
            
            self.lookGesture.isEnabled = true
            self.walkGesture.isEnabled = true
        //    if gesture.state == .Began {
                placeItemView.isHidden = true
                print("Double Tap Gesture Done, hide add object view")
                
        //    }
            
            AddingObject = false
           // DismissAddItemGesture.enabled = false
        }

        
        
    }
    
    
    func doubletapGestureRecognized(_ gesture: UITapGestureRecognizer) {
        
        if !AddingObject {
        
         if gesture.state == .began {
            placeItemView.isHidden = false
            print("Double Tap Gesture, show add objet view")
            
        }
            
            AddingObject = true
            
        } else {
            
            if gesture.state == .began {
             placeItemView.isHidden = true
                print("Double Tap Gesture Done, hide add object view")
                
            }
            
            AddingObject = false
            
        }
        
        
        
    }
    
    func selectItemGestureRecognized(_ gesture: UILongPressGestureRecognizer) {
        
        var nodeMaterial: SCNMaterial?

        print("long press recognized")
        
        if gesture.state == .began {
            
            self.lookGesture.isEnabled = false
            self.walkGesture.isEnabled = false
            self.moveItemGesture.isEnabled = true
            MovingObject = true
            
            print("long press began")
            print("Location touching = \(gesture.location(in: self.sceneView)))")
            
            let location = gesture.location(in: self.sceneView)
            
            TouchScreenX = location.x
            TouchScreenY = location.y
            
            
             if TouchScreenX + 50 > UIScreen.main.bounds.width {
            deleteItemViewX.constant = TouchScreenX - 100
             } else if TouchScreenX - 50 <= 0 {
               deleteItemViewX.constant = TouchScreenX + 100
             } else {
             deleteItemViewX.constant = TouchScreenX - 100
            }
            
            if TouchScreenY + 50 > UIScreen.main.bounds.height {
            deleteItemViewY.constant = TouchScreenY - 50
            } else if TouchScreenY - 50 <= 0 {
            deleteItemViewY.constant = TouchScreenY + 100
            } else {
            deleteItemViewY.constant = TouchScreenY
            }
 
            
          //  deleteItemViewY.constant = TouchScreenY
         //   deleteItemViewX.constant = TouchScreenX
            
            
            deleteItemView.isHidden = false
            
            //print("Long Pressed on Screen at X:\(TouchScreenX) Y:\(TouchScreenY)")
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            if NodeArray.count > 0 {
                
                print("NODE INFO: \(NodeArray.first?.node)")
                
                for item in (NodeArray.first?.node.childNodes)! {
                    print("NODE ITEM: \(item.name)")
                }
                
                nodeMaterial = NodeArray.first?.node.geometry!.firstMaterial
                
                print("NODE MATERIAL: \(nodeMaterial)")
                canDeleteObject = true
                
                print("Can delete object = \(canDeleteObject)")
                
               // print("Node array = \(NodeArray)")
                let result: SCNHitTestResult = NodeArray[0]
                print("LONG PRESS result name = \(result.node.name)")
               
               // print("result dictionary values = \(result.dictionaryWithValuesForKeys(["tag"]))")
              
              //  if result.node.name == "BLOCK" {
                if result.node.name == "WallRight" || result.node.name == "Barrel" || result.node.name == "Enemy" {
                
                    
                    let ItemMapX = floor(result.worldCoordinates.x)
                    let ItemMapY = floor(result.worldCoordinates.z)
                    
                    TouchingNode = result.node
                    
                    let itemPosition = SCNVector3(x: TouchingNode.presentation.position.x, y: TouchingNode.presentation.position.y, z: TouchingNode.presentation.position.z)
                    
                    let itemRotation = SCNVector4(x: TouchingNode.presentation.rotation.x, y: TouchingNode.presentation.rotation.y, z: TouchingNode.presentation.rotation.z, w: TouchingNode.presentation.rotation.w)
                    
                    if TouchingNode.childNodes.count > 0 {
                    print("Node Child Name = \(result.node.childNodes[0].name)")
                    }
                    
                let glowNode: SCNNode = result.node.copy() as! SCNNode
                   // glowNode.size = OriginalNode.size
                   // glowNode.anchorPoint = OriginalNode.anchorPoint
                   // glowNode.position = CGPoint(x: 0, y: 0)
                   // glowNode.alpha = 0.5
                   // glowNode.blendMode = SKBlendMode.Add
                    
                    // add the new node to the original node
                   // OriginalNode.addChildNode(glowNode)
                    
                    // add the original node to the scene
                   // self.addChild(OriginalNode)
                    
                    
                   // glowNode.
                    glowNode.name = "GLOWCHILD"
                    glowNode.position = itemPosition
                    glowNode.geometry = SCNCylinder(radius: 0.15, height: 0.6)
                    glowNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: glowNode.geometry!, options: nil))
                    glowNode.physicsBody?.categoryBitMask = CollisionCategory.Monster
                    glowNode.physicsBody?.collisionBitMask = CollisionCategory.All
                    //glowNode.name = "BLOCK"
                    let glowFilter = CIFilter(name: "CIGaussianBlur")!
                    glowFilter.setValue(120, forKey: kCIInputRadiusKey)
                    glowNode.filters = [glowFilter]
                    glowNode.light = SCNLight()
                    glowNode.light!.type = SCNLight.LightType.ambient
                    glowNode.light!.color = UIColor.darkGray
                   // glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
                    glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 0.5)
                    //glowNode.alpha = 0.5
                    //glowNode.blendMode =
                   // glowNode.geometry.c
                    //glowNode.setValuesForKeysWithDictionary(["tag":"1boxtest"])
                    // monsterNode.u
                    if #available(iOS 9.0, *) {
                        glowNode.physicsBody?.contactTestBitMask = ~0
                    }
                    
                    print("Adding Glow Node")
                    TouchingNode.addChildNode(glowNode)
                    
                    
                    /*
                    let nodeFilter = CIFilter(name: "CIGaussianBlur")!
                    nodeFilter.setValue(120, forKey: kCIInputRadiusKey)
                    TouchingNode.filters = [nodeFilter]
                    TouchingNode.light = SCNLight()
                    TouchingNode.light!.type = SCNLight.LightType.ambient
                    TouchingNode.light!.color = UIColor.darkGray
                    // glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
                    TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 0.5)
                    */
                    
                    //TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
                     TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 1.0)
                
                    
                   // self.sceneView.scene?.rootNode.addChildNode(TouchingNode)
   
                
                }
                
                //print("ITEM MAP X:\(ItemMapX) Y:\(ItemMapY)")
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "LONG PRESS Touching X: Y:"
               // alertView.message = "Pixel X:\(ItemMapX) Y:\(ItemMapY) name: \(result.node.name)"
                alertView.delegate = self
                
                alertView.addButton(withTitle: "OK")
              //  alertView.show()
                
            }
            
            
        }
        
        if gesture.state == UIGestureRecognizerState.changed {
            
            let location = gesture.location(in: self.sceneView)
           // let previousLocation = gesture.
            
            print("Can delete object = \(canDeleteObject)")
            
           // if gesture.direc
            let NextTouchScreenX = location.x
            let NextTouchScreenY = location.y

            if NextTouchScreenX >= TouchScreenX + 100 {
            
            print("Swiped to the right >= 100")
            
            if canDeleteObject {
                MovingObject = false
                TouchingNode.removeFromParentNode()
                
                print("swiping right, would delete the Touching Node Now")
                
            } else {
                print("Does nothing, no item to delete seleted")
            }

            
            }

            print("Long press moved")
            
        }
        
        
        if gesture.state == UIGestureRecognizerState.ended {
            canDeleteObject = false
            print("Can delete object = \(canDeleteObject)")
            TouchScreenX = 0
            TouchScreenY = 0
            
            deleteItemView.isHidden = true
            
            print("long press ended, removing nodes from Node Named:\(TouchingNode.name)")
            self.lookGesture.isEnabled = true
            self.walkGesture.isEnabled = true
            self.moveItemGesture.isEnabled = false
            
            if MovingObject {
                print("Moving Object/Long Press ended")
            // TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteColor()
               
                if TouchingNode.childNodes.count > 0 {
                    if (TouchingNode.childNode(withName: "GLOWCHILD", recursively: true) != nil) {
                        
                        
                       // TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                        if nodeMaterial != nil {
                        
                        TouchingNode.geometry?.firstMaterial? = nodeMaterial!
                            
                        }
                        
                       // nodeMaterial = tap.geometry!.firstMaterial
                        // print("Touches ended, this  node has a child node")
                        // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
                        // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
                        // GlowChildNode!.removeFromParentNode()
                        //TouchingNode.filters = nil
                       // TouchingNode.light = nil
                      //  TouchingNode.
                        
                        for cnodes in TouchingNode.childNodes {
                            print("removing ALL the child nodes")
                            if cnodes.name == "GLOWCHILD" {
                                print("Removing Glow Node")
                                cnodes.removeFromParentNode()
                            } else {
                               // cnodes.removeFromParentNode()
                            }
                        }
                    }
                }
          //  }
            
          //  MovingObject = false
                
            /*
                
            var location = gesture.locationInView(self.sceneView)
            
            // var location = touch.locationInNode(self.sceneView)
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            if NodeArray.count > 0 {
                
               
                //NodeArray[0].node.geometry
                
                if NodeArray[0].node.childNodes.count > 0 {
                    print("this node has a child")
                    if (NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true) != nil) {
                        print("this node has a child named GLOWCHILD")
                        
                       // NodeArray[0].node.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGrayColor()
                        NodeArray[0].node.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteColor()
                        // print("Touches ended, this  node has a child node")
                       // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
                        // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
                       // GlowChildNode!.removeFromParentNode()
                        for cnodes in NodeArray[0].node.childNodes {
                            print("removing ALL the child nodes")
                            if cnodes.name == "GLOWCHILD" {
                            cnodes.removeFromParentNode()
                            }
                        }
                        
                    }
                }
            }
            */
                MovingObject = false
        }
        
            
            
            //let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)!
          //  GlowChildNode.removeFromParentNode()
        }
        
        
    }
    
    
    func fireGestureRecognized(_ gesture: FireGestureRecognizer) {
        
        //update timestamp
        
        
        
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTappedFire < autofireTapTimeThreshold {
            tapCount += 1
        } else {
            tapCount = 1
        }
        lastTappedFire = now
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateAmmoNotification"), object: nil)
 
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
    

    
    private func characterDirection(towards: String) -> float3 {
        
        
        let controllerDirection = SCNVector3(x: 1, y: 1, z: 1)
        // let controllerDirection = self.controllerDirection()
        var direction = float3(controllerDirection.x, 0.0, controllerDirection.y)
        
        if towards != "hero" {
            
        if let pov = sceneView.pointOfView {
            let p1 = pov.presentation.convertPosition(SCNVector3(direction), to: nil)
            let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
            
            direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
            
            if direction.x != 0.0 || direction.z != 0.0 {
                direction = normalize(direction)
            }
        }
        
        } else {
            
            
            var currentPosition = EnemyNodeScene.node.position
            var targetPosition = heroNode!.presentation.position
            
            
             print("ENEMY CURRENT POSITION: \(currentPosition)")
             print("TARGET POSITION: \(targetPosition)")
            
            
            let location = heroNode!.position
            
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
            
            if let pov = sceneView.pointOfView {
                let p1 = pov.presentation.convertPosition(SCNVector3(heroDirection), to: nil)
                let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
                
                direction = float3(Float(p1.x - p0.x), 0.0, Float(p1.z - p0.z))
                
                if direction.x != 0.0 || direction.z != 0.0 {
                    direction = normalize(direction)
                }
            }
            
            
        }
        
        
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
    
    
    func EnemyRandomFiring() {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomMovemovementInt.count)))
        
        // print(ActiveLocations[randomIndex])
        let nextAttack = randomMovemovementInt[randomIndex]
        
        
        if nextAttack == 0 {
             self.shootBTNEnemy()
        }
   
    }
    
    func EnemyRandomMovements(time: TimeInterval) {
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(randomMovemovementInt.count)))
        
        // print(ActiveLocations[randomIndex])
        let nextMovement = randomMovemovementInt[randomIndex]
        
        
        if nextMovement == 0 {
            
            
            self.EnemyNodeScene.lookAround()
            
        } else {
        
        
        let direction = characterDirection(towards: "noone")
        
      //  let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial:groundTypeFromMaterial, action: "walk", target: "noone", heroDistance: 20)
            
        let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, action: "walk", target: "noone", heroDistance: 20)
        // let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial: GroundType.grass)
        if let groundNode = groundNode {
            updateCameraWithCurrentGround(groundNode)
        }
        
        
        }
        
        
    }
    
    var aimingEnemyGun = Bool()
    
    func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
       // let scene = gameView.scene!
        
        var HeroEnemyDistance = heroNode.position.distance(vector: EnemyNodeScene.node.position)
        //let HeroEnemyDistance = SCNVector3Distance(start)
        print("HeroEnemyDistance = \(HeroEnemyDistance)")
        
       
        
        if HeroEnemyDistance < 1 {
            print("Start fire weapon")
            EnemyNodeScene.fireWeapon()
        }
        
        HeroEnemyDistance = 20
        
        //EnemyTarget = "hero"
        
        if startScene {
            
            
            if !EnemyRunningAway {
                
               // self.EnemyRandomMovements(time: time)
                
            let direction = characterDirection(towards: EnemyTarget)
        
            //let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial:groundTypeFromMaterial, action: "walk", target: EnemyTarget, heroDistance: HeroEnemyDistance)
                
            let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, action: "walk", target: EnemyTarget, heroDistance: HeroEnemyDistance)
            
            // let groundNode = EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial: GroundType.grass)
            
            
            if let groundNode = groundNode {
                updateCameraWithCurrentGround(groundNode)
            }
            
               // EnemyNodeScene.lookAround()
                
            
            }
            
            
            if !self.EnemyDead {
                
                
                
                //UPDATE RESPONSE ATTACK 130K SCRIPTS RUN
                
                
                
                /*
                UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID as String, response: "", action: "read") {
                    (result, attackResponse) in
                    //  if let AttackResponseUpdated = result {
                    // print("Response Updated: \(result), response: \(attackResponse)")
                    
                    
                    if attackResponse == "run" {
                        
                        print("Enemy Should be running")
                        
                        self.EnemyShouldNotMove = false
                        self.EnemyRunningAway = true
                        
                        let direction = self.characterDirection(towards: "noone")
                        
                        let groundNode = self.EnemyNodeScene.walkInDirection(direction, time: time, scene: self.sceneView.scene!, groundTypeFromMaterial:self.groundTypeFromMaterial, action: "run", target: "noone", heroDistance: HeroEnemyDistance)
                        
                        if let groundNode = groundNode {
                            self.updateCameraWithCurrentGround(groundNode)
                        }
                        
                        //self.enemyNode.removeAnimation(forKey: "flail")
                        //self.enemyNode.addAnimation(self.enemyWalkAnimation, forKey: "walk")
                        // self.enemyNode.addAnimation(self.enemyFlailAnimation, forKey: "flail")
                    }
                    
                }
                
                */
            }
            
        }
        
        //get walk gesture translation
        let translation = walkGesture.translation(in: self.view)

       // print("Translation = \(translation)")
        
        //create impulse vector for hero
        let angle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
        var impulse = SCNVector3(x: max(-1, min(1, Float(translation.x) / 50)), y: 0, z: max(-1, min(1, Float(-translation.y) / 50)))
        
      
        //create Item Vector
        
        
        
        
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
        
        self.HeroPosition = SCNVector3(x: heroNode.presentation.position.x, y: heroNode.presentation.position.y, z: heroNode.presentation.position.z)
        
        print("HERO POSITION TEST: \(HeroPosition)")
        
        self.HeroRotation = SCNVector4(x: heroNode.presentation.rotation.x, y: heroNode.presentation.rotation.y, z: heroNode.presentation.rotation.z, w: heroNode.presentation.rotation.w)
        

        
        if EnemyTarget == "hero" {
            
            
            var IsEnemyFiring = EnemyNodeScene.IsEnemyFiring()
            
            
            //NEED TO DELETE
            IsEnemyFiring = true
            
            switch self.enemyWeapon {
                
            case "Gun":
                
            if IsEnemyFiring {
                
                
                //self.shootBTNEnemy()
                //GENERATES THE FIRING ACTION
                self.EnemyRandomFiring()
                
                let nowEnemy = CFAbsoluteTimeGetCurrent()
                if nowEnemy - lastTappedFireEnemy < autofireTapTimeThresholdEnemy {
                    let fireRateEnemy = min(Double(maxRoundsPerSecondEnemy), Double(tapCountEnemy) / autofireTapTimeThresholdEnemy)
                    if nowEnemy - lastFiredEnemy > 1 / fireRateEnemy {

                print("Enemy is firing, should show enemy bullet")
                
                let enemyAngle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
                var enemyDirection = SCNVector3(x: -sin(enemyAngle), y: 0, z: -cos(enemyAngle))
                
                enemyDirection = SCNVector3(x: cos(elevation) * enemyDirection.x, y: sin(elevation), z: cos(elevation) * enemyDirection.z)
                
                //create or recycle bullet node
                let bulletNode: SCNNode = {
                    if self.bulletsEnemy.count < self.maxBulletsEnemy {
                        
                        //  NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                        
                        return SCNNode()
                    } else {
                        
                        //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                        
                        
                        //    ammoRemaining--
                        //    self.ammoLBL.text = "ammo:\(ammoRemaining.description)"
                        return self.bulletsEnemy.remove(at: 0)
                    }
                }()
                if ammoRemainingEnemy > 0 {
                    bulletsEnemy.append(bulletNode)
                    
                    // NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
                    
                } else {
                   // self.overlayView.alpha = 1
                   // overlayLBL.text = "You're out of ammo!"
                }
                
                bulletNode.geometry = SCNBox(width: CGFloat(bulletRadiusEnemy) * 2, height: CGFloat(bulletRadiusEnemy) * 2, length: CGFloat(bulletRadiusEnemy) * 2, chamferRadius: CGFloat(bulletRadiusEnemy))
                
                // 0.4 Height
                // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
                
               // bulletNode.position = SCNVector3(x: EnemyNodeScene.node.presentation.position.x, y: 0.7, z: EnemyNodeScene.node.presentation.position.z)
                        
                bulletNode.position = SCNVector3(x: EnemyNodeScene.enemyWeapon.presentation.position.x, y: 0.7, z: EnemyNodeScene.enemyWeapon.presentation.position.z)
                
                
                bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                bulletNode.physicsBody?.categoryBitMask = CollisionCategory.BulletEnemy
                bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Enemy
                bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1.5, z: 1)
                self.sceneView.scene!.rootNode.addChildNode(bulletNode)
                
                //apply impulse
                let impulse = SCNVector3(x: enemyDirection.x * Float(bulletImpulseEnemy), y: enemyDirection.y * Float(bulletImpulse), z: enemyDirection.z * Float(bulletImpulseEnemy))
                bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
                bulletNode.name = "bulletEnemy"
                
                
                
                
                //update timestamp
                lastFiredEnemy = nowEnemy
                }
                
                
//                self.HeroHandsAttack.speed = 2.0
//                self.HeroHandsAttack.repeatCount = 1
//                self.heroHands.addAnimation(self.HeroHandsAttack, forKey: "handsPunch")
                
             }
                
            }
            
            default:
                break
                
            }
        }
        
        
        
        
        
        //handle firing
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTappedFire < autofireTapTimeThreshold {
            let fireRate = min(Double(maxRoundsPerSecond), Double(tapCount) / autofireTapTimeThreshold)
            if now - lastFired > 1 / fireRate {
                
                //get hero direction vector
                let angle = heroNode.presentation.rotation.w * heroNode.presentation.rotation.y
                var direction = SCNVector3(x: -sin(angle), y: 0, z: -cos(angle))
                
                
                
                
                
                
                
                
//                //get elevation
//                direction = SCNVector3(x: cos(elevation) * direction.x, y: sin(elevation), z: cos(elevation) * direction.z)
//                
//                //create or recycle bullet node
//                let bulletNode: SCNNode = {
//                    if self.bullets.count < self.maxBullets {
//                        
//                      //  NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//                        
//                        return SCNNode()
//                    } else {
//                        
//                     //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//
//                        
//                    //    ammoRemaining--
//                    //    self.ammoLBL.text = "ammo:\(ammoRemaining.description)"
//                        return self.bullets.remove(at: 0)
//                    }
//                }()
//                if ammoRemaining > 0 {
//                bullets.append(bulletNode)
//                    
//               // NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//                    
//                } else {
//                    self.overlayView.alpha = 1
//                    overlayLBL.text = "You're out of ammo!"
//                }
//                bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
//               
//                // 0.4 Height
//                // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
//                
//                bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.7, z: heroNode.presentation.position.z)
//                
//                
//                bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
//                bulletNode.physicsBody?.categoryBitMask = CollisionCategory.Bullet
//                bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Hero
//                bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1.5, z: 1)
//                self.sceneView.scene!.rootNode.addChildNode(bulletNode)
//                
//                //apply impulse
//                let impulse = SCNVector3(x: direction.x * Float(bulletImpulse), y: direction.y * Float(bulletImpulse), z: direction.z * Float(bulletImpulse))
//                bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
//                bulletNode.name = "bullet"
                

                
                switch self.currentWeapon {
                    
                    
                case "Gun":
                    //create or recycle bullet node
//                    var bulletNode: SCNNode = {
//                        if self.bullets.count < self.maxBullets {
//                            
//                            //  NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//                            
//                            return SCNNode()
//                        } else {
//                            
//                            //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//                            
//                            //    ammoRemaining--
//                            //    self.ammoLBL.text = "ammo:\(ammoRemaining.description)"
//                            return self.bullets.remove(at: 0)
//                        }
//                    }()
//                    if ammoRemaining > 0 {
//                        bullets.append(bulletNode)
//                        
//                        // NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateAmmoNotification", object: nil)
//                        
//                    } else {
//                        //self.overlayView.alpha = 1
//                        //overlayLBL.text = "You're out of ammo!"
//                    }
                    
                    
                    
                                    direction = SCNVector3(x: cos(elevation) * direction.x, y: sin(elevation), z: cos(elevation) * direction.z)
                    
                                    //create or recycle bullet node
                                    let bulletNode: SCNNode = {
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
                                        self.overlayView.alpha = 1
                                        overlayLBL.text = "You're out of ammo!"
                                    }
                                    bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
                    
                                    // 0.4 Height
                                    // bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
                    
                                    bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.7, z: heroNode.presentation.position.z)
                    
                    
                                    bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                                    bulletNode.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                                    bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Hero
                                    bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 1.5, z: 1)
                                    self.sceneView.scene!.rootNode.addChildNode(bulletNode)
                                    
                                    //apply impulse
                                    let impulse = SCNVector3(x: direction.x * Float(bulletImpulse), y: direction.y * Float(bulletImpulse), z: direction.z * Float(bulletImpulse))
                                    bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
                                    bulletNode.name = "bullet"
                    
                    
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
        
        
        
    }

    
    func updateUserHealth(current: Int, new: Int, setting: String, nodeName: String) {
        
        
        
        
        var newAmount = Int()

        
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
        
        
        self.AttackingPlayersHealthInt = newAmount
        
        let newAmountDouble = Double(newAmount)
        let tc = Double(100)
        
        let tempP = newAmountDouble / tc
        
        // let hitprogress = Float(tempP)
        
        
        let newAmountProgress = Float(tempP)
        print("new amount progress: \(newAmountProgress)")
        
        
        DispatchQueue.main.async(execute: {
            //print("generating Map now")
            self.hitProgressView.setProgress(newAmountProgress, animated: true)
            self.PlayingEnemySound = false
            
            if newAmount == 0 {
                
                self.sceneView.isPlaying = false
                
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
        
//                    self.enemyDeadAnimation.repeatCount = 1
//                    self.enemyDeadAnimation.autoreverses = true
//                    self.enemyDeadAnimation.duration = 10.0
//                    self.enemyNode.addAnimation(self.enemyDeadAnimation, forKey: "enemyDead")
//               
//                    if !self.ClosingView {
//                        
//                        self.ClosingView = true
//                        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
//                            
//                            
//                            DispatchQueue.main.async(execute: {
//                                //  self.removeFromSuperview()
//                                
//                                
//                                self.TargetEliminated()
//                                
//                                
//                            })
//                            
//                        })
//                        
//                    }
                    
                    
                })
                
                
               // self.enemyDeadAnimation.repeatCount = 1
                
                
                
            }
          
        })
        
        
        if newAmount == 0 {
            
            print("Target eliminated")
  
        }
        
        
    }
    
    
    func didBeginContact(_ contact: SKPhysicsContact) {
        print("CONTACT")
        
        if ((contact.bodyA.categoryBitMask.hashValue == CollisionCategory.Bullet) && (contact.bodyB.categoryBitMask.hashValue == CollisionCategory.Monster)) {
            
            print("Bullet  hit cylinder from DID BEGIN CONTACT SPRITE KIT?")
            
        }
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        
        print("Did move to parent view")
       // self.physicsWorld.contactDelegate = self
    }
    
    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("Contact received from physics world")
        //let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        /*
 if (contactMask == (CollisionBallCategory | CollisionTerminatorCategory)) {
 print("Collided")
 }
         */
        
        
        print("contactMask A: \(contact.nodeA.physicsBody!.categoryBitMask)")
        print("contactMask B: \(contact.nodeA.physicsBody!.categoryBitMask)")
      //  if didBeginContact(SKPhysicsContact.)
        print("contact A Name: \(contact.nodeA.name)")
        print("contact B Name: \(contact.nodeB.name)")
 
        let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        
        let contactMask2 = contact.nodeB.physicsBody!.categoryBitMask | contact.nodeA.physicsBody!.categoryBitMask
        
        //if didBeginContact(contact.)
        
        if (contactMask == (CollisionCategory.Monster | CollisionCategory.Wall) || contactMask2 == (CollisionCategory.Monster | CollisionCategory.Wall)) {
            
            
          print("Monster Item Hit the Wall")
            
            
           // self.performSegue(withIdentifier: "EndAttack", sender: self)
            
        }
        
        
        
        
         if (contactMask == (CollisionCategory.Hero | CollisionCategory.missionItem)) {
         
           
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Ran into mission Item"
                alertView.message = "Pick Up Item?"
               // alertView.delegate = self
              //  alertView.addButtonWithTitle("OK")
               // alertView.show()
            
            
            print("Hero hit mission item")
            
            attackTimer.invalidate()
            
         //   let AttackStaminaAmount = "50"
         //   let AttackGoldAmount = "50"
            
            prefs.set(["missionStatus":"complete", "missionID":"\(self.MissionID)", "missionObjective":"\(MissionObjective)"], forKey: "MissionCompletedDictionary")
            
            
            //self.performSegue(withIdentifier: "EndAttack", sender: self)
            
        }
        
        
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Monster)) {
            print("Bullet Collided with Cylinder")
            
            print("HIT COUNT = \(enemyHitCount.description), hit Cylinder: \(contact.nodeB.name)")
            //   enemyHitCount += 1
            //    print("EnemyHit count = \(enemyHitCount.description)")
            //    self.countLBL.text = "Hits:\(enemyHitCount.description)"
            
            if contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.Monster {
            
            
            if CylindersHitArray.contains(contact.nodeB.name!) {
            print("Already hit this one!!!!!")
                
                
                
            } else {
            CylindersHitArray.append(contact.nodeB.name!)
            print("Cylinders hit names arry: \(CylindersHitArray)")
                
                
               NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateCountNotification"), object: nil)

                enemyHitCount += 1
                
                
                if enemyHitCount >= TotalCylinders {
                    
                    enemyHitCount = TotalCylinders
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Mission Complete"
                    alertView.message = "All Targets Eliminated"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                    attackTimer.invalidate()
                    
                    
                    
                    
                   // self.performSegue(withIdentifier: "EndAttack", sender: self)

                    
                } else {
                    
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateCountNotification"), object: nil)
                    
                }
                
                /*
                print("EnemyHit count = \(enemyHitCount.description)")
                self.hitLBL.text = "Hits: \(enemyHitCount.description)"
                let hitprogress: Float = Float(enemyHitCount / TotalCylinders)
                hitProgressView.setProgress(hitprogress, animated: true)
                */
                
                
            }
            
            if contact.nodeB.name == "BLOCK" {
              //  contact.nodeB.removeFromParentNode()
            }
            
                
            } else {
                
                if CylindersHitArray.contains(contact.nodeA.name!) {
                    print("Already hit this one!!!!!")
                    
                    
                    
                } else {
                    CylindersHitArray.append(contact.nodeA.name!)
                    print("Cylinders hit names arry: \(CylindersHitArray)")
                    
                   // let HitNode = SCNNode()
                    
                  //  contact.nodeA.addChildNode(HitNode)
                    
                    enemyHitCount += 1

                    if enemyHitCount >= TotalCylinders {
                        
                        enemyHitCount = TotalCylinders
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Mission Complete"
                        alertView.message = "All Targets Eliminated"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        attackTimer.invalidate()
                        
                        self.performSegue(withIdentifier: "EndAttack", sender: self)

                        
                    } else {
                    
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "AttackUpdateCountNotification"), object: nil)
                    
                    }
                    
                 //   enemyHitCount += 1
                 //   ItemsHitProgressLBL.text = "\(enemyHitCount)"
                    
                    
                   // print("EnemyHit count = \(enemyHitCount.description)")
                 //   self.hitLBL.text = "Hits: \(enemyHitCount.description)"
                    
                   
                   
                    /*
                    ItemsHitProgressLBL.text = "\(enemyHitCount)"
                    print("EnemyHit count = \(enemyHitCount.description)")
                    self.hitLBL.text = "Hits: \(enemyHitCount.description)"
                    let hitprogress: Float = Float(enemyHitCount / TotalCylinders)
                    hitProgressView.setProgress(hitprogress, animated: true)
                    */
                    
                }
                
                if contact.nodeA.name == "BLOCK" {
                    //  contact.nodeB.removeFromParentNode()
                }

                
            }
           //
            //, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(self.GoldProductionAmount.description)"])
            
        }
        
        
        if (contactMask == (CollisionCategory.Enemy | CollisionCategory.Wall) || contactMask2 == (CollisionCategory.Enemy | CollisionCategory.Wall)) {
            
            
            print("Enemy Hit the Wall")
            
            
            // self.performSegue(withIdentifier: "EndAttack", sender: self)
            
        }
        
        
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Enemy)) {
            print("Bullet Collided with Enemy")
            
            EnemyTarget = "hero"
            
            let audioSource = SCNAudioSource(fileNamed: "animate.scnassets/male_uh.mp3")!
            let audioPlayer = SCNAudioPlayer(source: audioSource)
            EnemyNodeScene.node.addAudioPlayer(audioPlayer)
            
            var NewHealthAmount = Int()
            
            self.AlertEnemyOfAttack()
            
            switch contact.nodeB.name {
                
                
                
                case "bullet"?:
                    
                    NewHealthAmount = 50
            
                    switch contact.nodeA.name {
                
                        case "headPlane"?:
                            
                            NewHealthAmount = 50
                            
                            print("hit Head with bullet")
                            EnemyNodeScene.GotHit(location: "head", isDead: false, stopWalking: false)
                        
                            if (self.AttackingPlayersHealthInt - NewHealthAmount) <= 0 {
                                
                            } else {
                                
                            }
                        
                        default:
                            print("hit body with bullet")
                            
                            NewHealthAmount = 10
                            
                            EnemyNodeScene.GotHit(location: "belly", isDead: false, stopWalking: false)
                        
                            if (self.AttackingPlayersHealthInt - NewHealthAmount) <= 0 {
                                
                            } else {
                                
                            }
                }
                
                
                
                case "firstPlane"?:
                
                    
                    
                    switch contact.nodeA.name {
                    
                        case "headPlane"?:
                            print("hit Head with fist")
                            
                            NewHealthAmount = 10
                            
                            EnemyNodeScene.GotHit(location: "head", isDead: false, stopWalking: false)
                        
                            if (self.AttackingPlayersHealthInt - NewHealthAmount) <= 0 {
                                
                            } else {
                                
                            }
                        
                        default:
                            print("hit body with fist")
                            
                            NewHealthAmount = 5
                            
                            EnemyNodeScene.GotHit(location: "belly", isDead: false, stopWalking: false)
                            
                            if (self.AttackingPlayersHealthInt - NewHealthAmount) <= 0 {
                                
                            } else {
                                
                            }
                    }
                
                
                default:
                    break
            
            }
            
            
            
            
            
            
            
            if !PlayingEnemySound {
                self.PlayingEnemySound = true
                let uhsound = SCNAction.playAudio(audioSource, waitForCompletion: true)
                //enemyNode.runAction(uhsound)
                EnemyNodeScene.node.runAction(uhsound)
                EnemyNodeScene.node.removeAudioPlayer(audioPlayer)
            }
            

            
            updateUserHealth(current: self.AttackingPlayersHealthInt, new: NewHealthAmount, setting: "substract", nodeName: contact.nodeA.name!)
            
//            if contact.nodeA.name == "headPlane" {
//                EnemyNodeScene.GotHit(location: "head")
//            } else {
//            
//            
//            
//            {
            
         //   enemyHitCount += 1
        //    print("EnemyHit count = \(enemyHitCount.description)")
        //    self.countLBL.text = "Hits:\(enemyHitCount.description)"
            
          //   NSNotificationCenter.defaultCenter().postNotificationName("AttackUpdateCountNotification", object: nil)
            //, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(self.GoldProductionAmount.description)"])
            
        }
        
        
        
        
        
       
        
    }
    
    
    
    func AlertEnemyOfAttack() {

        if !EnemyAlreadyHit {
        
        backgroundThread(background: {
            
            self.EnemyAlreadyHit = true
            let type: NSString = "willAttack"
            
            let yesSuccess =  AttackNotice(self.username, username: self.AttackingPlayer as NSString, attackpower: self.AttackPower, type: type, attackedID: self.AttackingPlayerID as NSString)
            print("***Atttack Notice sent = \(yesSuccess)")
            
            //self.enemyNode.addAnimation(self.enemyFlailAnimation, forKey: "flail")

            
            DispatchQueue.main.async(execute: {
                //   print("Creating Local Inventory Data")
               // CreateLocalInventory(UserInfoNSData)
                
            })
            
            
        }, completion: {
            
            print("Finished Alerting User of Attack")
            DispatchQueue.main.async(execute: {
                //self.GetMyHUD.removeFromSuperview()
                //  self.tableView.reloadData()
                //  print("DISPATCH ASYNC - Finished Getting User's Info")
            })
           
        })
        
        

            
        }
        
    }
    
    @IBAction func pixelTestBTN(_ sender: AnyObject) {
        
        PixelColor(UIImage(named: "Map3.png")!, xLoc: 0, yLoc: 0)
        
        PixelColor(UIImage(named: "Map3.png")!, xLoc: 9, yLoc: 3)
        
        PixelColor(UIImage(named: "Map3.png")!, xLoc: 4, yLoc: 11)
        
        PixelColor(UIImage(named: "Map3.png")!, xLoc: 4, yLoc: 26)
        
        
        var ItemName = "Box"
        
        var newRed = UInt8()
        var newGreen = UInt8()
        var newBlue = UInt8()
        
        (newRed, newGreen, newBlue) = ReturnItemsColorCode(ItemName)
        
        
        let EditedImage = processPixelsInImage(UIImage(named: "Map3.png")!, xLoc: 3, yLoc: 11, newRed: newRed, newGreen: newGreen, newBlue: newBlue)
        
        mapImageView.image = EditedImage
        
        DispatchQueue.main.async(execute: {
            print("generating Map now")
        self.GenerateMap(EditedImage)
        })
        
    }
 
    
    func PixelColor(_ theImage: UIImage, xLoc: CGFloat, yLoc: CGFloat) {
        
        
        
        
        let pixelData = theImage.cgImage?.dataProvider?.data
        
        
        let data = CFDataGetBytePtr(pixelData)
        
        
        let pixelInfoTemp = ((theImage.size.width * yLoc) + xLoc) * 4
        
        let pixelInfo = Int(pixelInfoTemp)
        
        
        let Red = data?[pixelInfo + 0]
        let Green = data?[pixelInfo + 1]
        let Blue = data?[pixelInfo + 2]
        let alpha = data?[pixelInfo + 3]
        
        
        print("At x:\(xLoc) y:\(yLoc) the color = Red:\(Red) Green:\(Green) Blue:\(Blue)")
        
        //pixelData.
        
        /*
        var pixel : [UInt8] = [0, 0, 0, 0]
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(UnsafeMutablePointer(pixel), 1, 1, 8, 4, colorSpace, bitmapInfo)
        
        // Translate the context your required point(x,y)
        CGContextTranslateCTM(context, xLoc, yLoc);
        yourImageView.layer.renderInContext(context)
        
        theImage.renderIn
        
        NSLog("pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
        
        let redColor : Float = Float(pixel[0])/255.0
        let greenColor : Float = Float(pixel[1])/255.0
        let blueColor: Float = Float(pixel[2])/255.0
        let colorAlpha: Float = Float(pixel[3])/255.0
        
        // Create UIColor Object
        var color : UIColor! = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: CGFloat(colorAlpha))
 
 */
    }
    
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        
        UpdateResponseAttack(self.email as String, attackingID: self.AttackingPlayerID as String, response: "", action: "write") {
            (result, attackResponse) in
            print("Attack Complete Response Updated To Nil: \(result), attackResponse: \(attackResponse)")
        }
        
       // self.dismissViewControllerAnimated(true, completion: nil)
        attackTimer.invalidate()
        
        let AttackStaminaAmount = "50"
        let AttackGoldAmount = "50"
        
        switch UserObjective {
            case "mission":
            
        prefs.set(["missionStatus":"incomplete", "missionID":"\(self.MissionID)", "missionObjective":"\(MissionObjective)"], forKey: "MissionCompletedDictionary")
            
            case "training":
            
            print("need to add what happens when training ends")
            
            case "fixing":
            print("need to add what happens when fixing ends")
            
            
      //  } else {
            default:
        prefs.set(["attackStatus":"complete", "attackStamina":"\(AttackStaminaAmount)", "attackGold":"\(AttackGoldAmount)"], forKey: "AttackCompletedDictionary")
        }
        
        self.performSegue(withIdentifier: "EndAttack", sender: self)
        
    }
    
    
    func EditMapModel(_ image: UIImage) {
        
        let cgImage = image.cgImage
        
        var tiles: [Tile]!
        var entities = [Entity]()
        
        //create image context
        let width = Int((image.cgImage?.width)!)
        let height = Int((image.cgImage?.height)!)
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let info = CGImageAlphaInfo.premultipliedFirst.rawValue
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: info);
        
        let uncastedData = context!.data
        
        let pixelData = image.cgImage!.dataProvider!.data
        
        //let data = context.assumin
       // let data = uncastedData?.assumingMemoryBound(to: UInt8.self)
       // let pixelData = CGImageGetDataProvider(image as! CGImage)!.dataDataProviderCopyData(CGImageGetDataProvider(image as! CGImage)!)
       // let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(cgImage!)!)
       // let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        
       //   let data: UnsafePointer<UInt8> = CFDataGetBytePtr(uncastedData as! CFData!)
       // let data = UnsafePointer<UInt8>(CGBitmapContextGetData((context?)!))
        
        
        
        //let context = CGBitmapContextCreate(nil, width, height, 8, width * 4, colorSpace, CGBitmapInfo.ByteOrder32Little.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue)!
       // CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), cgImage)
         let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
      //  let data = UnsafeMutablePointer<UInt32>(CGBitmapContextGetData(context!))
      //   let data = UnsafeMutablePointer<UInt32>(context?.data)
      //  let pixel = pixelBuffer + Int(point.y) * width + Int(point.x)
        
       // let data = UnsafePointer<UInt8>(context?.data)
        
       // let data = UnsafeMutableRawPointer(context?.data)
        
      //  let data = context?.bytesPerRow.ass
        //let data = context.bytes.assumingMemoryBound(to: context?.self)
        
        //draw image into context
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context?.draw(image.cgImage!, in: rect)
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        self.mapImageView.image = newImage
        
        //enumerate pixels to generate tiles
       // self.init(width: width, height: height)
        for i in 0 ..< width * height {
            
            //get color components
            let offset = i * bytesPerPixel
            let red = data[offset + 1]
            let green = data[offset + 2]
            let blue = data[offset + 3]
            
            
            
            
            //convert color to tile type
            let tile = tiles[i]
            
          //  print("Item i for x:\(tiles![i].x) and y:\(tiles![i].y): red =\(red) green=\(green) blue=\(blue)")
            
            if red == 0 && green == 0 && blue == 0 {
                tile.type = .floor
            } else if red == 0 && green == 255 && blue == 0 {
                entities.append(Entity(type: .hero, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red == 255 && green == 0 && blue == 0 {
                entities.append(Entity(type: .monster, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red == 255 && green == 255 && blue == 0 {
                entities.append(Entity(type: .enemy, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red == 128 && green == 128 && blue == 128 {
                tile.type = .wall
            } else {
                tile.type = .rock
            }
        }
        
  
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         print("Touches Ended")
        
        if let touch = touches.first {
            
            print("Touches Ended")
            
            if MovingObject {
                print("Moving Object/Long Press ended")
                
            }
            
            MovingObject = false
            let location = touch.location(in: self.sceneView)
            
            // var location = touch.locationInNode(self.sceneView)
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            if NodeArray.count > 0 {
                if NodeArray[0].node.childNodes.count > 0 {
                    print("this node has a child")
                if (NodeArray[0].node.childNode(withName: "GLOWCHILD", recursively: true) != nil) {
                    print("this node has a child named GLOWCHILD")
        // print("Touches ended, this  node has a child node")
               // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
              // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
               // GlowChildNode!.removeFromParentNode()
                    
                    for cnodes in NodeArray[0].node.childNodes {
                        print("removing ALL the child nodes")
                        if cnodes.name == "GLOWCHILD" {
                            cnodes.removeFromParentNode()
                        }
                        //cnodes.removeFromParentNode()
                    }
                    
                }
              }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self.sceneView)
        let previousLocation = touch?.previousLocation(in: self.sceneView)
        
        
        print("Touch Location: \(touchLocation)")
        print("previous location: \(previousLocation)")
        
        
        
        if MovingObject {
        print("TouchesMoved")
        } else {
            print("touches moved but not moving an object")
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        
        if let touch = touches.first {
        super.touchesBegan(touches, with:event)
        //var point = touch?.locationInNode(self)
        let location = touch.location(in: self.sceneView)
        
       // var location = touch.locationInNode(self.sceneView)
        
        let NodeArray = sceneView.hitTest(location, options: nil)
        
        if NodeArray.count > 0 {
            
           // print("Node array = \(NodeArray)")
            let result: SCNHitTestResult = NodeArray[0]
            print("result name = \(result.node.name)")
           // print("result position: \(result.node.position)")
           // print("result geometry index: \(result.geometryIndex)")
           // print("result geometry: \(result.node.geometry)")
            
           // print("result world normal: \(result.worldNormal)")
           // print("result local normal: \(result.localNormal)")
          //  print("result local coordinates: \(result.localCoordinates)")
          //  print("result world coordinates: \(result.worldCoordinates)")
            let ItemMapX = floor(result.worldCoordinates.x)
            let ItemMapY = floor(result.worldCoordinates.z)
            
            
            
            print("ITEM MAP X:\(ItemMapX) Y:\(ItemMapY)")
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Touching X: Y:"
            alertView.message = "Pixel X:\(ItemMapX) Y:\(ItemMapY)"
            alertView.delegate = self
            
            alertView.addButton(withTitle: "OK")
           // alertView.show()
            
        }
        
        
        //let touchedNode = sceneView.scene.no
        
      //  let touchedNode = sceneView.scene?.rootNode
        print("Touched Point = \(location)")
        } else {
            print("No touch recognized")
        }
        
    }
    
    
    func AttackTimerBegin() {
        let aSelector: Selector = #selector(AttackMapViewController.UpdateAttackTime)
        attackTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: aSelector, userInfo: nil, repeats: true)
        // BootsTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: ["totalTime":"10"], repeats: true)
        attackTimerStartTime = Date.timeIntervalSinceReferenceDate
    }
    
    func timeString(_ time:TimeInterval) -> String {
        let minutes = Int(time) / 60
        //let seconds = Int(time) % 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    func UpdateAttackTime(){
        let item = "Body"
        var itemKey = "ARMORLEVELBODY"
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        // print("Current Time = \(currentTime)")
        
        var elapsedTime: TimeInterval = currentTime - attackTimerStartTime
        
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
        
        
        attackTimerTimeCount = attackTimerTimeCount - attackTimerTimeInterval
      //  attackTimerStartTime = attackTimerStartTime - attackTimerTimeInterval

        if attackTimerTimeCount <= 0 {
            
            print("*****ATTACK TIMER IS ZERO*****")
            
            print("\(item) has been upgraded")
            //itemTimerView4.hidden = true
           // self.BodyUpgrading = false
            attackTimer.invalidate()
            
            
          //  let CurrentLevelTemp = prefs.valueForKey(itemKey)
           // let CurrentLevel = Int(CurrentLevelTemp as! String)
           // let NextLevel = CurrentLevel! + 1
            
           // self.prefs.setValue(NextLevel.description, forKey: itemKey)
            //self.itemView4LBL.text = "\(item): \(self.prefs.valueForKey(itemKey)!)"
            // let NewBootsLevelTemp = prefs.valueForKey("ARMORLEVELBOOTS")
            
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Attack Complete!"
            alertView.message = "Returning to map now..."
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
          //  alertView.show()
            
            
            
            
            let AttackStaminaAmount = "50"
            let AttackGoldAmount = "50"
            
            
            switch UserObjective {
            case "mission":
                
                prefs.set(["missionStatus":"incomplete", "missionID":"\(self.MissionID)", "missionObjective":"\(MissionObjective)"], forKey: "MissionCompletedDictionary")
                
           // } else {
                
            case "training":
                print("update for training")
                
            case "fixing":
                print("update fixing")
                
            default:
                prefs.set(["attackStatus":"complete", "attackStamina":"\(AttackStaminaAmount)", "attackGold":"\(AttackGoldAmount)"], forKey: "AttackCompletedDictionary")
            }
            
            
             DispatchQueue.main.async(execute: {
              print("DISPATCH ENDING ATTACK")
            
                self.performSegue(withIdentifier: "EndAttack", sender: self)
            
            })
            
            
            
           // self.performSegueWithIdentifier("EndAttack", sender: self)
            //self.dismissViewControllerAnimated(true, completion: nil)
            
            
          //  self.NumberItemsUpgrading--
         //   NSUserDefaults().removeObjectForKey("\(item)EndUpgradeTime")
            
        } else {
            
            if attackTimerTimeCount <= 10 {
            timerLBL.text = timeString(attackTimerTimeCount)
            timerLBL.tintColor = UIColor.red
            } else {
            timerLBL.text = timeString(attackTimerTimeCount)
            timerLBL.tintColor = UIColor.white
            }
            
        }
        
    }
    
    
    /*
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        var didTouchNoneBlock = false
        var merging = false
        /*
        if (Teleport.teleportMode) {
            // check what nodes are tapped
            let p = gestureRecognize.location(in: scnView)
            
            let hitResults = scnView.hitTest(p, options: nil)
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                // retrieved the first clicked object
                let result: AnyObject! = hitResults[0]
                let id: Int  = result.node.value(forKey: "id") as! Int
                //print("ID block selected = \(id)")
                if id != -1 && (result.node.parent!.value(forKey: "merged")) == nil { // if not bg nor ground nor merged
                    World.zones[World.selectedZone!].selectedBlock = id
                    //print("ID block selected = \(id), blockSelected = \(World.zones[World.selectedZone!].selectedBlock)")
                    //link the blocks and dismiss
                    //print(Teleport.teleportMode)
                    Teleport.autoSwitchBackToZone = true
                    Teleport.saveTeleport()
                    self.dismiss(animated: true, completion: nil)
                } else if ((result.node.parent!.value(forKey: "merged")) != nil) { // if player chose a merged block
                    let alert = UIAlertController(title: "Warning", message: "You can't link the zone to a merged block.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        } else {
            */
            
            // check what nodes are tapped
            let p = gestureRecognize.location(in: sceneView)
            let hitResults = sceneView.hitTest(p, options: nil)
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                // retrieved the first clicked object
                let result: AnyObject! = hitResults[0]
                let id: Int  = result.node.value(forKey: "id") as! Int
                //print("Id block \(id)")
                
                if (!merging) { // we don't merge, we act normally
                   // if id != -1 && id != World.zones[World.selectedZone!].selectedBlock {
                        //print(World.zones[World.selectedZone!].links)
                    
                    /*
                        if ((World.zones[World.selectedZone!].links.values.index(of: id)) != nil) { // we find out if it's a teleport or not                                 let index = find(World.zones[World.selectedZone!].links.values, id)
                            
                            self.doYouWantToTeleport(id)
                        }
                    */
                        
                       // self.clearSelectedFace()
                        
                        SCNTransaction.animationDuration = 0.5
                       // self.editionOpened = true
                       // self.editionMode = false
                        // highlight it
                        //if edit was opened previously, we collapse it back
                       // animateEdition()
                        showHideEdition()
                        self.changeCamera(self.cameraBloqued ? true : false)
                        
                        if ((result.node.parent!.value(forKey: "merged")) != nil) { // if we are on a block merged
                            //print("merged node")
                            
                            World.zones[World.selectedZone!].selectedNode = result.node.parent! as SCNNode
                            
                            for childBlocks : AnyObject in result.node.parent!.childNodes {
                                childBlocks.geometry!!.firstMaterial!.emission.contents = UIColor.red
                            }
                            
                        } else {
                            let material = result.node!.geometry!.firstMaterial!
                            let emission = self.editionMode ? UIColor.red : UIColor.black
                            material.emission.contents = emission
                            World.zones[World.selectedZone!].selectedNode = result.node as SCNNode
                        }
                        
                        World.zones[World.selectedZone!].selectedBlock = id
                       
                        /*
                    } else { //the player touched the ground or it's the same block
                        
                        //print("touched the ground")
                        didTouchNoneBlock = true
                        
                    }
                    */
                    
                }
                
                /*
                 
                 else { // we merge !
                    
                    if (id != -1) {
                        if (result.node!.parent!.value(forKey: "merged") == nil) { // If isn't a merged block
                            
                            var removeIndex = -1
                            
                            for i in 0..<self.mergingNodes.count {
                                let nodeId = self.mergingNodes[i].value(forKey: "id") as! Int
                                
                                if nodeId == id { // if we touch an already selected block, we unselect it
                                    result.node!.geometry!.firstMaterial!.emission.contents = UIColor.black
                                    removeIndex = i
                                }
                            }
                            
                            if (removeIndex == -1) { // if it's not a block already selected
                                result.node!.geometry!.firstMaterial!.emission.contents = UIColor.red
                                self.mergingNodes.append(result.node!)
                            } else { // otherwise, we remove the block of the table
                                self.mergingNodes.remove(at: removeIndex)
                            }
                            
                            //print(mergingNodes)
                            
                        } else { // If we are on a merged block
                            
                            let alert = UIAlertController(title: "Warning", message: "This block is already merged. You can't merge it.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                */
            } else { //the player touched the background
                
                //print("touched the background")
                // if we are in edit mode, we don't consider the touch outside to avoir player errors
                didTouchNoneBlock = true
            }
            
            if (didTouchNoneBlock && !self.merging) { // if we don't merge
                //print("didTouchNoneBlock")
                
                self.editionOpened = true
                self.editionMode = true
                animateEdition()
                //if editMode is true, we turn it off
                self.editionMode = true
                showHideEdition()
                self.clearSelectedFace()
                self.changeCamera(((self.cameraBloqued) ? true : false))
            }
      //  }
    }
    */
//    override func becomeFirstResponder() -> Bool {
//        return true
//    }
//    
//    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            print("You shook me, now what")
        }
    }
    
   
    
    
    
    
    
}


//func ballisticVelocity(projectile:SCNNode, target: SCNVector3, angle: Float, scnView: SCNScene) -> SCNVector3 {
////    let origin = projectile.presentation.position
////   // var dir = target - origin// get target direction
////    
////    var dir = SCNVector3(x: 1, y: 1, z: 1)
//// 
////    let h = dir.y                  // get height difference
////    dir.y = 0                      // retain only the horizontal direction
////    var dist = dir.length()         // get horizontal distance
////    dir.y = dist * tan(angle)       // set dir to the elevation angle
////    dist += h / tan(angle)          // correct for small height differences
////    // calculate the velocity magnitude
////    let vel = sqrt(dist * -scnView.physicsWorld.gravity.y / sin(2 * angle))
////    return dir.normalized() * vel * Float(projectile.physicsBody!.mass)
//}

func GetNodeAnimations(theNode: SCNNode) -> ([SCNNode], [CAAnimation]) {
    
    
    var tempAnimations = [CAAnimation]()
    var tempAnimationSring = [String]()
    var tempNodes = [SCNNode]()
    
    //EnemyWalkingAnimations
    
    for nodesNames in (theNode.childNodes) {
        //  print("ARMATURE INFO")
        
        let theName = nodesNames.name
        //print("\(theName) Action Keys: \(nodesNames.actionKeys)")
        //print("\(theName) Animation Keys: \(nodesNames.animationKeys)")
        // print("\(theName) Child Nodes: \(nodesNames.childNodes)")
        
        let ChildNodes = nodesNames.childNodes
        for child1 in ChildNodes {
            
            let theChildName = child1.name
            print("\(theChildName) Animation Keys: \(child1.animationKeys)")
            
            for theAnimation in child1.animationKeys {
                tempAnimations.append(child1.animation(forKey: "\(theAnimation)")!)
                tempNodes.append(child1)
                child1.addAnimation(child1.animation(forKey: "\(theAnimation)")!, forKey: "walk")
                //child1.addAnimation(child1.animation(forKey: "\(theAnimation)"), forKey: "Walk")
            }
            
            
            for child2 in child1.childNodes {
                
                
                let childName2 = child2.name
                print("\(childName2) Animation Keys: \(child2.animationKeys)")
                
                
                for theAnimation in child2.animationKeys {
                    tempAnimations.append(child2.animation(forKey: "\(theAnimation)")!)
                    tempNodes.append(child2)
                    child2.addAnimation(child2.animation(forKey: "\(theAnimation)")!, forKey: "walk")
                }
                
                
                for child3 in child2.childNodes {
                    let childName3 = child3.name
                    print("\(childName3) Animation Keys: \(child3.animationKeys)")
                    
                    
                    for theAnimation in child3.animationKeys {
                        tempAnimations.append(child3.animation(forKey: "\(theAnimation)")!)
                        tempNodes.append(child3)
                        child3.addAnimation(child3.animation(forKey: "\(theAnimation)")!, forKey: "walk")
                    }
                    
                    
                    for child4 in child3.childNodes {
                        let childName4 = child4.name
                        print("\(childName4) Animation Keys: \(child4.animationKeys)")
                        
                        for theAnimation in child4.animationKeys {
                            tempAnimations.append(child4.animation(forKey: "\(theAnimation)")!)
                            tempNodes.append(child4)
                            child4.addAnimation(child4.animation(forKey: "\(theAnimation)")!, forKey: "walk")
                        }
                        
                        
                        for child5 in child4.childNodes {
                            let childName5 = child5.name
                            print("\(childName5) Animation Keys: \(child5.animationKeys)")
                            
                            for theAnimation in child5.animationKeys {
                                tempAnimations.append(child5.animation(forKey: "\(theAnimation)")!)
                                tempNodes.append(child5)
                                child5.addAnimation(child5.animation(forKey: "\(theAnimation)")!, forKey: "walk")
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        //   print("Armature Child Node Name: \(nodesNames.name)")
    }
    
    return (tempNodes, tempAnimations)
    
}



//extension UIViewController:MotionDelegate {
//    override public func becomeFirstResponder() -> Bool {
//        return true
//    }
//    
//    override public func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
//        if motion == .MotionShake { print("Shaking motionBegan with event\(event)") }
//    }
//    
//    override public func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {
//        if motion == .MotionShake { print("Shaking motionCancelled with event\(event)") }
//    }
//    
//    override public func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
//        if motion == .MotionShake { print("Shaking motionEnded with event\(event)") }
//    }
//}


/*
class Monster {
    let node: SCNNode
    let attackAnimation: CAAnimation
 
    init() {
        let url = NSBundle.mainBundle().URLForResource(/* dae file */)
        let sceneSource = SCNSceneSource(URL: url, options: [
            SCNSceneSourceAnimationImportPolicyKey : SCNSceneSourceAnimationImportPolicyDoNotPlay
            ])
        node = sceneSource.entryWithIdentifier("monster", withClass: SCNNode.self)
        attackAnimation = sceneSource.entryWithIdentifier("monsterIdle", withClass: CAAnimation.self)
    }
    
    func playAttackAnimation() {
        node.addAnimation(attackAnimation, forKey: "attack")
    }
}
*/


class AlertHelper {
    
    
    func showAttackAlert(fromController controller: UIViewController, message: String, title: String, email: NSString, attackingID: NSString, attackedBy: String) {
       // var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        var attackStatus = String()
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Under Attack!", message: "\(message)", preferredStyle: .alert)
        
        
        //actionSheetController2.addAction(UIAlertAction(title: "Fight Back", style: .Default, handler: nil))
        //actionSheetController2.addAction(UIAlertAction(title: "Run Away"))
        //actionSheetController2.show()
        
        // let actionSheetController: UIAlertController = UIAlertController(title: "Attack Alert!", message: "You are under Attack!", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let FightbackAction: UIAlertAction = UIAlertAction(title: "Fight Back", style: .default) { action -> Void in
            
            
            UpdateResponseAttack(email as String, attackingID: attackingID as String, response: "fight", action: "write") {
                (result, attackResponse) in
                // if let AttackResponseUpdated = result {
                print("Response Updated: \(result), attackResponse: \(attackResponse)")
                // }
            }
            
            // let (AttackResponseUpdated, response) = UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "fight", action: "write")
            
            // let (AttackResponseUpdated, response) = UpdateAttackResponse(self.email as String, attackingID: self.email as String, response: "fight", action: "write")
            
            //  print("Attack Respone Updated: \(AttackResponseUpdated), Attack Response: \(response)")
            
            
           // print("You're fighting back against \(attackedBy).  Way to be a man")
            
            
            attackStatus = "fightingback"
            //self.AttackingPlayersHealth = health
            
            
          //  print("Attacking Player = \(self.AttackingPlayer)")
            
            //  self.performSegueWithIdentifier("goto_attack", sender: self)

            let alertView:UIAlertView = UIAlertView()
            alertView.title = "You are now attacking \(attackedBy)"
            alertView.message = "Prepare yourself for the attack...coming soon"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
        //Create and an option action
        let RunawayAction: UIAlertAction = UIAlertAction(title: "Run Away!", style: .default) { action -> Void in
            
            print("You're running away from \(attackedBy).  Be a Man!")
            
            // let (AttackResponseUpdated, response) = UpdateResponseAttack(self.email as String, attackingID: self.email as String, response: "run", action: "write")
            
            
            UpdateResponseAttack(email as String, attackingID: attackingID as String, response: "run", action: "write") {
                (result, attackResponse) in
                // if let AttackResponseUpdated = result {
                print("Response Updated: \(result), attackResponse: \(attackResponse)")
                // }
            }
            
            //let (AttackResponseUpdated, response) = UpdateAttackResponse(self.email as String, attackingID: self.email as String, response: "run", action: "write")
            
            //  print("Attack Respone Updated: \(AttackResponseUpdated), Attack Response: \(response)")
            
            
            
            let RandomCowardMessages = ["Stand up for yourself!", "Smart move, live to fight another day", "You should feel ashamed...you coward"]
            
            let randomIndex = Int(arc4random_uniform(UInt32(RandomCowardMessages.count)))
            let RunAwayMessage = RandomCowardMessages[randomIndex]
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "You are running away from \(attackedBy)"
            alertView.message = "\(RunAwayMessage)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            
            //self.SubmitPic()
            
        }
        
        
        actionSheetController.addAction(RunawayAction)
        actionSheetController.addAction(FightbackAction)
        
        
        
        
        
        
        controller.present(actionSheetController, animated: true, completion: nil)
        
       // UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
}

extension SCNVector3
{
    
    func distance(vector: SCNVector3) -> Float {
       // return (self - vector).length()
        return SCNVector3(x: self.x - vector.x, y: self.y - vector.y, z: self.z - vector.z).length()
    }

    func length() -> Float {
        return sqrtf(x*x + y*y + z*z)
    }
    
//    func SCNVector3Distance(vectorStart: SCNVector3, vectorEnd: SCNVector3) -> Float {
//        return SCNVector3Length(vectorEnd - vectorStart)
//    }
    
}
