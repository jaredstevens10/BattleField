//
//  GeneralIntroViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/5/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

class GeneralIntroViewController: UIViewController {

    @IBOutlet weak var generalView: SKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = ArmyGeneralIntroSpriteScene.unarchiveFromFileArmyGeneral("ArmyGeneralIntroSpriteScene") as? ArmyGeneralIntroSpriteScene {
            
            // Configure the view.
           // let skView = self.view as! SKView
         //   skView.showsFPS = true
         //   skView.showsNodeCount = true
            
            
            generalView.showsFPS = true
            generalView.showsNodeCount = true
            generalView.ignoresSiblingOrder = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
         //   skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            generalView.presentScene(scene)
            //skView.presentScene(scene)
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
    

    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
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
