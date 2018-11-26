//
//  MoneyOverlay.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/1/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

class MoneyOverlay: SKScene {
    var money = 10
    var moneyLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.clear
        NotificationCenter.default.addObserver(self, selector: "saveGameData", name: NSNotification.Name(rawValue: "saveGameData"), object: nil)
        
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
        
        moneyBackground.zPosition = CGFloat(ZPosition.hudBackground.rawValue)
        addChild(moneyBackground)
        
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moneyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        //moneyLabel.position = CGPoint(x: size.width - 60, y: size.height - 115)
        
        moneyLabel.position = CGPoint(x: 0, y: 0)
        
        moneyLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        moneyLabel.fontSize = 50
        moneyLabel.zPosition = CGFloat(ZPosition.hudForeground.rawValue)
        addChild(moneyLabel)
        
      //  loadGameData()
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "scheduleNotifications", name: "scheduleNotifications", object: nil)
    }
    
    func updateMoneyBy(_ delta : Int) {
        let deltaLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
        if delta < 0 {
            deltaLabel.fontColor = SKColor(red: 198/255.0, green: 139/255.0, blue: 207/255.0, alpha: 1.0)
        } else {
            deltaLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        }
        deltaLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        deltaLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        deltaLabel.position = moneyLabel.position
        deltaLabel.text = String(format: "%i $", delta)
        deltaLabel.fontSize = moneyLabel.fontSize
        deltaLabel.zPosition = CGFloat(ZPosition.hudForeground.rawValue)
        addChild(deltaLabel)
        
        let moveLabelAction = SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0.5)
        let fadeLabelAction = SKAction.fadeOut(withDuration: 0.5)
        let labelAction = SKAction.group([moveLabelAction, fadeLabelAction])
        deltaLabel.run(labelAction, completion: {deltaLabel.removeFromParent()})
        
        money += delta
        moneyLabel.text = String(format: "%i $", money)
    }
    
    
    
    

}
