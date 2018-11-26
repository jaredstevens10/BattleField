//
//  ActionButtons.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
extension MapViewController {
/*
    func AttackClicked3(sender: UIButton, name: NSString, health: NSString) {
    println("attack!")
    
        AttackClicked2(name, health
      
    }

    
    func StatsClicked3(sender: UIButton) {
        StatsClicked2(SelectedOpponentName, SelectedOppStealthStatus)
        
         }

*/

    func StatsClicked(_ user: NSString, stealth: NSString, sender: MKAnnotationView) {
    
    print("Stats View")
    
    SelectedOpponentName = user
        print("Selected Opp Name: \(SelectedOpponentName)")
    SelectedOppStealthStatus = stealth
    
        print("about to start segue")
        
    let oppstatsinfoController = storyboard?.instantiateViewController(withIdentifier: "OppStats") as! OppStatsViewController
        
        oppstatsinfoController.TheirName = SelectedOpponentName as String as String as NSString
        
        oppstatsinfoController.StealthStatus = SelectedOppStealthStatus
   // var sender = initializer
    
//    oppstatsinfoController.adelegate=self
    
    
    oppstatsinfoController.modalPresentationStyle = .popover
    if let popoverController = oppstatsinfoController.popoverPresentationController {
        popoverController.sourceView = sender as UIView
        
        popoverController.sourceRect = sender.bounds
        
        popoverController.permittedArrowDirections = .any
        popoverController.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.currentContext
        
        popoverController.delegate = self
    }
    present(oppstatsinfoController, animated: true, completion: nil)
    
   
    
 }
    
    
    func AttackClicked(_ user: NSString, health: NSString) {
        print("attack!")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Attack??", message: "Are you sure you want to Attack?", preferredStyle: .alert)
        
        print("YOU SURE ACTION BUTTONS")
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
            //Do some stuff
        }
     
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Attack!", style: .default) { action -> Void in
            
            self.AttackingPlayer = user
            self.AttackingPlayersHealth = health
            self.AttackStatus = "new"
            
            print("Attacking Player = \(self.AttackingPlayer)")
            
          self.performSegue(withIdentifier: "goto_attack", sender: self)
            
         
            
          /*
            let yesSuccess =  Attack(user, self.AttackPower)
            println("Attack Success = \(yesSuccess)")
            
            
            
            if yesSuccess{
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Attack Success!"
                alertView.message = "Nice Job!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            
            }
            //self.SubmitPic()
            */
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    func PickUpClicked(_ Myusername: NSString, itemName: NSString, itemLat: Double, itemLong: Double, itemType: NSString, itemCode: NSString, itemID: NSString, amount: String) {
        print("attack!")
        
        
        var email = NSString()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString) 
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }

        
        
        
        CanPickUp = false
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
        var itemLocation = CLLocation(latitude: itemLat,longitude: itemLong)
        
        var distance = mylocnow.distance(from: itemLocation)
          print("distance: \(distance)")
        var miles = distance / 1609.34
          print("miles: \(miles)")
        if (miles < 1) {
            dist = Double(round(1000*(miles * 5280))/1000)
            if (dist < 1) {
               // distanceLBL.text = ("Distance: \(dist.description) Foot")
                      print("foot: \(distance)")
                CanPickUp = true
            } else {
                //distanceLBL.text = ("Distance: \(dist.description) Feet")
                if (dist < 100) {
                    CanPickUp = true                }
            }
            
        } else {
            dist = Double(round(1000*miles)/1000)
           // distanceLBL.text = ("Distance: \(dist.description) Miles")
        }
        
        if CanPickUp {
            
        
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Pick Up item?", message: "Are you sure you want to pick up this item?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
          //  self.AttackingPlayer = user
         //   self.AttackingPlayersHealth = health
            
            print("Picking up Item = \(self.itemname)")
            
            //self.performSegueWithIdentifier("goto_attack", sender: self)
            
            if itemName == "Gold" {
                
                
                let PickUpSuccess =  PickUpGold(Myusername, id: itemID, amount: amount as NSString)
                print("Item Pick Up Success = \(PickUpSuccess)")
                
                
                
                if PickUpSuccess{
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success!"
                    alertView.message = "You Picked up the \(amount) coins"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                let PreviousGold = self.prefs.value(forKey: "GOLDAMOUNT") as! String
                    print("NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold)")
                  
                   NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMoney"), object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(amount)"])
                    
                    
                    backgroundThread(background: {
                        //self.GetPublicTurns()
                        print("BACKGROUND THREAD - Updating Users' Info")
                        
                        print("Saving Images now")
                        
                        
                        let UserInfoNSData = GetUserInfo(email)
                        
                        DispatchQueue.main.async(execute: {
                            print("Creating Local Inventory Data")
                            CreateLocalInventory(UserInfoNSData)
                            
                        })
                        
                        
                        }, completion: {
                            
                            DispatchQueue.main.async(execute: {
                                //self.GetMyHUD.removeFromSuperview()
                                //  self.tableView.reloadData()
                                print("DISPATCH ASYNC - Finished Getting User's Info")
                            })
                            // print("Done Getting Steal Turns")
                            //   self.kolodaView.resetCurrentCardNumber()
                    })
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            } else {
            
            
            let PickUpSuccess =  PickUpItem(Myusername, id: itemID)
            print("Item Pick Up Success = \(PickUpSuccess)")
            
            
            
            if PickUpSuccess{
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = "You Picked up the \(itemName)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
                
              }
            
            }
            //self.SubmitPic()
           NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
            
        } else  {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "You're not close enough!"
            alertView.message = "You need to get closer to pick up this item"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }
        
    }
   
}
