//
//  ArmyGeneralIntroSpriteScene.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/5/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit



extension SKNode {
    class func unarchiveFromFileArmyGeneral(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            //  var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            
            //var sceneData = Data.dataWithContentsOfMappedFile(path) as! Data
            //var archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            
            let sceneData: NSData?
            do {
                sceneData = try NSData(contentsOfFile: file as String, options: NSData.ReadingOptions.alwaysMapped)
            } catch _ {
                sceneData = nil
            }
            
            var archiver = NSKeyedUnarchiver(forReadingWith: sceneData as! Data)
            
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! ArmyGeneralIntroSpriteScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}



class ArmyGeneralIntroSpriteScene: SKScene, SKPhysicsContactDelegate {

    let playerSpeed: CGFloat = 150.0
    let zombieSpeed: CGFloat = 75.0
    
    var goal: SKSpriteNode?
    var player: SKSpriteNode?
    var zombies: [SKSpriteNode] = []
    
    var lastTouch: CGPoint? = nil

    override func didMove(to view: SKView) {
        // Setup physics world's contact delegate
        physicsWorld.contactDelegate = self
        
        // Setup player
        player = self.childNode(withName: "general") as? SKSpriteNode
        if #available(iOS 9.0, *) {
            self.listener = player
        } else {
            // Fallback on earlier versions
        }
        
        // Setup zombies
        for child in self.children {
            if child.name == "enemy" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    
                   /*
                    if #available(iOS 9.0, *) {
                        let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    */
                   // child.addChild(audioNode)
                    
                   // zombies.append(child)
                }
            }
        }
        
        // Setup goal
       // goal = self.childNodeWithName("goal") as? SKSpriteNode
        
        // Setup initial camera position
        updateCamera()
    }
    
    
    func updateCamera() {
        if #available(iOS 9.0, *) {
            if let camera = camera {
                camera.position = CGPoint(x: player!.position.x, y: player!.position.y)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    fileprivate func handleTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            lastTouch = touchLocation
        }
    }
    
}
