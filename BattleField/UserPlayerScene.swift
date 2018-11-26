//
//  UserPlayerScene.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class UserPlayerScene: SCNScene {
    
    var WalkAnimation = CAAnimation()
    
    //------------ SET UP BODY NODES
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
    
    
    var enemyNode = SCNNode()
    var enemyRootNode = SCNNode()
    
    var material = SCNMaterial()
    
    
    var cameraNode: SCNNode?
    
    override init() {
        super.init()

        enemyEyeBrowString = "male_white-eyebrow001"
        enemyEyeLashString = "male_white-eyelashes01"
        enemyEyesString = "male_white-highpolyeyes"
        enemySuitString = "male_white-male_casualsuit06"
        enemyMuscleString = "male_white-male_muscle_13290"
        enemyShoesString = "male_white-shoes03"
        enemyHairString = "male_white-short04"
        enemyTeethString = "male_white-teeth_base"
        enemyTongueString = "male_white-tongue01"
        
        enemyEyeBrowTexture = "eyebrow001"
        enemyEyeLashTexture = "eyelashes01"
        enemyEyesTexture = "brown_eye"
        enemySuitTexture = "male_casualsuit06_diffuse"
        enemyMuscleTexture = "middleage_lightskinned_male_diffuse"
        enemyShoesTexture = "shoes03_diffuse"
        enemyHairTexture = "short04_diffuse"
        enemyTeethTexture = "teeth"
        enemyTongueTexture = "tongue01_diffuse"
        enemyRootNodeString = "male_white"
        
        /*
    let sphereGeometry = SCNSphere(radius: 1.0)
    sphereGeometry.firstMaterial?.diffuse.contents = UIColor.orangeColor()
    let sphereNode = SCNNode(geometry: sphereGeometry)
    self.rootNode.addChildNode(sphereNode)
    
        */
      //  var scene = SCNScene(named: "PlayerSceneKit/playerOBJ.scn")
   //var scene = SCNScene(named: "playerModel")
       // var scene = SCNScene(named: "playerOBJ.scn")
        
     //   let bundle = NSBundle.mainBundle()
      //  let path = bundle.pathForResource("playerobj2", ofType: "obj")
     //   let url = NSURL(fileURLWithPath: path!)
 
        
       // let scene = SCNScene(named: "ArmyUser3D.dae")
        
        let scene = SCNScene(named: "animate.scnassets/Man_White3.dae")
  
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 0.35
        camera.zNear = 0
        camera.zFar = 30
        camera.xFov = 50
        
  
        
        let node = SCNNode()
        node.camera = camera
        scene?.rootNode.addChildNode(node)
        print("Scene Root = \(scene?.rootNode.childNodes)")
        
        node.position = SCNVector3(0.0, 0.0, 50.0)
        
        let cur = node.rotation
        
   
        
        print("root node name = \(scene?.rootNode)")

        
        
        
//        let MilitaryModel = scene?.rootNode.childNode(withName: "MDL_Obj", recursively: true)
//        MilitaryModel?.position = SCNVector3(0.0, -0.3, -20.0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
//      
//        
//        
//        node.addChildNode(MilitaryModel!)
        
        
        
        
        
        
        var BodyGeometryNode = SCNNode()
        var BodyGeometry = SCNGeometry()
       
        // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
        material.diffuse.contents = UIImage(named: "animate.scnassets/middleage_lightskinned_male_diffuse.png")
        
        
        for nodes in (scene?.rootNode.childNodes)! {
            
            
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
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyShoesTexture).png")
                
                enemyRootNode.addChildNode(nodes)
                
                
                
                
            case "\(enemyMuscleString)"?:
                //case "male_white-male_muscle_13290"?:
                print("Skin found")
                print("GEOMETRY: \(nodes.geometry)")
                
                //  BodyGeometryNode = nodes
                BodyGeometry = nodes.geometry!
                //enemyNode.geometry?.materials.first =
                // enemyNode.addChildNode(nodes)
                
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyMuscleTexture).png")
                
                
                BodyGeometry = nodes.geometry!
                // nodes.addChildNode(bodyPlane)
                
                
                enemyRootNode.addChildNode(nodes)
                //enemyRootNode.addChildNode(enemySkin)
                //enemyNode.addChildNode(nodes)
                
            case "\(enemySuitString)"?:
                //case "male_white-male_casualsuit06"?:
                
                print("casual suit found")
                
                
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemySuitTexture).png")
                
                
                enemyRootNode.addChildNode(nodes)
                // enemyNode.addChildNode(EnemyGeometryTest)
                
            case "\(enemyHairString)"?:
                print("Hair found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyHairTexture).png")
                
                
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyTeethString)"?:
                print("teeth found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTeethTexture).png")
                
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyTongueString)"?:
                print("tongue found")
                // print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTongueTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyeBrowString)"?:
                print("tongue found")
                //    print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeBrowTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyeLashString)"?:
                print("tongue found")
                //  print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeLashTexture).png")
                enemyRootNode.addChildNode(nodes)
                
            case "\(enemyEyesString)"?:
                print("tongue found")
                //   print("GEOMETRY: \(nodes.geometry)")
                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyesTexture).png")
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
        
        
        
//        enemyNode.geometry = BodyGeometryNode.geometry
//        // enemyNode.physicsBody = SCNPhysicsBody.kinematic()
//        //enemyNode.physicsBody = SCNPhysicsBody.kinematic()
//        
          enemyNode.geometry?.firstMaterial = material
//        
//        // BodyGeometryNode.scale = SCNVector3(x: 0.15, y: 0.15, z: 0.15)
//        enemyNode.physicsBody? = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: BodyGeometryNode.geometry!, options: nil))
//        // enemyNode.physicsBody? = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: BodyGeometryNode.geometry!, options: nil))
//        
//        
//        enemyNode.physicsBody?.angularDamping = 0.9999999
//        enemyNode.physicsBody?.damping = 0.9999999
//        enemyNode.physicsBody?.rollingFriction = 0
//        enemyNode.physicsBody?.friction = 0
//        enemyNode.physicsBody?.restitution = 0
//        //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
//        enemyNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
//        // enemyNode.physicsBody?.categoryBitMask = CollisionCategory.Enemy
//        // enemyNode.physicsBody?.collisionBitMask = CollisionCategory.All
//        //^ CollisionCategory.Bullet
//        enemyNode.name = "enemyNode"
//        if #available(iOS 9.0, *) {
//            enemyNode.physicsBody?.contactTestBitMask = ~0
//        }
    
        
        
        
      //  enemyNode.rotation.x = 180

        
        enemyNode.position = SCNVector3(x: 0, y: -0.3, z: 0)
       // enemyNode.scale = SCNVector3(x: 0.15, y: 0.15, z: 0.15)
        
        // enemyRootNode.position = SCNVector3(x: 0, y: 1, z: -7)
        // enemyRootNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        
        
      //  enemyRootNode.scale = SCNVector3(x: 1, y: 1, z: 1)
    
//        enemyNode.physicsBody?.isAffectedByGravity = false
//        enemyRootNode.physicsBody?.isAffectedByGravity = false
//        
//        // for nodes in
//        
//        
//        for items in enemyRootNode.childNodes {
//            items.physicsBody?.isAffectedByGravity = false
//            
//            print("Root Items Name: \(items.name)")
//        }
        
   
        
        self.rootNode.addChildNode(enemyNode)
        self.rootNode.addChildNode(enemyRootNode)
        
        
 
        
        
        // let view = SCNView(frame: self.view.bounds)
    //    view.scene = scene
  //  let characterTopLevelNode = scene?.rootNode.childNodes[0]
    //characterTopLevelNode.l
    
     //    scene.position = SCNVector3(x: 3.0, y: 0.0, z: 0.0)
   // self.rootNode.addChildNode(characterTopLevelNode!)
    
        
        
        
        
        
        
        
        
        
        self.rootNode.addChildNode(node)
        //self.rootNode.ad
    
    
        let secondSphereGeometry = SCNSphere(radius: 0.5)
        secondSphereGeometry.firstMaterial?.diffuse.contents = UIColor.purple
        let secondSphereNode = SCNNode(geometry: secondSphereGeometry)
        secondSphereNode.position = SCNVector3(x: 0.0, y: 0.0, z: -10.0)
  //  self.rootNode.addChildNode(secondSphereNode)

        self.background.contents = UIImage(named: "FOShelterBG.png")

 
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "paused" {
            self.isPaused = change![NSKeyValueChangeKey.newKey] as! Bool
        }
    }
    
    
    

}
