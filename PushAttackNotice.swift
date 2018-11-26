//
//  PushAttackNotice.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
func SendAttackNotice(_ fromuser: NSString, player: NSString, token: NSString, power: Int, type: NSString) -> Bool
{
    var playerNew = player.replacingOccurrences(of: "'", with: "")
    
    var tokenNew = token.replacingOccurrences(of: "'", with: "")
    
    var message = "hey what's up?"
    
     var urlData = Data()
    
    var post:NSString = "player=\(playerNew)&token=\(tokenNew)&attackpower=\(power)&attackfrom=\(fromuser)&alert=\(type)&message=\(message)" as NSString
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GamePush.php")!
    
    print("URL entered")
    
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
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
          let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
                //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                print("success in sending push alert")
                
                return true
                
                //prefs.setObject(username, forKey: "USERNAME")
                
                //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
                //   prefs.synchronize()
                
                //  prefs.setValue(Admin, forKey: "ADMIN")
                
                //   Email = jsonData.valueForKey("email") as! NSString
                
                //   prefs.setValue(Email, forKey: "EMAIL")
                
                //   prefs.setValue(username, forKey: "USERNAME")
                
                //   self.dismissViewControllerAnimated(true, completion: nil)
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
                //alertView.message = "Sign in Error"
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
    //return false
}

func AttackingSuccess(_ fromuser: NSString, fromuserID: NSString, player: NSString, playerID: NSString, token: NSString, power: Int) -> Bool
{
    var playerNew = player.replacingOccurrences(of: "'", with: "")
    
    var tokenNew = token.replacingOccurrences(of: "'", with: "")
    
    var message = "ha ha I just attacked you"
    
    var post:NSString = "player=\(playerNew)&token=\(tokenNew)&attackpower=\(power)&attackfrom=\(fromuser)&alert=didAttack&message=\(message)" as NSString
    
    print("PostData: \(post)");
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GamePush.php")!
    
    print("URL entered")
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    var postLength:NSString = String( postData.count ) as NSString
    
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    var urlData = Data()
    
    var reponseError: NSError?
    var response: URLResponse?
    
       urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
       // NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
            print("Response Data: \(responseData)")
            
            var error: NSError?
            
                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
                //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                print("success in sending push alert")
                
                return true
                
                //prefs.setObject(username, forKey: "USERNAME")
                
                //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
                //   prefs.synchronize()
                
                //  prefs.setValue(Admin, forKey: "ADMIN")
                
                //   Email = jsonData.valueForKey("email") as! NSString
                
                //   prefs.setValue(Email, forKey: "EMAIL")
                
                //   prefs.setValue(username, forKey: "USERNAME")
                
                //   self.dismissViewControllerAnimated(true, completion: nil)
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
                //alertView.message = "Sign in Error"
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
    //return false
}

func handleAttackNotification(_ attackedBy: NSString) {
    
    var vc = UIViewController()
    
    vc = AllianceViewController()
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   //    appDelegate.window?.addSubview(vc.view)
    
    
    
    let actionSheetController: UIAlertController = UIAlertController(title: "You're Under Attack from \(attackedBy)!", message: "Choose how you will respond", preferredStyle: .alert)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "Run Away!", style: .default) { action -> Void in
        //Do some stuff
        print("You are running away, turn back and fight!")
    }
    
    //Create and an option action
    let nextAction: UIAlertAction = UIAlertAction(title: "Fight Back", style: .default) { action -> Void in
        
        print("You are staying to fight like a man!")
        
        
        
        
        
        
        
    }
    
    
    actionSheetController.addAction(nextAction)
    actionSheetController.addAction(cancelAction)
    //    [self.window addSubview:self.rootViewController.view];
    //    [self.window makeKeyAndVisible];
    
  //  self.window?.rootViewController?.presentViewController(actionSheetController, animated: true, completion: nil)
    
    appDelegate.window?.rootViewController?.present(actionSheetController, animated: true, completion: nil)
    

    
}



//TEST TEST TEST: SESSION DATA TASK

//class AttackUpdates {
//
//    class func UpdateResponseAttack(_ email: String, attackingID: String, response: String, action: String, completion: ((_ result: Bool, _ attackResponse: String) -> Void)!)
//{
//    //let priority = DispatchQueue.GlobalQueuePriority.default
//    
//    var attackResponse: String = "none"
//    var UpdateComplete = Bool()
//    
//    var post:NSString = "email=\(email)&attackingID=\(attackingID)&response=\(response)&action=\(action)" as NSString
//    
//    // var post:NSString = "attackingID=\(playerNew)&response=\(response)&token=\(tokenNew)&attackpower=\(power)&attackfrom=\(fromuser)&alert=didAttack&message=\(message)" as NSString
//    
//    print("PostData: \(post)");
//    
//    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackResponseUpdate.php")!
//    
//    //print("URL entered")
//    
//    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
//    
//    var postLength:NSString = String( postData.count ) as NSString
//    
//    
////    let d = "4"
////    let data = "x=4&y=\(d)"
////    request.httpBody = data.data(using: String.Encoding.ascii)
//    
//    let session = URLSession.shared
//    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
//    
//    // let request = NSMutableURLRequest(URL: NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackResponseUpdate.php")!)
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//   
//    request.httpMethod = "POST"
//    request.httpBody = postData
//
//    
//    let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//        if let error = error {
//            print(error)
//            
//            UpdateComplete = false
//           // return (false, attackResponse)
//        }
//        if let data = data{
//            print("data =\(data)")
//        }
//        if let response = response {
//            print("url = \(response.url!)")
//            print("response = \(response)")
//            let httpResponse = response as! HTTPURLResponse
//            print("response code = \(httpResponse.statusCode)")
//            
//            
//            
//            
//            var responseData:NSString  = NSString(data:data!, encoding:String.Encoding.utf8.rawValue)!
//            
//            print("Response Data: \(responseData)")
//            //if you response is json do the following
//            do{
//                //let resultJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
// 
//                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
//                
//                
//                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
//
//                NSLog("Success: %ld", success);
//                
//                if(success == 1)
//                {
//                    NSLog("Login SUCCESS");
//                    
//                    attackResponse = jsonData.value(forKey: "response") as! String
//                    
//                    UpdateComplete = true
//                    
//                   
////                    DispatchQueue.global(priority, 0).asynchronously() {
////                        DispatchQueue.maindispatch_get_main_queue().asynchronously() {
//                           completion(result: true, attackResponse: attackResponse)
////                        }
////                    }
//                    
//                   // completion(true, attackResponse)
//                    
//                   // return
//                    //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                    
//                   // return (true, attackResponse)
//                    
//                } else {
//                    var error_msg:NSString
//                    
//                    
//                    if jsonData["error_message"] as? NSString != nil {
//                        error_msg = jsonData["error_message"] as! NSString
//                    } else {
//                        error_msg = "Unknown Error"
//                    }
//                    
//                    UpdateComplete = false
////                    DispatchQueue.global(priority, 0).asynchronously() {
////                        DispatchQueue.maindispatch_get_main_queue().asynchronously() {
//                            completion(result: false, attackResponse: "error")
////                        }
////                    }
//                    
//                 //   completion(false, attackResponse)
//                    
//                }
//                
//                
//                //FOR JSON RETURN
////                let arrayJSON = resultJSON as! NSArray
////                
////                for value in arrayJSON{
////                    let dicValue = value as! NSDictionary
////                    for (key, value) in dicValue {
////                        print("key = \(key)")
////                        print("value = \(value)")
////                    }
////                }
//                
//            }catch _{
//                print("Received not-well-formatted JSON")
//                
//                UpdateComplete = false
////                DispatchQueue.global(priority, 0).asynchronously() {
////                    DispatchQueue.maindispatch_get_main_queue().asynchronously() {
//                        completion(result: false, attackResponse: "error")
////                    }
////                }
//               // completion(false, attackResponse)
//            }
//        }
//    })
//    task.resume()
//    
//   // return (UpdateComplete, attackResponse)
//}
//
//
//}

    
    func UpdateResponseAttack(_ email: String, attackingID: String, response: String, action: String, completion: @escaping (_ result: Bool, _ attackResponse: String) -> ())
    {
        //let priority = DispatchQueue.GlobalQueuePriority.default
        
        var attackResponse: String = "none"
        var UpdateComplete = Bool()
        
        var post:NSString = "email=\(email)&attackingID=\(attackingID)&response=\(response)&action=\(action)" as NSString
        
        // var post:NSString = "attackingID=\(playerNew)&response=\(response)&token=\(tokenNew)&attackpower=\(power)&attackfrom=\(fromuser)&alert=didAttack&message=\(message)" as NSString
        
       // print("PostData: \(post)");
        
        var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackResponseUpdate.php")!
        
        //print("URL entered")
        
        var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
        
        var postLength:NSString = String( postData.count ) as NSString
        
        
        //    let d = "4"
        //    let data = "x=4&y=\(d)"
        //    request.httpBody = data.data(using: String.Encoding.ascii)
        
        let session = URLSession.shared
        var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
        
        // let request = NSMutableURLRequest(URL: NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackResponseUpdate.php")!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if let error = error {
              //  print(error)
                
                UpdateComplete = false
                // return (false, attackResponse)
            }
            if let data = data{
              //  print("data =\(data)")
            }
            if let response = response {
              //  print("url = \(response.url!)")
              //  print("response = \(response)")
                let httpResponse = response as! HTTPURLResponse
              //  print("response code = \(httpResponse.statusCode)")
                
                
                
                
                var responseData:NSString  = NSString(data:data!, encoding:String.Encoding.utf8.rawValue)!
                
              //  print("Response Data: \(responseData)")
                //if you response is json do the following
                do{
                    //let resultJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                //    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                     //   NSLog("Login SUCCESS");
                        
                        attackResponse = jsonData.value(forKey: "response") as! String
                        
                        UpdateComplete = true
                        
                        
                        //                    DispatchQueue.global(priority, 0).asynchronously() {
                        //                        DispatchQueue.maindispatch_get_main_queue().asynchronously() {
                        completion(true, attackResponse)
                        //                        }
                        //                    }
                        
                        // completion(true, attackResponse)
                        
                        // return
                        //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        
                        // return (true, attackResponse)
                        
                    } else {
                        var error_msg:NSString
                        
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        UpdateComplete = false
                        //                    DispatchQueue.global(priority, 0).asynchronously() {
                        //                        DispatchQueue.maindispatch_get_main_queue().asynchronously() {
                       // completion(result: false, attackResponse: "error")
                        //                        }
                        //                    }
                        
                           completion(false, attackResponse)
                        
                    }
                    
                    
                    //FOR JSON RETURN
                    //                let arrayJSON = resultJSON as! NSArray
                    //
                    //                for value in arrayJSON{
                    //                    let dicValue = value as! NSDictionary
                    //                    for (key, value) in dicValue {
                    //                        print("key = \(key)")
                    //                        print("value = \(value)")
                    //                    }
                    //                }
                    
                }catch _{
                 //   print("Received not-well-formatted JSON")
                    
                    UpdateComplete = false
                    //                DispatchQueue.global(priority, 0).asynchronously() {
                    //                    DispatchQueue.maindispatch_get_main_queue().asynchronously() {
                    //completion(result: false, attackResponse: "error")
                    //                    }
                    //                }
                     completion(false, attackResponse)
                }
            }
        })
        task.resume()
        
        // return (UpdateComplete, attackResponse)
    }
    
    


func UpdateAttackResponse(_ email: String, attackingID: String, response: String, action: String) -> (Bool, String)
{
   // var playerNew = player.replacingOccurrences(of: "'", with: "")
    
   // var tokenNew = token.replacingOccurrences(of: "'", with: "")
    
   // var message = "ha ha I just attacked you"
    
    var attackResponse: String = "none"
    
    var post:NSString = "email=\(email)&attackingID=\(attackingID)&response=\(response)&action=\(action)" as NSString
    
   // var post:NSString = "attackingID=\(playerNew)&response=\(response)&token=\(tokenNew)&attackpower=\(power)&attackfrom=\(fromuser)&alert=didAttack&message=\(message)" as NSString
    
   // print("PostData: \(post)");
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AttackResponseUpdate.php")!
    
    print("URL entered")
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    var postLength:NSString = String( postData.count ) as NSString
    
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    var urlData = Data()
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        // NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //NSLog("Response ==> %@", responseData);
            
         //   print("Response Data: \(responseData)")
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
         //   NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            
            if(success == 1)
            {
            //    NSLog("Login SUCCESS");
                
                attackResponse = jsonData.value(forKey: "response") as! String
                
                //    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                
                return (true, attackResponse)
             
            } else {
                var error_msg:NSString
                
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
          
                return (false, attackResponse)
                
            }
            
        } else {
       
            return (false, attackResponse)
        }
    } else {
     
        return (false, attackResponse)
    }
    //return false
}
