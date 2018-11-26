//
//  AttackLoadingViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/11/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class AttackLoadingViewController: UIViewController {

    
    var UserObjective = String()
    @IBOutlet weak var loadingLBL: UILabel!
    var prefs:UserDefaults = UserDefaults.standard
    var AttackingPlayerID = NSString()
    var AttackingPlayer = NSString()
    var AttackingPlayersHealth = NSString()
    var AttackPower = Int()
    var UpdatedAttackPower = Int()
    var AttackStatus = NSString()
    var isAttacking = Bool()
    var isTraining = Bool()
    var isFixing = Bool()
    
    var currentWeapon = String()
    var enemyWeapon = String()
    
    var MyHealth = String()
    
    var StaminaUsed = Int()
    var NewStaminaAmount = Int()
    
    var MissionID = String()
    var MissionLevel = String()
    var MissionObjective = String()
    var MissionXP = String()
    var MissionMapURL = String()
    var MissionObjectURL = String()
    
    var username = NSString()
    var email = NSString()
    
    
    @IBAction func unwindToAttackLoading(_ segue: UIStoryboardSegue) {
        print("****Unwinding: User Objective = \(UserObjective)")
        
        switch UserObjective {
            
            case "mission":
            
            //print("mission")
            
            loadingLBL.text = "Mission Complete..."
            
            
            if let FromAttackViewController = segue.source as? AttackMapViewController {
                
                
                
                
                if prefs.value(forKey: "MissionCompletedDictionary") != nil {
                    
                    print("Attack Dictinoary not nil")
                    
                    let MissionCompletedDictionary = prefs.value(forKey: "MissionCompletedDictionary") as! NSDictionary
                    
                    
                    let NewMissionStatus = MissionCompletedDictionary["missionStatus"] as! String
                    let NewMissionID = MissionCompletedDictionary["missionID"] as! String
                    let NewMissionObjective = MissionCompletedDictionary["missionObjective"] as! String
                    //  print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
                    //   print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
                    if NewMissionStatus == "complete" {
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Mission Complete"
                        alertView.message = "Info(MissionID: \(NewMissionID), Mission Objective: \(NewMissionObjective))"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                    }
                    
                }
                
            }
            
            case "training":
            
             loadingLBL.text = "Leaving Headquarters..."
             self.dismiss(animated: true, completion: {
             
             let value = UIInterfaceOrientation.portrait.rawValue
             UIDevice.current.setValue(value, forKey: "orientation")
                
             })
            
            case "fixing":
            
            loadingLBL.text = "Training Complete..."
            self.dismiss(animated: true, completion: {
                
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
            })
            //)
            
            
            
        default:
            
            
            loadingLBL.text = "Attack Complete..."
            
            let AttackPowerTemp = prefs.value(forKey: "CURRENTATTACKINGPERCENT") as! Double
            self.UpdatedAttackPower = Int(AttackPowerTemp)
            print("Attack complete, attack power = \(AttackPower)")
            
            
            
            if let FromAttackViewController = segue.source as? AttackMapViewController {
                
                
                
                
                if prefs.value(forKey: "AttackCompletedDictionary") != nil {
                    
                    print("Attack Dictinoary not nil")
                
                let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
                
                
                let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
                let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
                
                print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
                print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Attack Complete"
                // alertView.message = "Info(My Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount), Attack Power: \(AttackPower), Attacking Player Name: \(AttackingPlayer), Attacking PlayerID: \(AttackingPlayerID), Attacking Player's Health: \(AttackingPlayersHealth)"
                
                let NewPlayersHealth = Int(AttackingPlayersHealth as String)! - UpdatedAttackPower
                
                var AttackMessage = String()
                
                if NewPlayersHealth <= 0 {
                    AttackMessage = "You Killed \(AttackingPlayer)!"
                } else {
                    
                    
                    if AttackPower >= 1 {
                        if AttackPower > 1 {
                            AttackMessage = "You were able to inflict \(AttackPower) points of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                        } else {
                            AttackMessage = "You were only able to inflict \(AttackPower) point of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                        }
                    } else {
                        AttackMessage = "You didn't hurt \(AttackingPlayer) at all. \(AttackingPlayer)'s health is still at \(NewPlayersHealth)"
                        
                    }
                    
                }
                
                alertView.message = "\(AttackMessage)"
                
                
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                //alertView.show()
                print("Attacking players health :\(AttackingPlayersHealth)")
                
                prefs.set(["attackStatus":"complete", "attackStamina":"\(NewStaminaAmount)", "attackGold":"\(AttackGoldAmount)","attackPlayer":"\(AttackingPlayer)","attackPlayerID":"\(AttackingPlayerID)","attackPower":"\(AttackPowerTemp.description)","attackStartHealth":"\(AttackingPlayersHealth)","attackNewHealth":"\(NewPlayersHealth)"], forKey: "AttackCompletedDictionary")
                
                
            }
            
        }
            
        }

 
//}

//}
            /*
 
 
        
        if UserObjective != "mission" {
        
        loadingLBL.text = "Attack Complete..."
        
        let AttackPowerTemp = prefs.value(forKey: "CURRENTATTACKINGPERCENT") as! Double
        self.UpdatedAttackPower = Int(AttackPowerTemp)
        print("Attack complete, attack power = \(AttackPower)")
        
        
        
        if let FromAttackViewController = segue.source as? AttackMapViewController {
            
            
            
            
            if prefs.value(forKey: "AttackCompletedDictionary") != nil {
                
                print("Attack Dictinoary not nil")
                
                let AttackCompletedDictionary = prefs.value(forKey: "AttackCompletedDictionary") as! NSDictionary
                
                
                let AttackStaminaAmount = AttackCompletedDictionary["attackStamina"] as! String
                let AttackGoldAmount = AttackCompletedDictionary["attackGold"] as! String
                
                print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
                print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Attack Complete"
               // alertView.message = "Info(My Stamina: \(AttackStaminaAmount), Gold Amount: \(AttackGoldAmount), Attack Power: \(AttackPower), Attacking Player Name: \(AttackingPlayer), Attacking PlayerID: \(AttackingPlayerID), Attacking Player's Health: \(AttackingPlayersHealth)"
                
                let NewPlayersHealth = Int(AttackingPlayersHealth as String)! - UpdatedAttackPower
                
                var AttackMessage = String()
                
                if NewPlayersHealth <= 0 {
                    AttackMessage = "You Killed \(AttackingPlayer)!"
                } else {
                
                
                if AttackPower >= 1 {
                    if AttackPower > 1 {
                    AttackMessage = "You were able to inflict \(AttackPower) points of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                    } else {
                    AttackMessage = "You were only able to inflict \(AttackPower) point of damage.  \(AttackingPlayer)'s health is now \(NewPlayersHealth)"
                    }
                } else {
                    AttackMessage = "You didn't hurt \(AttackingPlayer) at all. \(AttackingPlayer)'s health is still at \(NewPlayersHealth)"
 
                }
                
                }
                
                alertView.message = "\(AttackMessage)"
                
                
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                //alertView.show()
                print("Attacking players health :\(AttackingPlayersHealth)")
                
                prefs.set(["attackStatus":"complete", "attackStamina":"\(NewStaminaAmount)", "attackGold":"\(AttackGoldAmount)","attackPlayer":"\(AttackingPlayer)","attackPlayerID":"\(AttackingPlayerID)","attackPower":"\(AttackPowerTemp.description)","attackStartHealth":"\(AttackingPlayersHealth)","attackNewHealth":"\(NewPlayersHealth)"], forKey: "AttackCompletedDictionary")
                
                
            }
            
        }
        
        } else {
            
         loadingLBL.text = "Mission Complete..."
            
            
            if let FromAttackViewController = segue.source as? AttackMapViewController {
                
                
                
                
                if prefs.value(forKey: "MissionCompletedDictionary") != nil {
                    
                    print("Attack Dictinoary not nil")
                    
                    let MissionCompletedDictionary = prefs.value(forKey: "MissionCompletedDictionary") as! NSDictionary
                    
                    
                    let NewMissionStatus = MissionCompletedDictionary["missionStatus"] as! String
                    let NewMissionID = MissionCompletedDictionary["missionID"] as! String
                    let NewMissionObjective = MissionCompletedDictionary["missionObjective"] as! String
                  //  print("Attack Stamina Amount From Unwind = \(AttackStaminaAmount)")
                 //   print("Attack Gold Amount From Unwind = \(AttackGoldAmount)")
                    if NewMissionStatus == "complete" {
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Mission Complete"
                    alertView.message = "Info(MissionID: \(NewMissionID), Mission Objective: \(NewMissionObjective))"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                    }
                    
                }
                
            }
            
            //CONFIRM IF MISSION COMPLETED, THEN ADD ITEM TO INV
            
        }
 
 */
        
        DispatchQueue.main.async {
            print("dismissing timer view controller")
            // self.pr
            //self.dismissViewControllerAnimated(true, completion: nil)
            self.CloseAttackGame()
        }
        
       
        
       // self.dismissViewControllerAnimated(true, completion: nil)

        /*
        if segue.identifier == "EndAttack" {
            
        }
        */
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        print("Mission Map URL: \(MissionMapURL)")
        
        if isAttacking {
            
            if UserObjective != "mission" {
                
                
               NewStaminaAmount = prefs.integer(forKey: "MYSTAMINA") - StaminaUsed
                
                let UpdatedHealthStamina = SaveUsersHealthStamina("stamina", level: NewStaminaAmount, emailID: self.email)
                print("Stamina was updated = \(UpdatedHealthStamina)")
                
                
            loadingLBL.text = "Loading Attack..."
            } else {
            loadingLBL.text = "Loading Mission..."
            }
        }
        
        if isTraining {
            
print("is training")
            loadingLBL.text = "Loading Training..."
        }
        
        if isFixing {
            loadingLBL.text = "Loading Headquarters..."
        }

       // loadingLBL.text = "Attack Complete..."
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        if isAttacking {
            
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
            
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)

        
         print("Is attacking, segue")
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            print("waiting 4 seconds to start")
            
             self.performSegue(withIdentifier: "AttackPlayer", sender: self)
            
        })
        
        
        
      
           
        } else {
            
            if isTraining {
                
                
                
                let value = UIInterfaceOrientation.landscapeLeft.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
                
                let seconds = 2.0
                let secondsLoad = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
                
                
               // print("Is Training, segue")
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    print("waiting 4 seconds to start")
                    
                    self.performSegue(withIdentifier: "AttackPlayer", sender: self)
                    
                })
            
                
                
                
            } else {
            
            if isFixing {
                
                
                
                let value = UIInterfaceOrientation.landscapeLeft.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
                
                let seconds = 2.0
                let secondsLoad = 2.0
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
                
                
                print("Is Fixing, segue")
                
                
                DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                    //print("waiting 4 seconds to start")
                    
                    self.performSegue(withIdentifier: "AttackPlayer", sender: self)
                    
                })
                
                
                
                
            } else {
            
            if UserObjective != "mission" {
            self.loadingLBL.text = "Attack Complete..."
            } else {
            self.loadingLBL.text = "Mission Complete..."
            }

            let value = UIInterfaceOrientation.portrait.rawValue    //LandscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")

            let seconds = 2.0
            let secondsLoad = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
            
            print("Not attacking, dismiss VC")
            
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                print("waiting 4 seconds to start")

           // self.dismiss(animated: true, completion: nil)
                
                print("UNWIND TO MAP VIEW")
                self.performSegue(withIdentifier: "UnwindToMapView", sender: self)
                
            })
                
        }
            
        }
        
    }
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AttackPlayer" {
            if let battlecontroller = segue.destination as? AttackMapViewController {
                
                battlecontroller.UserObjective = self.UserObjective
                
                battlecontroller.currentWeapon = self.currentWeapon
                
                battlecontroller.MissionID = MissionID
                battlecontroller.MissionLevel = MissionLevel
                battlecontroller.MissionObjective = MissionObjective
                battlecontroller.MissionXP = MissionXP
                battlecontroller.MissionMapURL = MissionMapURL
                battlecontroller.MissionObjectURL = MissionObjectURL

                battlecontroller.AttackingPlayer = AttackingPlayer as String as String as NSString
                battlecontroller.AttackingPlayersHealth = AttackingPlayersHealth as String as String as NSString
                battlecontroller.AttackingPlayerID = AttackingPlayerID as String as String as NSString
                battlecontroller.AttackStatus = AttackStatus
                battlecontroller.AttackPower = AttackPower
                battlecontroller.isFixing = isFixing
                battlecontroller.MyHealth = MyHealth
                battlecontroller.enemyWeapon = enemyWeapon
               // battlecontroller.isAttacking = true
                
                
            }
        }
        
    }
    
    
    func CloseAttackGame() {
        print("received close notification")
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let yesSuccess =  Attack(self.username, attackingID: self.email, attackedName: self.AttackingPlayer, attackedID: self.AttackingPlayerID, attackpower: self.UpdatedAttackPower)
            print("Attack Success = \(yesSuccess)")
            
            DispatchQueue.main.async {
                print("dismissing timer view controller")
               // self.pr
                
                // NSNotificationCenter.defaultCenter().postNotificationName("UnwindTest", object: nil)
                
              //   NSNotificationCenter.defaultCenter().postNotificationName("UnwindTest", object: nil)
                
               // self.dismissViewControllerAnimated(true, completion: nil)
               // self.performSegueWithIdentifier("UnwindToMapView", sender: self)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
