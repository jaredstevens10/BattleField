//
//  GameFunctions.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/5/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


func SaveUsersHealthStamina(_ type: String, level: Int, emailID: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "type=\(type)&amount=\(level.description)&email=\(emailID)" as NSString
    
    //&longitude=\(longitude)"
    
    
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/UpdateHealthStamina.php")!
    
    //print(url)
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    var postLength:NSString = String( postData.count ) as NSString
    
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    var urlData = Data()
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //   NSLog("Response code: %ld", res.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //   NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
                
                /*
                DeviceTKN = jsonData.valueForKey("token") as! NSString
                
                print("user's device token - \(DeviceTKN)")
                */
                
              //  AttackingSuccess(attackingName, fromuserID: attackingID, player: attackedName, playerID: attackedID, token: DeviceTKN, power: attackpower)
                
                return true
                //return true
                /*
                 var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                 prefs.setObject(username, forKey: "USERNAME")
                 prefs.setInteger(1, forKey: "ISLOGGEDIN")
                 prefs.synchronize()
                 
                 self.dismissViewControllerAnimated(true, completion: nil)
                 
                 */
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                /*
                 
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign in Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 alertView.show()
                 
                 */
                return false
            }
            
        } else {
            /*
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Sign in Failed!"
             alertView.message = "Connection Failed"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             */
            return false
            
        }
    } else {
        
        /*
         var alertView:UIAlertView = UIAlertView()
         alertView.title = "Sign in Failed!"
         alertView.message = "Connection Failure"
         
         if let error = reponseError {
         alertView.message = (error.localizedDescription)
         
         }
         
         
         alertView.delegate = self
         alertView.addButtonWithTitle("OK")
         alertView.show()
         
         */
        return false
    }
    
    return false
}


func CheckCurrentUpgradingStatus() -> Int {
    
    let prefs:UserDefaults = UserDefaults.standard
    var AllowedNumberToUpgrade = Int()
    var NumberItemsUpgrading: Int = 0
    
    let ItemsUpgradingArray = ["BootsUPGRADETIME","BodyUPGRADETIME","HelmetUPGRADETIME","ShieldUPGRADETIME","moneyBankUPGRADETIME"]
    
    AllowedNumberToUpgrade = prefs.integer(forKey: "ALLOWEDNUMBERTOUPGRADE")
    
    var moneyBankUpgradeTimeLeft = TimeInterval()
    var BootsUpgradeTimeLeft = TimeInterval()
    var BodyUpgradeTimeLeft = TimeInterval()
    var HelmetUpgradeTimeLeft = TimeInterval()
    var ShieldUpgradeTimeLeft = TimeInterval()
    
    

    for items in ItemsUpgradingArray {
        
        var timeInterval = TimeInterval()
        
        if UserDefaults.standard.value(forKey: items) != nil {
            print("\(items) IS being upgraded")
            NumberItemsUpgrading += 1
        } else {
            print("\(items) is NOT being upgraded")
        }
        
    }
    
    
    /*
    if prefs.valueForKey("moneyBankUPGRADETIME") != nil {
        moneyBankUpgradeTimeLeft = prefs.valueForKey("moneyBankUPGRADETIME") as! NSTimeInterval
    } else  {
        moneyBankUpgradeTimeLeft = 0
    }
    
    if moneyBankUpgradeTimeLeft > 0 {
        print("is upgrading money bank")
        NumberItemsUpgrading += 1
    } else {
        print("is NOT upgrading money bank")
    }
    
    */
    
    
    let AvailableUpgradeSpace = AllowedNumberToUpgrade - NumberItemsUpgrading
    
    print("Available upgrade space = \(AllowedNumberToUpgrade.description) - \(NumberItemsUpgrading.description) = \(AvailableUpgradeSpace.description)")
    
    
    return AvailableUpgradeSpace
}


/*
func GenerateM() {
    
    
    let item = "Boots"
    let upgradeCost = BootsUpgradeCost
    if !BootsUpgrading {
        
        
        if self.NumberItemsUpgrading >= self.AllowedNumberToUpgrade {
            
            var alertmessage = String()
            var alertTitle = String()
            if self.AllowedNumberToUpgrade > 1 {
                alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) item at a time"
                alertTitle = "Upgrade in Process"
            } else {
                alertmessage = "You can only upgrade \(self.AllowedNumberToUpgrade) items at a time"
                alertTitle = "Upgrades in Process"
            }
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "\(alertTitle)"
            alertView.message = "\(alertmessage)"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            
            
            
            if upgradeCost <= myGoldAmount {
                
                
                
                
                //NumberItemsUpgrading++
                UpgradeCertainItem(item, cost: upgradeCost)
                
            } else {
                
                let neededGold = upgradeCost - myGoldAmount
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Insufficient Gold"
                alertView.message = "You need to collect $\(neededGold) to upgrade."
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                
            }
        }
    }  else {
        
        let itemEndTime = prefs.valueForKey("\(item)EndUpgradeTime") as! NSTimeInterval
        let timeUntilComplete = itemEndTime - now
        print("Time Until Complete = \(timeUntilComplete)")
        
        let fullUpgradeTime = prefs.valueForKey("\(item)UPGRADETIME") as! NSTimeInterval
        
        let PercentComplete = (timeUntilComplete / fullUpgradeTime) as! Double
        
        print("Percent Complete = \(PercentComplete)")
        
        var costTemp = Double((upgradeCost * 2)) * PercentComplete
        
        
        var costTemp2 = round(costTemp)
        var cost = Int(costTemp2)
        
        UpgradeCertainItemNow(item, cost: cost)
    }
    
    
}
 
 */
