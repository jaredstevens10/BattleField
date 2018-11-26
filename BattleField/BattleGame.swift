//
//  BattleGame.swift
//  BattleField
//
//  Created by Jared Stevens on 7/31/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

var endTurn = false
var isFingerOnTarget = false
let TargetCategoryName = "target"

var AttackingPlayer = NSString()
var AttackingPlayersHealth = NSString()
var AttackPower = Int()
var username = NSString()
var NumberOfHits = Int()
var NumberOfMisses = Int()

let TargetCategory   : UInt32 = 0x1 << 0 // 00000000000000000000000000000001
let BottomCategory : UInt32 = 0x1 << 1 // 00000000000000000000000000000010
let BlockCategory  : UInt32 = 0x1 << 2 // 00000000000000000000000000000100
let PaddleCategory : UInt32 = 0x1 << 3 // 00000000000000000000000000001000

class BattleGame: SKScene, SKPhysicsContactDelegate {


//let scene = BattleGame.unarchiveFromFile("BattleGame")! as! BattleGame
    var target = SKSpriteNode()
    var actionMoveUp = SKAction()
    
  override func didMove(to view: SKView) {
        super.didMove(to: view)
    
    NumberOfHits = 0
    NumberOfMisses = 0
  
    
    var bgImage = SKSpriteNode(imageNamed: "radar.jpg")
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
   // CGPathMoveToPoint(<#T##path: CGMutablePath?##CGMutablePath?#>, UnsafePointer<CGAffineTransform>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>)
  //  CGPathMoveToPoint(path, nil, 0, 0)
  //  CGPathAddLineToPoint(path, nil, 50, 100)
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
    
    
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first //as UITouch
        let touchLocation = touch!.location(in: self)
        NumberOfMisses = NumberOfMisses + 1
        print("Number of Misses: \(NumberOfMisses)")
        print("Began touch on screen")
        
        
        
        if let body = physicsWorld.body(at: touchLocation) {
            if body.node!.name == target.name {
                print("Began touch on target, Attacking \(AttackingPlayer)")
                isFingerOnTarget = true
                endTurn = true
                NumberOfHits = NumberOfHits + 1
                print("Number of hits: \(NumberOfHits)")
                print("sending close notification")
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "CloseGame"), object: self)
                //self.view?.presentScene(nil)
              
             //  let vc = self.view!
             //   self.view.window = BattleViewController
                
 //               vc.dismissViewControllerAnimated(true, completion: nil)
                
                
                //let controller = self.view?.window?.rootViewController as! BattleViewController
                //var test = controller.AttackingPlayer
                
                
                             //  println("test = \(test)")
             //   (scene!.view!.window?.rootViewController as! BattleViewController?)!.dismissViewControllerAnimated(false, completion: nil)
                
                /*
                let yesSuccess =  Attack(AttackingPlayer, AttackPower)
                println("Attack Success = \(yesSuccess)")
*/
            }
        }
    }
    
 
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1. Check whether user touched the paddle
        if isFingerOnTarget {
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = "You have hit the Target!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
*/
            
            // 2. Get touch location
            
            /*
            var touch = touches.first as! UITouch
            var touchLocation = touch.locationInNode(self)
            var previousLocation = touch.previousLocationInNode(self)
            
            // 3. Get node for paddle
            var paddle = childNodeWithName(PaddleCategoryName) as! SKSpriteNode
            
            // 4. Calculate new position along x for paddle
            var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
            
            // 5. Limit x so that paddle won't leave screen to left or right
            paddleX = max(paddleX, paddle.size.width/2)
            paddleX = min(paddleX, size.width - paddle.size.width/2)
            
            // 6. Update paddle position
            paddle.position = CGPointMake(paddleX, paddle.position.y)

*/
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingerOnTarget = false
    }
    
       
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        username = prefs.valueForKey("USERNAME") as! NSString as String
        
        println("Battling")
        
        /*
        let yesSuccess =  Attack(AttackingPlayer, AttackPower)
        println("Attack Success = \(yesSuccess)")
        
        
        
        if yesSuccess{
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Attack Success!"
        alertView.message = "Nice Job!"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
        
        }
        */
        
        // Do any additional setup after loading the view.
    }
    
  
 */
    
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
