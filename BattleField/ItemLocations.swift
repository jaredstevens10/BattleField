//
//  ItemLocations.swift
//  BattleField
//
//  Created by Jared Stevens on 8/3/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation

//CheckForNearItems

func CheckForNearItems (_ username: NSString, latitude: Double, longitude: Double, radius: Int) -> Data {
    
    
    var post:NSString = "username=\(username)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/CheckForNearItems.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
   // var postLength:NSString = String(postData.count)
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
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            // NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
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
    }
    
    return urlData
}

func ItemLocations (_ username: NSString, latitude: Double, longitude: Double, radius: Int, altitude: Double) -> Data {
    
    
    var post:NSString = "username=\(username)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&altitude=\(altitude)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GameItemLocations.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String( postData.count )
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
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
           // NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary

            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
             //   NSLog("Login SUCCESS");
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
    }
    
    return urlData
}


func PickUpItem(_ username: NSString, id: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&itemID=\(id)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/PickUpItem.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
   // var postLength:NSString = String( postData.count )
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
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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

func DropItemNow(_ username: NSString, id: NSString, lat: String, long: String, alt: String) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&itemID=\(id)&lat=\(lat)&long=\(long)&alt=\(alt)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/DropItemNow.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
   // var postLength:NSString = String( postData.count )
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
        
   //     NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
       //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
             let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
           // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
          //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
         //   NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
                
              //SendAttackNotice(username, DeviceTKN, attackpower)
                
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


func PickUpGold(_ username: NSString, id: NSString, amount: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&itemID=\(id)&amount=\(amount)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/PickUpItem.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
   // var postLength:NSString = String( postData.count )
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
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
            //    NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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


func UpdateUserGold(_ username: NSString, email: NSString, amount: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&email=\(email)&goldamount=\(amount)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/UpdateUser.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String(postData.count)
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
        
   //     NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
             //   NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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

func UpdateUserPotions(_ username: NSString, email: NSString, amount: NSString, type: String, info: String) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&email=\(email)&potionamount=\(amount)&type=\(type)&info=\(info)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
  //
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/UpdateUser.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
   // var postLength:NSString = String(postData.count)
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
        
    //    NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
            //    NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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

func UpdateUserDiamonds(_ username: NSString, email: NSString, amount: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&email=\(email)&diamondsamount=\(amount)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/UpdateUser.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String( postData.count )
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
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
            //    NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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


func UpdateUserLevel(_ username: NSString, email: NSString, category: NSString, level: NSString) -> Bool {
    
    var AttackSuccess = Bool()
    
    var post:NSString = "username=\(username)&email=\(email)&category=\(category)&level=\(level)" as NSString
    
    //&longitude=\(longitude)"
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var DeviceTKN = NSString()
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/UpdateUser.php")!
    
    print(url)
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String(postData.count)
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
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //     NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            // DeviceTKN = jsonData.valueForKey("token") as! NSString
            
            //  println("user's device token - \(DeviceTKN)")
            
            
            
            
            
            
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
                
                //SendAttackNotice(username, DeviceTKN, attackpower)
                
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

func GetMyItems (_ username: NSString, category: NSString) -> Data {
    
    
    var post:NSString = "username=\(username)&category=\(category)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
 //   NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetMyItems.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String( postData.count )
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
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
           // NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
             //   NSLog("Login SUCCESS");
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
    }
    
    return urlData
}
