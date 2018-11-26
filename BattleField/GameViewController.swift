//
//  GameViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/31/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//
//  GameViewController.swift
//  ShootEmUp
//
//  Created by Joey deVilla on 9/1/14.
//  Copyright (c) 2014 Global Nerdy. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            //  var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            
          //  var sceneData = Data.dataWithContentsOfMappedFile(path) as! Data
            
            let sceneData: NSData?
            do {
                sceneData = try NSData(contentsOfFile: file as String, options: NSData.ReadingOptions.alwaysMapped)
            } catch _ {
                sceneData = nil
            }
            
            var archiver = NSKeyedUnarchiver(forReadingWith: sceneData as! Data)
            
          //  var archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! TrainingScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    
    
    @IBOutlet weak var trainingView: SKView!
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = TrainingScene.unarchiveFromFile("TrainingScene") as? TrainingScene {
            // Configure the view.
            let skView = self.trainingView as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
