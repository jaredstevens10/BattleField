//
//  EditMapViewController.swift
//  BattleField


import UIKit
import SceneKit
import SpriteKit




class EditMapViewController: UIViewController, UIGestureRecognizerDelegate, SCNSceneRendererDelegate, SCNPhysicsContactDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var closePlaceItemViewBTN: UIButton!
    
    
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
    
    
    @IBOutlet weak var ShootView: UIView!
    
    @IBOutlet weak var closeBTN: UIButton!
    @IBOutlet weak var targetIMG: UIImageView!
    
    var ammoRemaining = Int()
    @IBOutlet weak var ammoLBL: UILabel!
    var enemyHitCount = Int()
    
    //MARK: config
    let autofireTapTimeThreshold = 0.2
    let maxRoundsPerSecond = 30
    let bulletRadius = 0.05
    let bulletImpulse = 15
    let maxBullets = 20
    
    @IBOutlet var sceneView: SCNView!
    @IBOutlet var overlayView: UIView!
    
    var lookGesture: UIPanGestureRecognizer!
    var walkGesture: UIPanGestureRecognizer!
    var moveItemGesture: UIPanGestureRecognizer!
    var fireGesture: FireGestureRecognizer!
    
    
    @IBOutlet var deleteNodeGesture: UISwipeGestureRecognizer!
    
    var DoubleTapGesture = UITapGestureRecognizer()
    var DismissAddItemGesture = UITapGestureRecognizer()
    // var placeItemGesture: placeItemGestureRecognizer!
    
    @IBOutlet var placeItemGesture: UILongPressGestureRecognizer!
    
    var heroNode: SCNNode!
    var camNode: SCNNode!
    var elevation: Float = 0
    var mapNode: SCNNode!
    var map: Map!
    
    var tapCount = 0
    var lastTappedFire: TimeInterval = 0
    var lastFired: TimeInterval = 0
    var bullets = [SCNNode]()
    @IBOutlet weak var countView: UIView!
    
    @IBOutlet weak var countLBL: UILabel!
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        countLBL.text = "Hits: \(enemyHitCount.description)"
        self.countView.layer.cornerRadius = 5
        self.closeBTN.layer.cornerRadius = 5
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        //generate map
        
        //sceneView.backgroundColor = UIColor.greenColor()
        
        let startMap = UIImage(named:"Map2")!
        GenerateMap(startMap)
        
        
        NotStartingPoint = true
        
        //look gesture
        lookGesture = UIPanGestureRecognizer(target: self, action: #selector(EditMapViewController.lookGestureRecognized(_:)))
        lookGesture.delegate = self
        view.addGestureRecognizer(lookGesture)
        
        //walk gesture
        walkGesture = UIPanGestureRecognizer(target: self, action: #selector(EditMapViewController.walkGestureRecognized(_:)))
        walkGesture.delegate = self
        view.addGestureRecognizer(walkGesture)
        
        //move item gesture
        
        
        
        //place item gesture
        placeItemGesture = UILongPressGestureRecognizer(target: self, action: #selector(EditMapViewController.selectItemGestureRecognized(_:)))
        placeItemGesture.delegate = self
        view.addGestureRecognizer(placeItemGesture)
        
        //move item gesture
        moveItemGesture = UIPanGestureRecognizer(target: self, action: #selector(EditMapViewController.moveItemGestureRecognized(_:)))
        moveItemGesture.delegate = self
        view.addGestureRecognizer(moveItemGesture)
        
        //Double Tap Gesture
        // DoubleTapGesture = UITapGestureRecognizer(target: self, action: "doubletapGestureRecognized:")
        DoubleTapGesture.numberOfTapsRequired = 2
        DoubleTapGesture.addTarget(self, action: #selector(EditMapViewController.doubletapped(_:)))
        DismissAddItemGesture.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(DoubleTapGesture)
        
        //Dismiss Add Item View
        DismissAddItemGesture.numberOfTapsRequired = 1
        DismissAddItemGesture.addTarget(self, action: #selector(EditMapViewController.dismissAddItemTapped(_:)))
        DismissAddItemGesture.delegate = self
        DismissAddItemGesture.isEnabled = false
        // view.addGestureRecognizer(DismissAddItemGesture)
        
        //Delete Node Swipe
        deleteNodeGesture.addTarget(self, action: #selector(EditMapViewController.deleteNodeSwipeGesture(_:)))
        deleteNodeGesture.delegate = self
        deleteNodeGesture.direction = .right
        view.addGestureRecognizer(deleteNodeGesture)
        
        
        //fire gesture
        fireGesture = FireGestureRecognizer(target: self, action: #selector(EditMapViewController.fireGestureRecognized(_:)))
        fireGesture.delegate = self
        // view.addGestureRecognizer(fireGesture)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlaceItemInventory.count
    }
    
    @objc func SelectedPlaceItem(_ sender: AnyObject) {
        
        var ItemToPlace: PlaceItemInfo!
        let itemTag = sender.tag
        ItemToPlace = PlaceItemInventory[itemTag!]
        
        let ItemImage = ItemToPlace.itemImage
        let ItemObjReference = ItemToPlace.itemOBJReference
        let ItemNodeReference = ItemToPlace.itemNODEReference
        let ItemMaterialReference = ItemToPlace.itemMaterialReference
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
        cell.itemIMG.contentMode = UIView.ContentMode.scaleAspectFit
        cell.countLBL.text = "\(ItemToPlace.itemCount.description)"
        cell.selectItemBTN.tag = indexPath.row
        cell.selectItemBTN.addTarget(self, action: #selector(EditMapViewController.SelectedPlaceItem(_:)), for: UIControl.Event.touchUpInside)
        //cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    
    
    func GenerateMap(_ mapImage: UIImage) {
        // map = Map(image: UIImage(named:"Map2")!)
        
        print("Not Starting Point = \(NotStartingPoint)")
        
        
        
        
        map = Map(image: mapImage)
        //create a new scene
        let scene = SCNScene()
        scene.physicsWorld.gravity = SCNVector3(x: 0, y: -9, z: 0)
        scene.physicsWorld.timeStep = 1.0/360
        scene.physicsWorld.contactDelegate = self
        
        //add entities
        for entity in map.entities {
            switch entity.type {
            case .hero:
                
                heroNode = SCNNode()
                heroNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNCylinder(radius: 0.2, height: 1), options: nil))
                heroNode.physicsBody?.angularDamping = 0.9999999
                heroNode.physicsBody?.damping = 0.9999999
                heroNode.physicsBody?.rollingFriction = 0
                heroNode.physicsBody?.friction = 0
                heroNode.physicsBody?.restitution = 0
                heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
                heroNode.physicsBody?.categoryBitMask = CollisionCategory.Hero
                heroNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet
                if #available(iOS 9.0, *) {
                    heroNode.physicsBody?.contactTestBitMask = ~0
                }
                
                print("Not Starting Point Test 2 = \(NotStartingPoint)")
                if NotStartingPoint {
                    //heroNode.position = SCNVector3(x: self.HeroX, y: 0.5, z: self.HeroZ)
                    
                    heroNode.position = HeroPosition
                    heroNode.rotation = HeroRotation
                    print("Hero should start at \(heroNode.position)")
                    
                } else {
                    heroNode.position = SCNVector3(x: entity.x, y: 0.5, z: entity.y)
                    print("Hero should start at \(heroNode.position)")
                }
                
                // self.HeroX = entity.x
                //  self.HeroY = entity.y
                
                scene.rootNode.addChildNode(heroNode)
                
            case .monster:
                
                let monsterNode = SCNNode()
                monsterNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
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
                scene.rootNode.addChildNode(monsterNode)
                
                
            case .enemy:
                
                var EnemyNode = SCNNode()
                
                let enemyScene = SCNScene(named: "ArmyUser3D.dae")
                // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
                
                EnemyNode = (enemyScene?.rootNode.childNode(withName: "MDL_Obj", recursively: true))!
                
                print("Enemy Node = \(EnemyNode)")
                
                let material = SCNMaterial()
                material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
                //  material.specular.contents = UIColor.whiteColor()
                //MilitaryModel?.geometry?.firstMaterial = material
                
                EnemyNode.geometry?.firstMaterial = material
                //EnemyNode.geometry? =
                //MilitaryModel?.position
                
                
                
                // EnemyNode.position = SCNVector3(x: entity.x, y: 0.3, z: entity.y)
                
                EnemyNode.position = SCNVector3(x: entity.x, y: 0.0, z: entity.y)
                //EnemyNode.geometry = SCNCylinder(radius: 0.50, height: 0.8)
                EnemyNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: EnemyNode.geometry!, options: nil))
                EnemyNode.physicsBody?.categoryBitMask = CollisionCategory.Enemy
                EnemyNode.physicsBody?.collisionBitMask = CollisionCategory.All
                EnemyNode.name = "Enemy"
                
                EnemyNode.scale = SCNVector3(x: 2.0, y: 2.0, z: 2.0)
                
                if #available(iOS 9.0, *) {
                    EnemyNode.physicsBody?.contactTestBitMask = ~0
                }
                scene.rootNode.addChildNode(EnemyNode)
                // print("Add Enemy Node")
                
            case .missionItem:
                
                var BoxNode = SCNNode()
                
                let BoxScene = SCNScene(named: "Hammer.dae")
                
                //  let BoxScene = SCNScene(named: "\(MissionObjectURL).dae")
                
                //let BoxScene = SCNScene(named: "box2.dae")
                // let MilitaryModel = enemyScene?.rootNode.childNodeWithName("MDL_Obj", recursively: true)
                
                //                BoxNode = (BoxScene?.rootNode.childNodeWithName("objMesh", recursively: true))!
                BoxNode = (BoxScene?.rootNode.childNode(withName: "_null_", recursively: true))!
                
                print("Box Scene Nodes = \(BoxScene?.rootNode.childNodes)")
                
                let material = SCNMaterial()
                material.diffuse.contents = UIImage(named: "metal.jpg")
                
                let materialTwo = SCNMaterial()
                materialTwo.diffuse.contents = UIImage(named: "wood.jpg")
                
                
                var materials = [SCNMaterial]()
                //   material.diffuse.contents = UIImage(named: "DEFbox1.png")
                materials.append(material)
                materials.append(materialTwo)
                //  material.specular.contents = UIColor.whiteColor()
                //MilitaryModel?.geometry?.firstMaterial = material
                
                
                //UNCOMMENT FOR FIRST MATERIAL----------
                // BoxNode.geometry?.firstMaterial = material
                
                
                BoxNode.geometry?.materials = materials
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
        heroNode.addChildNode(camNode)
        
        //add camera
        let camera = SCNCamera()
        camera.zNear = 0.01
        camera.zFar = Double(max(map.width, map.height))
        camNode.camera = camera
        
        //create map node
        mapNode = SCNNode()
        
        //add walls
        for tile in map.tiles {
            
            if tile.type == .wall {
                
                //create walls
                if tile.visibility.contains(.Top) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y))
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Right) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x) + 1, y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    
                    
                    
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Bottom) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 0)
                    wallNode.position = SCNVector3(x: Float(tile.x) + 0.5, y: 0.5, z: Float(tile.y) + 1)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
                    mapNode.addChildNode(wallNode)
                }
                if tile.visibility.contains(.Left) {
                    let wallNode = SCNNode()
                    wallNode.geometry = SCNPlane(width: 1, height: 1)
                    wallNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(-M_PI_2))
                    wallNode.position = SCNVector3(x: Float(tile.x), y: 0.5, z: Float(tile.y) + 0.5)
                    
                    let wallMaterial = SCNMaterial()
                    wallMaterial.diffuse.contents = UIImage(named: "brickWallTexture.png")
                    //  material.specular.contents = UIColor.whiteColor()
                    //MilitaryModel?.geometry?.firstMaterial = material
                    
                    wallNode.geometry?.firstMaterial = wallMaterial
                    
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
        
        
        
        mapNode.addChildNode(floorNode)
        
        //add ceiling
        let ceilingNode = SCNNode()
        ceilingNode.geometry = SCNPlane(width: CGFloat(map.width), height: CGFloat(map.height))
        ceilingNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI_2))
        ceilingNode.position = SCNVector3(x: Float(map.width)/2, y: 1, z: Float(map.height)/2)
        
        let ceilingMaterial = SCNMaterial()
        ceilingMaterial.diffuse.contents = UIImage(named: "ceilingTexture.png")
        //  material.specular.contents = UIColor.whiteColor()
        //MilitaryModel?.geometry?.firstMaterial = material
        
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
        sceneView.scene = scene
        sceneView.delegate = self
        
        //show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //configure the view
        sceneView.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 1
        }) 
    }
    
    @IBAction func hideOverlay() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
        }) 
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
    
    @objc func lookGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        //get translation and convert to rotation
        let translation = gesture.translation(in: self.view)
        let hAngle = acos(Float(translation.x) / 200) - Float(M_PI_2)
        let vAngle = acos(Float(translation.y) / 200) - Float(M_PI_2)
        
        //rotate hero
        heroNode.physicsBody?.applyTorque(SCNVector4(x: 0, y: 1, z: 0, w: hAngle), asImpulse: true)
        
        //tilt camera
        elevation = max(Float(-M_PI_4), min(Float(M_PI_4), elevation + vAngle))
        camNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: elevation)
        
        //reset translation
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    
    @objc func walkGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizer.State.ended || gesture.state == UIGestureRecognizer.State.cancelled {
            
            
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            
            // self.HeroX = heroNode.position.x
            //  self.HeroZ = heroNode.position.z
            
            //  print("HeroX = \(HeroX)")
            //   print("HeroZ = \(HeroZ)")
            
            // print("CGPointZero = \(CGPointZero)")
            //  let pos = heroNode.position
            //   print("Hero position: \(pos)")
            
        }
    }
    
    @objc func moveItemGestureRecognized(_ gesture: UIPanGestureRecognizer) {
        
        //   var startPoint = CGPoint()
        //   var endPoint = CGPoint()
        
        if gesture.state == UIGestureRecognizer.State.began {
            
            ObjectStartPoint =  gesture.location(in: self.view)
            
        }
        
        if gesture.state == UIGestureRecognizer.State.ended {
            
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
        if gesture.state == UIGestureRecognizer.State.ended || gesture.state == UIGestureRecognizer.State.cancelled {
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
    
    
    @IBAction func shootBTN(_ sender: AnyObject) {
        
        DoubleTapGesture.isEnabled = false
        
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTappedFire < autofireTapTimeThreshold {
            tapCount += 1
        } else {
            tapCount = 1
        }
        lastTappedFire = now
        
        DoubleTapGesture.isEnabled = true
        
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
    
    
    @objc func deleteNodeSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        
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
    
    @objc func dismissAddItemTapped(_ gesture: UITapGestureRecognizer) {
        
        if AddingObject {
            
            self.placeItemView.isHidden = true
            self.AddingObject = false
            self.lookGesture.isEnabled = true
            self.walkGesture.isEnabled = true
            
        }
    }
    
    @objc func doubletapped(_ gesture: UITapGestureRecognizer) {
        //print("Double Tapped")
        
        
        if !AddingObject {
            //  DismissAddItemGesture.enabled = false
            self.lookGesture.isEnabled = false
            self.walkGesture.isEnabled = false
            
            // if gesture.state == .Began {
            self.placeItemView.isHidden = false
            print("Double Tap Gesture, show add objet view")
            
            
            
            let location = gesture.location(in: self.sceneView)
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            if NodeArray.count > 0 {
                
                print("Node array = \(NodeArray)")
                let result: SCNHitTestResult = NodeArray[0]
                print("LONG PRESS result name = \(result.node.name)")
                
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
    
    @objc func selectItemGestureRecognized(_ gesture: UILongPressGestureRecognizer) {
        
        
        
        
        
        
        
        // print("long press recognized")
        
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
            
            print("Long Pressed on Screen at X:\(TouchScreenX) Y:\(TouchScreenY)")
            
            let NodeArray = sceneView.hitTest(location, options: nil)
            
            if NodeArray.count > 0 {
                
                
                canDeleteObject = true
                
                print("Can delete object = \(canDeleteObject)")
                
                print("Node array = \(NodeArray)")
                let result: SCNHitTestResult = NodeArray[0]
                print("LONG PRESS result name = \(result.node.name)")
                
                // print("result dictionary values = \(result.dictionaryWithValuesForKeys(["tag"]))")
                
                
                if result.node.name == "BLOCK" {
                    
                    
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
                    //glowNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 0.5)
                    
                    // glowNode.geometry.c
                    //glowNode.setValuesForKeysWithDictionary(["tag":"1boxtest"])
                    // monsterNode.u
                    if #available(iOS 9.0, *) {
                        glowNode.physicsBody?.contactTestBitMask = ~0
                    }
                    
                    TouchingNode.addChildNode(glowNode)
                    //TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
                    TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 2/255, green: 206/255, blue: 165/255, alpha: 1.0)
                    
                    
                    self.sceneView.scene?.rootNode.addChildNode(TouchingNode)
                    
                    
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
        
        if gesture.state == UIGestureRecognizer.State.changed {
            
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
        
        
        if gesture.state == UIGestureRecognizer.State.ended {
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
                        TouchingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                        // print("Touches ended, this  node has a child node")
                        // let GlowChildNode = NodeArray[0].node.childNodeWithName("GLOWCHILD", recursively: true)
                        // let GlowChildNode = TouchingNode.childNodeWithName("GLOWCHILD", recursively: true)! {
                        // GlowChildNode!.removeFromParentNode()
                        for cnodes in TouchingNode.childNodes {
                            print("removing ALL the child nodes")
                            if cnodes.name == "GLOWCHILD" {
                                cnodes.removeFromParentNode()
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
    
    
    @objc func fireGestureRecognized(_ gesture: FireGestureRecognizer) {
        
        //update timestamp
        
        
        /*
         let now = CFAbsoluteTimeGetCurrent()
         if now - lastTappedFire < autofireTapTimeThreshold {
         tapCount += 1
         } else {
         tapCount = 1
         }
         lastTappedFire = now
         */
    }
    
    func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
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
                
                //create or recycle bullet node
                let bulletNode: SCNNode = {
                    if self.bullets.count < self.maxBullets {
                        return SCNNode()
                    } else {
                        ammoRemaining -= 1
                        self.ammoLBL.text = "ammo:\(ammoRemaining.description)"
                        return self.bullets.remove(at: 0)
                    }
                }()
                if ammoRemaining > 0 {
                    bullets.append(bulletNode)
                } else {
                    self.overlayView.alpha = 1
                    overlayLBL.text = "You're out of ammo!"
                }
                bulletNode.geometry = SCNBox(width: CGFloat(bulletRadius) * 2, height: CGFloat(bulletRadius) * 2, length: CGFloat(bulletRadius) * 2, chamferRadius: CGFloat(bulletRadius))
                bulletNode.position = SCNVector3(x: heroNode.presentation.position.x, y: 0.4, z: heroNode.presentation.position.z)
                
                
                
                bulletNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: bulletNode.geometry!, options: nil))
                bulletNode.physicsBody?.categoryBitMask = CollisionCategory.Bullet
                bulletNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Hero
                bulletNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
                self.sceneView.scene!.rootNode.addChildNode(bulletNode)
                
                //apply impulse
                let impulse = SCNVector3(x: direction.x * Float(bulletImpulse), y: direction.y * Float(bulletImpulse), z: direction.z * Float(bulletImpulse))
                bulletNode.physicsBody?.applyForce(impulse, asImpulse: true)
                
                //update timestamp
                lastFired = now
            }
        }
    }
    
    func didBeginContact(_ contact: SKPhysicsContact) {
        print("CONTACT")
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        
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
        
        let contactMask = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        if (contactMask == (CollisionCategory.Bullet | CollisionCategory.Enemy)) {
            print("Bullet Collided with Enemy")
            enemyHitCount += 1
            print("EnemyHit count = \(enemyHitCount.description)")
            self.countLBL.text = "Hits:\(enemyHitCount.description)"
        }
        
        
    }
    
    
    @IBAction func pixelTestBTN(_ sender: AnyObject) {
        
        PixelColor(UIImage(named: "Map2.png")!, xLoc: 0, yLoc: 0)
        
        PixelColor(UIImage(named: "Map2.png")!, xLoc: 9, yLoc: 3)
        
        PixelColor(UIImage(named: "Map2.png")!, xLoc: 4, yLoc: 11)
        
        PixelColor(UIImage(named: "Map2.png")!, xLoc: 4, yLoc: 26)
        
        
        var ItemName = "Box"
        
        var newRed = UInt8()
        var newGreen = UInt8()
        var newBlue = UInt8()
        
        (newRed, newGreen, newBlue) = ReturnItemsColorCode(ItemName)
        
        
        let EditedImage = processPixelsInImage(UIImage(named: "Map2.png")!, xLoc: 3, yLoc: 11, newRed: newRed, newGreen: newGreen, newBlue: newBlue)
        
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
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func EditMapModel(_ image: UIImage) {
        
        
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
        
        //let data = context.assumin
      //  let data = uncastedData?.assumingMemoryBound(to: UInt8.self)
      //  let data: UnsafePointer<UInt8> = CFDataGetBytePtr(uncastedData as! CFData!)
        
        let data = context!.data?.assumingMemoryBound(to: UInt8.self)
       // let data = UnsafePointer<UInt8>(context?.data)
        
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
            let red = data?[offset + 1]
            let green = data?[offset + 2]
            let blue = data?[offset + 3]
            
            
            
            
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
                
                print("Node array = \(NodeArray)")
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
    
    
}
