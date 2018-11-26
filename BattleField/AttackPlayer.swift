//
//  AttackPlayer.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation


func Attack(_ attackingName: NSString, attackingID: NSString, attackedName: NSString, attackedID: NSString, attackpower: Int) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(attackedName)&attackpower=\(attackpower)&attackedID=\(attackedID)" as NSString
    
    //&longitude=\(longitude)"
    
    
    
    //&password=\(password)"
    
    NSLog("Attack User PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackUser.php")!
    
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
            
            NSLog("Attack User Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
           
           
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
                
                DeviceTKN = jsonData.value(forKey: "token") as! NSString
                
                print("user's device token - \(DeviceTKN)")
                
                
                AttackingSuccess(attackingName, fromuserID: attackingID, player: attackedName, playerID: attackedID, token: DeviceTKN, power: attackpower)
                
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

func AttackNotice(_ fromuser: NSString, username: NSString, attackpower: Int, type: NSString, attackedID: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&attackpower=\(attackpower)&attackedID=\(attackedID)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackUser.php")!
    
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
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
                DeviceTKN = jsonData.value(forKey: "token") as! NSString
                
                print("user's device token - \(DeviceTKN)")

                
                
                SendAttackNotice(fromuser, player: username, token: DeviceTKN, power: attackpower, type: type)
                
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
