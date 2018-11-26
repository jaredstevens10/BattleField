//
//  EnemyPlayer.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/13/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation


/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This class manages the main character, including its animations, sounds and direction.
 */

import SceneKit

enum GroundType: Int {
    case grass
    case rock
    case water
    case inTheAir
    case count
}

private typealias ParticleEmitter = (node: SCNNode, particleSystem: SCNParticleSystem, birthRate: CGFloat)

class EnemyCharacter {
    
    var enemyRootNode = SCNNode()
    
    var enemyHead = SCNNode()
    var enemyBody = SCNNode()
    var enemyLegL = SCNNode()
    var enemyLegR = SCNNode()
    var enemySpine = SCNNode()
    var enemyEyeR = SCNNode()
    var enemyEyeL = SCNNode()
    
    var enemyWeapon = SCNNode()
    
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
    
    var AimingGun = Bool()
    var aimingComplete = Bool()
    
    // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
    
    
    // MARK: Initialization
    
    init() {
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "animate.scnassets/middleage_lightskinned_male_diffuse.png")
        
        panningComplete = true

        
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
        enemySuitTexture = "male_casualsuit06_diffuse2"
        enemyMuscleTexture = "middleage_lightskinned_male_diffuse"
        enemyShoesTexture = "shoes03_diffuse"
        enemyHairTexture = "short04_diffuse"
        enemyTeethTexture = "teeth"
        enemyTongueTexture = "tongue01_diffuse"
        
        enemyRootNodeString = "male_white"
        // MARK: Load character from external file
        
        // The character is loaded from a .scn file and stored in an intermediate
        // node that will be used as a handle to manipulate the whole group at once
        
        //let characterScene = SCNScene(named: "animate.scnassets/panda.scn")!
        
        let characterScene = SCNScene(named: "animate.scnassets/Man_Rest20.dae")!
        
      //  let characterScene = SCNScene(named: "animate.scnassets/Man_Rest20_Scene.scn")!
        
      //  let characterScene = SCNScene(named: "animate.scnassets/Man_Rest_GK.dae")!
        //let characterScene = SCNScene(named: "animate.scnassets/Man_White_SMALL4.dae")!
        let characterTopLevelNode = characterScene.rootNode.childNodes[0]
        
        
//        let helmetTemp = (characterScene.rootNode.childNode(withName: "helmet", recursively: true))!
//        helmetTemp.isHidden = true
//        let vestTemp = (characterScene.rootNode.childNode(withName: "vest", recursively: true))!
//        vestTemp.isHidden = true
//        
        let GunTemp = (characterScene.rootNode.childNode(withName: "Gun", recursively: true))!
        GunTemp.isHidden = false
        
        GunTemp.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        
        
        let gunGeom = SCNSphere(radius: 0.01)
        let gunPlane = SCNNode(geometry: gunGeom)
        gunPlane.physicsBody = SCNPhysicsBody.kinematic()
        gunGeom.firstMaterial?.diffuse.contents = UIColor.red
        gunPlane.opacity = CGFloat(0)
        gunPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: gunPlane.geometry!, options: nil))
      
        gunPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        gunPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^
        if #available(iOS 9.0, *) {
            gunPlane.physicsBody?.contactTestBitMask = ~0
        }
        gunPlane.name = "gunPlane"
        gunPlane.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        
        enemyWeapon = GunTemp
        
      //  enemyWeapon.addChildNode(gunPlane)
        
        
        
        
        print("characterTopLevelNode name: \(characterTopLevelNode.name)")
        
        enemyHead = (characterScene.rootNode.childNode(withName: "head", recursively: true))!
        enemyLegL = (characterScene.rootNode.childNode(withName: "lowerleg02_L", recursively: true))!
        enemyLegR = (characterScene.rootNode.childNode(withName: "lowerleg02_R", recursively: true))!
        enemySpine = (characterScene.rootNode.childNode(withName: "spine03", recursively: true))!
      //  enemyEyeR = (characterScene.rootNode.childNode(withName: "oculi01_R", recursively: true))!
        //enemyEyeL = (characterScene.rootNode.childNode(withName: "oculi01_L", recursively: true))!
        enemyEyeR = (characterScene.rootNode.childNode(withName: "eye_R", recursively: true))!
        enemyEyeL = (characterScene.rootNode.childNode(withName: "eye_L", recursively: true))!
        
        
        // enemyHead = (characterScene.rootNode.childNode(withName: "spine05", recursively: true))!
        //enemyHead = (characterScene.rootNode.childNode(withName: "head", recursively: true))!
        //enemyBody = (characterScene.rootNode.childNode(withName: "spine02", recursively: true))!
        
       
        
        
        characterTopLevelNode.geometry?.firstMaterial = material
        
        
       // let RandomRotationX = arc4random_uniform(360) + 1
        
        characterTopLevelNode.rotation.x = 180
        //characterTopLevelNode.rotation.x = Float(RandomRotationX)
        
        // characterTopLevelNode.scale = SCNVector3(x: 0.15, y: 0.15, z: 0.15)
        node.addChildNode(characterTopLevelNode)
        
        
        
         for nodes in (characterScene.rootNode.childNodes) {
         
         
         switch nodes.name {
         case "Armature"?:
         print("armature")
         
         
         case "\(enemyRootNodeString)"?:
         //   nodes.rotation.y = 180
         //enemyNode = nodes
         
         
         
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
         //  BodyGeometry = nodes.geometry!
         //enemyNode.geometry?.materials.first =
         // enemyNode.addChildNode(nodes)
         
         nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyMuscleTexture).png")
         
         
         //BodyGeometry = nodes.geometry!
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
         //print("tongue found")
         // print("GEOMETRY: \(nodes.geometry)")
         nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTongueTexture).png")
         enemyRootNode.addChildNode(nodes)
         
         case "\(enemyEyeBrowString)"?:
       //  print("tongue found")
         //    print("GEOMETRY: \(nodes.geometry)")
         nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyEyeBrowTexture).png")
         enemyRootNode.addChildNode(nodes)
         
         case "\(enemyEyeLashString)"?:
        // print("tongue found")
         //  print("GEOMETRY: \(nodes.geometry)")
         nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/body/\(enemyEyeLashTexture).png")
         enemyRootNode.addChildNode(nodes)
         
         case "\(enemyEyesString)"?:
       //  print("tongue found")
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
        
       
        
        let headGeom = SCNSphere(radius: 0.03)
        let headPlane = SCNNode(geometry: headGeom)
        
        print("Head Geo Bounding Box: \(headGeom.boundingBox)")
        
        //bodyPlane.rotation = SCNVector4(1,0,2,M_PI)
        // headPlane.physicsBody = SCNPhysicsBody.dynamic()
        headPlane.physicsBody = SCNPhysicsBody.kinematic()
        headGeom.firstMaterial?.diffuse.contents = UIColor.red
        headPlane.opacity = CGFloat(0)
        
        headPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        headPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            headPlane.physicsBody?.contactTestBitMask = ~0
        }
        headPlane.name = "headFrontPlane"
        headPlane.position = SCNVector3(0.0, 0.03, 0.0)
        
        
        let headB_Geom = SCNSphere(radius: 0.03)
        let headB_Plane = SCNNode(geometry: headB_Geom)
        //bodyPlane.rotation = SCNVector4(1,0,2,M_PI)
        // headPlane.physicsBody = SCNPhysicsBody.dynamic()
        headB_Plane.physicsBody = SCNPhysicsBody.kinematic()
        headB_Geom.firstMaterial?.diffuse.contents = UIColor.red
        headB_Plane.opacity = CGFloat(0)
        
        headB_Plane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        headB_Plane.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.EnemySense//^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            headB_Plane.physicsBody?.contactTestBitMask = ~0
        }
        headB_Plane.name = "headBackPlane"
        headB_Plane.position = SCNVector3(0.0, -0.03, 0.0)

        
        
        enemyHead.name = "enemyHead"
       // enemyHead.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        //enemyHead.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyHead.physicsBody?.contactTestBitMask = ~0
        }
        
        
        
        enemyHead.addChildNode(headPlane)
        enemyHead.addChildNode(headB_Plane)
        
        
        
        
        
        
        
        //SET UP EYES
       // let eyeR_Geom = SCNSphere(radius: 0.03)
        let eyeR_Geom = SCNCylinder(radius: 0.02, height: 7.0)
        let eyeR_Plane = SCNNode(geometry: eyeR_Geom)
        eyeR_Plane.pivot = SCNMatrix4MakeTranslation(0, 3.5, -3.5)
        eyeR_Plane.rotation = SCNVector4(1,0,0,M_PI_2)
        // headPlane.physicsBody = SCNPhysicsBody.dynamic()
        eyeR_Plane.physicsBody = SCNPhysicsBody.kinematic()
        eyeR_Geom.firstMaterial?.diffuse.contents = UIColor.red
        eyeR_Plane.opacity = CGFloat(0.3)
        
        eyeR_Plane.physicsBody?.categoryBitMask = CollisionCategory.EnemyEyes
        eyeR_Plane.physicsBody?.collisionBitMask = CollisionCategory.Hero//^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            eyeR_Plane.physicsBody?.contactTestBitMask = ~0
        }
        eyeR_Plane.name = "eyeR_Plane"
        eyeR_Plane.position = SCNVector3(0.0, 3.5, 0.0)
        
        enemyEyeR.addChildNode(eyeR_Plane)
        

        let eyeL_Geom = SCNCylinder(radius: 0.02, height: 7.0)
        let eyeL_Plane = SCNNode(geometry: eyeL_Geom)
       
        eyeL_Plane.pivot = SCNMatrix4MakeTranslation(0, 3.5, -3.5)
        eyeL_Plane.rotation = SCNVector4(1,0,0,M_PI_2)
        // headPlane.physicsBody = SCNPhysicsBody.dynamic()
        eyeL_Plane.physicsBody = SCNPhysicsBody.kinematic()
        eyeL_Geom.firstMaterial?.diffuse.contents = UIColor.red
        eyeL_Plane.opacity = CGFloat(0.3)
        
        eyeL_Plane.physicsBody?.categoryBitMask = CollisionCategory.EnemyEyes
        eyeL_Plane.physicsBody?.collisionBitMask = CollisionCategory.Hero//^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            eyeL_Plane.physicsBody?.contactTestBitMask = ~0
        }
        eyeL_Plane.name = "eyeL_Plane"
        eyeL_Plane.position = SCNVector3(0.0, 3.5, 0.0)
        
        enemyEyeL.addChildNode(eyeL_Plane)
        
        
        
        
        
        
        //SET UP RIGHT SPINE
        let spineGeom = SCNSphere(radius: 0.02)
        let spinePlane = SCNNode(geometry: spineGeom)
        
        spinePlane.physicsBody = SCNPhysicsBody.kinematic()
        spineGeom.firstMaterial?.diffuse.contents = UIColor.red
        spinePlane.opacity = CGFloat(0.5)
        
        
//        spinePlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: spinePlane.geometry!, options: nil))
//        spinePlane.physicsBody?.angularDamping = 0.9999999
//        spinePlane.physicsBody?.damping = 0.9999999
//        spinePlane.physicsBody?.rollingFriction = 0
//        spinePlane.physicsBody?.friction = 0
//        spinePlane.physicsBody?.restitution = 0
//        spinePlane.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        
        
        spinePlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        spinePlane.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.EnemySense  //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            spinePlane.physicsBody?.contactTestBitMask = ~0
        }
        spinePlane.name = "spineFPlane"
        spinePlane.position = SCNVector3(0.0, 0.03, 0.0)
        
        
        
        
        let spineBGeom = SCNSphere(radius: 0.02)
        let spineBPlane = SCNNode(geometry: spineBGeom)
        
        spineBPlane.physicsBody = SCNPhysicsBody.kinematic()
        spineBGeom.firstMaterial?.diffuse.contents = UIColor.red
        spineBPlane.opacity = CGFloat(0.5)
        spineBPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        spineBPlane.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.EnemySense //^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            spineBPlane.physicsBody?.contactTestBitMask = ~0
        }
        spineBPlane.name = "spineBPlane"
        spineBPlane.position = SCNVector3(0.0, -0.03, 0.0)

        
        
        let enemyBSenseGeom = SCNSphere(radius: 0.2)
        let enemyBSensePlane = SCNNode(geometry: enemyBSenseGeom)
        
        enemyBSensePlane.physicsBody = SCNPhysicsBody.kinematic()
        enemyBSenseGeom.firstMaterial?.diffuse.contents = UIColor.red
        enemyBSensePlane.opacity = CGFloat(0.3)
        enemyBSensePlane.physicsBody?.categoryBitMask = CollisionCategory.EnemySense
        enemyBSensePlane.physicsBody?.collisionBitMask = CollisionCategory.Building ^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyBSensePlane.physicsBody?.contactTestBitMask = ~0
        }
        enemyBSensePlane.name = "enemyBSense"
        enemyBSensePlane.position = SCNVector3(0.0, -0.3, 0.0)
        
        enemySpine.addChildNode(enemyBSensePlane)
        
        
        
        let enemyFSenseGeom = SCNSphere(radius: 0.2)
        let enemyFSensePlane = SCNNode(geometry: enemyFSenseGeom)
        
        enemyFSensePlane.physicsBody = SCNPhysicsBody.kinematic()
        enemyFSenseGeom.firstMaterial?.diffuse.contents = UIColor.red
        enemyFSensePlane.opacity = CGFloat(0.3)
        enemyFSensePlane.physicsBody?.categoryBitMask = CollisionCategory.EnemySense
        enemyFSensePlane.physicsBody?.collisionBitMask = CollisionCategory.Building ^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyFSensePlane.physicsBody?.contactTestBitMask = ~0
        }
        enemyFSensePlane.name = "enemyFSense"
        enemyFSensePlane.position = SCNVector3(0.0, 0.3, 0.0)
        
        enemySpine.addChildNode(enemyFSensePlane)
        
        let enemyLSenseGeom = SCNSphere(radius: 0.2)
        let enemyLSensePlane = SCNNode(geometry: enemyLSenseGeom)
        
        enemyLSensePlane.physicsBody = SCNPhysicsBody.kinematic()
        enemyLSenseGeom.firstMaterial?.diffuse.contents = UIColor.red
        enemyLSensePlane.opacity = CGFloat(0.3)
        enemyLSensePlane.physicsBody?.categoryBitMask = CollisionCategory.EnemySense
        enemyLSensePlane.physicsBody?.collisionBitMask = CollisionCategory.Building ^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyLSensePlane.physicsBody?.contactTestBitMask = ~0
        }
        enemyLSensePlane.name = "enemyLSense"
        enemyLSensePlane.position = SCNVector3(-0.3, 0.0, 0.0)
        enemySpine.addChildNode(enemyLSensePlane)
        
        
        
        let enemyRSenseGeom = SCNSphere(radius: 0.2)
        let enemyRSensePlane = SCNNode(geometry: enemyFSenseGeom)
        
        enemyRSensePlane.physicsBody = SCNPhysicsBody.kinematic()
        enemyRSenseGeom.firstMaterial?.diffuse.contents = UIColor.red
        enemyRSensePlane.opacity = CGFloat(0.3)
        enemyRSensePlane.physicsBody?.categoryBitMask = CollisionCategory.EnemySense
        enemyRSensePlane.physicsBody?.collisionBitMask = CollisionCategory.Building ^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            enemyLSensePlane.physicsBody?.contactTestBitMask = ~0
        }
        enemyRSensePlane.name = "enemyRSense"
        enemyRSensePlane.position = SCNVector3(0.3, 0.0, 0.0)
        enemySpine.addChildNode(enemyRSensePlane)
        
        
        
        
        
        
        enemySpine.addChildNode(spinePlane)
        enemySpine.addChildNode(spineBPlane)
        
        
        
        
        //SET UP LEFT LEG
        
        // let headGeom = SCNSphere(radius: 0.01)
        let legLGeom = SCNSphere(radius: 0.03)
        let legLPlane = SCNNode(geometry: legLGeom)
        
        legLPlane.physicsBody = SCNPhysicsBody.kinematic()
        legLGeom.firstMaterial?.diffuse.contents = UIColor.red
        legLPlane.opacity = CGFloat(0)
//        legLPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: legLPlane.geometry!, options: nil))
//        legLPlane.physicsBody?.angularDamping = 0.9999999
//        legLPlane.physicsBody?.damping = 0.9999999
//        legLPlane.physicsBody?.rollingFriction = 0
//        legLPlane.physicsBody?.friction = 0
//        legLPlane.physicsBody?.restitution = 0
//        legLPlane.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        legLPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        legLPlane.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.EnemySense//^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            legLPlane.physicsBody?.contactTestBitMask = ~0
        }
        legLPlane.name = "legLPlane"
        enemyLegL.addChildNode(legLPlane)
        
      
        //SET UP RIGHT LEG
        let legRGeom = SCNSphere(radius: 0.03)
        let legRPlane = SCNNode(geometry: legRGeom)
        
        legRPlane.physicsBody = SCNPhysicsBody.kinematic()
        legLGeom.firstMaterial?.diffuse.contents = UIColor.red
        legRPlane.opacity = CGFloat(0)
//        legRPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: legRPlane.geometry!, options: nil))
//        legRPlane.physicsBody?.angularDamping = 0.9999999
//        legRPlane.physicsBody?.damping = 0.9999999
//        legRPlane.physicsBody?.rollingFriction = 0
//        legRPlane.physicsBody?.friction = 0
//        legRPlane.physicsBody?.restitution = 0
//        legRPlane.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        legRPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
        legRPlane.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.EnemySense//^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            legLPlane.physicsBody?.contactTestBitMask = ~0
        }
        legRPlane.name = "legRPlane"
        enemyLegR.addChildNode(legRPlane)
        
        
        
        
        

        node.addChildNode(enemyRootNode)
        
        
        
        
        
        
        
        
        
        
        
        
        
 
        // MARK: Configure collision capsule
        
        // Collisions are handled by the physics engine. The character is approximated by
        // a capsule that is configured to collide with collectables, enemies and walls
        
        let (min, max) = node.boundingBox
        print("bouding box min: \(min)")
        let collisionCapsuleRadius = CGFloat((max.x - min.x) * 0.4)
      //  let collisionCapsuleRadius = CGFloat((max.x - min.x) * 3.0)
        //let collisionCapsuleRadius = CGFloat(5.0)
        //let collisionCapsuleHeight = CGFloat(5.0)
        let collisionCapsuleHeight = CGFloat(max.y - min.y)
        
        print("Enemy Collision Capsule Radius: \(collisionCapsuleRadius)")
        print("Enemy Collision Capsule Height: \(collisionCapsuleHeight)")
        
        let characterCollisionNode = SCNNode()
        characterCollisionNode.name = "enemyCollider"
        
        
       // characterCollisionNode.position = SCNVector3(0.0, 1.5, 0.0)
        characterCollisionNode.position = SCNVector3(0.0, collisionCapsuleHeight * 0.51, 0.0) // a bit too high so that the capsule does not hit the floor
        characterCollisionNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        characterCollisionNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape:SCNPhysicsShape(geometry: SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight), options:nil))
        
       // characterCollisionNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
       // characterCollisionNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight), options:nil))
        
       // characterCollisionNode.physicsBody!.contactTestBitMask = BitmaskSuperCollectable | BitmaskCollectable | BitmaskCollision | BitmaskEnemy
         characterCollisionNode.physicsBody!.collisionBitMask = CollisionCategory.All
       // characterCollisionNode.physicsBody!.categoryBitMask = CollisionCategory.Enemy
        
        characterCollisionNode.physicsBody!.contactTestBitMask = ~0
        
        //characterCollisionNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
       // node.addChildNode(characterCollisionNode)
      
        
        
        
        
        
        
        
        
        
        
       // let bodyGeom = SCNSphere(radius: 0.01)
        let bodyGeom = SCNCapsule(capRadius: 2.0, height: 2.0)
        let bodyPlane = SCNNode(geometry: bodyGeom)
  
        bodyPlane.physicsBody = SCNPhysicsBody.kinematic()
        bodyGeom.firstMaterial?.diffuse.contents = UIColor.red
        bodyPlane.opacity = CGFloat(0)
        bodyPlane.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: bodyPlane.geometry!, options: nil))
        bodyPlane.physicsBody?.angularDamping = 0.9999999
        bodyPlane.physicsBody?.damping = 0.9999999
        bodyPlane.physicsBody?.rollingFriction = 0
        bodyPlane.physicsBody?.friction = 0
        bodyPlane.physicsBody?.restitution = 0
        bodyPlane.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
       // bodyPlane.physicsBody?.categoryBitMask = CollisionCategory.Enemy
       // bodyPlane.physicsBody?.collisionBitMask = CollisionCategory.All //^ CollisionCategory.Enemy
        if #available(iOS 9.0, *) {
           // bodyPlane.physicsBody?.contactTestBitMask = ~0
        }
        
        bodyPlane.name = "bodyPlane"
        bodyPlane.position = SCNVector3(x: 0.0, y: 0.2, z: 0.0)
        
        
       // enemyRootNode.addChildNode(bodyPlane)
        
        
        

        
       // node.addChildNode(enemyRootNode)
        
        
        
        
       // characterCollisionNode.position = SCNVector3(x: 0, y: 3.5, z: 0)

        
        
        
        
        // MARK: Load particle systems
        
        // Particle systems were configured in the SceneKit Scene Editor
        // They are retrieved from the scene and their birth rate are stored for later use
        
        func particleEmitterWithName(_ name: String) -> ParticleEmitter {
            let emitter: ParticleEmitter
            emitter.node = characterTopLevelNode.childNode(withName: name, recursively:true)!
            emitter.particleSystem = emitter.node.particleSystems![0]
            emitter.birthRate = emitter.particleSystem.birthRate
            emitter.particleSystem.birthRate = 0
            emitter.node.isHidden = false
            return emitter
        }
        
        // fireEmitter = particleEmitterWithName("fire")
        // smokeEmitter = particleEmitterWithName("smoke")
        // whiteSmokeEmitter = particleEmitterWithName("whiteSmoke")
        
        
        // MARK: Load sound effects
        
//        reliefSound = SCNAudioSource(name: "aah_extinction.mp3", volume: 2.0)
//        haltFireSound = SCNAudioSource(name: "fire_extinction.mp3", volume: 2.0)
//        catchFireSound = SCNAudioSource(name: "ouch_firehit.mp3", volume: 2.0)
        
        for i in 0..<10 {
//            if let grassSound = SCNAudioSource(named: "animate.scnassets/sounds/Step_grass_0\(i).mp3") {
//                grassSound.volume = 0.5
//                grassSound.load()
//                steps[GroundType.grass.rawValue].append(grassSound)
//            }
//            
//            if let rockSound = SCNAudioSource(named: "animate.scnassets/sounds/Step_rock_0\(i).mp3") {
//                rockSound.load()
//                steps[GroundType.rock.rawValue].append(rockSound)
//            }
//            
//            if let waterSound = SCNAudioSource(named: "animate.scnassets/sounds/Step_splash_0\(i).mp3") {
//                waterSound.load()
//                steps[GroundType.water.rawValue].append(waterSound)
//            }
        }
        
        
        // MARK: Configure animations
        
        // Some animations are already there and can be retrieved from the scene
        // The "walk" animation is loaded from a file, it is configured to play foot steps at specific times during the animation
        
        characterTopLevelNode.enumerateChildNodes { (child, _) in
            for key in child.animationKeys {                  // for every animation key
                let animation = child.animation(forKey: key)! // get the animation
                animation.usesSceneTimeBase = false           // make it system time based
                animation.repeatCount = Float.infinity        // make it repeat forever
                child.addAnimation(animation, forKey: key)             // animations are copied upon addition, so we have to replace the previous animation
            }
        }
        
        HitBellyAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Action_Hit_Belly.dae")!
        HitBellyAnimation.usesSceneTimeBase = false
        HitBellyAnimation.fadeInDuration = 0.3
        HitBellyAnimation.fadeOutDuration = 0.3
        HitBellyAnimation.repeatCount = 1
        
        HitHeadAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Action_Hit_Head.dae")!
        HitHeadAnimation.usesSceneTimeBase = false
        HitHeadAnimation.fadeInDuration = 0.3
        HitHeadAnimation.fadeOutDuration = 0.3
        HitHeadAnimation.repeatCount = 1
        
        HitHeadFront_Fall_Animation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Action_Hit_Head_Front_Fall.dae")!
        HitHeadFront_Fall_Animation.usesSceneTimeBase = false
        HitHeadFront_Fall_Animation.fadeInDuration = 0.3
        HitHeadFront_Fall_Animation.fadeOutDuration = 0.3
        HitHeadFront_Fall_Animation.repeatCount = 1
        HitHeadFront_Fall_Animation.isRemovedOnCompletion = false
        
        HitHeadBack_Fall_Animation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Action_Hit_Head_Back_Fall.dae")!
        HitHeadBack_Fall_Animation.usesSceneTimeBase = false
        HitHeadBack_Fall_Animation.fadeInDuration = 0.3
        HitHeadBack_Fall_Animation.fadeOutDuration = 0.3
        HitHeadBack_Fall_Animation.repeatCount = 1
        HitHeadBack_Fall_Animation.isRemovedOnCompletion = false
        
        
        HitLegLAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Hit_Leg_L.dae")!
        HitLegLAnimation.usesSceneTimeBase = false
        HitLegLAnimation.fadeInDuration = 0.3
        HitLegLAnimation.fadeOutDuration = 0.3
        HitLegLAnimation.repeatCount = 1
        
        HitLegRAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/enemyHit/Man_Hit_Leg_R.dae")!
        HitLegRAnimation.usesSceneTimeBase = false
        HitLegRAnimation.fadeInDuration = 0.3
        HitLegRAnimation.fadeOutDuration = 0.3
        HitLegRAnimation.repeatCount = 1
        
        PanningAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_Action_Panning.dae")!
        PanningAnimation.usesSceneTimeBase = false
        PanningAnimation.fadeInDuration = 0.3
        PanningAnimation.fadeOutDuration = 0.3
        PanningAnimation.repeatCount = Float.infinity
        PanningAnimation.isRemovedOnCompletion = false
        
        aimGunAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_Action_Gun_Aim.dae")!
        aimGunAnimation.usesSceneTimeBase = false
        aimGunAnimation.fadeInDuration = 0.3
        aimGunAnimation.fadeOutDuration = 0.3
        aimGunAnimation.repeatCount = 1
        
        
        fireGunAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_Action_Gun_Fire.dae")!
        fireGunAnimation.usesSceneTimeBase = false
        fireGunAnimation.fadeInDuration = 0.3
        fireGunAnimation.fadeOutDuration = 0.3
        fireGunAnimation.repeatCount = Float.infinity
        fireGunAnimation.isRemovedOnCompletion = false
        
        runAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_Action_Run.dae")
        // walkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/walk.scn")
        
        runAnimation.usesSceneTimeBase = false
        runAnimation.fadeInDuration = 0.3
        runAnimation.fadeOutDuration = 0.3
        runAnimation.repeatCount = Float.infinity
        runAnimation.speed = EnemyCharacter.speedFactor * 2
        runAnimation.animationEvents = [
            SCNAnimationEvent(keyTime: 0.1) { (_, _, _) in self.playFootStep() },
            SCNAnimationEvent(keyTime: 0.3) { (_, _, _) in self.playFootStep() }]
        
        walkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_Action_Walk.dae")
        // walkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/walk.scn")
        
        walkAnimation.usesSceneTimeBase = false
        walkAnimation.fadeInDuration = 0.3
        walkAnimation.fadeOutDuration = 0.3
        walkAnimation.repeatCount = Float.infinity
        walkAnimation.speed = EnemyCharacter.speedFactor
        walkAnimation.animationEvents = [
            SCNAnimationEvent(keyTime: 0.1) { (_, _, _) in self.playFootStep() },
            SCNAnimationEvent(keyTime: 0.6) { (_, _, _) in self.playFootStep() }]
    }
    
    // MARK: Retrieving nodes
    
    let node = SCNNode()
    
    // MARK: Controlling the character
    
    //static let speedFactor = Float(1.538)
    static var speedFactor = Float(0.5)
    
    private var groundType = GroundType.inTheAir
    private var previousUpdateTime = TimeInterval(0.0)
    private var accelerationY = SCNFloat(0.0) // Simulate gravity
    
    private var directionAngle: SCNFloat = 0.0 {
        didSet {
            if directionAngle != oldValue {
                node.runAction(SCNAction.rotateTo(x: 0.0, y: CGFloat(directionAngle), z: 0.0, duration: 0.1, usesShortestUnitArc: true))
            }
        }
    }
    
    //func walkInDirection(_ direction: float3, time: TimeInterval, scene: SCNScene, groundTypeFromMaterial: GroundType) -> SCNNode? {
    
    func aimWeapon() {
       // isWalking = false
       // isRunning = false
        
        if !node.animationKeys.contains("aimGun") {
        node.addAnimation(aimGunAnimation, forKey: "aimGun")
        }
        
    }
    
    func fireWeapon() {
        // isWalking = false
        // isRunning = false
        
        if !node.animationKeys.contains("fireGun") {
            node.addAnimation(fireGunAnimation, forKey: "fireGun")
            "starting to fire weapon"
        } else {
            "already firing weapon"
        }
        
    }
   
    func TurnWalkDirection(bumpedLocation: String) {
        
        //, direction: float3
        
        switch bumpedLocation {
            
            case "front":
            print("bumped front")
            
            print("Direction Angle: \(directionAngle)")
            
            //let currentX = directionAngle
           // directionAngle = SCNFloat(atan2(direction.x, direction.z))
            
            let NewAngle = directionAngle + 3.0

            print("New Angle: \(NewAngle)")
            
            
            node.runAction(SCNAction.rotateTo(x: 0.0, y: CGFloat(NewAngle), z: 0.0, duration: 0.1, usesShortestUnitArc: true))
            
            isWalking = false
            isRunning = false
            
            case "back":
            print("bumped back")
            case "left":
            print("bumped left")
            case "right":
            print("bumped right")
        default:
            break
            
            
            
        }
        
    }
    
    
    func GotHit(location: String, isDead: Bool, stopWalking: Bool) {
        
        
        
        
        if isDead {
         
            switch location {
            case "belly":
                node.addAnimation(HitBellyAnimation, forKey: "hitBelly")
                //node.addAnimation(fireGunAnimation, forKey: "hitBelly")
                print("hit belly")
                
            case "spineFront":
                //node.addAnimation(HitBellyAnimation, forKey: "hitSpine")
                
                self.isWalking = stopWalking
                // node.addAnimation(HitHeadFront_Fall_Animation, forKey: "hitHeadFrontFall")
                
                node.addAnimation(HitHeadFront_Fall_Animation, forKey: "hitHeadFrontFall")
                
                
                
                
            case "spineBack":
                //node.addAnimation(HitBellyAnimation, forKey: "hitSpine")
               
                
                self.isWalking = stopWalking
                
                node.addAnimation(HitHeadBack_Fall_Animation, forKey: "hitHeadBackFall")
                
                
            case "headFront":
                
                self.isWalking = stopWalking
                
                node.addAnimation(HitHeadFront_Fall_Animation, forKey: "hitHeadFrontFall")
                
               // node.addAnimation(HitHeadBack_Fall_Animation, forKey: "hitHeadBackFall")
                
            case "headBack":
                
                 self.isWalking = stopWalking
                
                node.addAnimation(HitHeadBack_Fall_Animation, forKey: "hitHeadBackFall")
                
               //  node.addAnimation(HitHeadFront_Fall_Animation, forKey: "hitHeadFrontFall")

                
            case "legL":
                node.addAnimation(HitLegLAnimation, forKey: "hitLegL")
                
                print("hit in head")
                
            case "legR":
                node.addAnimation(HitLegRAnimation, forKey: "hitLegR")
                
                print("hit in head")
                
            default:
                break
            }
            
            
            
        } else {
        
        
        switch location {
            case "belly":
            node.addAnimation(HitBellyAnimation, forKey: "hitBelly")
            //node.addAnimation(fireGunAnimation, forKey: "hitBelly")
            print("hit belly")
            
            case "spineFront":
            node.addAnimation(HitBellyAnimation, forKey: "hitSpineFront")
            //node.addAnimation(fireGunAnimation, forKey: "hitBelly")
            print("hit belly")
            
            case "spineBack":
            node.addAnimation(HitBellyAnimation, forKey: "hitSpineBack")
            //node.addAnimation(fireGunAnimation, forKey: "hitBelly")

            
            case "headFront":
            node.addAnimation(HitHeadAnimation, forKey: "hitHead")
            
            case "headBack":
            node.addAnimation(HitHeadAnimation, forKey: "hitHead")
            
            print("hit in head")
            
            case "legL":
            node.addAnimation(HitLegLAnimation, forKey: "hitLegL")
            
            
           
            
            print("hit in head")
            
            case "legR":
            node.addAnimation(HitLegRAnimation, forKey: "hitLegR")
            
            print("hit in head")
            
        default:
            break
        }
            
      }
        
    }
    
    func lookAround() {
        print("look around")
        
        if isWalking {
            isWalking = false
        }
        
        if !isPanning {
            
           // if panningComplete {
               isPanning = true
           // }
        
        }
        
    }
    
    
    
    func walkInDirection(_ direction: float3, time: TimeInterval, scene: SCNScene, action: String, target: String, heroDistance: Float) -> SCNNode? {
    //func walkInDirection(_ direction: float3, time: TimeInterval, scene: SCNScene, groundTypeFromMaterial: (SCNMaterial) -> GroundType, action: String, target: String, heroDistance: Float) -> SCNNode? {
        // delta time since last update
        
        switch action {
            case "walk":
                EnemyCharacter.speedFactor = Float(0.5)
                break
            case "run":
                EnemyCharacter.speedFactor = Float(1.8)
                 break
               // EnemyCharacter.speedFactor = EnemyCharacter.speedFactor * 1.3
            default:
                break
            
        }
        
        print("Enemy Speed = \(EnemyCharacter.speedFactor)")
        
        
        if previousUpdateTime == 0.0 {
            previousUpdateTime = time
        }
        
        let deltaTime = Float(min(time - previousUpdateTime, 1.0 / 60.0))
        print("Delta Time: \(deltaTime)")
        let characterSpeed: Float = deltaTime * EnemyCharacter.speedFactor * 0.84
        
        print("Character Speed: \(characterSpeed)")
        
        previousUpdateTime = time
        
        let initialPosition = node.position
        
        // move
        if direction.x != 0.0 && direction.z != 0.0 {
          
            
            if heroDistance < 5 {
                isWalking = false
                isRunning = false
                
                if aimingComplete {
                    isFiringGun = true
                } else {
                    isAimingGun = true
                }
            } else {
            
            
            switch action {
                
                case "walk":
                    
                    // move character
                    let position = float3(node.position)
                    node.position = SCNVector3(position + direction * characterSpeed)
                    
                    // update orientation
                    directionAngle = SCNFloat(atan2(direction.x, direction.z))
                    
                    isWalking = true
                    isRunning = false
                    isAimingGun = false
                    isFiringGun = false
                
                case "run":
                    
                    // move character
                    let position = float3(node.position)
                    node.position = SCNVector3(position + direction * characterSpeed)
                    
                    // update orientation
                    directionAngle = SCNFloat(atan2(direction.x, direction.z))
                    
                    isWalking = false
                    isRunning = true
                    isAimingGun = false
                    isFiringGun = false
                
                case "aim":
                
                // move character
               // let position = float3(node.position)
               // node.position = SCNVector3(position + direction * characterSpeed)
                // update orientation
               // directionAngle = SCNFloat(atan2(direction.x, direction.z))
                
                isWalking = false
                isRunning = false
                isAimingGun = true
                isFiringGun = false
                
                default:
                    isWalking = true
                    isRunning = false
                    isAimingGun = false
                    isFiringGun = false
             }
            }
        } else {
            
            
//            if heroDistance < 10 {
//               isUsingGun = true
//            }
            
            
            isWalking = false
            isRunning = false
        }
        
        
        
        // Update the altitude of the character
        
        var position = node.position
        var p0 = position
        var p1 = position
        
        let maxRise = SCNFloat(0.08)
        let maxJump = SCNFloat(10.0)
        p0.y -= maxJump
        p1.y += maxRise
        
        // Do a vertical ray intersection
        var groundNode: SCNNode?
       // let results = scene.physicsWorld.rayTestWithSegment(from: p1, to: p0, options:[.collisionBitMask: BitmaskCollision | BitmaskWater, .searchMode: SCNPhysicsWorld.TestSearchMode.closest])
        
        let results = scene.physicsWorld.rayTestWithSegment(from: p1, to: p0, options:[.collisionBitMask: CollisionCategory.All, .searchMode: SCNPhysicsWorld.TestSearchMode.closest])
        
        if let result = results.first {
            var groundAltitude = result.worldCoordinates.y
            groundNode = result.node
            
            let groundMaterial = result.node.childNodes[0].geometry!.firstMaterial!
          //  groundType = groundTypeFromMaterial(groundMaterial)
           // groundType = groundTypeTemp
            
            if groundType == .water {
                if isBurning {
                    haltFire()
                }
                
                // do a new ray test without the water to get the altitude of the ground (under the water).
               // let results = scene.physicsWorld.rayTestWithSegment(from: p1, to: p0, options:[.collisionBitMask: BitmaskCollision, .searchMode: SCNPhysicsWorld.TestSearchMode.closest])
                
                 let results = scene.physicsWorld.rayTestWithSegment(from: p1, to: p0, options:[.collisionBitMask: CollisionCategory.All, .searchMode: SCNPhysicsWorld.TestSearchMode.closest])
                
                let result = results[0]
                groundAltitude = result.worldCoordinates.y
            }
            
            let threshold = SCNFloat(1e-5)
            let gravityAcceleration = SCNFloat(0.18)
            
            if groundAltitude < position.y - threshold {
                accelerationY += SCNFloat(deltaTime) * gravityAcceleration // approximation of acceleration for a delta time.
                if groundAltitude < position.y - 0.2 {
                    groundType = .inTheAir
                }
            }
            else {
                accelerationY = 0
            }
            
            position.y -= accelerationY
            
            // reset acceleration if we touch the ground
            if groundAltitude > position.y {
                accelerationY = 0
                position.y = groundAltitude
            }
            
            // Finally, update the position of the character.
            node.position = position
            
        }
        else {
            // no result, we are probably out the bounds of the level -> revert the position of the character.
            node.position = initialPosition
        }
        

    
        
        return groundNode
    }
    
    // MARK: Animating the character
    
    private var walkAnimation: CAAnimation!
    private var HitBellyAnimation: CAAnimation!
    private var HitHeadAnimation: CAAnimation!
    private var PanningAnimation: CAAnimation!
    private var runAnimation: CAAnimation!
    private var aimGunAnimation: CAAnimation!
    private var fireGunAnimation: CAAnimation!
    
    private var HitLegLAnimation: CAAnimation!
    private var HitLegRAnimation: CAAnimation!
    
    private var HitHeadFront_Fall_Animation: CAAnimation!
    private var HitHeadBack_Fall_Animation: CAAnimation!
    
    private var FallingKneesAnimation: CAAnimation!
    
    private var panningComplete = Bool()
    
    private var isPanning: Bool = false {
        didSet {
            if oldValue != isPanning {
                // Update node animation.
                if isPanning {
                   // node.addAnimation(PanningAnimation, forKey: "panning")
                    
                    if panningComplete {
                    
                     panningComplete = false
                        
                    UIView.animate(withDuration: 2.0, animations: {
                        self.node.addAnimation(self.PanningAnimation, forKey: "panning")
                    }, completion: {(finished:Bool) in
                        self.panningComplete = finished
                    })
                    
                    }
                    
                } else {
                    node.removeAnimation(forKey: "panning", fadeOutDuration: 0.2)
                }
            }
        }
    }
    
    func StartMoving(action: String) {
        
        switch action {
            case "walk":
            isWalking = true
            case "run":
            isRunning = true
        default:
            break
        }
        
    }
    
    private var isWalking: Bool = false {
        didSet {
            if oldValue != isWalking {
                // Update node animation.
                if isWalking {
                    print("IS Walking, aiming complete is now False")
                    self.isAimingGun = false
                    self.isFiringGun = false
                    node.addAnimation(walkAnimation, forKey: "walk")
                    node.removeAnimation(forKey: "run", fadeOutDuration: 0.2)
                    
                } else {
                    node.removeAnimation(forKey: "walk", fadeOutDuration: 0.2)
                }
            }
        }
    }
    
    private var isRunning: Bool = false {
        didSet {
            if oldValue != isRunning {
                // Update node animation.
                if isRunning {
                    //self.aimingComplete = false
                    self.isAimingGun = false
                    self.isFiringGun = false
                    node.addAnimation(runAnimation, forKey: "run")
                    node.removeAnimation(forKey: "walk", fadeOutDuration: 0.2)
                } else {
                    node.removeAnimation(forKey: "run", fadeOutDuration: 0.2)
                }
            }
        }
    }
    
    private var isAimingGun: Bool = false {
        didSet {
            if oldValue != isAimingGun {
                // Update node animation.
                if isAimingGun {
                    //node.addAnimation(aimGunAnimation, forKey: "aimGun")
                    
                    
                    if !aimingComplete {
print("Should be aiming gun")
                        
                    self.node.addAnimation(self.aimGunAnimation, forKey: "aimGun")
                        
                    self.aimingComplete = true
//                        UIView.animate(withDuration: 0.3, animations: {
//                            self.node.addAnimation(self.aimGunAnimation, forKey: "aimGun")
//                        }, completion: {(finished:Bool) in
//                            
//                            print("aiming gun should be complete")
//                            
//                            self.aimingComplete = true
//                        })
                        
                    } else {
                        
                    node.removeAnimation(forKey: "aimGun", fadeOutDuration: 0.2)
                    isFiringGun = true
                      // node.addAnimation(fireGunAnimation, forKey: "fireGun")
                        
                    }
                    
                    
                } else {
                    node.removeAnimation(forKey: "aimGun", fadeOutDuration: 0.2)
                    //node.removeAnimation(forKey: "fireGun", fadeOutDuration: 0.2)
                }
            }
        }
    }
    
    private var isFiringGun: Bool = false {
        didSet {
            if oldValue != isFiringGun {
                // Update node animation.
                if isFiringGun {
                    node.addAnimation(fireGunAnimation, forKey: "fireGun")
                } else {
                    node.removeAnimation(forKey: "fireGun", fadeOutDuration: 0.2)
                }
            }
        }
    }
    
    private var walkSpeed: Float = 1.0 {
        didSet {
            // remove current walk animation if any.
            let wasWalking = isWalking
            if wasWalking {
                isWalking = false
            }
            
            walkAnimation.speed = EnemyCharacter.speedFactor * walkSpeed
            
            // restore walk animation if needed.
            isWalking = wasWalking
        }
    }
    
    
    func IsEnemyFiring() -> Bool {
        print("ENEMY IS FIRING = \(aimingComplete)")
        return aimingComplete
        
    }
    
    // MARK: Dealing with fire
    
    private var isBurning = false
    private var isInvincible = false
    
    private var fireEmitter: ParticleEmitter! = nil
    private var smokeEmitter: ParticleEmitter! = nil
    private var whiteSmokeEmitter: ParticleEmitter! = nil
    
    func catchFire() {
//        if isInvincible == false {
//            isInvincible = true
//            node.runAction(SCNAction.sequence([
//                SCNAction.playAudio(catchFireSound, waitForCompletion: false),
//                SCNAction.repeat(SCNAction.sequence([
//                    SCNAction.fadeOpacity(to: 0.01, duration: 0.1),
//                    SCNAction.fadeOpacity(to: 1.0, duration: 0.1)
//                    ]), count: 7),
//                SCNAction.run { _ in self.isInvincible = false } ]))
//        }
//        
//        isBurning = true
//        
//        // start fire + smoke
//        fireEmitter.particleSystem.birthRate = fireEmitter.birthRate
//        smokeEmitter.particleSystem.birthRate = smokeEmitter.birthRate
//        
//        // walk faster
//        walkSpeed = 2.3
    }
    
    func haltFire() {
//        if isBurning {
//            isBurning = false
//            
//            node.runAction(SCNAction.sequence([
//                SCNAction.playAudio(haltFireSound, waitForCompletion: true),
//                SCNAction.playAudio(reliefSound, waitForCompletion: false)])
//            )
//            
//            // stop fire and smoke
//            fireEmitter.particleSystem.birthRate = 0
//            SCNTransaction.animateWithDuration(1.0) {
//                self.smokeEmitter.particleSystem.birthRate = 0
//            }
//            
//            // start white smoke
//            whiteSmokeEmitter.particleSystem.birthRate = whiteSmokeEmitter.birthRate
//            
//            // progressively stop white smoke
//            SCNTransaction.animateWithDuration(5.0) {
//                self.whiteSmokeEmitter.particleSystem.birthRate = 0
//            }
//            
//            // walk normally
//            walkSpeed = 1.0
//        }
    }
    
    // MARK: Dealing with sound
    
//    private var reliefSound: SCNAudioSource
//    private var haltFireSound: SCNAudioSource
//    private var catchFireSound: SCNAudioSource
//    
//    private var steps = [[SCNAudioSource]](repeating: [], count: GroundType.count.rawValue)
    
    private func playFootStep() {
//        if groundType != .inTheAir { // We are in the air, no sound to play.
//            // Play a random step sound.
//            let soundsCount = steps[groundType.rawValue].count
//            let stepSoundIndex = Int(arc4random_uniform(UInt32(soundsCount)))
//            node.runAction(SCNAction.playAudio(steps[groundType.rawValue][stepSoundIndex], waitForCompletion: false))
//        }
    }
    
}






