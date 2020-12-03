//
//  EffectsOverlay.swift
//  BattleField
//
//  Created by Jared Stevens2 on 5/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit


class EffectsOverlay: SKScene {
    
    
     var CloudPositions = [CGPoint]()
    
    var Path = String()
    var Particle = SKEmitterNode()
    var Effect = String()
    
    let cloudSpeed: CGFloat = 150.0
    
    var MoveLeft = SKAction()
    var MoveRight = SKAction()
    var cloud = SKSpriteNode()
    
    
    var NumberClouds = Int()
    
    var cloudsLeft: [SKSpriteNode] = []
    var cloudsRight: [SKSpriteNode] = []

    override func didMove(to view: SKView) {
        
        CloudPositions.append(CGPoint(x: 408.0, y: 232.0))
        CloudPositions.append(CGPoint(x: 442.0, y: 492.0))
        CloudPositions.append(CGPoint(x: 532.0, y: 393.0))
        CloudPositions.append(CGPoint(x: 505.0, y: 253.0))
        CloudPositions.append(CGPoint(x: 490.0, y: 453.0))
        CloudPositions.append(CGPoint(x: 420.0, y: 273.0))
        CloudPositions.append(CGPoint(x: 435.0, y: 293.0))
        CloudPositions.append(CGPoint(x: 380.0, y: 393.0))
        CloudPositions.append(CGPoint(x: 395.0, y: 293.0))
        CloudPositions.append(CGPoint(x: 550.0, y: 293.0))
        
        NumberClouds = 20
        
       
        GenerateCloudsLeft(NumberClouds)
        GenerateCloudsRight(NumberClouds)
        
        /*
        cloud = self.childNodeWithName("cloud") as! SKSpriteNode
        
        
        for child in self.children {
            if child.name == "cloud" {
                if let child = child as? SKSpriteNode {
                    // Add SKAudioNode to zombie
                    //let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    //child.addChild(audioNode)
                    
                    clouds.append(child)
                }
            }
        }
        
        */
        
      //  self.backgroundColor = UIColor.clearColor()
      //  self.backgroundColor = UIColor.blackColor()
        
        MoveLeft = SKAction.moveBy(x: -500, y: 100, duration: 3.0)
        MoveRight = SKAction.moveBy(x: 500, y: 100, duration: 3.0)
        
        
       // Effect = "rain"
        
        //backgroundColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundColor = UIColor.clear
      //  let EffectsFrame = CGRect(x: 0, y: 0, width: device.width, height: device.height)
        
      //  EffectSpriteView = SKView(frame: EffectsFrame)
        
        //theView.scene?.background.contents = UIColor.clearColor()
        //  EffectSpriteView.allowsTransparency = true
        // EffectSpriteView.backgroundColor = UIColor.clearColor()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(EffectsOverlay.UpdateMapEffect(_:)), name: NSNotification.Name(rawValue: "UpdateMapEffect"), object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(EffectsOverlay.UpdateClouds(_:)), name: NSNotification.Name(rawValue: "UpdateClouds"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EffectsOverlay.RefreshClouds(_:)), name: NSNotification.Name(rawValue: "RefreshClouds"), object: nil)
        
      //  addClouds()
        
        /*
        Path = NSBundle.mainBundle().pathForResource("Rain", ofType: "sks")
        Particle = NSKeyedUnarchiver.unarchiveObjectWithFile(rainPath!) as! SKEmitterNode
        
        
        switch Effect {
        case "rain":
        
        rainParticle.position = CGPointMake(self.size.width/2, self.size.height)
        rainParticle.name = "rainParticle"
        rainParticle.targetNode = self.scene
       // rainParticle.inputView?.backgroundColor = UIColor.clearColor()
        
        default:
            break
        }
        
        self.addChild(rainParticle)
        
        */
        
        
     // MoveClouds("out")
        
        
    }
    
    @objc func RefreshClouds(_ notification: Notification) {
        
        
        GenerateCloudsLeft(10)
        GenerateCloudsRight(10)
        
    }
    
    
    func addClouds() {
        print("Adding Clouds")
        
        //cloud = self.childNodeWithName("cloud") as! SKSpriteNode
        //cloud = SKSpriteNode(imageNamed: "CloudSmall")
        cloud.setScale(0.8)
        cloud.position = CGPoint(x: 50, y: 100)
        self.addChild(cloud)
        
  
    }
    
 
    
    
    @objc func UpdateClouds(_ notification: Notification) {
     
       // self.removeAllChildren()
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        self.Effect = userInfo!["effect"] as! String
        
       // let Degree = userInfo!["degree"] as! String
        print("Cloud Effect is \(Effect)")
        
        MoveClouds(Effect)
        
    }
    
    func randomInRange(_ lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    
  
    
    
    func MakeACloud(_ side: String) {
       // print("Making a single Cloud")
       // let randPos = Int(arc4random()) % CloudPositions.count
       // let randPosition = CloudPositions[randPos]
      //  CloudPositions.removeAtIndex(randPos)
        
        
        
        // x coordinate between MinX (left) and MaxX (right):
        let randomX = randomInRange(Int(self.frame.minX - 20), hi: Int(self.frame.maxX + 20))
        // y coordinate between MinY (top) and MidY (middle):
        let randomY = randomInRange(Int(self.frame.minY  - 20), hi: Int(self.frame.midY + 20))
        let randPosition = CGPoint(x: randomX, y: randomY)
        
        
        
        let theCloud = SKSpriteNode(imageNamed: "CloudSmall.png")
        theCloud.position = randPosition
        theCloud.xScale = 3.0
        theCloud.yScale = 3.0
        theCloud.name = "cloud\(side)"
        
        self.addChild(theCloud)
        if side == "left" {
        cloudsLeft.append(theCloud)
        } else {
        cloudsRight.append(theCloud)
        }
        
    }
    
    func GenerateCloudsLeft(_ count: Int) {
     //    func GenerateClouds(count: Int, task: () -> ()) {
        
        for cloud in cloudsLeft {
         cloud.removeFromParent()
        }
        
        
        cloudsLeft.removeAll()
        
        
        for i in 0 ..< count {
            
          MakeACloud("left")
            
        }
   
    }
    
    func GenerateCloudsRight(_ count: Int) {
        //    func GenerateClouds(count: Int, task: () -> ()) {
        
        for cloud in cloudsRight {
            cloud.removeFromParent()
        }
        
        
        cloudsRight.removeAll()
        
        
        for i in 0 ..< count {
            
            MakeACloud("right")
            
        }
        
    }
    
    /*
    func resetClouds() {
        
        for cloud in clouds {
            
            let MoveLeftNow = SKAction.moveByX(-1000, y: 100, duration: 3.0)
            
            cloud.runAction(MoveLeftNow)
            
           // cloud.position = cloud.star
           
        }
        
        
    }
    */
    
    func MoveClouds(_ effect: String) {
        
        /*
        if effect == "out" {
        
        cloud.runAction(MoveLeft)
            
        } else {
            
        cloud.runAction(MoveRight)
            
        }
        */
        
        
        let targetPosition = CGPoint(x: 0, y: 0)
        
        
        if effect == "out" {
        
        for cloud in cloudsLeft {
            
            let MoveLeftNow = SKAction.moveBy(x: -1000, y: 100, duration: 3.0)
            
            cloud.run(MoveLeftNow)
            /*
            let currentPosition = cloud.position
            
            let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
            let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
            cloud.runAction(rotateAction)
            
            let velocotyX = cloudSpeed * cos(angle)
            let velocityY = cloudSpeed * sin(angle)
            
            let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
            cloud.physicsBody!.velocity = newVelocity;
            
            */
        }
            
            for cloud in cloudsRight {
                
                let MoveLeftNow = SKAction.moveBy(x: 1000, y: 100, duration: 3.0)
                
                cloud.run(MoveLeftNow)
                /*
                 let currentPosition = cloud.position
                 
                 let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
                 let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
                 cloud.runAction(rotateAction)
                 
                 let velocotyX = cloudSpeed * cos(angle)
                 let velocityY = cloudSpeed * sin(angle)
                 
                 let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                 cloud.physicsBody!.velocity = newVelocity;
                 
                 */
            }
            
        } else {
          
            
            for cloud in cloudsLeft {
                
                let MoveLeftNow = SKAction.moveBy(x: 1000, y: 100, duration: 3.0)
                
                cloud.run(MoveLeftNow)
                /*
                 let currentPosition = cloud.position
                 
                 let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
                 let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
                 cloud.runAction(rotateAction)
                 
                 let velocotyX = cloudSpeed * cos(angle)
                 let velocityY = cloudSpeed * sin(angle)
                 
                 let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                 cloud.physicsBody!.velocity = newVelocity;
                 
                 */
            }

            for cloud in cloudsRight {
                
                let MoveLeftNow = SKAction.moveBy(x: -1000, y: 100, duration: 3.0)
                
                cloud.run(MoveLeftNow)
                /*
                 let currentPosition = cloud.position
                 
                 let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(M_PI)
                 let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
                 cloud.runAction(rotateAction)
                 
                 let velocotyX = cloudSpeed * cos(angle)
                 let velocityY = cloudSpeed * sin(angle)
                 
                 let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                 cloud.physicsBody!.velocity = newVelocity;
                 
                 */
            }
            
        }
        
        
        
    }
    
    func AddWeather(_ effect: String, degree: String) {
        
        
        switch Effect {
        case "rain":
            
            Path = Bundle.main.path(forResource: "Rain", ofType: "sks")!
            Particle = NSKeyedUnarchiver.unarchiveObject(withFile: Path) as! SKEmitterNode
            Particle.position = CGPoint(x: self.size.width/2, y: self.size.height)
            Particle.name = "rainParticle"
            Particle.targetNode = self.scene
            
            
        case "snow":
            
            Path = Bundle.main.path(forResource: "Snow", ofType: "sks")!
            Particle = NSKeyedUnarchiver.unarchiveObject(withFile: Path) as! SKEmitterNode
            Particle.position = CGPoint(x: self.size.width/2, y: self.size.height)
            Particle.name = "snowParticle"
            Particle.targetNode = self.scene

            // rainParticle.inputView?.backgroundColor = UIColor.clearColor()
            
        default:
            break
        }
        
        self.addChild(Particle)
        
        
    }
    
    
    
    @objc func UpdateMapEffect(_ notification: Notification) {
        
       // self.removeAllChildren()
        self.RemoveWeatherNodes()
        
        let userInfo = notification.userInfo
        //  print("Money UserInfo = \(userInfo)")
        
        self.Effect = userInfo!["effect"] as! String
        
        let Degree = userInfo!["degree"] as! String
        print("Effect is \(Effect)")
        
        AddWeather(Effect, degree: Degree)
        addClouds()
        
    }
    
    
    func RemoveWeatherNodes() {
    for child in self.children {
    if child.name != "cloud" {
        
        child.removeFromParent()
        
        /*
    if let child = child as? SKSpriteNode {
    // Add SKAudioNode to zombie
    //let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
    //child.addChild(audioNode)
    
    child.removeFromParent()
    }
        */
    }
    }
    
    }
    
}


extension SKNode {
    class func unarchiveFromFileEffect(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            //  var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
           // var sceneData = Data.dataWith
            //var sceneData = Data.dataWithContentsOfMappedFile(path) as! Data
            
            let sceneData: NSData?
            do {
                sceneData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.alwaysMapped)
            } catch _ {
                sceneData = nil
            }
            
            var archiver = NSKeyedUnarchiver(forReadingWith: sceneData as! Data)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! EffectsOverlay
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}


/*
 
 {
 var money = 10
 var moneyLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
 
 override func didMoveToView(view: SKView) {
 
 self.backgroundColor = UIColor.clearColor()
 NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveGameData", name: "saveGameData", object: nil)
 
 // Draw background
 /*
 let background = SKSpriteNode(imageNamed: "bg_kookiekiosk")
 background.position = CGPoint(x: size.width/2, y: size.height/2)
 background.zPosition = CGFloat(ZPosition.background.rawValue)
 addChild(background)
 */
 
 // Draw HUD in top right corner that displays the amount of money the player has
 let moneyBackground = SKSpriteNode(imageNamed: "moneyBag.png")
 //moneyBackground.position = CGPoint(x: size.width - moneyBackground.size.width/2 - 10, y: size.height - moneyBackground.size.height/2 - 13)
 
 moneyBackground.position = CGPoint(x: 0, y: 0)
 
 moneyBackground.zPosition = CGFloat(ZPosition.HUDBackground.rawValue)
 addChild(moneyBackground)
 
 moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
 moneyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
 //moneyLabel.position = CGPoint(x: size.width - 60, y: size.height - 115)
 
 moneyLabel.position = CGPoint(x: 0, y: 0)
 
 moneyLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
 moneyLabel.fontSize = 50
 moneyLabel.zPosition = CGFloat(ZPosition.HUDForeground.rawValue)
 addChild(moneyLabel)
 
 //  loadGameData()
 //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "scheduleNotifications", name: "scheduleNotifications", object: nil)
 }
 
 func updateMoneyBy(delta : Int) {
 let deltaLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
 if delta < 0 {
 deltaLabel.fontColor = SKColor(red: 198/255.0, green: 139/255.0, blue: 207/255.0, alpha: 1.0)
 } else {
 deltaLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
 }
 deltaLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
 deltaLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
 deltaLabel.position = moneyLabel.position
 deltaLabel.text = String(format: "%i $", delta)
 deltaLabel.fontSize = moneyLabel.fontSize
 deltaLabel.zPosition = CGFloat(ZPosition.HUDForeground.rawValue)
 addChild(deltaLabel)
 
 let moveLabelAction = SKAction.moveBy(CGVector(dx: 0, dy: 20), duration: 0.5)
 let fadeLabelAction = SKAction.fadeOutWithDuration(0.5)
 let labelAction = SKAction.group([moveLabelAction, fadeLabelAction])
 deltaLabel.runAction(labelAction, completion: {deltaLabel.removeFromParent()})
 
 money += delta
 moneyLabel.text = String(format: "%i $", money)
 }
 
 
 
 
 
 }
 
 */
