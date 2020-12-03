//
//  AppDelegate.swift
//  BattleField
//
//  Created by Jared Stevens on 7/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
//import GoogleSignIn

//GIDSignInDelegate //SHOULD BE PART OF CLASS BELOW

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
   let prefs:UserDefaults = UserDefaults.standard
    
    let DT = NSString()
    
    var scheme: String! // = String()
    var path: String! //= String()
    var query2: String! //y: = String()
    var nsurl: URL!
    
    enum Actions:String{
        case increment = "INCREMENT_ACTION"
        case decrement = "DECREMENT_ACTION"
        case reset = "RESET_ACTION"
    }
    
    var categoryID:String{
        get{
            return "COUNTER_CATEGORY"
        }
    }
    
    var window: UIWindow?
    
    var loadedEnoughToDeepLink : Bool = false
    var deepLink : RemoteNotificationDeepLink?
    
    // Deep Link Methods
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        
        print("Should handle local notification here")
        
        
        print("LOCAL NOTIFICATION USER INFO: \(notification.userInfo)")
        print("identifier: \(identifier)")
        
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        
        print("MY SEPCIAL USERINFO!!!!! = \(userInfo)")
        print("MY SPECIAL IDENTIFIER!!!!!!!!! = \(identifier)")
        
        
        var notificationDetails: NSDictionary = userInfo as NSDictionary
        print("notification details \(notificationDetails)")
        
        var jsonAlert = JSON(notificationDetails)
        
        print("AppDelete Handle Identifier JSON ALERT \(jsonAlert)")
        
        for result in jsonAlert["aps"].arrayValue {
            var testmessage = result["alert"].stringValue
            print("Test Message success: \(testmessage)")
        }
        
        //var NoficationMessage = jsonAlert["aps"]["alert"].stringValue
        
        //println("TEST 2 \(test2)")

        var NotificationMessage = jsonAlert["aps"]["alert"].stringValue
        var attackedBy = jsonAlert["aps"]["attackedBy"].stringValue
        var category = jsonAlert["aps"]["category"].stringValue

        
        if identifier == "FightBack" {
            print("fighting back banner triggered")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "FightBackNotification"), object: nil)
        }
        else if identifier == "RunAway" {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "RunAwayNotification"), object: nil)
        }
        else if identifier == "GetItem" {
            print("Get Item")
        }
        
        completionHandler()
        
        /*
        
        println("Did Receive Remote Notification")
        var rootViewController = self.window!.rootViewController
        
        var notificationDetails: NSDictionary = userInfo as NSDictionary
        println("notification details \(notificationDetails)")
        
        var jsonAlert = JSON(notificationDetails)
        
        var NotificationMessage = jsonAlert["aps"]["alert"].stringValue
        var attackedBy = jsonAlert["aps"]["attackedBy"].stringValue
        var category = jsonAlert["aps"]["category"].stringValue
        
        println("Alert Category: \(category)")
        
        if category == "attack" {
            
            
            
        }
        
        if category == "message" {
            var notifiAlert = UIAlertView()
            //var NotificationMessage = jsonAlert["aps"]["alert"].stringValue
            //var attackedBy = jsonAlert["aps"]["attackedBy"].stringValue
            //var TestMessage : AnyObject? = userInfo["alert"]
            notifiAlert.title = "Incoming Message"
            notifiAlert.message = NotificationMessage
            notifiAlert.addButtonWithTitle("Ok")
            notifiAlert.show()
        }
        
        for result in jsonAlert["aps"].arrayValue {
            var testmessage = result["alert"].stringValue
            println("Test Message success: \(testmessage)")
        }
        
       // if notification.userInfo:
*/
    }
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplicaition)
        
//        if 1 == 1 {
//            
//            return GIDSignIn.sharedInstance().handleURL(url,
//                                                        sourceApplication: Options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
//                                                        annotation: Options[UIApplicationOpenURLOptionsAnnotationKey])
//            
//        } else {
        
        
        
        nsurl = url
        scheme = url.scheme
        path = url.path
        query2 = url.query
        
        if url.host == nil
        {
            return true;
        }
        
        let urlString = url.absoluteString
        let queryArray = urlString.components(separatedBy: "/")
        let query = queryArray[2]
        
        // Check if article
        if query.range(of: "article") != nil
        {
            let data = urlString.components(separatedBy: "/")
            if data.count >= 3
            {
                let parameter = data[3]
                let userInfo = [RemoteNotificationDeepLinkAppSectionKey : parameter ]
                print("Running Deep LInk Remote Code")
                self.applicationHandleRemoteNotification(application, didReceiveRemoteNotification: userInfo)
            }
        }
        
        

        
        return true
            
        //}
    }
    
    
    
    
//    func application(application: UIApplication,
//                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
//        
//        return GIDSignIn.sharedInstance().handle(url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey.rawValue] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
//        
//      //  return GIDSignIn.sharedInstance().handleURL(url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
//    }
    
    //JARED REMOVED 12-3-2020
    /*
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
                                            UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation!]
        
        
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    */
    
    //JARED REMOVED 12-3-2020
    /*
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //Code
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //print did disconnect
    }
    
    */
    
    
    func applicationHandleRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        if application.applicationState == UIApplication.State.background || application.applicationState == UIApplication.State.inactive
        {
            var canDoNow = loadedEnoughToDeepLink
            
            self.deepLink = RemoteNotificationDeepLink.create(userInfo)
            
            if canDoNow
            {
                self.triggerDeepLinkIfPresent()
            }
        }
    }
    
    func triggerDeepLinkIfPresent() -> Bool
    {
        self.loadedEnoughToDeepLink = true
        let ret = (self.deepLink?.trigger() != nil)
        self.deepLink = nil
        return ret
    }

    var tracking = GPSTrackingManager()

    
  //  var locationController: LocationController = LocationController() as LocationController;
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let testBadge = prefs.integer(forKey: "NEARITEMBADGE")
        print("Test Badge = \(testBadge.description)")
        /*
        if prefs.integerForKey("NEARITEMBADGE") == 0 {
            prefs.setInteger(0, forKey: "NEARITEMBADGE")
        }
        */
        
        prefs.set(0, forKey: "NEARITEMBADGE")
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        print("Did launch")
        
        
       /*
        
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum);
        
        var bgTask = UIBackgroundTaskIdentifier()
        bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(bgTask)
        }
        
        if(self.locationController.profileForTracking != nil && self.locationController.profileForTracking != "Disabled" && self.locationController.intervalForTracking != nil && self.locationController.trackingAllowed == true){
            self.locationController.initLocationManager();
            
            if(self.locationController.timer != nil){
                self.locationController.timer = self.locationController.timer;
            } else {
                self.locationController.startTimerForLocationUpdate();
            }
            
            print("Location can now start ....");
            
        }
        
        */
        
        

        
        
        //GOOGLE SIGN IN SET UP
        var configureError: NSError?
       // GGLContext.sharedInstance().configureWithError(&configureError)
        //GGLContext.share
        //GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        
        //JARED REMOVED 12-3-2020
        /*
        GIDSignIn.sharedInstance().clientID = "753257567954-dsj16lu6s2p97jri30t0bhngvsgv6bvg.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        */
        
        
        
        
        
        
        let types: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
        
        let settings = UIUserNotificationSettings(types: types, categories: nil)
       // UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        switch application.backgroundRefreshStatus {
            
        case UIBackgroundRefreshStatus.denied:
            print("background fresh status is denied")
            
        case UIBackgroundRefreshStatus.available:
            print("background fresh status is Available")
            
            if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
                
                
                
                let localNotification = UILocalNotification()
                localNotification.regionTriggersOnce = true
                localNotification.alertBody = "You're on the move!, Prepare for battle"
                //UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
                
                print("it's a location event, start tracking new location")
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Tracking Alert"
                alertView.message = "Tracking your location!"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
              //  alertView.show()
                
                
                tracking.startTracking()
            }
            
            
        case UIBackgroundRefreshStatus.restricted:
            print("background fresh status is restricted")
            
            
        default:
            break
        }
        
        if application.applicationState != UIApplication.State.background {
            let preBackgroundPush = !application.responds(to: #selector(getter: UIApplication.backgroundRefreshStatus))
            let oldPushHandlerOnly = !self.responds(to: "application:didReceiveRemoteNotification")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplication.LaunchOptionsKey.remoteNotification] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                //   PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
            }
            
        }
        
        
        if #available(iOS 10.0, *) {
            
            print("iOS 10 is AVAILABLE")
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
                
                print("REQUESTING iOS 10 Notification Access")
                
                if granted {
                    print("NOTIFICATION ACCESS GRANTED")
                   
                    
                    /*
                    if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
                        
                        print("responds to registeruserNotificationsettign")
                        
                    }
                    
                    
                    */
                    
                    
                     if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
                     
                     print("responds to registeruserNotificationsettign")
                     
                     let FightBackAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
                     FightBackAction.identifier = "FightBack"
                     FightBackAction.title = "Fight Back"
                     FightBackAction.activationMode = UIUserNotificationActivationMode.background
                     FightBackAction.isAuthenticationRequired = false
                     
                     let FleeAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
                     FleeAction.identifier = "RunAway"
                     FleeAction.title = "Run Away"
                     FleeAction.activationMode = UIUserNotificationActivationMode.background
                     FleeAction.isAuthenticationRequired = false
                     
                     let replyActions = NSArray(objects: FightBackAction, FleeAction)
                     let replyActionsMinimal = NSArray(objects: FightBackAction, FleeAction)
                     
                     let replyCategory : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
                     replyCategory.identifier = "actionCategory"
                     replyCategory.setActions(replyActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.default)
                     replyCategory.setActions(replyActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.minimal)
                     
                     let actionCategories = NSSet(object: replyCategory)
                     
                     print("Responds to register notice")
                     let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge]
                     
                     let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: actionCategories as! Set<UIUserNotificationCategory>)
                     
                     application.registerUserNotificationSettings(settings)
                     
                     print("registering for Remote notifications")
                     application.registerForRemoteNotifications()
                     } else {
                     
                     let types: UIRemoteNotificationType = [UIRemoteNotificationType.badge, UIRemoteNotificationType.alert, UIRemoteNotificationType.sound]
                     application.registerForRemoteNotifications(matching: types)
                     //   application.regis
                     
                     }
                    
                    
                    
                    
                    
                    
                  // application.registerForRemoteNotifications()
                    
                }
                
                // Do something here
                
                /*
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    // Enable or disable features based on authorization.
                }
                application.registerForRemoteNotifications()
                */
                
            }
            
           // application.registerForRemoteNotifications()
            
        } else {
            
            /*
            if 1 == 1 {
                
                if #available(iOS 10.0, *) {
                    let center = UNUserNotificationCenter.current()
                    
                    center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        // Enable or disable features based on authorization.
                    }
                    
                    
                    application.registerForRemoteNotifications()
                    
                    
                } else {
                    // Fallback on earlier versions
                }
               
            } else {
                */
        
            
            print("iOS 10 Not AVAILABLE")
        if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
            
            print("responds to registeruserNotificationsettign")
            
            let FightBackAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            FightBackAction.identifier = "FightBack"
            FightBackAction.title = "Fight Back"
            FightBackAction.activationMode = UIUserNotificationActivationMode.background
            FightBackAction.isAuthenticationRequired = false
            
            let FleeAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            FleeAction.identifier = "RunAway"
            FleeAction.title = "Run Away"
            FleeAction.activationMode = UIUserNotificationActivationMode.background
            FleeAction.isAuthenticationRequired = false
            
            let replyActions = NSArray(objects: FightBackAction, FleeAction)
            let replyActionsMinimal = NSArray(objects: FightBackAction, FleeAction)
            
            let replyCategory : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            replyCategory.identifier = "actionCategory"
            replyCategory.setActions(replyActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.default)
            replyCategory.setActions(replyActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.minimal)
            
            let actionCategories = NSSet(object: replyCategory)
            
            print("Responds to register notice")
            let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge]
            
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: actionCategories as! Set<UIUserNotificationCategory>)
            
            application.registerUserNotificationSettings(settings)
            
            print("registering for Remote notifications")
            application.registerForRemoteNotifications()
        } else {
            
           let types: UIRemoteNotificationType = [UIRemoteNotificationType.badge, UIRemoteNotificationType.alert, UIRemoteNotificationType.sound]
            application.registerForRemoteNotifications(matching: types)
       
        }
            
       // }
        
        }
        
     
        
        /*
        if let launchOpts = launchOptions {
            var notificationDetails: NSDictionary = launchOpts.objectForKey(UIApplicationLaunchOptionsRemoteNotificationKey) as NSDictionary
        }
        */
        // Override point for customization after application launch.
        return true
    }
    
    
    /*
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        var bgTask = UIBackgroundTaskIdentifier()
        
        bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(bgTask)
        }
        
        if(self.locationController.profileForTracking != nil && self.locationController.profileForTracking != "Disabled" && self.locationController.intervalForTracking != nil && self.locationController.trackingAllowed == true){
            self.locationController.initLocationManager();
            
            if(self.locationController.timer != nil){
                self.locationController.timer = self.locationController.timer;
            } else {
                self.locationController.startTimerForLocationUpdate();
            }
            
            println("Location can now start ....");
            
        }
    }
*/
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        print("Did Register for user notifications - from Application 'didregisteruser...'")
        
    }
 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("******SHOULD GET DEVICE TOKEN******")
        
        //   println("Device Token: \(deviceToken)")
        
        let DT = deviceToken.hex()
        
        /*
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        */
        
        
          // print("Device DT: \(DT)")
       /*
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock(nil)
        */
        //NSUserDefaults.standardUserDefaults().setValue(DT, forKey: "DT")
        
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
        //  NSUserDefaults.standardUserDefaults().setValue(DT, forKey: "deviceToken")
        
        print("Setting current deviceToken: \(DT)")
    }

    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("LOCAL NOTIFICATION, PRINT ALERT INFO \(notification.alertBody)")
        print("ALERT ACTION = \(notification.alertAction)")
        print("ALERT UserInfo = \(notification.userInfo)")
        
        
        
        if application.applicationState == UIApplication.State.inactive || application.applicationState == UIApplication.State.background {
            
            print("App opened from local notification while in background")
            
        }
        
        
        
        if notification.alertAction == "View Item" {
            
            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
            
            //var jsonAlert = JSON(notificationDetails)
            
            let ItemName = userInfo["ItemName"] as! String
            let ItemLat = userInfo["lat"] as! String
            let ItemLong = userInfo["long"] as! String
            let NotificationMessage = "Go pick up this item!"
            let category = "NearbyItem"
            
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleViewItem"), object: nil, userInfo: ["message":NotificationMessage, "ItemLat":ItemLat, "ItemLong":ItemLong, "ItemName":ItemName, "category":category])
            
            
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 1
        print("Print received local notification")
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info = ",notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Did Receive UNNotificatioResponse User Info = ",response.notification.request.content.userInfo)
        completionHandler()
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        print("DID receive remote notification: \(userInfo)")
        
        
        var notificationDetails: NSDictionary = userInfo as NSDictionary
        
        var jsonAlert = JSON(notificationDetails)
        var NotificationMessage = jsonAlert["aps"]["alert"].stringValue
        var attackedBy = jsonAlert["aps"]["attackedBy"].stringValue
        var category = jsonAlert["aps"]["category"].stringValue
        
 
       // println("tiggering action notificaiton - local")
      //  triggerActionNotification(attackedBy, message: NotificationMessage, theCategory: category)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "HandleAttackMessage"), object: nil, userInfo: ["message":NotificationMessage, "attackedBy":attackedBy, "category":category])
        
        
    }
    
    

    func triggerActionNotification(_ attackFrom: NSString, message: NSString, theCategory: NSString) {
        
        print("local action notification callled")
        
        let prefs:UserDefaults = UserDefaults.standard
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        
        let notification = UILocalNotification()
        notification.alertBody = "\(username), You are under Attack!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.fireDate = Date()
        notification.category = "actionCategory"
        UIApplication.shared.scheduleLocalNotification(notification)
        
        print("Local action not complete")
        
    }
    
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        
        print("Failed to register for Remote Notifications")
      //  NSLog("Failed to get token; error: %@", error)
        print(error.localizedDescription)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        prefs.removeObject(forKey: "NEARITEMSARRAY")
        
        tracking.MonitorSignificantChanges()
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
         tracking.startTracking()
        
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "startvc") as! ViewController
        
        
       // self.window?.rootViewController? = initViewController
        
        //FOREGROUND RESTART APP
       // self.window?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
        

        
        print("App Entered Foreground")
        print("Should Pop to root")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        /*
         
         
         
        let storyboard = UIStoryboard(named; "main", bundle: nil)
        let rootController = storyboard.instantiateViewControllerWithIdentifier("Login")
        
        self.window?
*/
        
        print("Application did become active")
        
        
        
        let testBadge = prefs.integer(forKey: "NEARITEMBADGE")
        print("Badges DID BECOME ACTIVE = \(testBadge.description)")
        prefs.set(0, forKey: "NEARITEMBADGE")
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        print("Application will terminate")
        
        tracking.MonitorSignificantChanges()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ClavenSolutions.BattleField" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "BattleField", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("BattleField.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch  {
            /*
           // error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as AnyObject
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            */
            print("error is \(error)")
            
            abort()
        }
        
        
        /*
         } catch var error1 as NSError {
         error = error1
         coordinator = nil
         // Report any error we got.
         var dict = [String: AnyObject]()
         dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
         dict[NSLocalizedFailureReasonErrorKey] = failureReason
         dict[NSUnderlyingErrorKey] = error
         error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
         // Replace this with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         NSLog("Unresolved error \(error), \(error!.userInfo)")
         abort()
         }
 
 */
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    
                    print("Error = \(error)")
                    abort()
                }
                
                /*let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
 */
            }
        }
    }

}

extension Data {
    func hex(separator:String = "") -> String {
        return (self.map { String(format: "%02.2hhx", $0) }).joined(separator: separator)
        //%02.2hhx
        //%02X
    }
}

