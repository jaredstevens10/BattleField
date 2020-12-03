//
//  AttackTimerViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 8/5/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    
    /*
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = (try! NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe))
            
            //var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    
    */
}


class AttackTimerViewController: UIViewController  {
    
   // var attacktimercontroller: BattleViewController = BattleViewController()
    
    var type = NSString()
    
    var AttackingPlayerID = NSString()
    var AttackingPlayer = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackPower = Int()
    var AttackStatus = NSString()
    var username = NSString()
    var email = NSString()
    
    var timer = Timer()
    
    @IBOutlet weak var cancelBTN: UIButton!
    
    @IBOutlet weak var TimerLBL: UILabel!
    
    var counter = Int()
    
    @IBOutlet weak var AlertLBL: UILabel!
    
    var scene = SKScene()
    
    //scene.
    var skView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = BattleGame(size: view.bounds.size)
        skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        
        //skView.presentScene(scene)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AttackTimerViewController.CloseAttackGame), name: NSNotification.Name(rawValue: "CloseGame"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: "StartAttack", name: NSNotification.Name(rawValue: "StartAttack"), object: nil)
        
        
        
        counter = 20
        
        let prefs:UserDefaults = UserDefaults.standard
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }

        
        
       // username = prefs.valueForKey("USERNAME") as! NSString as String
        
        NotificationCenter.default.addObserver(self, selector: "UserIsFightingBack", name: NSNotification.Name(rawValue: "UserIsFightingBack"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: "UserRanAway", name: NSNotification.Name(rawValue: "UserRanAway"), object: nil)
        
        //TimerLBL.text = String(counter)
        
        TimerLBL.text = "\(counter) Seconds"
        
        TimerLBL.layer.borderWidth = 2
        TimerLBL.layer.borderColor = UIColor.black.cgColor
        TimerLBL.layer.cornerRadius = 20
        cancelBTN.layer.cornerRadius = 20
        
        if AttackStatus == "new" {
            //SHOW COUNTDOWN TIMER
            TimerLBL.isHidden = false
            AlertLBL.isHidden = false
            cancelBTN.isHidden = false
        
        print("Attacking Player \(AttackingPlayer)")
        AlertLBL.text = "\(AttackingPlayer) has been notifited of your attack.  They have 20 Seconds to respond"
        
        type = "willAttack"
        
            let yesSuccess =  AttackNotice(username, username: AttackingPlayer, attackpower: AttackPower, type: type, attackedID: AttackingPlayerID)
        print("Attack Notice Sent = \(yesSuccess)")
            
        timercountdown()
            
        }
        
        if AttackStatus == "fightingback" {
         //DO NOT SHOW COUNT DOWN TIMER
        self.TimerLBL.isHidden = true
        self.AlertLBL.isHidden = true
        self.cancelBTN.isHidden = true
         
            type = "fightingBack"
            
            let yesSuccess =  AttackNotice(username, username: AttackingPlayer, attackpower: AttackPower, type: type, attackedID: AttackingPlayerID)
            print("Attack Notice Sent = \(yesSuccess)")
            
            self.skView.presentScene(self.scene)
        }

        // Do any additional setup after loading the view.
        

    }
    @objc func updateCounter() {
        
        if counter != 0 {
        TimerLBL.text = "\(String(describing: counter -= 1)) Seconds"
            //timer.invalidate()
        }
        
        if counter == 0 {
            timer.invalidate()
        }
        
        if counter < 5 {
            TimerLBL.textColor = UIColor.red
            TimerLBL.layer.borderColor = UIColor.red.cgColor        }
        
        if counter == 0 {
            
            TimerLBL.text = "\(counter) Seconds"
            
            let actionSheetController: UIAlertController = UIAlertController(title: "No response!", message: "\(AttackingPlayer) failed to respond, continue your Attack?", preferredStyle: .alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "Attack!", style: .default) { action -> Void in
                print("Is Attacking Player = \(self.AttackingPlayer)")
                
              //  self.dismissViewControllerAnimated(true, completion: nil)
                
              //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
             //   username = prefs.valueForKey("USERNAME") as! NSString as String
                
                self.TimerLBL.isHidden = true
               self.AlertLBL.isHidden = true
                self.cancelBTN.isHidden = true
                
                print("Battling - \(self.AttackingPlayer)")
                
                
                
                
                self.skView.presentScene(self.scene)
                
                //self.performSegueWithIdentifier("start_fight", sender: self)
                
               
 
            }
            
            
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
            
            self.present(actionSheetController, animated: true, completion: nil)
            /*
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "No Response!"
            alertView.message = "\(AttackingPlayer) failed to respond, have your way with them."
            alertView.delegate = self
            alertView.addButtonWithTitle("Attack")
            alertView.show()
            self.performSegueWithIdentifier("start_fight", sender: self)
*/
        }
    }
    
    func timercountdown(){
        
        //if counter > 0 {
            
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(AttackTimerViewController.updateCounter), userInfo: nil, repeats: true)
            
        //}
        
    }
    
    
    @IBAction func CancelAttack(_ sender: AnyObject) {
        
        type = "cancelAttack"
        
        let yesSuccess =  AttackNotice(username, username: AttackingPlayer, attackpower: AttackPower, type: type, attackedID: AttackingPlayerID)
        print("Attack Cancel Notice Sent = \(yesSuccess)")
        
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == "start_fight" {
            if let battlecontroller = segue.destinationViewController as? BattleViewController {
                
                battlecontroller.AttackingPlayer = AttackingPlayer as String
                battlecontroller.AttackingPlayersHealth = AttackingPlayersHealth as String
                
                //NEED TO ADD ARMOR, PLAYER TYPE ETC VARIABLES
            }
            
        }
      */
    }
    
    @objc func CloseAttackGame() {
        print("received close notification")
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
      //  let yesSuccess =  Attack(self.username, username: self.AttackingPlayer, attackpower: self.AttackPower)
            
        let yesSuccess =  Attack(self.username, attackingID: self.email, attackedName: self.AttackingPlayer, attackedID: self.AttackingPlayerID, attackpower: self.AttackPower)
        print("Attack Success = \(yesSuccess)")
            
            DispatchQueue.main.async {
                print("dismissing timer view controller")
                self.dismiss(animated: true, completion: nil)
            }
        
        }
        
      /*
        if yesSuccess{
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Attack Success!"
            alertView.message = "Target Hit!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
*/
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    /*
    @IBAction func CloseAttackBTN(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
      //  self.tdelegate?.battleviewcontrollerfinished(self)
    }
   */
    
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    
    //   override func supportedInterfaceOrientations() -> Int {
    //     return UIInterfaceOrientation.LandscapeLeft.rawValue
    //  }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
   
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
}

/*
extension AttackTimerViewController : BattleViewControllerDelegate {
    func battleviewcontrollerfinished(battleviewController: BattleViewController) {
        
        println("Battle delegate Finished called")
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
        // self.WeaponItem.image = ArmorViewController.armorPKimage
        /*
        self.shieldBTN.setImage(shieldviewController.armorPKimage, forState:.Normal)
        
        switch shieldviewController.armorPKLabel {
        case "Wood Armor":
        println("wood armor")
        ShieldDefense = 5
        case "Black Armor":
        println("black armor")
        ShieldDefense = 10
        default:
        ShieldDefense = 0
        }
        
        ShieldSpeed = shieldviewController.SpeedSelected
        ShieldPower = shieldviewController.PowerSelected
        ShieldRange = shieldviewController.RangeSelected
        
        UpdateMap()
        */
        
        // println("SheildDefense =  \(ShieldPower)")
        //= settingsViewController.weaponPKimage
        
    }
}
*/

