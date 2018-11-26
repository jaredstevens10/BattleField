//
//  RightMenuViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/31/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class RightMenuViewController: UIViewController {

    @IBOutlet weak var missionNotificationLBL: UILabel!
    
     var prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var missionsView: UIView!
    
    @IBOutlet weak var trainingView: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    
    @IBOutlet weak var targetsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        missionNotificationLBL.layer.cornerRadius = 15
        missionNotificationLBL.layer.masksToBounds = true
        missionNotificationLBL.clipsToBounds = true
        
        baseView.layer.cornerRadius = 5
        baseView.layer.borderColor = UIColor.darkGray.cgColor
        baseView.layer.borderWidth = 1
        baseView.layer.masksToBounds = true
        baseView.clipsToBounds = true
        
        missionsView.layer.cornerRadius = 5
        missionsView.layer.borderColor = UIColor.darkGray.cgColor
        missionsView.layer.borderWidth = 1
        missionsView.layer.masksToBounds = true
        missionsView.clipsToBounds = true
        
        trainingView.layer.cornerRadius = 5
        trainingView.layer.borderColor = UIColor.darkGray.cgColor
        trainingView.layer.borderWidth = 1
        trainingView.layer.masksToBounds = true
        trainingView.clipsToBounds = true
        
        targetsView.layer.cornerRadius = 5
        targetsView.layer.borderColor = UIColor.darkGray.cgColor
        targetsView.layer.borderWidth = 1
        targetsView.layer.masksToBounds = true
        targetsView.clipsToBounds = true
        
        settingsView.layer.cornerRadius = 5
        settingsView.layer.borderColor = UIColor.darkGray.cgColor
        settingsView.layer.borderWidth = 1
        settingsView.layer.masksToBounds = true
        settingsView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func TrainingBTN(_ sender: AnyObject) {
        
        
        self.performSegue(withIdentifier: "GoToTraining", sender: self)
        
        /*
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Training"
        alertView.message = "Coming Soon...In Development"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
 */
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToTraining" {
            
            if let AttackTrainingViewController = segue.destination as? AttackLoadingViewController {
                //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
                
                var wp = String()
                
                if self.prefs.value(forKey: "HOLDINGWEAPON") == nil {
                    wp = "Fist"
                } else {
                    wp = self.prefs.value(forKey: "HOLDINGWEAPON") as! String
                }
                
                AttackTrainingViewController.currentWeapon = wp
                
                AttackTrainingViewController.isTraining = true
                AttackTrainingViewController.UserObjective = "training"
                AttackTrainingViewController.AttackingPlayerID = "jaredstevens10@yahoo.com"
                AttackTrainingViewController.AttackingPlayer = "jaredstevens10"
                AttackTrainingViewController.AttackPower = 1
                AttackTrainingViewController.AttackingPlayersHealth = "100"
                AttackTrainingViewController.MyHealth = "100"
                AttackTrainingViewController.enemyWeapon = "Gun"
                
            }
            
        }
        
    }
    
    @IBAction func homebaseBTN(_ sender: Any) {
        
        self.performSegue(withIdentifier: "HomeBase", sender: self)
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
