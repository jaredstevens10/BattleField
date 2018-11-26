//
//  HowToViews.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/14/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit


class HowToView: UIView, MKMapViewDelegate {
    
   var buttonClicked = Bool()
    
    @IBOutlet weak var DownArrowCenter: NSLayoutConstraint!
    
    @IBOutlet weak var DownArrowView: UIView!
    @IBOutlet weak var UpArrowLeft: UIView!
    
    @IBOutlet weak var UpArrowRight: UIView!
    @IBOutlet weak var titleDescLBL: UILabel!
    @IBOutlet weak var LeftMenuView: UIButton!
    @IBOutlet weak var RightMenuView: UIButton!
    var itemsArray = [String]()
    var descriptionsArray = [String]()
    var itemsCount = Int()
    var itemsArrayTemp = [String]()
    
    @IBOutlet weak var descriptionLBL: UILabel!
    //var HowToSteps = Int()
    
    @IBOutlet weak var moneyView2: UIView!
    @IBOutlet weak var refreshView: UIButton!
    @IBOutlet weak var centerUserView: UIButton!
    @IBOutlet weak var moneyBagView: UIView!
    @IBOutlet weak var stealthView: UIView!
    
    
    @IBOutlet weak var moneyView: UIView!
    
    @IBOutlet weak var newsViewBTN: UIView!
    @IBOutlet weak var xpNumView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var hideBTN: UIButton!
    
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var shieldView: UIView!
    @IBOutlet weak var weaponView: UIView!
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var diamondView: UIView!
    @IBOutlet weak var healthView: UIView!
    @IBOutlet weak var healthProgress: VerticalProgressView!
    @IBOutlet weak var staminaView: UIView!
    @IBOutlet weak var staminaProgress: VerticalProgressView!
    @IBOutlet weak var mapMenuView: UIView!
    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var flashLightView: UIView!
    @IBOutlet weak var xpView: UIView!
  
    @IBOutlet weak var BGView: UIView!
    var healthprogressNum = Float()
    var staminaprogressNum = Float()
    
    var username = NSString()
    var email = NSString()
    var item = String()
    
    var theViewToPulse = UIView()
   
    var prefs:UserDefaults = UserDefaults.standard
    //var isHidden = Bool()
   
    
    var titleText: String! {
        didSet {
          //  titleLBL.text = titleText
        }
        
    }
    

    
    
    override func awakeFromNib() {
        
        DownArrowView.isHidden = true
        UpArrowLeft.isHidden = true
        UpArrowRight.isHidden = true
        xpView.isHidden = true
        titleDescLBL.isHidden = true
        
        healthView.isHidden = true
        missionView.layer.cornerRadius = 5
        missionView.layer.masksToBounds = true
        missionView.clipsToBounds = true
        missionView.layer.borderWidth = 1
        missionView.layer.borderColor = UIColor.black.cgColor
        
        weaponView.layer.cornerRadius = 5
        weaponView.layer.masksToBounds = true
        weaponView.clipsToBounds = true
        weaponView.layer.borderWidth = 1
        weaponView.layer.borderColor = UIColor.black.cgColor
        
        shieldView.layer.cornerRadius = 5
        shieldView.layer.masksToBounds = true
        shieldView.clipsToBounds = true
        shieldView.layer.borderWidth = 1
        shieldView.layer.borderColor = UIColor.black.cgColor
        
        diamondView.layer.cornerRadius = 5
        diamondView.layer.masksToBounds = true
        diamondView.clipsToBounds = true
        diamondView.layer.borderWidth = 1
        diamondView.layer.borderColor = UIColor.black.cgColor
        
        newsViewBTN.layer.cornerRadius = 5
        newsViewBTN.layer.masksToBounds = true
        newsViewBTN.clipsToBounds = true
        newsViewBTN.layer.borderWidth = 1
        newsViewBTN.layer.borderColor = UIColor.black.cgColor
        
        targetView.layer.cornerRadius = 5
        targetView.layer.masksToBounds = true
        targetView.clipsToBounds = true
        targetView.layer.borderWidth = 1
        targetView.layer.borderColor = UIColor.black.cgColor
        
        moneyView.layer.cornerRadius = 5
        moneyView.layer.masksToBounds = true
        moneyView.clipsToBounds = true
        moneyView.layer.borderWidth = 1
        moneyView.layer.borderColor = UIColor.black.cgColor
        
        xpNumView.layer.cornerRadius = 15
        xpNumView.layer.masksToBounds = true
        xpNumView.clipsToBounds = true
        xpNumView.layer.borderWidth = 1
        xpNumView.layer.borderColor = UIColor.white.cgColor
        
        flashLightView.layer.cornerRadius = 5
        flashLightView.layer.masksToBounds = true
        flashLightView.clipsToBounds = true
        flashLightView.layer.borderWidth = 1
        flashLightView.layer.borderColor = UIColor.black.cgColor
        
        // print("AWAKE FROM NIB PIN TYPE: \(self.PinType)")
        
 
        
        //STAMINA USED...NEED TO CHANGE AS IT SHOULD BASED UPON ATTACK

        
        
        /*
        BGView.layer.cornerRadius = 10
        BGView.clipsToBounds = true
        BGView.layer.masksToBounds = true
        BGView.layer.borderWidth = 1
        BGView.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
        */

        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        
        
        
        
        // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        

        
        /*
        if let attackUserHealthTemp = Double(attackUserHealth) {
            let UserHealthProgress = attackUserHealthTemp / 100
            print("ENEMY USER HEALTH = \(UserHealthProgress.description)")
        }
        */
        
        
        
        
        healthprogressNum = 0.8
        //  healthprogress = Float(UserHealthProgress)
        
        //  self.healthProgressView.setProgress(healthprogress, animated: true)
        self.healthProgress.progress = healthprogressNum
        
        /*
        DispatchQueue.main.async(execute: {
            
            if self.healthprogress > 0.5 {
                self.healthLBL.text = (self.healthprogress * 100).description
                self.healthLBL.textColor = UIColor.white
                self.healthProgressView.fillDoneColor = UIColor.green
            } else {
                self.healthLBL.text = (self.healthprogress * 100).description
                self.healthLBL.textColor = UIColor.darkGray
                if self.healthprogress < 0.3 {
                    self.healthProgressView.fillDoneColor = UIColor.red
                } else {
                    self.healthProgressView.fillDoneColor = UIColor.orange
                }
            }
            
        })
        
        */
        
        
        /*
        self.healthView.layer.borderColor = UIColor.darkGray.cgColor
        self.healthView.layer.borderWidth = 1
        self.healthView.fillDoneColor = UIColor.red
        self.healthView.filledView?.backgroundColor = UIColor.white.cgColor
        self.healthView.layer.cornerRadius = 5
        
        self.staminaView.layer.borderColor = UIColor.darkGray.cgColor
        self.staminaView.layer.borderWidth = 1
        self.staminaView.fillDoneColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        self.staminaView.filledView?.backgroundColor = UIColor.white.cgColor
        self.staminaView.layer.cornerRadius = 5
        */
        
        hideBTN.layer.borderWidth = 1
        hideBTN.layer.borderColor = UIColor.white.cgColor
        hideBTN.layer.cornerRadius = 40
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
        
        
        let title = "Training 101"
        let message = "Training: First you'll need to get familiar with the map and the tools you'll be using."
        let reference = ""
        
        DispatchQueue.main.async(execute: {
            let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
            view.tag = 1000
            self.addSubview(view)
        })
        
        
        
    }
    
    //  override func awake
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        self.titleDescLBL.layer.cornerRadius = 60
        self.titleDescLBL.layer.masksToBounds = true
        self.titleDescLBL.clipsToBounds = true
        self.titleDescLBL.layer.borderWidth = 2
        self.titleDescLBL.layer.borderColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0).cgColor
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.7
        })
        
       // pulseView(theView: theViewToPulse)
        
      //  pulseView(theView: theViewToPulse)
        
        
       // shakeView(theViewToPulse, repeatCount: 5)
        
        itemsArrayTemp = itemsArray
        
        DownArrowCenter.constant = -130
        
       // self.frame = CGRect(x: -75, y: -145, width: 200, height: 150)
        
      
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        
        
        
        if itemsCount < 1 {
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.0
            self.isHidden = true
        })
        
        } else {
            
            
            switch itemsCount {
            case 19:
                
                theViewToPulse = DownArrowView
                titleDescLBL.isHidden = false
                DownArrowView.isHidden = false
                UpArrowLeft.isHidden = true
                UpArrowRight.isHidden = true
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "The Map"
                descriptionLBL.text = "This is where you are now, but tap the button below any time to come back to the map"
                
               
                
            case 18:
                
                theViewToPulse = DownArrowView
                DownArrowView.isHidden = false
                UpArrowLeft.isHidden = true
                UpArrowRight.isHidden = true
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Agent View"
                descriptionLBL.text = "To view and update your agent tap here (more coming soon)"
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    self.DownArrowView.center.x = self.DownArrowView.center.x + 130
                    self.DownArrowCenter.constant = 0
                    
                    
                }, completion: { (Bool) -> Void in
                })
                
            case 17:
                
                theViewToPulse = DownArrowView
                DownArrowView.isHidden = false
                UpArrowLeft.isHidden = true
                UpArrowRight.isHidden = true
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "My Team"
                descriptionLBL.text = "Tap here to access your team information.  You can also create and joint a team here."
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                 
                    self.DownArrowView.center.x = self.DownArrowView.center.x + 130
                    self.DownArrowCenter.constant = 130
                   
                    
                }, completion: { (Bool) -> Void in
                })
            case 16:
                theViewToPulse = UpArrowLeft
                DownArrowView.isHidden = true
                UpArrowLeft.isHidden = false
                UpArrowRight.isHidden = true
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Message Menu"
                descriptionLBL.text = "Tap to access the messenger, where you can send messages to your team and message other players"
            case 15:
                theViewToPulse = UpArrowRight
                UpArrowRight.isHidden = false
                UpArrowLeft.isHidden = true
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Right Menu"
                descriptionLBL.text = "Tap to view other menu options including settings and setting up your home base"
            case 14:
                theViewToPulse = healthView
                UpArrowRight.isHidden = true
                healthView.isHidden = false
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Health Meter"
                descriptionLBL.text = "Your players current health...you might want to watch this one"
            case 13:
                theViewToPulse = staminaView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = false
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Stamina Meter"
                descriptionLBL.text = "Attacks and other activites can make you tired, keep this high for maximum effectivness"
            case 12:
                theViewToPulse = flashLightView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = false
                mapMenuView.isHidden = false
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Flashlight"
                descriptionLBL.text = "At night your map gets dark, this will help you see better"
            case 11:
                theViewToPulse = xpNumView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = false
                shieldView.isHidden = true
                xpView.isHidden = false
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Player Level"
                descriptionLBL.text = "Gain Experience Points to level up your player.  With each level comes new items, including new missions.  To join a team you'll need to reach level 3"
            case 10:
                theViewToPulse = newsView
                healthView.isHidden = true
                newsView.isHidden = false
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "News"
                descriptionLBL.text = "Stay up to date on new content"
            case 9:
                theViewToPulse = targetView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = false
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Targets"
                descriptionLBL.text = "Here you can find a list of your current targets."
                
            case 8:
                theViewToPulse = missionView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = false
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Missions"
                descriptionLBL.text = "Check out your current missions.  Complete missions to obtain new weapons, Experience Points, and Level up your Agent"
            case 7:
                theViewToPulse = weaponView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = false
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Weapons"
                descriptionLBL.text = "Access your weapons here.  Weapons can be found everywhere, stay alert.  Switching weapons can improve you range of view"
            case 6:
                theViewToPulse = shieldView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = false
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Armor"
                descriptionLBL.text = "In order to protect yourself it would be wise to locate some Armor.  Here you can access those items"
            case 5:
                theViewToPulse = diamondView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = false
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Diamonds"
                descriptionLBL.text = "Diamonds are helpful to upgrade your player and other items you obtain"
                
            case 4:
                theViewToPulse = refreshView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = false
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = false
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Refresh Map"
                descriptionLBL.text = "Tap here anytime to refresh the view of the map"
            case 3:
                theViewToPulse = centerUserView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = true
                shieldView.isHidden = true
                mapMenuView.isHidden = false
                moneyView.isHidden = true
                xpView.isHidden = true
                centerUserView.isHidden = false
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Center Location"
                descriptionLBL.text = "Tap here to center the map on your current location"
            case 2:
                theViewToPulse = moneyBagView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = false
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = true
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = false
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Coin Purse"
                descriptionLBL.text = "Carry some money with you, you can deposit and withdraw money at your Home location when nearby"
            case 1:
                theViewToPulse = moneyView
                healthView.isHidden = true
                newsView.isHidden = true
                weaponView.isHidden = true
                staminaView.isHidden = true
                targetView.isHidden = true
                diamondView.isHidden = true
                missionView.isHidden = true
                flashLightView.isHidden = true
                mapMenuView.isHidden = false
                shieldView.isHidden = true
                xpView.isHidden = true
                moneyView.isHidden = false
                centerUserView.isHidden = true
                refreshView.isHidden = true
                moneyBagView.isHidden = true
                stealthView.isHidden = true
                moneyView2.isHidden = true
                titleDescLBL.text = "Money Generator"
                descriptionLBL.text = "You are constantly earning money, tap here to collect it and move to your Coin Purse."
                
            default:
                break
            }
            
            itemsCount -= 1
           
            pulseView(theView: theViewToPulse)
            shakeView(theViewToPulse, repeatCount: 5)
            
            
            
        }
        
        
        //self.removeFromSuperview()
    }
    

    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    
    
    
    class func setTitle(_ title: String) {
        //titleLBL.text = title
    }
    
    
    // class func instanceFromNib(title: String, itemImage: UIImage) -> ItemAnnotationView
    
    
    
    class func instanceFromNib(_ title: String, item: String, description: String, itemsArray: [String], descriptionsArray: [String], itemsCount: Int) -> HowToView {
        // class func instanceFromNib(title: String) -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = HowToView()
        // var itemTitle: String!
        // itemTitle = title
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        //  Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        Nib = UINib(nibName: "HowToView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HowToView

        Nib.item = item
        Nib.itemsArray = itemsArray
        Nib.descriptionsArray = descriptionsArray
        Nib.itemsCount = itemsCount
        switch item {
            
            case "mission":
            Nib.theViewToPulse = Nib.missionView
                
            Nib.healthView.isHidden = true
            Nib.newsView.isHidden = true
            Nib.weaponView.isHidden = true
            Nib.staminaView.isHidden = true
            Nib.targetView.isHidden = true
            Nib.diamondView.isHidden = true
            Nib.missionView.isHidden = false
            Nib.flashLightView.isHidden = true
            Nib.mapMenuView.isHidden = true
            Nib.shieldView.isHidden = true
            
            case "health":
            
            Nib.theViewToPulse = Nib.healthView
            
            //Nib.healthView.isHidden = false
            Nib.newsView.isHidden = true
            Nib.weaponView.isHidden = true
            Nib.staminaView.isHidden = true
            Nib.targetView.isHidden = true
            Nib.diamondView.isHidden = true
            Nib.missionView.isHidden = true
            Nib.flashLightView.isHidden = true
            Nib.mapMenuView.isHidden = true
            Nib.shieldView.isHidden = true
            
        case "stamina":
            
            Nib.theViewToPulse = Nib.healthView
            
            Nib.healthView.isHidden = true
            Nib.newsView.isHidden = true
            Nib.weaponView.isHidden = true
            Nib.staminaView.isHidden = false
            Nib.targetView.isHidden = true
            Nib.diamondView.isHidden = true
            Nib.missionView.isHidden = true
            Nib.flashLightView.isHidden = true
            Nib.mapMenuView.isHidden = true
            Nib.shieldView.isHidden = true
            
            
        default:
            break
            
        }
        
        Nib.BGView.alpha = 0.0
        /*
        if Nib.attackUserHealth != "NA" {
            let attackUserHealthTemp = Double(Nib.attackUserHealth)!
            
            
            Nib.healthLBL.text = attackUserHealth
            let UserHealthProgress = attackUserHealthTemp / 100
            print("FROM INSTANCE - ENEMY USER HEALTH = \(UserHealthProgress.description)")
            // healthprogress = 0.8
            Nib.healthprogress = Float(UserHealthProgress)
            Nib.staminaprogress = 1.0
            
            Nib.staminaProgressView.setProgress(Nib.staminaprogress, animated: true)
            //  self.healthProgressView.setProgress(healthprogress, animated: true)
            // dispatch_async(dispatch_get_main_queue(), {
            Nib.healthProgressView.setProgress(Nib.healthprogress, animated: true)
            
        }
        */
        
  /*
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
        // print("My current location = \(mylocnow)")
        
        var itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
        
        //  print("Item location = \(itemLocation)")
        
        var distance = mylocnow.distance(from: itemLocation)
        //  print("start nib distance: \(distance)")
        var miles = distance / 1609.34
        //   print("start nib miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            
            
            if (dist < 1) {
                // distanceLBL.text = ("Distance: \(dist.description) Foot")
                //    print("foot: \(distance)")
                Nib.distanceLBL.text = "\(dist.description) foot"
                CanPickUp = true
                Nib.CanPickUp = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanPickUp = true
                    Nib.CanPickUp = true
                    Nib.distanceLBL.text = "\(dist.description) feet"
                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
            if dist < 1 {
                Nib.distanceLBL.text = "\(dist.description) mile"
                
            } else {
                Nib.distanceLBL.text = "\(dist.description) miles"
                
            }
            // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
        //Nib.distanceLBL.text = "Unknown distance"
        
        Nib.itemDistance = dist
        
        */
        
        
        // Nib.titleLBL.text = title
        //  self.setTitle(title)
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    
 
    
    
    /*
    func FocusOnMissionLocation(_ missionLat: Double, missionLong: Double) {
     
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocation(latitude: missionLat, longitude: missionLong).coordinate, 5000.0, 5000.0)
        
        missionMapView.setRegion(coordinateRegion, animated: true)
   
    }
    
    */
    

    
    
}




func shakeView(_ theView: UIView, repeatCount: Float){
    let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
    shake.duration = 0.1
    shake.repeatCount = repeatCount
    shake.autoreverses = true
    
    
    
    let from_point:CGPoint = CGPoint(x: theView.center.x - 3, y: theView.center.y)
    let from_value:NSValue = NSValue(cgPoint: from_point)
    
    let to_point:CGPoint = CGPoint(x: theView.center.x + 3, y: theView.center.y)
    let to_value:NSValue = NSValue(cgPoint: to_point)
    
    shake.fromValue = from_value
    shake.toValue = to_value
    theView.layer.add(shake, forKey: "position")
}

func pulseView(theView: UIView) {
    
    let animationDuration = 0.35
    
    UIView.animate(withDuration: animationDuration, animations: { () -> Void in
        
    }, completion: { (completion) -> Void in
        
        // self.GoldAmountLBLView.isHidden = false
        
        // theView.transform = theView.transform.scaledBy(x: 0.001, y: 0.001)
        
        theView.transform = theView.transform.scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            theView.transform = CGAffineTransform.identity
        })
        
        
    })
    
}


class MessageView: UIView {
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageLBL: UILabel!
    var title = String()
    var message = String()
    var reference = String()
    
    override func awakeFromNib() {
        
        
        
        /*
         BGView.layer.cornerRadius = 10
         BGView.clipsToBounds = true
         BGView.layer.masksToBounds = true
         BGView.layer.borderWidth = 1
         BGView.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
         */

        
        
        //        hideBTN.layer.borderWidth = 1
        //        hideBTN.layer.borderColor = UIColor.white.cgColor
        //        hideBTN.layer.cornerRadius = 30
        //        hideBTN.layer.masksToBounds = true
        //        hideBTN.clipsToBounds = true
        
        hideBTN.layer.borderWidth = 1
        hideBTN.layer.borderColor = UIColor.white.cgColor
        hideBTN.layer.cornerRadius = 15
        hideBTN.layer.masksToBounds = true
        hideBTN.clipsToBounds = true
        
    
        //messageView.layer.borderWidth = 1
        //messageView.layer.borderColor = UIColor.white.cgColor
        messageView.layer.cornerRadius = 5
        messageView.layer.masksToBounds = true
        messageView.clipsToBounds = true
        
        hideBTN.layer.shadowColor = UIColor.black.cgColor
        hideBTN.layer.shadowOpacity = 1
        hideBTN.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        hideBTN.layer.shadowRadius = 10
        
       
        
    }
    
    //  override func awake
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        self.messageLBL.text = message
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.7
        })
        
//        messageView.layer.shadowColor = UIColor.black.cgColor
//        messageView.layer.shadowOpacity = 1
//        messageView.layer.shadowOffset = CGSize.zero
//        messageView.layer.shadowRadius = 10
        
        
//        hideBTN.layer.shadowColor = UIColor.black.cgColor
//        hideBTN.layer.shadowOpacity = 1
//        hideBTN.layer.shadowOffset = CGSize.zero
//        hideBTN.layer.shadowRadius = 10
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
   
    @IBAction func hideBTN(_ sender: AnyObject) {
        
    

       // NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowNewMessageView"), object: nil, userInfo: ["ViewToPulse":"\(reference)"])
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"\(reference)"])
        
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.0
            self.isHidden = true
        })
        
        switch title {
            
            case "Code Name":
                print("title is Code Name")
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTextResponder"), object: nil, userInfo: nil)
            
            case "Agent ID":
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateThreeTextResponder"), object: nil, userInfo: nil)
            
            default:
            break
        }
        
        if title == "Code Name" {
            print("title is Code Name")
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTextResponder"), object: nil, userInfo: nil)
        }
        
       // self.removeFromSuperview()
    }
    
    class func instanceFromNib(title: String, message: String, reference: String) -> MessageView {

        let bounds = UIScreen.main.bounds
        var Nib = MessageView()
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        Nib = UINib(nibName: "MessageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MessageView
        
        Nib.title = title
        Nib.message = message
        
        // Nib.BGView.alpha = 0.0
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
}


