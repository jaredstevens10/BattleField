//
//  ViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var messageToUserLBL: UILabel!
    
    var messageToUser = String()
    var messageToUserArray = ["Upgrade your coin purse to hold more Gold","Complete missions to advance your career","Binoculars will help you see things far away","Upgrading your weapons will make them more powerful","Potions can be used to increase your health and battle stamina","Keep an eye out for gold chests"]
    
    
    @IBOutlet weak var LoadProgressView: UIProgressView!
    
    var appVersion = NSString()
    var currentAppVersion = "1.0.0"
    var TotalItemsArray = [NSString]()
    
    
    var ItemsInventoryArray = [ItemInventory]()
    var TotalItems = Int()
    
    var MissionListInventoryArray = [MissionListInventory]()
    var TotalItemsMissionList = Int()
    var SavedMissionListInfo = [NSManagedObject]()
    var TotalMissionsArray = [NSString]()
    
    var TotalImages = Int()
    var TotalImagesArray = [NSString]()
    var SavedImagesInventory = [NSManagedObject]()
    
    let ServerURL = "http://\(ServerInfo.sharedInstance)/Apps/BattleField/Items/"
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var ItemInventoryInfo = [ItemInventory]()
    var SavedItemsInventory = [NSManagedObject]()
    
    
    @IBOutlet weak var backgroundIMG: UIImageView!
    var username = NSString()
    var email = NSString()
    @IBOutlet weak var helmetLogo: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var StartBTN: UIButton!
    
    func GetUserInfoData(_ email: NSString) {
        
        
        backgroundThread(background: {
            //self.GetPublicTurns()
          //  print("BACKGROUND THREAD - Updating Users' Info")
            
         //   print("Saving Images now")
            
            
            let UserInfoNSData = GetUserInfo(email)
            
            DispatchQueue.main.async(execute: {
             //   print("Creating Local Inventory Data")
             CreateLocalInventory(UserInfoNSData)
                
            })
            
            
            }, completion: {
                
                DispatchQueue.main.async(execute: {
                    //self.GetMyHUD.removeFromSuperview()
                    //  self.tableView.reloadData()
                  //  print("DISPATCH ASYNC - Finished Getting User's Info")
                })
                // print("Done Getting Steal Turns")
                //   self.kolodaView.resetCurrentCardNumber()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("start vc did apear")
        
        
        let value = UIInterfaceOrientation.portrait.rawValue // .LandscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
          //  print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
         self.LoadProgressView.setProgress(0.2, animated: true)
        
        // if Reachability.isConnectedToNetwork() {
        
            
            /*
        let UserInfoNSData = GetUserInfo(email)
        
         } else {
            
            print("Can't get user info, no network")
        }
        */
        
        
        
        
        GetUserInfoData(email)
        
        
        RetrieveMissionInfo()
 
        
        let seconds = 2.0
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        /*
        helmetLogo.alpha = 0
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            
            self.helmetLogo.alpha = 1
            //  self.logoIMGw.constant = 100
            //  self.logoIMGh.constant = 100
            // self.cirProgress.alpha = 1.0
            // self.viewCS.alpha = 1.0
            
            
        })
        
        */
        
        
        DispatchQueue.main.async(execute: {
          //  print("Creating Local Inventory Data")
            // CreateLocalInventory(UserInfoNSData)
            
       
        
      //  dispatch_after(dispatchTime, dispatch_get_main_queue(), {
        //    print("waiting 4 seconds to start")
            
             if Reachability.isConnectedToNetwork() {
            
                /*
                let NeedToUpdate = CheckAppVersion(self.currentAppVersion)

                print("App Version = \(self.currentAppVersion)")
                
                if !NeedToUpdate {
                    
                    */
            self.LoadProgressView.setProgress(0.2, animated: true)
            
            let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
            if (isLoggedIn != 1) {
                
                 self.LoadProgressView.setProgress(1.0, animated: true)
                
                self.performSegue(withIdentifier: "goto_login", sender: self)
            } else {
                
              //  if Reachability.isConnectedToNetwork() {
                 //   print("User Name = \(self.username)")
                    
                     self.LoadProgressView.setProgress(0.5, animated: true)
                
                    let NeedToUpdate = CheckAppVersion(self.currentAppVersion as NSString)
                    
                    print("App Version = \(self.currentAppVersion)")
                
                
                 DispatchQueue.main.async(execute: {
                
                
                
                    
                    if !NeedToUpdate {
                    
                    self.appVersion = self.currentAppVersion as NSString
                    self.LoadProgressView.setProgress(0.6, animated: true)
                    /*
                    
                      if self.prefs.valueForKey("APPVERSION") != nil {
                    
                      self.appVersion = self.prefs.valueForKey("APPVERSION") as! NSString
                    
                      } else {
                        
                      self.appVersion = "0.0.0"
                    }
                    
                    */
                    
                    
                let UpdatedIcons = self.prefs.bool(forKey: "ICONSUPDATED")
                        
                
                
                    
                    if !UpdatedIcons {
                    
                let URLDataItems = RefreshItemInventory(self.username)
                self.ItemInventoryInfo = self.FilterItemData(URLDataItems)
                        
                 DispatchQueue.main.async(execute: {
               // print("Item Inventory Info = \(self.ItemInventoryInfo)")
                backgroundThread(background: {
                //self.GetPublicTurns()
              //  print("BACKGROUND THREAD - Updating Users' location")
      
               //     print("Saving Images now")
                    
                    for items in self.ItemInventoryInfo {
                        
                     //   print("Saving \(items.name)")
                        
                        let theImageURL = "\(self.ServerURL)\(items.imageURL).png"
                        let theImageURL100 = "\(self.ServerURL)\(items.imageURL100).png"
                        let theImageURL3D = "\(self.ServerURL)\(items.imageURL3D).dae"
                        
                        
                        SaveFile(theImageURL, name: "/\(items.imageURL).png")
                        
                        
                        if items.imageURL100 != "" {
                        SaveFile(theImageURL100, name: "/\(items.imageURL100).png")
                        }
                        
                        if items.imageURL3D != "" {
                            
                            //WOULD SAVE 3D FILE HERE
                            
                            if items.imageURL3D == "InfantryKnife3D" {
                            SaveFile(theImageURL3D, name: "/\(items.imageURL3D).dae")
                            }
                        }
                    }
                    
                  self.LoadProgressView.setProgress(0.7, animated: true)
                    
                    
                }, completion: {
                
                    
                    self.prefs.set(true, forKey: "ICONSUPDATED")
                    
                    //self.MergeMyLevelMissions(username: self.username, email: self.email, lat: Double, long: Double)
                    
                DispatchQueue.main.async(execute: {
                    
                     self.LoadProgressView.setProgress(1.0, animated: true)
                    
                    print("FINISHED UPDATING ALL THE ICONS AND MISSIONS")
                    
                    DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                   //     print("waiting 4 seconds to start")
                        
                        self.performSegue(withIdentifier: "GoToMap", sender: self)
                        
                    })
                    
                //self.GetMyHUD.removeFromSuperview()
                //  self.tableView.reloadData()
               // print("DISPATCH ASYNC - Finished Updating the users' location")
                })
                // print("Done Getting Steal Turns")
                //   self.kolodaView.resetCurrentCardNumber()
                })
                
                
                
                
                    
                
                })
                
                    } else {
                        
                        let UpdatedMissionInfo = self.prefs.bool(forKey: "MISSIONINFOUPDATED")
                        
                        
                        if !UpdatedMissionInfo {
                        
                        self.RefreshMissionInfoFunction()
                        
                        } else {
                            
                       // print("MERGING")
                       // self.MergeMyLevelMissions(username: self.username, email: self.email, lat: Double, long: Double)
                            
                        self.LoadProgressView.setProgress(1.0, animated: true)
                        
                        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                          //  print("waiting 4 seconds to start")

                            print("IS READY TO GO TO THE MAP NOW")
                          
                         self.performSegue(withIdentifier: "GoToMap", sender: self)

                            })
                        
                        }
                        }
                
                    } else {
                        
                        print("need to update")
                        
                    }
                    
                })
                
            //  }
                //    admin = prefs.valueForKey("ADMIN") as! NSString
            }
                
                    /*
                } else {
                    
                    
                    print("Need to update app")
                    self.performSegueWithIdentifier("GoToMap", sender: self)
                }

*/
                
                
            
             } else {
                
                print("Check network settings")
            }
        
            
        })
        
        
        
        

        /*
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //  self.logoIMGw.constant = 100
            //  self.logoIMGh.constant = 100
            // self.cirProgress.alpha = 1.0
            // self.viewCS.alpha = 1.0
            
            
        })
*/
        
        
        //backgroundIMG.alpha = 0
    }
    
    /*
    func MergeMyLevelMissions(username: NSString, email: NSString, lat: Double, long: Double) {
        
        
        print("!!!MERGING MY LEVEL MISSIONS NOW")
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        //GET MY CURRENT MISSIONS (IN USERS DATABASE)
        let URLData = GetMission(email, level: level as NSString, status: status as NSString)
        let MissionIDsArray = FilterMyMissionsData(URLData)
        
        print("My Current Mission IDs: \(MissionIDsArray)")
        let URLDataItems = GetServerMissionData(username, level: level as NSString)
        let WasMyMissionsUpdated = MergeMissionInfoData(URLDataItems, CurrentMissionIDs: MissionIDsArray, email: email)
        
    
    }
    */
    
    
    
    func RefreshMissionInfoFunction() {
        print("NEED TO UPDATE MISSION INFO, DOING THAT NOW")
        
      //  let UpdatedMissionInfo = self.prefs.boolForKey("MISSIONINFOUPDATED")
        
        
       // if !UpdatedMissionInfo {
            
            let URLDataItems = RefreshMissionInfo(self.username)
            self.MissionListInventoryArray = self.FilterMissionInfoData(URLDataItems)
        
      //  let URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
      //  MissionInfoArray = FilterMissionItems(URLData)
        
            // var name = prefs.valueForKey("USERNAME") as! NSString as String
            
            //  self.usernameLabel.text = "Welcome Back \(name)"
            
            
            
            
            DispatchQueue.main.async(execute: {
                // print("Item Inventory Info = \(self.ItemInventoryInfo)")
                
                
                
                backgroundThread(background: {
                    //self.GetPublicTurns()
                   // print("BACKGROUND THREAD - Updating Users' location")
                    
                  //  print("Saving Images now")
                    
                    for items in self.MissionListInventoryArray {
                        
                     //   print("Saving \(items.name)")
                        
                        let MapImageURL = "\(self.ServerURL)\(items.mapURL).png"
                        let ObjectImageURL = "\(self.ServerURL)\(items.objectURL).png"
                        
                        SaveFile(MapImageURL, name: "/\(items.mapURL).png")
                        
                        
                        if items.objectURL != "" {
                            SaveFile(ObjectImageURL, name: "/\(items.objectURL).png")
                        }
                    }
                    
                   // self.LoadProgressView.setProgress(0.7, animated: true)
                    
                    
                    }, completion: {
                        
                        
                        self.prefs.set(true, forKey: "MISSIONINFOUPDATED")
                        
                        DispatchQueue.main.async(execute: {
                            
                           // self.LoadProgressView.setProgress(1.0, animated: true)
                            
                            print("FINISHED UPDATING ALL THE MISSION INFO")
                            
                            /*
                            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                                print("waiting 4 seconds to start")
                                
                                self.performSegueWithIdentifier("GoToMap", sender: self)
                                
                            })
                           */
                            //self.GetMyHUD.removeFromSuperview()
                            //  self.tableView.reloadData()
                            // print("DISPATCH ASYNC - Finished Updating the users' location")
                        })
                        // print("Done Getting Steal Turns")
                        //   self.kolodaView.resetCurrentCardNumber()
                })
                
                
                
                
                
                
            })
            
   //     }
        
        
        
    }
    
    
    func SaveNewItem(_ nametemp: String, imageurltemp: String, powertemp: String, rangetemp: String, speedtemp: String, categorytemp: String, imageurl100temp: String, itemordertemp: String, healthtemp: String, staminatemp: String, viewRangetemp: String, subCategory: String, imageURL3Dtemp: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Items", in: managedContext)
        
        let newitem = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        /*
         let rangetemp = ""
         let speedtemp = ""
         let powertemp = ""
         let nametemp = ""
         let imageurltemp = ""
         */
        
        newitem.setValue(rangetemp, forKey: "range")
        newitem.setValue(staminatemp, forKey: "stamina")
        newitem.setValue(healthtemp, forKey: "health")
        newitem.setValue(powertemp, forKey: "power")
        newitem.setValue(speedtemp, forKey: "speed")
        newitem.setValue(nametemp, forKey: "name")
        newitem.setValue(imageurltemp, forKey: "imageURL")
        newitem.setValue(categorytemp, forKey: "category")
        newitem.setValue(imageurl100temp, forKey: "imageURL100")
        newitem.setValue(itemordertemp, forKey: "itemOrder")
        newitem.setValue(viewRangetemp, forKey: "viewRange")
        newitem.setValue(subCategory, forKey: "subCategory")
        newitem.setValue(imageURL3Dtemp, forKey: "imageURL3D")
        
        print("Saving ITEM: \(nametemp)ImageIcon")
        
        prefs.setValue(imageurltemp, forKey: "\(nametemp)ImageIcon")
        prefs.setValue(imageurl100temp, forKey: "\(nametemp)ImageIcon100")
        prefs.setValue(imageURL3Dtemp, forKey: "\(nametemp)ImageIcon3D")
        
        var error: NSError?
        
        do {
            try managedContext.save()
            
          //  print("\(nametemp) has been saved")
            
            
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
    }
    
    
    func SaveNewMission(_ missionID: String, nametemp: String, mapurltemp: String, xptemp: String, objectivetemp: String, leveltemp: String, objecturltemp: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Missions", in: managedContext)
        
        let newitem = NSManagedObject(entity: entity!, insertInto: managedContext)
        
       /*
        let rangetemp = ""
        let speedtemp = ""
        let powertemp = ""
        let nametemp = ""
        let imageurltemp = ""
*/
        newitem.setValue(missionID, forKey: "id")
        newitem.setValue(objecturltemp, forKey: "objectURL")
        newitem.setValue(leveltemp, forKey: "level")
        newitem.setValue(mapurltemp, forKey: "mapURL")
        newitem.setValue(nametemp, forKey: "name")
        newitem.setValue(objectivetemp, forKey: "objective")
        newitem.setValue(xptemp, forKey: "xp")

        
        prefs.setValue(mapurltemp, forKey: "Mission\(nametemp)MapImage")
        prefs.setValue(objecturltemp, forKey: "Mission\(nametemp)ObjectImage")
        
        
        var error: NSError?
        
        do {
            try managedContext.save()
            
            // print("\(nametemp) has been saved")
            
            
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
    }
    
    
    func SaveNewImage(_ nametemp: String, imageurltemp: String, categorytemp: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "Images", in: managedContext)
        
        let newitem = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        /*
         let rangetemp = ""
         let speedtemp = ""
         let powertemp = ""
         let nametemp = ""
         let imageurltemp = ""
         */
        
      // newitem.setValue(rangetemp, forKey: "range")
      //  newitem.setValue(powertemp, forKey: "power")
      //  newitem.setValue(speedtemp, forKey: "speed")
        newitem.setValue(nametemp, forKey: "name")
        newitem.setValue(imageurltemp, forKey: "imageURL")
        newitem.setValue(categorytemp, forKey: "category")
        
        var error: NSError?
        
        do {
            try managedContext.save()
            
          //  print("\(nametemp) has been saved")
            
            
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error!.userInfo)")
        }
    }
    
    func RetrieveItems() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
        self.LoadProgressView.setProgress(0.1, animated: true)
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
              //  print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                
                if prefs.value(forKey: "\(ItemNameURL)ImageIcon") == nil {
                    
                print("\(ItemNameURL)ImageIcon is nil, setting user default value now")
                prefs.setValue(ItemNameURL, forKey: "\(ItemNameURL)ImageIcon")
                    
                }
                
                TotalItemsArray.append(ItemNameURL as NSString)
            }
            
            
          //  print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    func RetrieveMissionInfo() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Missions")
        let errorGroups: NSError?
        
        self.LoadProgressView.setProgress(0.2, animated: true)
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedMissionListInfo = resultsGroups
                print("Saved Mission List = \(SavedMissionListInfo)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedMissionListInfo as [NSManagedObject] {
                TotalItemsMissionList += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let MissionID = items.value(forKey: "id") as! String
                
                TotalMissionsArray.append(MissionID as NSString)
            }
            
            
            print("Current items IMAGE URL =\(TotalMissionsArray)")
            
            
            
            if self.SavedMissionListInfo.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedImagesInventory = resultsGroups
              //  print("Saved images = \(SavedImagesInventory)")
            } else {
             //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedImagesInventory as [NSManagedObject] {
                TotalImages += 1
               // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                
                TotalImagesArray.append(ItemNameURL as NSString)
            }
            
            
         //   print("Current items IMAGE URL =\(TotalImagesArray)")
            
            
            
            if self.SavedImagesInventory.count > 0 {
              //  GroupInfoLBL.hidden = true
            } else {
              //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        helmetLogo.alpha = 0
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            
            self.helmetLogo.alpha = 1
            //  self.logoIMGw.constant = 100
            //  self.logoIMGh.constant = 100
            // self.cirProgress.alpha = 1.0
            // self.viewCS.alpha = 1.0
            
            
        })
        
        
    }
    
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let randomIndex = Int(arc4random_uniform(UInt32(messageToUserArray.count)))
  
        messageToUser = messageToUserArray[randomIndex]
        messageToUserLBL.text = messageToUser
        
        let value = UIInterfaceOrientation.portrait.rawValue // .LandscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        
        /*
        let vc = ViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: false)
        */
        
       
        
        
        prefs.setValue(currentAppVersion, forKey: "APPVERSION")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        helmetLogo.alpha = 0
        backgroundIMG.alpha = 0
        StartBTN.layer.borderWidth = 1
        StartBTN.layer.cornerRadius = 5
        
        StartBTN.layer.borderColor = UIColor.white.cgColor
        //StartBTN.layer.borderColor = UIColor.blackColor().CGColor
        //self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.cornerRadius = 5
        
        logoutButton.layer.borderColor = UIColor.white.cgColor
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
          //  print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.RefreshItemInfo(_:)), name: NSNotification.Name(rawValue: "RefreshItemInfo"),  object: nil)
        
        /*
        
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            
            
            
            
            var name = prefs.valueForKey("USERNAME") as! NSString as String
            
            self.usernameLabel.text = "Welcome Back \(name)"
            
            
            
            self.performSegueWithIdentifier("GoToMap", sender: self)
            
            
            
        //    admin = prefs.valueForKey("ADMIN") as! NSString
        }
        
        */
     //   print("View did load, about to retrieve items")
        
        RetrieveItems()
        //RetrieveImages()
    }
    
    
    @IBAction func StartBTN(_ sender: AnyObject) {
    
    self.performSegue(withIdentifier: "GoToMap", sender: self)
    
    }
    
    
    func RefreshItemInfo(_ notification: Notification)
    {
        
        if Reachability.isConnectedToNetwork() {
        
            print("Some Images were nil, refreshing Item Images in the background now")
            
        let URLDataItems = RefreshItemInventory(self.username)
        self.ItemInventoryInfo = self.FilterItemData(URLDataItems)
 
        DispatchQueue.main.async(execute: {
            // print("Item Inventory Info = \(self.ItemInventoryInfo)")
            backgroundThread(background: {

                
                for items in self.ItemInventoryInfo {
                    //   print("Saving \(items.name)")
                    
                    let theImageURL = "\(self.ServerURL)\(items.imageURL).png"
                    let theImageURL100 = "\(self.ServerURL)\(items.imageURL100).png"
                    let theImageURL3D = "\(self.ServerURL)\(items.imageURL3D).dae"
    
                    SaveFile(theImageURL, name: "/\(items.imageURL).png")
                    
                    if items.imageURL100 != "" {
                        SaveFile(theImageURL100, name: "/\(items.imageURL100).png")
                    }
                    
                    if items.imageURL3D != "" {
                        
                        //WOULD SAVE 3D FILE HERE
                        
                        if items.imageURL3D == "InfantryKnife3D" {
                            SaveFile(theImageURL3D, name: "/\(items.imageURL3D).dae")
                        }
                    }
                }
                
                self.LoadProgressView.setProgress(0.7, animated: true)
                
                
            }, completion: {
                
                self.prefs.set(true, forKey: "ICONSUPDATED")

            })
            

          })
        
        }
        
    }
    
    
    @IBAction func logoutTapped(_ sender : UIButton) {
        
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        self.performSegue(withIdentifier: "goto_login", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FilterItemData(_ urlData: Data) -> [ItemInventory] {
         print("NEED TO UPDATE ITEM INFO/IMAGES, DOING THAT NOW")
        var ItemData = [ItemInventory]()
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        
        
        for result in json["Items"].arrayValue {
            
            if ( result["id"] != "0") {
                
                let itemname = result["name"].stringValue
                let imageURL = result["imageURL"].stringValue
                let category = result["category"].stringValue
                let power = result["power"].stringValue
                let speed = result["speed"].stringValue
                let range = result["range"].stringValue
                let health = result["health"].stringValue
                let stamina = result["stamina"].stringValue
                let imageURL100 = result["imageURL100"].stringValue
                let itemOrder = result["itemOrder"].stringValue
                let viewRange = result["viewRange"].stringValue
                let subCategory = result["subCategory"].stringValue
                
                let imageURL3D = "\(imageURL)3D"
                
                // if uniqueitem == "yes" {
                
                ItemData.append(ItemInventory(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, viewRange: viewRange, subCategory: subCategory, imageURL3D: imageURL3D, unlocked: true))
                
                //  }
                
                //  if uniqueitem == "yes" {
                
                if !TotalItemsArray.contains(imageURL as NSString) {
                    
                    print("ITEMS: \(itemname) has not been saved yet, saving now")
                    
                    
                    prefs.set(true, forKey: "\(itemname)AlertLocation")
                    
                    SaveNewItem(itemname, imageurltemp: imageURL, powertemp: power, rangetemp: range, speedtemp: speed, categorytemp: category, imageurl100temp: imageURL100, itemordertemp: itemOrder, healthtemp: health, staminatemp: stamina, viewRangetemp: viewRange, subCategory: subCategory, imageURL3Dtemp: imageURL3D)
                    
                    
                    //  }
                    
                    /*
                     if !TotalImagesArray.contains(imageURL) {
                     print("IMAGES: \(itemname) has not been saved yet, saving now")
                     
                     SaveNewImage(itemname, imageurltemp: imageURL, categorytemp: category)
                     }
                     */
                    
                }
                
            }
            
        }
        
        // print("ItemData from Filter \(ItemData)")
        
        return ItemData
    }
    
    func FilterMissionInfoData(_ urlData: Data) -> [MissionListInventory] {
        
        var ItemData = [MissionListInventory]()
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        

        
        for result in json["Items"].arrayValue {
            
            if ( result["id"] != "0") {
                
                    let missionID = result["id"].stringValue
                    let missionname = result["missionName"].stringValue
                    let missionMapURL = result["missionMapURL"].stringValue
                    let xp = result["xp"].stringValue
                    let objective = result["objective"].stringValue
                    let level = result["level"].stringValue
                    let objectURL = result["objectURL"].stringValue

                
                
                
                
               // if uniqueitem == "yes" {
                
                ItemData.append(MissionListInventory(name: missionname, mapURL: missionMapURL, level: level, objectURL: objectURL, objective: objective, xp: xp))
                
              //  }
                
               //  if uniqueitem == "yes" {
                
                if !TotalMissionsArray.contains(missionMapURL as NSString) {
                    
                    print("ITEMS: \(missionname) has not been saved yet, saving now")
                    
                   
                    SaveNewMission(missionID, nametemp: missionname, mapurltemp: missionMapURL, xptemp: xp, objectivetemp: objective, leveltemp: level, objecturltemp: objectURL)
                    
              //  }
                    
                    /*
                    if !TotalImagesArray.contains(imageURL) {
                        print("IMAGES: \(itemname) has not been saved yet, saving now")
                        
                        SaveNewImage(itemname, imageurltemp: imageURL, categorytemp: category)
                    }
                    */
                    
                }
                
           }
            
        }
        
       // print("ItemData from Filter \(ItemData)")
        
        return ItemData
    }
    

    @IBAction func unwindToStartAfterLoginViewController(_ unwindSegue: UIStoryboardSegue) {

        print("Unwinded back to start")
        
    }
    
    
    
    @IBAction func unwindToStartViewController(_ unwindSegue: UIStoryboardSegue) {
        
        
        
        
        print("FROM START VC - Clearing User Defaults - Count: \(UserDefaults.standard.dictionaryRepresentation().keys.count)")
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
            
        }
        
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
       
        
         self.prefs.set(false, forKey: "MyAttributePointsSet")
         self.prefs.set(false, forKey: "SettingsLoggingOut")
        
        
//        let isLoggedIn:Int = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
//        if (isLoggedIn != 1) {
//            
//            self.LoadProgressView.setProgress(1.0, animated: true)
        
            self.performSegue(withIdentifier: "goto_login", sender: self)
       // }
        
  // print("Unwinded back to start")
        /*
        if let blueViewController = unwindSegue.sourceViewController as? QuoteViewController {
            print("Coming from Quote")
        }
 */
        
        

    }
    
    
    
    
    
    
}


struct ItemInventory {
    
    var name: String
    var imageURL: String
    var category: String
    var power: String
    var speed: String
    var range: String
    var imageURL100: String
    var itemOrder: String
    var viewRange: String
    var subCategory: String
    var imageURL3D: String
    var unlocked: Bool
    
}

struct MissionListInventory {
    
    var name: String
    var mapURL: String
    var level: String
    var objectURL: String
    var objective: String
    var xp: String
    
}

struct ItemInventorySorted {
    
    var name: String
    var imageURL: String
    var category: String
    var power: String
    var speed: String
    var range: String
    var imageURL100: String
    var itemOrder: String
    var itemOrderNum: Int
    var health: String
    var stamina: String
    var viewRange: String
    var subCategory: String
    var unlocked: Bool
}

struct ItemInventorySortedWeapon {
    
    var name: String
    var imageURL: String
    var category: String
    var power: String
    var speed: String
    var range: String
    var imageURL100: String
    var itemOrder: String
    var itemOrderNum: Int
    var health: String
    var stamina: String
    var viewRange: String
    var level: String
    var available: Bool
    var ammo: String
    var subCategory: String
    var unlocked: Bool
}

struct ItemInventorySortedPotion {
    
    var name: String
    var imageURL: String
    var category: String
    var power: String
    var speed: String
    var range: String
    var imageURL100: String
    var itemOrder: String
    var itemOrderNum: Int
    var health: String
    var stamina: String
    var Count: Int
    var Max: Int
    var Cost: Int
    var viewRange: String
    var subCategory: String
    var unlocked: Bool
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


