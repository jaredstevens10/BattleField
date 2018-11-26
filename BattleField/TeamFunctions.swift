//
//  TeamFunctions.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/16/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

//import Foundation
import Foundation



func GetNearbyTeams (_ username: NSString, latitude: Double, longitude: Double, radius: Int, altitude: Double) -> Data {
    
    
    var post:NSString = "username=\(username)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&altitude=\(altitude)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AllTeams.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    //var postLength:NSString = String( postData.count )
    let postLength:NSString = String( postData.count ) as NSString
    
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
            
                NSLog("TEAMS Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
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

func CreateNewTeam (_ username: NSString, email: NSString, teamName: NSString, teamlat: NSString, teamlong: NSString, mylat: NSString, mylong: NSString, myalt: NSString) -> Bool {
    
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var createSuccess = Bool()
    var base64Image = String()
    
    /*
    if ProfilePictureAdded {
        let image = self.ProfileImage.image
        
        let imageData = UIImageJPEGRepresentation(image!, 1.0)
        
        
        if MediaType == "gif" {
            
            base64Image = gifNSData.base64EncodedString(options: [])
            
        } else {
            
            base64Image = imageData!.base64EncodedString(options: [])
            
        }
        DoUpload = true
    }
    */
    
    // var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)&email=\(email)&token=\(TokenNew)&playerid=\(email)&privacy=no&setting=signup"
    
    var post_old:NSString = "username=\(username)&email=\(email)&teamname=\(teamName)&teamlat=\(teamlat)&teamlong=\(teamlong)&lat=\(mylat)&long=\(mylong)&setting=newteam&alt=\(myalt)" as NSString
    
    let post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/TeamCreate.php")!
    
    //var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
    var postLength:NSString = String(postData.count) as NSString
    
    var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    //var urlData = NSData()
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        reponseError = error
        urlData = nil
    }
    
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            let uniqueIDtemp: NSInteger = jsonData.value(forKey: "uniqueID") as! NSInteger
            let uniqueID = uniqueIDtemp.description
            //[jsonData[@"success"] integerValue];
            
            
            print("NEW PLAYER UNIQUE ID = \(uniqueID)")
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                prefs.set("\(teamName)", forKey: "MyTeamName")
                
                createSuccess = true
                NSLog("Sign Up SUCCESS");
                //  prefs.setBool(true, forKey: "ISLOGGEDIN")
                //prefs.setValue(username, forKey: "USERNAME")
                //prefs.setValue(email, forKey: "EMAIL")
                
                
                
                /*
                if MediaType == "gif" {
                    
                    // UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "gif")
                    
                } else {
                    
                    print("SHOULD UPLOAD IMAGE NOW")
                    print("BASE 64 DATA IS = \(base64Image)")
                    //  UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "image")
                }
                */
                
                DispatchQueue.main.async(execute: {
                    
                   // self.performSegue(withIdentifier: "backtostart", sender: self)
                    // self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                
            } else {
                
                createSuccess = false
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                /*
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed!"
                alertView.message = error_msg as String
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                // alertView.show()
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error!"
                    alertView.message = "\(error_msg)"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                    /*
                     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                     
                     */
                    
                })
                */
                
                
            }
            
        } else {
            createSuccess = false
            DispatchQueue.main.async(execute: {
                
                /*
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "The Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                */
                /*
                 SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                 
                 */
                
            })
        }
    }  else {
        createSuccess = false
        DispatchQueue.main.async(execute: {
            
            /*
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "Please check your internet connection"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            */
            /*
             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
             
             */
            
        })
    }
    
    return createSuccess
}

func CheckTeamName(_ email: String, teamName: String) -> Bool {
    
    var isOk = Bool()
    
    var post:NSString = "email=\(email)&teamname=\(teamName)&setting=checkName" as NSString
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/TeamCreate.php")!
    
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
    
    //var urlData = NSData()
    
    var urlData: Data?
    do {
        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    } catch let error as NSError {
        reponseError = error
        urlData = nil
    }
    
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
        //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //  let uniqueIDtemp: NSInteger = jsonData.valueForKey("uniqueID") as! NSInteger
            //  let uniqueID = uniqueIDtemp.description
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                isOk = true
                print("Team Name is available")
                
                
            } else {
                
                isOk = false
                
                /*
                 var error_msg:NSString
                 
                 if jsonData["error_message"] as? NSString != nil {
                 error_msg = jsonData["error_message"] as! NSString
                 } else {
                 error_msg = "Unknown Error"
                 }
                 var alertView:UIAlertView = UIAlertView()
                 alertView.title = "Sign Up Failed!"
                 alertView.message = error_msg as String
                 alertView.delegate = self
                 alertView.addButtonWithTitle("OK")
                 // alertView.show()
                 
                 dispatch_async(dispatch_get_main_queue(),{
                 
                 
                 SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                 
                 })
                 */
                
            }
            
        } else {
            /*
            DispatchQueue.main.async(execute: {
                /*
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Error!"
                alertView.message = "The Connection Failed"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                */
                /*
                 SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                 */
                
            })
            */
        }
    }  else {
        /*
        DispatchQueue.main.async(execute: {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error!"
            alertView.message = "Please check your internet connection"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            /*
             SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
             
             */
            
        })
        */
    }
    
    
    return isOk
}


func GetTeamInfo(_ email: NSString, level: NSString, status: NSString, category: NSString) -> Data {
    
    
    let post:NSString = "email=\(email)&level=\(level)&status=\(status)&category=\(category)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetTargets.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
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
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            // NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    return urlData
}

func ManageTeamMember(_ email: NSString, username: NSString, teamname: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, action: NSString, memberUsername: NSString, memberEmail: NSString, memberTitle: NSString) -> Bool {
    
    // username, email, teamname, category, action, membertitle, memberstatus, lat, long, memberusername, memberemail
    
    
    var Added = Bool()
    
    //updateAmmo, updateCount, updateLevel
    
    let post:NSString = "username=\(username)&email=\(email)&teamname=\(teamname)&lat=\(lat)&long=\(long)&action=\(action)&memberusername=\(memberUsername)&memberemail=\(memberEmail)&membertitle=\(memberTitle)&status=\(status)&category=members" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/ManageTargets.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
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
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //  NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                Added = true
                NSLog("Login SUCCESS");
                
            } else {
                
                Added = false
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            Added = false
        }
    } else {
        Added = false
        
    }
    
    return Added
}


func ManageTeamAdmins(_ email: NSString, username: NSString, teamname: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, action: NSString, memberUsername: NSString, memberEmail: NSString, memberTitle: NSString, memberID: NSString) -> Bool {
    
   // username, email, teamname, category, action, membertitle, memberstatus, lat, long, memberusername, memberemail
    
    
    var Added = Bool()
    
    //updateAmmo, updateCount, updateLevel
    
    let post:NSString = "username=\(username)&email=\(email)&teamname=\(teamname)&lat=\(lat)&long=\(long)&action=\(action)&memberusername=\(memberUsername)&memberemail=\(memberEmail)&memberID=\(memberID)&category=admins" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/ManageTargets.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
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
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            //  NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                Added = true
                NSLog("Login SUCCESS");
                
            } else {
                
                Added = false
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            Added = false
        }
    } else {
        Added = false
        
    }
    
    return Added
}

