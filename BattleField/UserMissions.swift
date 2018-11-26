//
//  UserMissions.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/20/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//
//  UserTerritories.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/19/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


func GetServerMissionData (_ username: NSString, level: NSString) -> Data {
    
    var prefs:UserDefaults = UserDefaults.standard
    
    let appVersion = prefs.value(forKey: "APPVERSION")
    
    var post:NSString = "username=\(username)&level=\(level)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/RefreshMissionInfo.php")!
    
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
        
        //   NSLog("Response code: %ld", res.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
             // NSLog("Server Mission Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            //NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("SUCCESS getting Server Mission Data");
                
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


func MergeMissionInfoData(_ urlData: Data, CurrentMissionIDs: [NSString], email: NSString, lat: Double, long: Double, alt: Double) -> (Bool, Int) {
    
    //var ItemData = [MissionListInventory]()
    
   // var MyMissionsIDArray = [NSString]()
    
    var NewMissionCount: Int = 0
    
    var MissionsMerged = Bool()
    
    var traits = [NSString]()
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    var json = JSON(jsonData)
    
    
    
    for result in json["Data"].arrayValue {
        
        if ( result["id"] != "0") {
            
            let missionID = result["id"].stringValue
            let missionname = result["missionName"].stringValue
            let missionMapURL = result["missionMapURL"].stringValue
            let xp = result["xp"].stringValue
            let objective = result["objective"].stringValue
            let level = result["level"].stringValue
            let objectURL = result["objectURL"].stringValue
            let category = result["category"].stringValue
            let categoryTitle = result["categoryTitle"].stringValue
            
            let missionIDtemp = missionID as! NSString
            
            
            // if uniqueitem == "yes" {
            
           // ItemData.append(MissionListInventory(name: missionname, mapURL: missionMapURL, level: level, objectURL: objectURL, objective: objective, xp: xp))
            
            //  }
            
            //  if uniqueitem == "yes" {
            
            if !CurrentMissionIDs.contains(missionIDtemp) {
                
              //  print("I DO NOT HAVE MISSION: \(missionname) SAVED TO MY PERSONAL MISSIONS")
                
                NewMissionCount += 1
            
                //let idTemp: NSString = self.TargetUserID as NSString
                
                
                //  print("Adding Target at Lat: \(latTemp) Long: \(longTemp)")
                
              let MissionLat = lat.description
              let MissionLong = long.description
              let MissionAlt = alt.description
              let MissionStatus = "incomplete"
            
                //UPDATE: NEED TO ADJUST MISSION RADIUS BASED ON LEVEL ETC
              let radius = "0.05"
                
                let AddMissionStatus = AddMission(email, id: missionID as NSString, lat: MissionLat as NSString, long: MissionLong as NSString, level: level as NSString, status: MissionStatus as NSString, objective: objective as NSString, xp: xp as NSString, action: "add", missionname: missionname as NSString, missionImageName: missionMapURL as NSString, radius: radius as NSString, category: category as NSString, categorytitle: categoryTitle as NSString, alt: MissionAlt as NSString)
                    
              
              //  print("NEW MISSION ADDED ( \(missionID)  ) TO MY PERSONAL MISSIONS")
                
                
                //SaveNewMission(missionID, nametemp: missionname, mapurltemp: missionMapURL, xptemp: xp, objectivetemp: objective, leveltemp: level, objecturltemp: objectURL)
                
                //  }
                
                /*
                 if !TotalImagesArray.contains(imageURL) {
                 print("IMAGES: \(itemname) has not been saved yet, saving now")
                 
                 SaveNewImage(itemname, imageurltemp: imageURL, categorytemp: category)
                 }
                 */
                
            } else {
             //  print("I DO HAVE MISSION: \(missionname) SAVED TO MY PERSONAL MISSIONS")
            }
            
        }
        
    }
    
    // print("ItemData from Filter \(ItemData)")
    
    return (MissionsMerged, NewMissionCount)
}


func FilterMyMissionsData(_ urlData: Data) -> [NSString] {
    
    // print("Item Inventory before filter: \(ItemsInventoryArray)")
    
    
    var MyMissionIDs = [NSString]()
    var MyWeaponsInventoryArrayTemp = [MissionInfo]()
    
    
    
    
    var traits = [NSString]()
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    var json = JSON(jsonData)
    
    //println("Json value: \(jsonData)")
    
   // print("Json valueJSON: \(json)")
    
    for result in json["Data"].arrayValue {
        
        if ( result["id"] != "NA") {
            
            let missionIDtemp = result["id"].stringValue
            // print("ITEM NAME = \(itemName)")
            let latTemp = result["latitude"].stringValue
            let lat = Double(latTemp)
            
            let longTemp = result["longitude"].stringValue
            let long = Double(longTemp)
            
            
            let status = result["status"].stringValue
            let level = result["level"].stringValue
            let objective = result["objective"].stringValue
            let xp = result["xp"].stringValue
            //let itemID = "NA"
            
            var AddItem = Bool()
            
            let itemImageURL = "" //result["imageURL"].stringValue
            let missionID = missionIDtemp as! NSString
            
            MyMissionIDs.append(missionID)
            /*
            if self.ShowAllMissions {
                AddItem = true
            } else {
                if status == "incomplete" {
                    AddItem = true
                } else {
                    AddItem = false
                }
                
            }
            
            if AddItem {
                
                MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                
            }
            */
            
        }
        
    }
    
    
    return MyMissionIDs
}

func GetMission(_ email: NSString, level: NSString, status: NSString) -> Data {
    
    
    let post:NSString = "email=\(email)&level=\(level)&status=\(status)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    // NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetMissions.php")!
    
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
            
            //NSLog("Get Missions Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            // NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                //  NSLog("Get MISSIONS SUCCESS");
                
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

func GetNews(_ email: NSString) -> Data {
    
    
  //  let post:NSString = "email=\(email)&level=\(level)&status=\(status)" as NSString
    let post:NSString = "email=\(email)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetNews.php")!
    
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
            
            //NSLog("Get News Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
           // NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Get MISSIONS SUCCESS");
                
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

func AddMission(_ email: NSString, id: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, objective: NSString, xp: NSString, action: NSString, missionname: NSString, missionImageName: NSString, radius: NSString, category: NSString, categorytitle: NSString, alt: NSString) -> Bool {
    
    
    var Added = Bool()
    
    //updateAmmo, updateCount, updateLevel
    
    let post_old:NSString = "email=\(email)&missionID=\(id)&lat=\(lat)&long=\(long)&level=\(level)&status=\(status)&objective=\(objective)&xp=\(xp)&action=\(action)&missionname=\(missionname)&imagename=\(missionImageName)&radius=\(radius)&category=\(category)&categorytitle=\(categorytitle)&alt=\(alt)" as NSString
    
    let post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("Add Mission PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/ManageMissions.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
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
        
    ///   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Add Mission Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                Added = true
                NSLog("Add Mission SUCCESS");
                
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

func DeleteMission(_ email: NSString, itemName: NSString, itemURL: NSString, itemURL100: NSString, category: NSString, count: NSString, ammoCount: NSString, level: NSString, action: NSString) -> Data {
    
    
    let post:NSString = "email=\(email)&missionID=\(itemName)&itemURL=\(itemURL)&itemURL100=\(itemURL100)&category=\(category)&count=\(count)&ammoCount=\(ammoCount)&level=\(level)&action=delete" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/ManageMissions.php")!
    
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
            
          //  NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
          //  NSLog("Success: %ld", success);
            
            if(success == 1)
            {
              //  NSLog("Login SUCCESS");
                
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

func UpdateMission(_ email: NSString, id: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, objective: NSString, xp: NSString, action: NSString, alt: NSString) -> Data {
    
    //updateAmmo, updateCount, updateLevel
    
    let post_old:NSString = "email=\(email)&missionID=\(id)&lat=\(lat)&long=\(long)&level=\(level)&status=\(status)&objective=\(objective)&xp=\(xp)&action=\(action)&alt=\(alt)" as NSString
    
    let post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/ManageMissions.php")!
    
    //let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
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
            
            NSLog("UPDATE MISSION Response ==> %@", responseData);
            
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



func GetTeamMission(_ email: NSString, level: NSString, status: NSString, teamName: NSString) -> Data {
    
    
    let post:NSString = "email=\(email)&level=\(level)&status=\(status)&teamname=\(teamName)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
   // NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetTeamMissions.php")!
    
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
            
            // NSLog("Success: %ld", success);
            
            if(success == 1)
            {
               // NSLog("Login SUCCESS");
                
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

func AddTeamMission(_ email: NSString, id: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, objective: NSString, xp: NSString, action: NSString, teamName: NSString, category: NSString, categorytitle: NSString, alt: NSString) -> Bool {
    
    
    var Added = Bool()
    
    //updateAmmo, updateCount, updateLevel
    
    let post:NSString = "email=\(email)&missionID=\(id)&lat=\(lat)&long=\(long)&level=\(level)&status=\(status)&objective=\(objective)&xp=\(xp)&action=\(action)&teamname=\(teamName)&category=\(category)&categorytitle=\(categorytitle)&alt=\(alt)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/TeamManageMissions.php")!
    
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

func DeleteTeamMission(_ email: NSString, itemName: NSString, itemURL: NSString, itemURL100: NSString, category: NSString, count: NSString, ammoCount: NSString, level: NSString, action: NSString, teamName: NSString) -> Data {
    
    
    let post:NSString = "email=\(email)&missionID=\(itemName)&itemURL=\(itemURL)&itemURL100=\(itemURL100)&category=\(category)&count=\(count)&ammoCount=\(ammoCount)&level=\(level)&teamname=\(teamName)&action=delete" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/TeamManageMissions.php")!
    
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
            
            //  NSLog("Response ==> %@", responseData);
            
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

func UpdateTeamMission(_ email: NSString, id: NSString, lat: NSString, long: NSString, level: NSString, status: NSString, objective: NSString, xp: NSString, action: NSString, alt: NSString) -> Data {
    
    //updateAmmo, updateCount, updateLevel
    
    let post:NSString = "email=\(email)&missionID=\(id)&lat=\(lat)&long=\(long)&level=\(level)&status=\(status)&objective=\(objective)&xp=\(xp)&action=\(action)&alt=\(alt)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/TeamManageMissions.php")!
    
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

