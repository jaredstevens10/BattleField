//
//  PlayerModel.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SceneKit



class PlayerModel: SKScene, SKPhysicsContactDelegate {

   // let scene = SCNScene("ENEMY_Army Soldier.scn")
    
    var target = SKSpriteNode()
    var actionMoveUp = SKAction()
    
override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    NumberOfHits = 0
    NumberOfMisses = 0
    
    
    var bgImage = SKSpriteNode(imageNamed: "FOShelterBG.png")
    
    
    bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
    self.addChild(bgImage)
    
    // 1. Create a physics body that borders the screen
    let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    // 2. Set the friction of that physicsBody to 0
    borderBody.friction = 0
    // 3. Set physicsBody of scene to borderBody
    self.physicsBody = borderBody
    
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    
    target = SKSpriteNode(imageNamed: "SniperScopeRed2.png")
    target.physicsBody?.isDynamic = true
    target.zRotation = CGFloat(-M_PI/2)
    target.physicsBody = SKPhysicsBody(rectangleOf: target.size)
    target.physicsBody?.categoryBitMask = UInt32(TargetCategory)
    
    target.physicsBody?.collisionBitMask = 0
    target.name = "target"
    target.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
    
    self.addChild(target)
    
    var path = CGMutablePath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 50, y: 100))
    //CGPathMoveToPoint(path, nil, 0, 0)
    //CGPathAddLineToPoint(path, nil, 50, 100)
    var followLine = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 3.0)
    
    var reversedLine = followLine.reversed()
    var square = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
    var followSquare = SKAction.follow(square.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
    
    var circle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 100)
    
    var followCircle = SKAction.follow(circle.cgPath, asOffset: true, orientToPath: false, duration: 5.0)
    
    target.run(SKAction.sequence([followLine, reversedLine, followSquare, followCircle]))    //target.position = CGPointMake(self.size.width/2, self.size.height/2)
    //target.physicsBody!.applyImpulse(CGVectorMake(5,-15))
    
    
    
    //target.physicsBody!.applyImpulse(CGVectorMake(5,-15))
    // let target = SKNode.unarchiveFromFile("target")!
    
    //let target = childNodeWithName(TargetCategoryName) as! SKSpriteNode
    
    //  target.physicsBody!.applyImpulse(CGVectorMake(5, -15))
    
    // self.addChild(target)
    
    let bottomRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
    let bottom = SKNode()
    bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
    addChild(bottom)
    
    bottom.physicsBody!.categoryBitMask = BottomCategory
    //  target.physicsBody!.categoryBitMask = TargetCategory
    
    physicsWorld.contactDelegate = self
    
}


deinit {
    NotificationCenter.default.removeObserver(self)
}

}

