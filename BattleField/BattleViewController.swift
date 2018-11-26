//
//  BattleViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/31/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

/*

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}
*/
protocol BattleViewControllerDelegate: class {
    func battleviewcontrollerfinished(battleviewcontroller: BattleViewController)
}

class BattleViewController: UIViewController {

    var tdelegate: BattleViewControllerDelegate?
    var AttackingPlayer = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackPower = Int()
    var username = NSString()
    
       // var AppKey = "com.ClavenSolutions.BattleField"

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
     //   battleviewcontroller.tdelegate = self

        
               
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        username = prefs.valueForKey("USERNAME") as! NSString as String
        
        println("Battling - \(AttackingPlayer)")
        

        let scene = BattleGame(size: view.bounds.size)
      
        //scene.
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        
        
       // skView.presentScene(scene)
        

        
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
    
    override func viewDidAppear(animated: Bool) {
        
        /*
        let scene = BattleGame(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        */
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
        
    @IBAction func CloseAttackBTN(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.tdelegate?.battleviewcontrollerfinished(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func shouldAutorotate() -> Bool {
        return true
    }

    
 //   override func supportedInterfaceOrientations() -> Int {
   //     return UIInterfaceOrientation.LandscapeLeft.rawValue
  //  }
    
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

