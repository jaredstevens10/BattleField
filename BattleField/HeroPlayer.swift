//
//  HeroPlayer.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/14/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

//import Foundation

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

//enum GroundType: Int {
//    case grass
//    case rock
//    case water
//    case inTheAir
//    case count
//}

private typealias ParticleEmitter = (node: SCNNode, particleSystem: SCNParticleSystem, birthRate: CGFloat)

class HeroCharacter {
    
//    var enemyRootNode = SCNNode()
//    
//    var enemyHead = SCNNode()
//    var enemyBody = SCNNode()
    
    var heroHandsNode = SCNNode()
    var heroHands = SCNNode()
    
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
    
    
    // material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
    
    
    // MARK: Initialization
    
    init() {
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "animate.scnassets/middleage_lightskinned_male_diffuse.png")
        
        
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
//        let characterScene = SCNScene(named: "animate.scnassets/Man_White_SMALL4.dae")!
//        let characterTopLevelNode = characterScene.rootNode.childNodes[0]
        
        let characterTopLevelNode = SCNNode()
        
      //  print("characterTopLevelNode name: \(characterTopLevelNode.name)")
        
       // enemyHead = (characterScene.rootNode.childNode(withName: "head", recursively: true))!
        // enemyHead = (characterScene.rootNode.childNode(withName: "spine05", recursively: true))!
        //enemyHead = (characterScene.rootNode.childNode(withName: "head", recursively: true))!
        //enemyBody = (characterScene.rootNode.childNode(withName: "spine02", recursively: true))!
        
        
        
        
       // characterTopLevelNode.geometry?.firstMaterial = material
       // characterTopLevelNode.rotation.x = 180
        
        
        
       // heroNode = SCNNode()
        characterTopLevelNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNCylinder(radius: 0.2, height: 1.7), options: nil))
        characterTopLevelNode.physicsBody?.angularDamping = 0.9999999
        characterTopLevelNode.physicsBody?.damping = 0.9999999
        characterTopLevelNode.physicsBody?.rollingFriction = 0
        characterTopLevelNode.physicsBody?.friction = 0
        characterTopLevelNode.physicsBody?.restitution = 0
        //heroNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0, z: 1)
        characterTopLevelNode.physicsBody?.velocityFactor = SCNVector3(x: 1, y: 0.5, z: 1)
        characterTopLevelNode.physicsBody?.categoryBitMask = CollisionCategory.Hero
        characterTopLevelNode.physicsBody?.collisionBitMask = CollisionCategory.All ^ CollisionCategory.Bullet
        if #available(iOS 9.0, *) {
            characterTopLevelNode.physicsBody?.contactTestBitMask = ~0
        }
        
        characterTopLevelNode.position = SCNVector3(x: 0, y: 0.5, z: 0)
        
        // characterTopLevelNode.scale = SCNVector3(x: 0.15, y: 0.15, z: 0.15)
        
        
        
//         let handsScene = SCNScene(named: "animate.scnassets/Hand_Rest_SMALL.dae")!

//        heroHands = (handsScene.rootNode.childNode(withName: "basicRig", recursively: true))!
//        let handModels = (handsScene.rootNode.childNode(withName: "basicRig_Body", recursively: true))!
//        
//        handModels.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: handModels.geometry!, options: nil))
//        
//        let skinTone = "white"
//        
//        switch skinTone {
//        case "white":
//            handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
//            
//        case "brown":
//            // handModels.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//            heroHands.physicsBody?.isAffectedByGravity = false
//            
//        default:
//            handModels.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 227/255, green: 164/255, blue: 135/255, alpha: 1)
//        }
//        
//        
//        //heroHands.position = SCNVector3(x: 0, y: 0, z: -1.4)
//        heroHands.position = SCNVector3(x: 0, y: -0.5, z: -1.0)
//      //  heroHands.scale = SCNVector3(x: 0.09, y: 0.09, z: 0.09)
//        
//        // handModels.addChildNode(heroWeapon)
//        
//        heroHands.addChildNode(handModels)
//        heroHands.rotation = SCNVector4(0,4,2.6,M_PI)
//        
//        heroHands.rotation.y = 10
        //self.heroHands.rotation.x = 10
        
        
        
        
        
        
//        let camNode = SCNNode()
//        camNode.position = SCNVector3(x: 0, y: 0, z: 0)
//        characterTopLevelNode.addChildNode(camNode)
//        
//        
//        
//    
//        
//        //add camera
//        let camera = SCNCamera()
//        camera.zNear = 0.01
//       // camera.zFar = Double(max(60, 60))
//      //  camera.zFar = Double(max(map.width, map.height))
//        camNode.camera = camera
//        
//        
//        
//        camNode.addChildNode(heroHands)
        //characterTopLevelNode.addChildNode(heroHands)

        
        node.addChildNode(characterTopLevelNode)
        
        
        
        
//        for nodes in (characterScene.rootNode.childNodes) {
//            
//            
//            switch nodes.name {
//            case "Armature"?:
//                print("armature")
//                
//                
//            case "\(enemyRootNodeString)"?:
//                //   nodes.rotation.y = 180
//                //enemyNode = nodes
//                
//                
//                
//                for nodes2 in nodes.childNodes {
//                    //   print("nodes2 name: \(nodes2.name)")
//                }
//                
//                
//                
//            case "\(enemyShoesString)"?:
//                print("Shoes found")
//                //   print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyShoesTexture).png")
//                
//                enemyRootNode.addChildNode(nodes)
//                
//                
//                
//                
//            case "\(enemyMuscleString)"?:
//                //case "male_white-male_muscle_13290"?:
//                print("Skin found")
//                print("GEOMETRY: \(nodes.geometry)")
//                
//                //  BodyGeometryNode = nodes
//                //  BodyGeometry = nodes.geometry!
//                //enemyNode.geometry?.materials.first =
//                // enemyNode.addChildNode(nodes)
//                
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyMuscleTexture).png")
//                
//                
//                //BodyGeometry = nodes.geometry!
//                // nodes.addChildNode(bodyPlane)
//                
//                
//                enemyRootNode.addChildNode(nodes)
//                //enemyRootNode.addChildNode(enemySkin)
//                //enemyNode.addChildNode(nodes)
//                
//            case "\(enemySuitString)"?:
//                //case "male_white-male_casualsuit06"?:
//                
//                print("casual suit found")
//                
//                
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemySuitTexture).png")
//                
//                
//                enemyRootNode.addChildNode(nodes)
//                // enemyNode.addChildNode(EnemyGeometryTest)
//                
//            case "\(enemyHairString)"?:
//                print("Hair found")
//                //  print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyHairTexture).png")
//                
//                
//                enemyRootNode.addChildNode(nodes)
//                
//            case "\(enemyTeethString)"?:
//                print("teeth found")
//                //  print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTeethTexture).png")
//                
//                enemyRootNode.addChildNode(nodes)
//                
//            case "\(enemyTongueString)"?:
//                print("tongue found")
//                // print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyTongueTexture).png")
//                enemyRootNode.addChildNode(nodes)
//                
//            case "\(enemyEyeBrowString)"?:
//                print("tongue found")
//                //    print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeBrowTexture).png")
//                enemyRootNode.addChildNode(nodes)
//                
//            case "\(enemyEyeLashString)"?:
//                print("tongue found")
//                //  print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyeLashTexture).png")
//                enemyRootNode.addChildNode(nodes)
//                
//            case "\(enemyEyesString)"?:
//                print("tongue found")
//                //   print("GEOMETRY: \(nodes.geometry)")
//                nodes.geometry?.materials.first?.diffuse.contents = UIImage(named: "animate.scnassets/\(enemyEyesTexture).png")
//                enemyRootNode.addChildNode(nodes)
//                
//                
//                
//            case "MDL_Obj"?:
//                print("test")
//            case "Default_Camera"?:
//                print("\(nodes.name)")
//            case "Lamp"?:
//                print("\(nodes.name)")
//            case "Camera"?:
//                print("\(nodes.name)")
//            case "Infinite_Light_1"?:
//                print("\(nodes.name)")
//            case "Image_Based_Light_1"?:
//                print("\(nodes.name)")
//                
//            default:
//                print("Adding \(nodes.name) by default")
//                //enemyRootNode.addChildNode(nodes)
//            }
//            /*
//             if nodes.name == "Armature" {
//             enemyNode = nodes
//             } else {
//             
//             enemyRootNode.addChildNode(nodes)
//             }
//             */
//        }
        

        
        
        
        
        
        
        
        node.addChildNode(heroHandsNode)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // MARK: Configure collision capsule
        
        // Collisions are handled by the physics engine. The character is approximated by
        // a capsule that is configured to collide with collectables, enemies and walls
        
        let (min, max) = node.boundingBox
        let collisionCapsuleRadius = CGFloat((max.x - min.x) * 0.4)
        let collisionCapsuleHeight = CGFloat(max.y - min.y)
        
        let characterCollisionNode = SCNNode()
        characterCollisionNode.name = "enemyCollider"
        
        characterCollisionNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        characterCollisionNode.position = SCNVector3(0.0, collisionCapsuleHeight * 0.51, 0.0) // a bit too high so that the capsule does not hit the floor
        characterCollisionNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        characterCollisionNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape:SCNPhysicsShape(geometry: SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight), options:nil))
        // characterCollisionNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: SCNCapsule(capRadius: collisionCapsuleRadius, height: collisionCapsuleHeight), options:nil))
        
        // characterCollisionNode.physicsBody!.contactTestBitMask = BitmaskSuperCollectable | BitmaskCollectable | BitmaskCollision | BitmaskEnemy
        characterCollisionNode.physicsBody!.collisionBitMask = CollisionCategory.All
        characterCollisionNode.physicsBody!.categoryBitMask = CollisionCategory.Enemy
        characterCollisionNode.physicsBody!.contactTestBitMask = ~0
        node.addChildNode(characterCollisionNode)
        
        
        //        var BodyGeometryNode = SCNNode()
        //
        //       // let cnode = SCNCone(topRadius: 0.5, bottomRadius: 2, height: 4.0)
        //        node.geometry? = characterCollisionNode.geometry?
        //        node.geometry?.firstMaterial = material
        //        node.physicsBody? = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: characterCollisionNode.geometry!, options: nil))
        
        //node.physicsBody =
        
        // node.ph
        
        
        
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
        
        HitBellyAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch_Belly_SMALL.dae")!
        HitBellyAnimation.usesSceneTimeBase = false
        HitBellyAnimation.fadeInDuration = 0.3
        HitBellyAnimation.fadeOutDuration = 0.3
        HitBellyAnimation.repeatCount = 1
        
        HitHeadAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Ouch_Head_SMALL.dae")!
        HitHeadAnimation.usesSceneTimeBase = false
        HitHeadAnimation.fadeInDuration = 0.3
        HitHeadAnimation.fadeOutDuration = 0.3
        HitHeadAnimation.repeatCount = 1
        
        walkAnimation = CAAnimation.animationWithSceneNamed("animate.scnassets/Man_White_Walk_SMALL.dae")
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
    static let speedFactor = Float(0.5)
    
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
    
    func GotHit(location: String) {
        
        
        switch location {
        case "belly":
            node.addAnimation(HitBellyAnimation, forKey: "hitBelly")
            
        case "head":
            node.addAnimation(HitHeadAnimation, forKey: "hitHead")
            
            print("hit in head")
            
        default:
            break
        }
        
    }
    
    func walkInDirection(_ direction: float3, time: TimeInterval, scene: SCNScene, groundTypeFromMaterial: (SCNMaterial) -> GroundType) -> SCNNode? {
        // delta time since last update
        if previousUpdateTime == 0.0 {
            previousUpdateTime = time
        }
        
        let deltaTime = Float(min(time - previousUpdateTime, 1.0 / 60.0))
        let characterSpeed = deltaTime * EnemyCharacter.speedFactor * 0.84
        previousUpdateTime = time
        
        let initialPosition = node.position
        
        // move
        if direction.x != 0.0 && direction.z != 0.0 {
            // move character
            let position = float3(node.position)
            node.position = SCNVector3(position + direction * characterSpeed)
            
            // update orientation
            directionAngle = SCNFloat(atan2(direction.x, direction.z))
            
            isWalking = true
        }
        else {
            isWalking = false
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
            groundType = groundTypeFromMaterial(groundMaterial)
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
    
    private var isWalking: Bool = false {
        didSet {
            if oldValue != isWalking {
                // Update node animation.
                if isWalking {
                    node.addAnimation(walkAnimation, forKey: "walk")
                } else {
                    node.removeAnimation(forKey: "walk", fadeOutDuration: 0.2)
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
