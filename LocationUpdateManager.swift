//
//  LocationUpdateManager.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/24/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


class GPSTrackingManager: NSObject, CLLocationManagerDelegate {
    
    var prefs:UserDefaults = UserDefaults.standard
    var username = NSString()
    var email = NSString()
    var locationManager: CLLocationManager!
    var seenError : Bool = false
    var TrackingOn = Bool()
    var locations = [MKPointAnnotation]()
    
    func checkLocationAuthorizationStatus(_ manager: CLLocationManager!, status: CLAuthorizationStatus) -> Bool {
        switch status {
        case .authorizedAlways:
            print("Authorized")
            return true
        case .authorizedWhenInUse, .denied, .restricted:
            return false
        case .notDetermined:
            print("NotDetermined")
            manager.requestAlwaysAuthorization()
        default:
            print("Default")
            return false
        }
        return false
    }
    
    
    class func sharedManager() -> AnyObject {
        let sharedMyModel: AnyObject? = nil
        var onceToken: Int
        //var onceToken: UnsafeMutablePointer
        
      
        
    //    dispatch_once(onceToken, {() -> Void in
    //        sharedMyModel = self()
     //   })
        return sharedMyModel!
    }
    
    
    func startTracking() {
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        } else {
            username = "UnknownUsername"
            email = "UnknowEmail"
            
        }
        
        
        
        
        TrackingOn = checkLocationAuthorizationStatus(locationManager, status: CLLocationManager.authorizationStatus() )
        
        
        let PreventBackgroundTracking = UserDefaults.standard.bool(forKey: "DoNotTrackInBackground")
        
        if !PreventBackgroundTracking {
        
        if TrackingOn {
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let PauseTrackingAuto = UserDefaults.standard.bool(forKey: "ImproveBatteryPauseTracking")
            
        print("****!!!!PAUSING BACKGROUND = \(PauseTrackingAuto)")
            
        locationManager.pausesLocationUpdatesAutomatically = PauseTrackingAuto
            //false
            
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
            
        } else {
            
            print("Unable to track because it's not authorized")
            
        }
        
        } else {
            
            print("Background Tracking has been disabled by user")
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    
    func sendBackgroundLocationToServer(_ location: CLLocation) {
        
        
        let BGT: UIBackgroundTaskIdentifier = 0
        
        let bgTask = UIApplication.shared.beginBackgroundTask( expirationHandler: {
            
            UIApplication.shared.endBackgroundTask(BGT)
            
        })
        
        
        
        if (bgTask != UIBackgroundTaskInvalid) {
            
            UIApplication.shared.endBackgroundTask(0)
           // bgTask = UIApplicationTaskInvalid
            
        }
        
        
        
    }
    
    func StopMonitoringSignificantChanges() {
        print("Stopped Monitoring Significant Changes")
        
        if locationManager != nil {
            print("Location Manager was not Nil")
            locationManager.stopMonitoringSignificantLocationChanges()
            
            print("Location Manager start tracking again")
            
            self.startTracking()
            
        }
        
    }
    
    
    func MonitorSignificantChanges() {
        
        let localNotification = UILocalNotification()
        localNotification.regionTriggersOnce = true
        localNotification.alertBody = "Monitor Significant Changes - Significant Location Change, saving Location"
        
//        print("Send Notification while in the background")
//        
//        
//        
//        localNotification.regionTriggersOnce = true
//        localNotification.alertAction = "View Item"
//        localNotification.userInfo = ["ItemName":"AssaultRifle","lat":"28.898","long":"-81.22787"]
//        localNotification.alertBody = "Item Alert: AssaultRifle nearby to pick up!"
//        //localNotification.category
//        localNotification.category = "itemReminderCategory"
        
        
        
        
       // UIApplication.shared.scheduleLocalNotification(localNotification)
       // NSLog("Entering region")
        
        

                if prefs.value(forKey: "USERNAME") != nil {
                    username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                    email = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
                } else {
                    username = "UnknownUsername"
                    email = "UnknownEmail"
                    
                }
                
                
                
                
                TrackingOn = checkLocationAuthorizationStatus(locationManager, status: CLLocationManager.authorizationStatus() )
                
                if TrackingOn {
                    
                    
                    locationManager = CLLocationManager()
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.requestAlwaysAuthorization()
                   // locationManager.startUpdatingLocation()
                    locationManager.startMonitoringSignificantLocationChanges()
                    locationManager.pausesLocationUpdatesAutomatically = false
                    
                    if #available(iOS 9.0, *) {
                        locationManager.allowsBackgroundLocationUpdates = true
                    } else {
                        // Fallback on earlier versions
                    }
                    
                } else {
                    
                    print("Unable to track because it's not authorized")
                    
                }
        }
    
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        //println("locations = \(locationManager)")
        
        
        
        
        
        let latValue = locationManager.location!.coordinate.latitude
        let lonValue = locationManager.location!.coordinate.longitude
        let altValue = locationManager.location!.altitude
        
      //  print("Lat Value: \(latValue)")
      //  print("Long Value: \(lonValue)")
        
        let mylatRefresh = latValue 
        let mylongRefresh = lonValue
        let myaltRefresh = altValue
        var SavedLatitude = Double()
        var SavedLongitude = Double()
        var SavedAltitude = Double()
        
        if prefs.value(forKey: "MYLATITUDE") != nil {
            //print("Lat Stored in Core Data")
            SavedLatitude = prefs.value(forKey: "MYLATITUDE") as! Double
            SavedLongitude = prefs.value(forKey: "MYLONGITUDE") as! Double
            
            if prefs.value(forKey: "MYALTITUDE") != nil {
            SavedAltitude = prefs.value(forKey: "MYALTITUDE") as! Double
            } else {
            SavedAltitude = 0.00
            }
        } else {
            SavedLatitude = 0.00
            SavedLongitude = 0.00
            SavedAltitude = 0.00
            
            
        }
        
      //  print("Core Data Lat: \(SavedLatitude)")
      //  print("Core Data Long: \(SavedLongitude)")
        
        
        //let SavedLatitude = prefs.valueForKey("MYLATITUDE") as! Double
        //let SavedLongitude = prefs.valueForKey("MYLONGITUDE") as! Double
        
        let SavedCoord = CLLocation(latitude: SavedLatitude, longitude: SavedLongitude)
        let CurrentCoord = CLLocation(latitude: latValue, longitude: lonValue)
        
        let meters = CurrentCoord.distance(from: SavedCoord)
     //   print("Meters Distance = \(meters)")
        
        if meters > 5 {
            
      //  print("distance from saved spot to new spot is greater than 5 Meters")
        
        if ((SavedLatitude == latValue) && (SavedLongitude == lonValue)) {
            
         //   print("No location change, not saving the data")
            
        } else {
        
        prefs.setValue(latValue, forKey: "MYLATITUDE")
        prefs.setValue(lonValue, forKey: "MYLONGITUDE")
        prefs.setValue(altValue, forKey: "MYALTITUDE")
        
            backgroundThread(background: {
                //self.GetPublicTurns()
             //   print("BACKGROUND THREAD - Updating Users' location")
                if SaveMyLoc(self.username, latitude: mylatRefresh, longitude: mylongRefresh, email: self.email, altitude: myaltRefresh) {
                  //  print("My loc (lat: \(mylatRefresh) long: \(mylongRefresh)) have been saved to server")
                    // return true
                }
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        //self.GetMyHUD.removeFromSuperview()
                        //  self.tableView.reloadData()
                      //  print("DISPATCH ASYNC - Finished Updating the users' location")
                    })
                    // print("Done Getting Steal Turns")
                    //   self.kolodaView.resetCurrentCardNumber()
            })
        
        }
            
        }
        
    }
    
   // func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    
    /*
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.newLocation
        let fromLocation = locations.fromLocation
        
        
        let localNotification = UILocalNotification()
        localNotification.regionTriggersOnce = true
        localNotification.alertBody = "Significant Location Change, saving Location"
       // UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        
        
      //  print("LOCATION CHANGED FROM ONE TO ANOTHER")
        /*
        var IsInBackground = false
        if UIApplication.sharedApplication().applicationState == UIApplicationState.Background {
            IsInBackground = true
        }
        
        if IsInBackground {
            sendBackgroundLocationToServer(newLocation)
        }
        
        */
        
        if UIApplication.shared.applicationState != .active {
            print("App is backgrounded. New location is %@", newLocation)
        }
        
        
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newLocation.coordinate
        
        // Also add to our map so we can remove old values later
        locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = locations.first!
            locations.remove(at: 0)
            
            // Also remove from the map
            //mapView.removeAnnotation(annotationToRemove)
        }
        
        if UIApplication.shared.applicationState == .active {
         //   mapView.showAnnotations(locations, animated: true)
        } else {
            //print("App is in backgrounded. New location is %@", newLocation)
            let newLat = newLocation.coordinate.latitude
            let newLong = newLocation.coordinate.longitude
            
            
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
            
                    
                    prefs.setValue(newLat, forKey: "MYLATITUDE")
                    prefs.setValue(newLong, forKey: "MYLONGITUDE")
                    
                    backgroundThread(background: {
                        //self.GetPublicTurns()
                      //  print("BACKGROUND THREAD - Updating Users' location")
                        if SaveMyLoc(self.username, latitude: newLat, longitude: newLong) {
                            localNotification.alertBody = "My loc (lat: \(newLat) long: \(newLong)) have been saved to server"
                            
                            UIApplication.shared.scheduleLocalNotification(localNotification)
                            
                            
                        
                            // return true
                        }
                        }, completion: {
                            
                            DispatchQueue.main.async(execute: {
                                //self.GetMyHUD.removeFromSuperview()
                                //  self.tableView.reloadData()
                             //   print("DISPATCH ASYNC - Finished Updating the users' location")
                            })
                            // print("Done Getting Steal Turns")
                            //   self.kolodaView.resetCurrentCardNumber()
                    })
                    
            
            
            
            
        }
    }
    */
    

}








func backgroundThread(_ delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
    // dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
        if(background != nil){ background!(); }
        
        let popTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            if(completion != nil){ completion!(); }
        }
    }
}
