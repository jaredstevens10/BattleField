//
//  SaveLocation.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import UserNotificationsUI
import CoreLocation
import CoreData



@available(iOS 10.0, *)
extension UNNotificationAttachment {
    
    static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let imageFileIdentifier = identifier+".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            guard let imageData = image.pngData() else {
                return nil
            }
            try imageData.write(to: fileURL)
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print("error " + error.localizedDescription)
        }
        return nil
    }
}
//}



//func scheduleItemNotificationOLD(_ itemName: String, lat: Double, long: Double, imageName: String) {
//    
//    //setupNotificationSettings()
//    
//    var NotifyDate = Date()
//    var now: TimeInterval {
//        return Date().timeIntervalSinceReferenceDate
//    }
//    //let endTime = now + 10
//    let endTime = now
//    NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
//    
//    print("NotifyDate: \(NotifyDate)")
//    print("end time: \(endTime)")
//    
//    let localNotification = UILocalNotification()
//    
//    
//    localNotification.fireDate = NotifyDate
//    
//    
//    localNotification.regionTriggersOnce = true
//    localNotification.alertAction = "View Item"
//    localNotification.userInfo = ["ItemName":"\(itemName)","lat":"\(lat)","long":"\(long)"]
//    localNotification.alertBody = "Item Alert: \(itemName) nearby to pick up!"
//    //localNotification.category
//    localNotification.category = "itemReminderCategory"
//    //localNotification.
//   // prefs.setValue(itemID, forKey: "LASTNEARITEM")
//    print("SCHEDULING LOCAL NOTIFICATION: FROM scheduleItemNotification NOW")
//    UIApplication.shared.scheduleLocalNotification(localNotification)
//    
//    
//}


func scheduleItemNotification(_ itemName: String, lat: Double, long: Double, imageName: String) {
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
/*
    if #available(iOS 10.0, *) {
        let content = UNMutableNotificationContent()
        let requestIdentifier = "itemNotification"
        
        content.badge = 1
        content.title = "Item Alert"
        content.subtitle = "Item Alert: \(itemName) nearby to pick up!"
        //content.body = "Item Alert: \(itemName) nearby to pick up!"
        content.userInfo = ["ItemName":"\(itemName)","lat":"\(lat)","long":"\(long)"]
        content.categoryIdentifier = "itemReminderCategory"
        
        //content.sound = UNNotificationSound.default()
        //content.alert
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        let ItemImageTemp = UIImage(data: theImageData!)
        
        if let attachment = UNNotificationAttachment.create(identifier: requestIdentifier, image: ItemImageTemp!, options: nil) {
            // where myImage is any UIImage that follows the
            content.attachments = [attachment]
        }
        
        //content.image
        // If you want to attach any image to show in local notification
        // let url = Bundle.main.url(forResource: "itemName", withExtension: ".png")
//        do {
//            
//            //let attachmentNew = UNNotificationAttachment(
//            let attachment = try? UNNotificationAttachment(identifier: requestIdentifier, url: url, options: nil)
//            
//           // content.
//            content.attachments = [attachment!]
//        }
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            print("Notification Register Success")
        }

    } else {
        
 */
        // Fallback on earlier versions
        
        
        var NotifyDate = Date()
        var now: TimeInterval {
            return Date().timeIntervalSinceReferenceDate
        }
        let endTime = now + 10
        //let endTime = now
        NotifyDate = Date(timeIntervalSinceReferenceDate: endTime)
        
       // print("NotifyDate: \(NotifyDate)")
       // print("end time: \(endTime)")
        
        let localNotification = UILocalNotification()
        
        
        //localNotification.fireDate = NotifyDate
        
        
        localNotification.regionTriggersOnce = true
        localNotification.alertAction = "View Item"
        localNotification.userInfo = ["ItemName":"\(itemName)","lat":"\(lat)","long":"\(long)"]
        localNotification.alertBody = "Item Alert: \(itemName) nearby to pick up!"
        //localNotification.category
        localNotification.category = "itemReminderCategory"
        //localNotification.
        // prefs.setValue(itemID, forKey: "LASTNEARITEM")
        print("SCHEDULING LOCAL NOTIFICATION: FROM scheduleItemNotification NOW")
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
     // }
    }


func setupNotificationSettings() {
    let notificationSettings: UIUserNotificationSettings! = UIApplication.shared.currentUserNotificationSettings
    
    if (notificationSettings.types == UIUserNotificationType()){
        // Specify the notification types.
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound]
        
        
        // Specify the notification actions.
        let justInformAction = UIMutableUserNotificationAction()
        justInformAction.identifier = "justInform"
        justInformAction.title = "OK, got it"
        justInformAction.activationMode = UIUserNotificationActivationMode.background
        justInformAction.isDestructive = false
        justInformAction.isAuthenticationRequired = false
        
        let getItemAction = UIMutableUserNotificationAction()
        getItemAction.identifier = "GetItem"
        getItemAction.title = "View Item"
        getItemAction.activationMode = UIUserNotificationActivationMode.background
        getItemAction.isDestructive = true
        getItemAction.isAuthenticationRequired = false
        
        let trashAction = UIMutableUserNotificationAction()
        trashAction.identifier = "trashAction"
        trashAction.title = "Test Action"
        trashAction.activationMode = UIUserNotificationActivationMode.background
        trashAction.isDestructive = true
        trashAction.isAuthenticationRequired = true
        
        let actionsArray = NSArray(objects: justInformAction, getItemAction, trashAction)
        let actionsArrayMinimal = NSArray(objects: trashAction, getItemAction)
        
        // Specify the category related to the above actions.
        let itemReminderCategory = UIMutableUserNotificationCategory()
        itemReminderCategory.identifier = "itemReminderCategory"
        itemReminderCategory.setActions(actionsArray as! [UIUserNotificationAction], for: UIUserNotificationActionContext.default)
        itemReminderCategory.setActions(actionsArrayMinimal as! [UIUserNotificationAction], for: UIUserNotificationActionContext.minimal)
        
        
        let categoriesForSettings = NSSet(objects: itemReminderCategory)
        
        
        // Register the notification settings.
        let newNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: categoriesForSettings as! Set<UIUserNotificationCategory>)
        UIApplication.shared.registerUserNotificationSettings(newNotificationSettings)
    }
}


final class NearItemsInfo2 {
    let itemID: String = String()
    let itemName: String = String()
    let itemLat: Double = Double()
    let itemLong: Double = Double()
    
}


struct NearItemsInfo {
    var itemID: String
    var itemName: String
    var itemLat: Double
    var itemLong: Double
}


final class MyStruct {
    let start : Date = Date()
    let stop : Date = Date()
}




func SaveMyLoc(_ username: NSString, latitude: Double, longitude: Double, email: NSString, altitude: Double) -> Bool {
    
    let prefs:UserDefaults = UserDefaults.standard
    var token = Data()
    var TokenNew = String()
    
    if (prefs.value(forKey: "deviceToken") != nil)  {
        token  = prefs.value(forKey: "deviceToken") as! Data
        
        let Token = token
        let TokenNew2 = Token.description.replacingOccurrences(of: "<", with: "")
        let TokenNew3 = TokenNew2.replacingOccurrences(of: ">", with: "")
        TokenNew = TokenNew3.replacingOccurrences(of: " ", with: "")
        
        TokenNew = token.hex()

        
      //  print("deviceToken not nil")
     //   print("token = \(self.token)")
    } else {
        TokenNew = "UNKNOWN"
      //  print("DeviceToken IS nil")
    }
    
    

   // print("SAVING MY LOCATION")
    
    var post:NSString = "username=\(username)&latitude=\(latitude)&longitude=\(longitude)&token=\(TokenNew)&altitude=\(altitude)" as NSString
    
    //var urlData = NSData()
    
    //&password=\(password)"
    
  //  NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/SaveLoc.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
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
        
       // NSLog("Save Loc Response code: %ld", res.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            print("SaveLoc Response ==> %@", responseData);
            
            
            
            
            
            
         var error: NSError?
            
         let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
         //   NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                
                let totalitems:NSInteger = jsonData.value(forKey: "totalitems") as! NSInteger
                
                
                
                let prefs:UserDefaults = UserDefaults.standard
                
                if totalitems > 0 {
                    
                    if totalitems == 1 {
                        
                        
                        
                        let oneItem = FilterNearbyItemData(urlData)
                        
                        let itemName = oneItem[0].name
                        let itemID = oneItem[0].itemID
                        let lat = oneItem[0].Location.latitude
                        let long = oneItem[0].Location.longitude
                        
                        let itemImage = oneItem[0].itemImage
                        let imageName = oneItem[0].imageName
                        
                        var lastITEM = String()
                        
                        var  NearItemsArray = [NSDictionary]()
                        var ItemIDArray = [String]()
                        
                        
                        
                        
                        let range: Double = 100
                        var mylocnow = CLLocation(latitude: latitude, longitude: longitude)
                        var homeLocation = CLLocation(latitude: lat, longitude: long)
                        var distance = mylocnow.distance(from: homeLocation)
                        var miles = distance / 1609.34
                        var feet = Double(round(1000*(miles * 5280))/1000)
                        
                        
                        print("item: \(itemName) is \(feet) feet away")
                        
                        var NotificationsNearbyItemsRadius = Double()
                        
                        if prefs.value(forKey: "NotificationsNearbyItemsRadius") != nil {
                            NotificationsNearbyItemsRadius = prefs.value(forKey: "NotificationsNearbyItemsRadius") as! Double
                        } else {
                            NotificationsNearbyItemsRadius = 100.0
                        }
                        
                        
                        
                        var ItemInRadius = Bool()
                        if feet <= NotificationsNearbyItemsRadius {
                            ItemInRadius = true
                        }
                        
                        print("item in radius = \(ItemInRadius)")
                        
                        //COMMENT NEAR ITEMS ARRAY
                        
                        if prefs.value(forKey: "NEARITEMSARRAY") != nil {
                        
                            print("NEARITEMSARRAY is not nil")
                            
                      //  let NearItemsArrayData = prefs.valueForKey("NEARITEMSARRAY") as! NSData
                            
                            
                         //   NearItemsArray.append(NearItemsInfo(itemID: itemID, itemName: itemName, itemLat: lat, itemLong: long))
                            
                            
                            
                            NearItemsArray = prefs.value(forKey: "NEARITEMSARRAY") as! [NSDictionary]
                            
                            
                            
                            
                            
                            
                            for ArrayItems in NearItemsArray {
                                
                                let theItemID = ArrayItems["itemID"] as! String
                                
                                ItemIDArray.append(theItemID)
                            }
                            
                            print("ITEM IDs Are: \(ItemIDArray)")
                            
                            if !ItemIDArray.contains(itemID) {
                                
                                var NotifyUser = Bool()
                                
                                if prefs.bool(forKey: "\(itemName)AlertLocation") != nil {
                                    NotifyUser = prefs.bool(forKey: "\(itemName)AlertLocation")
                                } else {
                                    NotifyUser = true
                                }
                                
                                if NotifyUser {
                                
                                NearItemsArray.append(["itemName":"\(itemName)","itemID":"\(itemID)","itemLat":"\(lat.description)","itemLong":"\(long.description)","imageName":"\(imageName)"])
                                

                                prefs.set(NearItemsArray, forKey: "NEARITEMSARRAY")
                                
                                
                                
                                //SEND LOCAL NOTIFICATION ON NEW ITEM NEARBY
                                var now: TimeInterval {
                                    return Date().timeIntervalSinceReferenceDate
                                }

                                print("scheduleItemNotification func begin")
                                scheduleItemNotification(itemName, lat: lat, long: long, imageName: imageName)
                                let nearItemBadge =  prefs.integer(forKey: "NEARITEMBADGE")
                                let NewItemBadge = nearItemBadge + 1
                                prefs.set(NewItemBadge, forKey: "NEARITEMBADGE")
                                UIApplication.shared.applicationIconBadgeNumber = NewItemBadge

                                }
                            }
                            

                           
                            
                            
                        } else {
                           
                            print("NEARITEMSARRAY IS nil")
                            
                            
                            NearItemsArray.append(["itemName":"\(itemName)","itemID":"\(itemID)","itemLat":"\(lat.description)","itemLong":"\(long.description)","imageName":"\(imageName)"])
                           
                            prefs.set(NearItemsArray, forKey: "NEARITEMSARRAY")
                            
                            
                            
                            //SEND LOCAL NOTIFICATION ON NEW ITEM NEARBY
                            var now: TimeInterval {
                                return Date().timeIntervalSinceReferenceDate
                            }
                            
                            
                            print("*****SHOULD SCHEDULE LOCAL NOTIFICATION FOR ITEM NOW*****")
                            
                            scheduleItemNotification(itemName, lat: lat, long: long, imageName: imageName)
                            
                            
                            let nearItemBadge =  prefs.integer(forKey: "NEARITEMBADGE")
                            let NewItemBadge = nearItemBadge + 1
                            prefs.set(NewItemBadge, forKey: "NEARITEMBADGE")
                            UIApplication.shared.applicationIconBadgeNumber = NewItemBadge
                            

                            
                        }
                        
                        
 
                        
                        
                   /*
                        
                        if prefs.valueForKey("LASTNEARITEM") != nil {
                          lastITEM = prefs.valueForKey("LASTNEARITEM") as! String
                        } else {
                          lastITEM = "0"
                        }
                        
                        if lastITEM != itemID {
                        
                            
                        var now: NSTimeInterval {
                                return NSDate().timeIntervalSinceReferenceDate
                        }
                            
                            //var now = NSDate.
                        
                            
                        scheduleItemNotification(itemName, lat: lat, long: long)
                        
                            /*
                        var localNotification = UILocalNotification()
                        localNotification.regionTriggersOnce = true
                        localNotification.alertBody = "Item Alert: \(itemName) nearby to pick up!"
                         */
                
                        prefs.setValue(itemID, forKey: "LASTNEARITEM")
                        
                            
                            
                       // UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                        
                         
                        
                        let nearItemBadge =  prefs.integerForKey("NEARITEMBADGE")
                            
                        let NewItemBadge = nearItemBadge + 1
                            
                            
                        prefs.setInteger(NewItemBadge, forKey: "NEARITEMBADGE")
                            
                        UIApplication.sharedApplication().applicationIconBadgeNumber = NewItemBadge
                        
                        }
                        
                        */
                            
                    } else {
                        
                        
                    var localNotification = UILocalNotification()
                    localNotification.regionTriggersOnce = true
                    localNotification.alertBody = "There are multiple items nearby to pick up!"
                        
                    
                    //    let nearItemBadge =  prefs.integerForKey("NEARITEMBADGE")
                    //    let NewItemBadge = nearItemBadge + 1
                        
                        
                        
                        //  prefs.setInteger(NewItemBadge, forKey: "NEARITEMBADGE")
                        
                        
                        
                      //  UIApplication.sharedApplication().applicationIconBadgeNumber = NewItemBadge
                  //  UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                    
                    }
                    
                    
                    
                }
                
                
                let OtherCameraURLData = GetOtherCameras(email, level: "1", status: "active", background: false)
               // OtherNearbyCameras = FilterOtherCameraItems(OtherCameraURLData)
                
                
                
                let jsonDataC:NSDictionary = (try! JSONSerialization.jsonObject(with: OtherCameraURLData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                
                let successC:NSInteger = jsonDataC.value(forKey: "success") as! NSInteger
                
                if successC == 1 {
                    
        
                var NearbyCameras: Int = 0
                    
                let itemsC:NSInteger = jsonDataC.value(forKey: "totalCameras") as! NSInteger
                    
               //  print("Total cameras = \(itemsC.description)")
                    
                if itemsC > 1 {
                
                var json = JSON(jsonData)
                
                //println("Json value: \(jsonData)")
               // print("Json Mission valueJSON: \(json)")
                
                for result in json["Data"].arrayValue {
                    
                    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                    
                    var formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                    
                    
                    
                    if ( result["id"] != "NA") {
                        
                       // print("OTHER CAMERA INFO FOUND")
                        
                        let itemID = result["id"].stringValue
                        // print("ITEM NAME = \(itemName)")
                        let latTemp = result["latitude"].stringValue
                        let lat = Double(latTemp)
                        
                        let longTemp = result["longitude"].stringValue
                        let long = Double(longTemp)
                        
                        
                        let status = result["status"].stringValue
                        let level = result["level"].stringValue
                        let starttimeTemp = result["starttime"].stringValue
                        let endtimeTemp = result["endtime"].stringValue
                        let rangeTemp = result["range"].stringValue
                        let range = Double(rangeTemp)
                        
                        let targetName = result["targetname"].stringValue
                        let targetID = result["targetid"].stringValue
                        
                        let objective = "test objective"
                        // let xp = result["xp"].stringValue
                        let xp = "10"
                        //let itemID = "NA"
                        
                        let itemImageURL = "" //result["imageURL"].stringValue

                        // MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                        
                        let missionTitle = "Survellencex"
                        
                        let missionCoordinate = CLLocationCoordinate2DMake(lat!, long!)
                        
                        let imageName = "Camera"
                        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                        let theImageData = try? Data(contentsOf: url)
                        let itemImage = UIImage(data:theImageData!)!
                        
                        //  let missionMapURL = result["imageURL"].stringValue
                        let missionMapURL = "Camera"
                        let missionObjectURL = "Camera"
                        
                        let itemOwner = username
                        
                        
                        // let StartTemp = "2017-01-11 14:47:22"
                        let StartTempFormated = formatter.date(from: starttimeTemp)
                        //   let EndTemp = "2017-01-12 14:47:22"
                        let EndTempFormated = formatter.date(from: endtimeTemp)
                        
                        let itemStart = StartTempFormated
                        let itemEnd = EndTempFormated
                        let itemRadius = 5.0
                        //  let range: Double = 50
                        
                        
                         var curLoc = CLLocation()
                         var mylocnow = CLLocation(latitude: latitude, longitude: longitude)
                         /*
                         var curLocManager = CLLocationManager()
                         curLoc = curLocManager.location!
                         var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
                         */
                         var cameraLocation = CLLocation(latitude: lat!,longitude: long!)
                         //var distance = mylocnow.distance(from: itemLocation)
                         var distance = mylocnow.distance(from: cameraLocation)
     
                         var miles = distance / 1609.34
                        //print("Cmiles: \(miles)")
                        
                         var feet = Double(round(1000*(miles * 5280))/1000)
                        
                        print("***CAMERA Distance (feet away): \(feet)***")
                        
                        if range! >= feet {
                            print("***TOO CLOSE, YOUVE BEEN SPOTTED***")
                            
                            NearbyCameras += 1

                        } else {
                            print("***NOT SPOOTED, YOURE SAFE***")
                        }
                        
                     
                        
                        
                        
                        
                        
                    }
                    
                  }
                    
                 }
                    
                    if NearbyCameras > 0 {
                        
                        var localNotification = UILocalNotification()
                        localNotification.regionTriggersOnce = true
                        localNotification.alertBody = "You've been spotted by survellence!"
                        
                    }
                
                }
                
                
                
                
               // NSLog("Login SUCCESS");
                return true
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
    
    //return urlData
}


func FilterNearbyItemData(_ urlData: Data) -> [NearbyItem] {
    
    var itemPoints = [NearbyItem]()
    var itemPoint: NearbyItem?
    var LocationData = [NSArray]()
    
    var traits = [NSString]()
    
    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
    
    var json = JSON(jsonData)
    
    //println("Json value: \(jsonData)")
    //  println("Json valueJSON: \(json)")
    
    for result in json["items"].arrayValue {
        
        if ( result["name"] != "dummy") {
            if ( result["isAvailable"] != "no") {
               let itemname = result["name"].stringValue
               let itemID = result["id"].stringValue
               let itemlat2 = result["latitude"].stringValue
               let itemlong2 = result["longitude"].stringValue
                
               let itemType = result["type"].stringValue
                // println("ItemType Test: - \(itemType)")
               let itemStatus = result["isAvailable"].stringValue
               let itemCode = result["code"].stringValue
               let itemlat = (itemlat2 as NSString).doubleValue
               let itemlong = (itemlong2 as NSString).doubleValue
                
                let imageName = result["imagename"].stringValue
                
               // print("Image Name = \(imageName)")
                /*
                
                if (playername == username) {
                
                PlotPoint = MyLabel(title: playername as String, userHealth: playerhealth as String, discipline: "test", stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: playerlat, longitude: playerlong))
                
                mapView.addAnnotation(PlotPoint)
                
                } else {
                */
                
                
                let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                
                
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                let theImageData = try? Data(contentsOf: url)
                
                
                if itemname == "Cannon" || itemname == "Grenade" || itemname == "Assault Rifle" {
                    
                    itemPoint = NearbyItem(name: itemname as String, itemStatus: itemStatus as String, Location: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemID: itemID as String, itemImage: UIImage(data:theImageData!)!, imageName: imageName)
                    
                 //   itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(data:theImageData!)!)
                    
                }  else {
                    
                    // let url = NSURL.fileURLWithPath(path)
                    // let ItemImage = UIImage(data: theImageData!)
                    
                    
                  //  itemPoint = NearbyItem(name: itemname as String, itemStatus: itemStatus as String, Location: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemID: itemID as String, itemImage: UIImage(named: "\(imageName).png")!, imageName: imageName)
                    
                  
                   itemPoint = NearbyItem(name: itemname as String, itemStatus: itemStatus as String, Location: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemID: itemID as String, itemImage: UIImage(data:theImageData!)!, imageName: imageName) 
                    
                  //  itemPoint = ItemLabel(title: itemname as String, itemStatus: itemStatus as String, discipline: "test", itemType: itemType as String,coordinate: CLLocationCoordinate2D(latitude: itemlat, longitude: itemlong), itemCode: itemCode as String, itemID: itemID as String, image: UIImage(named: "\(imageName).png")!)
                    
                }
                
                itemPoints.append(itemPoint!)
                
          //      mapView.addAnnotation(itemPoint)
                //  }
                /*
                playernameArray.append(playername)
                playerlatArray.append(playerlat)
                playerlongArray.append(playerlong)
                playerhealthArray.append(playerhealth)
                playerstealthArray.append(playerstealth)
                */
            }
        }
        
    }
    /*
    LocationData.append(playernameArray)
    LocationData.append(playerlatArray)
    LocationData.append(playerlongArray)
    LocationData.append(playerhealthArray)
    LocationData.append(playerstealthArray)
    */
    
    return itemPoints
}

struct NearbyItem {
    
    var name: String
    var itemStatus: String
    var Location: CLLocationCoordinate2D
    var itemID: String
    var itemImage: UIImage
    var imageName: String
    
    init (name: String, itemStatus: String, Location: CLLocationCoordinate2D, itemID: String, itemImage: UIImage, imageName: String) {
        self.name = name
        self.itemStatus = itemStatus
        self.Location = Location
        self.itemID = itemID
        self.itemImage = itemImage
        self.imageName = imageName
    }
    
}




func UpdateStealthMode(_ username: NSString, stealth: NSString) -> Bool {
    
    
    var post:NSString = "username=\(username)&stealth=\(stealth)" as NSString
    
    //&longitude=\(longitude)"
    

    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/StealthMode.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
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
        
       // NSLog("Response code: %ld", res?.statusCode);
        
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
               // NSLog("Login SUCCESS");
                print("Stealth Mode SUCCESS")
                return true
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
    
    //return urlData
}

func SaveFile(_ fileURL: String, name: String) {
    
    let request: URLRequest = URLRequest(url: URL(string: fileURL)!)
    let mainQueue = OperationQueue.main
    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
        if error == nil {
            // Convert the downloaded data in to a UIImage object
            
            
            
            
            SaveFileToDirectory(data!, name: name)
            
            //var image = UIImage(data: data!)
            // Store the imge in to our cache
            //  self.imageCache[urlString] = image
            // Update the cell
            DispatchQueue.main.async(execute: {
                //if let cellToUpdate = TableView.cellForItemAtIndexPath(indexPath) {
                //if let cellToUpdate = TableView.cel
                
            })
        }
        
    })
    
}

func SaveFileToDirectory(_ data: Data, name: String ) {
    
    //let data = NSData(contentsOfURL: YTLink)
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    
    let tempTYVideo = (documentDirectory as NSString).appending(name)
    //let tempTYVideo = (documentDirectory as NSString).stringByAppendingString("/tempYTVideo.mov")
    if FileManager.default.fileExists(atPath: tempTYVideo as String) {
        print("Deleting existing file\n")
        
        do {
            
            try FileManager.default.removeItem(atPath: tempTYVideo as String)
            
            
            
            
        } catch {
            print("Error = \(error)")
        }
    }
    
    
    
    
    do {
        
        //     try data?.writeToFile(tempTYVideo, options: NSDataWritingOptions.AtomicWrite)
        
        try data.write(to: URL(fileURLWithPath: tempTYVideo), options: [.atomic])
        print("File saved to path = \(tempTYVideo)")
        let prefs:UserDefaults = UserDefaults.standard
        
        switch name {
            
        case "/PQTempMusic4.m4v" :
            prefs.set(true, forKey: "DEFAULTSAVEDvideo")
            
        case "/tada.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDtada")
            
        case "/please.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDplease")
            
        case "/joy.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDjoy")
            
        case "/metroid.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDmetroid")
            
        case "/doorbell.caf" :
            prefs.set(true, forKey: "DEFAULTSAVEDdoorbell")
            
        case "/ComedicFun.mp3":
            prefs.set(true, forKey: "DEFAULTCFUN")
            prefs.set(false, forKey: "MuteGameAudio")
            
        case "/DemoImageTurn.jpg":
            prefs.set(true, forKey: "DemoImageTurn")
            
        default:
            break
            
        }
        
        
    } catch {
        print("ERROR Saving Temp Video = \(error)")
    }
    
    
    
    print("Temp Video Saved at path = \(tempTYVideo)")
    
    //  let savePath = (documentDirectory as NSString).stringByAppendingString("/tempYTAudio.m4a")
    
    //   dispatch_async(dispatch_get_main_queue(), {
    
    // self.createVideoNow(YTLink)
    
    //    })
    
}



func CheckAppVersion (_ version: NSString) -> Bool {
    
    var prefs:UserDefaults = UserDefaults.standard
    
    let appVersion = prefs.value(forKey: "APPVERSION")
    
    var NeedToUpdate = false
    
    var post:NSString = "version=\(version)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AppVersion.php")!
    
    var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
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
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
           // NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                
                print("App Version is NOT current")
                NeedToUpdate = true
                
               // NSLog("Login SUCCESS");
                /*
                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                prefs.setObject(username, forKey: "USERNAME")
                prefs.setInteger(1, forKey: "ISLOGGEDIN")
                prefs.synchronize()
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
                */
            } else {
                
                NeedToUpdate = false
               // prefs.setValue(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)
                prefs.set(false, forKey: "ICONSUPDATED")
                prefs.set(false, forKey: "MISSIONINFOUPDATED")
                prefs.value(forKey: "APPVERSION")
                
                print("App Version IS current")
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
            
            //NeedToUpdate = false
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
    
    return NeedToUpdate
}




