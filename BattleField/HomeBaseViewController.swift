//
//  HomeBaseViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/12/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class HomeBaseViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    @IBOutlet weak var segmentViewHolder: UIView!
    
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    @IBOutlet weak var moneyLBL: UILabel!
    
    var ShouldViewHQ = Bool()
    
    @IBOutlet weak var safeView: UIView!
    
    @IBOutlet weak var fixView: UIView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    var prefs:UserDefaults = UserDefaults.standard
    var mylat = Double()
    var mylong = Double()
    var myalt = Double()
    var myloc = CLLocation()
    var CenterOnUser = Bool()
    var TrackingOn = Bool()
    var LocManager = CLLocationManager()
    var UserZoomRadius = Double()
    
    var email = NSString()
    var username = NSString()
    var homelevel = NSString()
    var homegoldAmount = String()
    var homeID = String()
    var homeImageName: String = "HQlevel1_100"
    var homeName = String()
    var homestartupgrade = String()
    var homeendupgrade = String()
    var homeStatus = String()
    
    var ZoomLevel = Double()
    var AfterStartupLoad = Bool()
    var restrictedRegion: MKCoordinateRegion!
    var regionRadius : CLLocationDistance = 1000
    
    @IBOutlet weak var SetLocView: UIView!
    @IBOutlet weak var MapHolderView: UIView!
    
    @IBOutlet weak var SetLocViewX: NSLayoutConstraint!
    @IBOutlet weak var SetLocViewH: NSLayoutConstraint!
    
    @IBOutlet weak var buttonMsgLBL: UILabel!
    
    var HomeLat = Double()
    var HomeLong = Double()
    var HomeAlt = Double()
    var HomeSet = Bool()
    
    var HomeReset = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = prefs.value(forKey: "USERNAME") as! NSString
            email =  prefs.value(forKey: "EMAIL") as! NSString
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        //UIColor(red: 145.0, green: 38.0, blue: 27.0, alpha: 1.0)
        let CR: CGFloat = 50
        self.SetLocView.layer.cornerRadius = CR
        self.SetLocView.layer.masksToBounds = true
        self.SetLocView.clipsToBounds = true
        self.SetLocView.layer.borderWidth = 2
        self.SetLocView.layer.borderColor = UIColor.white.cgColor
        
        //let CR: CGFloat = 50
        self.safeView.layer.cornerRadius = CR
        self.safeView.layer.masksToBounds = true
        self.safeView.clipsToBounds = true
        self.safeView.layer.borderWidth = 2
        self.safeView.layer.borderColor = UIColor.white.cgColor
        
        self.fixView.layer.cornerRadius = CR
        self.fixView.layer.masksToBounds = true
        self.fixView.clipsToBounds = true
        self.fixView.layer.borderWidth = 2
        self.fixView.layer.borderColor = UIColor.white.cgColor
        
        
        self.MapHolderView.layer.cornerRadius = 5
        self.MapHolderView.layer.masksToBounds = true
        self.MapHolderView.clipsToBounds = true
        self.MapHolderView.layer.borderWidth = 2
        self.MapHolderView.layer.borderColor = UIColor.white.cgColor
        
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(MapViewController.ScrollViewSwipeDown(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
       // self.ScrollItemsView.addGestureRecognizer(swipeDown)
        
        self.mapView.delegate = self
        self.mapView.mapType = MKMapType.satellite
        self.mapView.isUserInteractionEnabled = false
        
         let currentZoom = mapView.zoomLevel

        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeBaseViewController.HQTransferMoneyNotification(_:)), name: NSNotification.Name(rawValue: "HQTransferMoneyNotification"),  object: nil)
        
        
        segmentControl.items = ["Headquarters", "Current Location"]
        segmentControl.font = UIFont(name: "Verdana", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor.darkGray
        segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(HomeBaseViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        HomeSet = prefs.bool(forKey: "HomeSet")
        
        if !HomeSet {
            ShouldViewHQ = false
            self.segmentViewHolder.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
           
            ShouldViewHQ = true
            var updateRegion: Bool = false

            
            var locationTemp = CLLocationCoordinate2D()
            
            if HomeSet {
                
                // if prefs.value(forKey: "HomeLat") != nil {
                HomeLat = prefs.value(forKey: "HomeLat") as! Double
                HomeLong =  prefs.value(forKey: "HomeLong") as! Double
                
                locationTemp = CLLocationCoordinate2D(latitude: HomeLat, longitude: HomeLong)
            } else {
                locationTemp = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
            }

            var spanTemp = MKCoordinateSpan()
            
            
            spanTemp = MKCoordinateSpan (latitudeDelta: 0.003, longitudeDelta: 0.003)
            
            restrictedRegion = MKCoordinateRegion(center: locationTemp, span: spanTemp)
            
            
            if ((mapView.region.span.latitudeDelta > restrictedRegion.span.latitudeDelta * 4) || (mapView.region.span.longitudeDelta > restrictedRegion.span.longitudeDelta * 4) ) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.latitude - restrictedRegion.center.latitude) > restrictedRegion.span.latitudeDelta) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.longitude - restrictedRegion.center.longitude) > restrictedRegion.span.longitudeDelta) {
                updateRegion = true
            }
            if (updateRegion) {
                //  self.manuallyChangingMap = true
                print("Updating region is true")
                self.mapChangedFromUserInteraction = true
                mapView.setRegion(restrictedRegion, animated:true)
                self.mapChangedFromUserInteraction = false
                
                self.AfterStartupLoad = true
                // self.manuallyChangingMap = false
            }
            
           
            
        } else if segmentControl.selectedIndex == 1 {
            
            ShouldViewHQ = false
            var updateRegion: Bool = false
            
            
          //
            
            var curLoc = CLLocation()
            var curLocManager = CLLocationManager()
            curLoc = curLocManager.location!
            var myLocNow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
            
            mylat = curLoc.coordinate.latitude
            mylong = curLoc.coordinate.longitude
            myalt = curLoc.altitude
            
            var  locationTemp = CLLocationCoordinate2D(latitude: mylat, longitude: mylong)

            
            /*
            if HomeSet {
                
                // if prefs.value(forKey: "HomeLat") != nil {
                HomeLat = prefs.value(forKey: "HomeLat") as! Double
                HomeLong =  prefs.value(forKey: "HomeLong") as! Double
                
                locationTemp = CLLocationCoordinate2D(latitude: HomeLat, longitude: HomeLong)
            } else {
                locationTemp = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
            }
            
            */
            
            var spanTemp = MKCoordinateSpan()
            
            
            spanTemp = MKCoordinateSpan (latitudeDelta: 0.003, longitudeDelta: 0.003)
            
            restrictedRegion = MKCoordinateRegion(center: locationTemp, span: spanTemp)
            
            
            if ((mapView.region.span.latitudeDelta > restrictedRegion.span.latitudeDelta * 4) || (mapView.region.span.longitudeDelta > restrictedRegion.span.longitudeDelta * 4) ) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.latitude - restrictedRegion.center.latitude) > restrictedRegion.span.latitudeDelta) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.longitude - restrictedRegion.center.longitude) > restrictedRegion.span.longitudeDelta) {
                updateRegion = true
            }
            if (updateRegion) {
                //  self.manuallyChangingMap = true
                print("Updating region is true")
                self.mapChangedFromUserInteraction = true
                mapView.setRegion(restrictedRegion, animated:true)
                self.mapChangedFromUserInteraction = false
                
                self.AfterStartupLoad = true
                // self.manuallyChangingMap = false
            }
          
            
        } else {
            
           
            
            DispatchQueue.main.async(execute: {
                //    self.actInd.hidden = true
                //    self.actInd.stopAnimating()
            })
           
        }
    }
    
    @objc func HQTransferMoneyNotification(_ notification:Notification) {
    
        
        let alertController = UIAlertController(
            title: "Personal Safe",
            message: "Would you like to deposit or withdraw funds?",
            preferredStyle: .alert)
    
         let depositAction = UIAlertAction(title: "Deposit", style: .default) { (action) in
        
        
            let alertControllerDeposit = UIAlertController(
                title: "Deposit Funds",
                message: "Enter the amount you want to deposit?",
                preferredStyle: .alert)
        
        
        alertControllerDeposit.addTextField { (textField: UITextField!) in
            // textField.n
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = "$ Amount"
            textField.isSecureTextEntry = true
            textField.textAlignment = .center
        }
        
        let depositAction = UIAlertAction(title: "Deposit", style: .default) { (action) in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            if firstTextField.text != "" {
                let alertControllerError = UIAlertController(
                    title: "Success",
                    message: "Deposit Complete",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                   // UserDefaults.standard.set(true, forKey: "SecuritySet")
                    
                   
                }
                alertControllerError.addAction(cancelAction)
                self.present(alertControllerError, animated: true, completion: nil)
                
                
            } else {
                
                let alertControllerError = UIAlertController(
                    title: "Amount?",
                    message: "Please enter an amount to deposit",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    
                }
                alertControllerError.addAction(cancelAction)
                self.present(alertControllerError, animated: true, completion: nil)
                
                
                
            }
            
        }
        

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
           // let firstTextField = alertController.textFields![0] as UITextField
            
        }
        
        
        
        
        alertControllerDeposit.addAction(depositAction)
        //alertController.addAction(withdrawAction)
        alertControllerDeposit.addAction(cancelAction)
        
        self.present(alertControllerDeposit, animated: true, completion: nil)
            
        }
        
        let withdrawAction = UIAlertAction(title: "Withdraw", style: .default) { (action) in
            
            
            let alertControllerDeposit = UIAlertController(
                title: "Withdraw Funds",
                message: "Enter the amount you want to withdraw?",
                preferredStyle: .alert)
            
            
            alertControllerDeposit.addTextField { (textField: UITextField!) in
                // textField.n
                textField.keyboardType = UIKeyboardType.numberPad
                textField.placeholder = "Security Code"
                textField.isSecureTextEntry = true
                textField.textAlignment = .center
            }
            
            let depositAction = UIAlertAction(title: "Withdraw", style: .default) { (action) in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                if firstTextField.text != "" {
                    let alertControllerError = UIAlertController(
                        title: "Success",
                        message: "Withdrawn Complete",
                        preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                       // UserDefaults.standard.set(true, forKey: "SecuritySet")
                        
                        
                    }
                    alertControllerError.addAction(cancelAction)
                    self.present(alertControllerError, animated: true, completion: nil)
                    
                    
                } else {
                    
                    let alertControllerError = UIAlertController(
                        title: "Amount?",
                        message: "Please enter an amount to withdrawn",
                        preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        
                    }
                    alertControllerError.addAction(cancelAction)
                    self.present(alertControllerError, animated: true, completion: nil)
                    
                    
                    
                }
                
            }
            

            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                
              //  let firstTextField = alertController.textFields![0] as UITextField
                
            }
            
            
            
            
            alertControllerDeposit.addAction(depositAction)
            //alertController.addAction(withdrawAction)
            alertControllerDeposit.addAction(cancelAction)
            
            self.present(alertControllerDeposit, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
          //  let firstTextField = alertController.textFields![0] as UITextField
            
        }
        
        alertController.addAction(depositAction)
        alertController.addAction(withdrawAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       // prefs.set(false, forKey: "HomeSet")
        HomeSet = prefs.bool(forKey: "HomeSet")
        print("HomeSet: \(HomeSet)")
       // HomeSet = false
        
        mapView.showsUserLocation = true
        
        if HomeSet {
            
            ShouldViewHQ = true
            self.segmentViewHolder.isHidden = false
            
            
            HomeLat = prefs.value(forKey: "HomeLat") as! Double
            HomeLong = prefs.value(forKey: "HomeLong") as! Double
            HomeAlt = prefs.value(forKey: "HomeAlt") as! Double
            homelevel = prefs.value(forKey: "HomeLevel") as! NSString
            homeID = prefs.value(forKey: "HomeID") as! String
            homeImageName = prefs.value(forKey: "HomeimageName") as! String
            homegoldAmount = prefs.value(forKey: "HomeGoldAmount") as! String
            homeName = prefs.value(forKey: "HomeName") as! String
            homestartupgrade = prefs.value(forKey: "HomeStartUpgrade") as! String
            homeendupgrade = prefs.value(forKey: "HomeEndUpgrade") as! String
            homeStatus = prefs.value(forKey: "HomeStatus") as! String
            
            let CR: CGFloat = 50
            // self.SetLocView.layer.cornerRadius = CR
            self.buttonMsgLBL.text = "Update Location"
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.SetLocView.center.x = self.SetLocView.center.x - 0
                self.SetLocView.layer.cornerRadius = CR
                self.SetLocViewH.constant = 100
                //self.TableViewTOP.constant = 100
            })
            
            
            
            var curLoc = CLLocation()
            var curLocManager = CLLocationManager()
            curLoc = curLocManager.location!
            var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
            
            mylat = curLoc.coordinate.latitude
            mylong = curLoc.coordinate.longitude
            myalt = curLoc.altitude
            
            print("HQ - MY LAT: \(mylat)")
            print("HQ - MY LONG: \(mylong)")
            
            print("HQ - HOME LAT: \(HomeLat)")
            print("HQ - HOME LONG: \(HomeLong)")
            
            let userCoordinate = CLLocationCoordinate2D(latitude: self.HomeLat, longitude: self.HomeLong)
            
            let eyeLat = HomeLat - 0.021078
            let eyeLong = HomeLong + 0.04904
            let eyeCoordinate = CLLocationCoordinate2D(latitude: eyeLat, longitude: eyeLong)
            let mapCamera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 500.0)
            
            mapView.setCamera(mapCamera, animated: true)
            FocusOnHomeLocation(HomeLat, missionLong: HomeLong, homeSet: HomeSet, missionAlt: HomeAlt)
            
            
        } else {
        print("home not set!!!")
            ShouldViewHQ = false
            self.segmentViewHolder.isHidden = true
            
            let CR: CGFloat = 50
            self.SetLocView.layer.cornerRadius = CR
            
            self.buttonMsgLBL.text = "Set Location"
        
          //  HomeLat = prefs.value(forKey: "HomeLat") as! Double
          //  HomeLong = prefs.value(forKey: "HomeLong") as! Double
            homelevel = "1"
            homeID = "home"
            homeImageName = "HQLevel1_100"
            homegoldAmount = "0"
            homeName = "My Home"
            homestartupgrade = "2017-01-01 12:00:00"
            homeendupgrade = "2017-01-01 12:00:00"
            homeStatus = "NA"
        
        var curLoc = CLLocation()
        var curLocManager = CLLocationManager()
        curLoc = curLocManager.location!
        var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
        
        mylat = curLoc.coordinate.latitude
        mylong = curLoc.coordinate.longitude
        myalt = curLoc.altitude
        
        let userCoordinate = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
        
        let eyeLat = mylat - 0.021078
        let eyeLong = mylong + 0.04904
        let eyeCoordinate = CLLocationCoordinate2D(latitude: eyeLat, longitude: eyeLong)
        let mapCamera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 100.0)
        
        
            FocusOnHomeLocation(mylat, missionLong: mylong, homeSet: HomeSet, missionAlt: myalt)
        
      }
    
    }
    
    @IBAction func SetLocationBTN(_ sender: Any) {
        
        var msgTitle = String()
        var msgMSG = String()
        if self.HomeSet {
            msgTitle = "Update Location?"
            msgMSG = "Move your Headquarters to your current location?"
        } else {
            msgTitle = "Set Location?"
            msgMSG = "Set your current location as your Headquarters?"
        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: "\(msgTitle)", message: "\(msgMSG)", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            
            if !self.HomeSet {
                
                let homeinfoUpdated = ManageHomeInfo(self.email, username: self.username, level: self.homelevel, status: self.homeStatus as! NSString, action: "add", lat: self.mylat.description as! NSString, long: self.mylong.description as! NSString, id: self.homeID as! NSString, startupgrade: self.homestartupgrade as! NSString, endupgrade: self.homeendupgrade as! NSString, goldamount: self.homegoldAmount as! NSString, alt: self.myalt.description as! NSString)
                
                
                if homeinfoUpdated {
                    
                    self.HomeSet = true
                    
                    UserDefaults.standard.set(true, forKey: "HomeSet")
                    UserDefaults.standard.set(self.mylat, forKey: "HomeLat")
                    UserDefaults.standard.set(self.mylong, forKey: "HomeLong")
                     UserDefaults.standard.set(self.myalt, forKey: "HomeAlt")
                    UserDefaults.standard.set(self.homelevel, forKey: "HomeLevel")
                    UserDefaults.standard.set(self.homeImageName, forKey: "HomeimageName")
                    UserDefaults.standard.set(self.homeName, forKey: "HomeName")
                    UserDefaults.standard.set(self.homeID, forKey: "HomeID")
                    
                    self.HomeReset = true
                    
                    
                    self.FocusOnHomeLocation(self.mylat, missionLong: self.mylong, homeSet: self.HomeSet, missionAlt: self.myalt)
                    
                    
                    let actionSheetControllerError: UIAlertController = UIAlertController(title: "Success", message: "Your Headquarters location has been updated.", preferredStyle: .alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                        
                    }
                    
                    
                    actionSheetControllerError.addAction(cancelAction)
                    
                    self.present(actionSheetControllerError, animated: true, completion: nil)
                    
                } else {
                    
                   
                    let actionSheetControllerError: UIAlertController = UIAlertController(title: "Error", message: "There was an error updating your Headquarters location.  Please try again later.", preferredStyle: .alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                        
                    }

                    
                    actionSheetControllerError.addAction(cancelAction)
                    
                    self.present(actionSheetControllerError, animated: true, completion: nil)
                    
                    
                }
                
            } else {
                
                let homeinfoUpdated = ManageHomeInfo(self.email, username: self.username, level: self.homelevel, status: self.homeStatus as! NSString, action: "updateLocation", lat: self.mylat.description as! NSString, long: self.mylong.description as! NSString, id: self.homeID as! NSString, startupgrade: self.homestartupgrade as! NSString, endupgrade: self.homeendupgrade as! NSString, goldamount: self.homegoldAmount as! NSString, alt: self.myalt.description as! NSString)
            
                if homeinfoUpdated {
                    
                    self.HomeSet = true
                    UserDefaults.standard.set(true, forKey: "HomeSet")
                    UserDefaults.standard.set(self.mylat, forKey: "HomeLat")
                    UserDefaults.standard.set(self.mylong, forKey: "HomeLong")
                    UserDefaults.standard.set(self.myalt, forKey: "HomeAlt")
                    UserDefaults.standard.set(self.homelevel, forKey: "HomeLevel")
                    UserDefaults.standard.set(self.homeImageName, forKey: "HomeimageName")
                    UserDefaults.standard.set(self.homeName, forKey: "HomeName")
                    UserDefaults.standard.set(self.homeID, forKey: "HomeID")
                    
                     self.HomeReset = true
                    
                    self.FocusOnHomeLocation(self.mylat, missionLong: self.mylong, homeSet: self.HomeSet, missionAlt: self.myalt)
                    
                    
                    let actionSheetControllerError: UIAlertController = UIAlertController(title: "Success", message: "Your Headquarters location has been set.  Would you like to refresh the locations of your missions?", preferredStyle: .alert)
                    
                    //Create and add the Cancel action
                    
                    
                    let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                        
                        
                        let actionSheetControllerMission: UIAlertController = UIAlertController(title: "Success", message: "Your Missions have been updated.", preferredStyle: .alert)
                        
                        //Create and add the Cancel action

                        
                        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                            
                            
                        }
                        
                        
                        actionSheetControllerMission.addAction(cancelAction)
                        
                        self.present(actionSheetControllerMission, animated: true, completion: nil)
                        

                        
                    }
                    
                    
                    let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
                        

                    }
                    
                    
                    actionSheetControllerError.addAction(cancelAction)
                    actionSheetControllerError.addAction(yesAction)
                    
                    self.present(actionSheetControllerError, animated: true, completion: nil)
                    
                } else {
                    
                    
                    let actionSheetControllerError: UIAlertController = UIAlertController(title: "Error", message: "There was an error saving your Headquarters location.  Please try again later.", preferredStyle: .alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                        
                    }
                    
                    
                    actionSheetControllerError.addAction(cancelAction)
                    
                    self.present(actionSheetControllerError, animated: true, completion: nil)
                    
                    
                }
                
            }
           // let homeinfoData = AddTarget(self.email, username: self.username, id: idTemp, lat: latTemp, long: longTemp, level: levelTemp, status: "incomplete", objective: objectiveTemp, xp: xpTemp, action: actionTemp, name: nameTemp, targetID: targetIDTemp))
           
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    func checkLocationAuthorizationStatus(_ manager: CLLocationManager!, status: CLAuthorizationStatus) -> Bool {
        switch status {
        case .authorizedAlways:
            print("Authorized")
            prefs.set(true, forKey: "TRACKINGON")
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
    
    
    var mapChangedFromUserInteraction = false
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
        
        // print("Region Will Change:  UserZoom Radius = \(UserZoomRadius)")
        
        if (mapChangedFromUserInteraction) {
            // user will change map region
            
            self.CenterOnUser = false
            
           // self.CenterUserBTN.setImage(UIImage(named: "Center Direction-50.png"), for: UIControl.State())
            
            //  print("user WILL change map.")
        }
        
    }
    
    
    
    fileprivate func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended ) {
                    // print("map region changed by user gesture")
                    return true
                }
            }
        }
        return false
    }
    
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
        // let location = locations.
        
        
        
        
        myloc = LocManager.location!
        mylat = myloc.coordinate.latitude
        mylong = myloc.coordinate.longitude
        
        //prefs.setValue(mylat.description, forKey: "MYCURRENTLAT")
        //prefs.setValue(mylong.description, forKey: "MYCURRENTLONG")
        
        if CenterOnUser {
            
            //   print("Center on User while driving")
            
            regionRadius = 200
            
            //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
            
            //     print("Center Map on User - Region Radius = \(regionRadius)")
            
            
            let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude).coordinate, latitudinalMeters: regionRadius * 5.0, longitudinalMeters: regionRadius * 5.0)
            
            // mapView.setCenterCoordinate(location.coordinate, animated: true)
            
            ZoomLevel = self.UserZoomRadius
            
            
            //   mapView.setCenterCoordinateZoom(location.coordinate, zoomLevel: ZoomLevel, animated: true)
            // print("Centering with zoom level \(ZoomLevel)")
            
            /*
            if !CapturingTerritory {
                
                
                
                //mapView.setRegion(coordinateRegion, animated: true)
                
                let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
                
                if !mapChangedFromUserInteraction {
                    
                    
                    if AfterStartupLoad {
                        
                        mapView.setCenter(myloc.coordinate, animated: true)
                        
                    }
                    
                }
                
                // print("Starting View: New Room Radius = \(NewZoomRadius)")
                
                //  mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: (NewZoomRadius), animated: true)
                
                
            }
            */
            
            /*
             else {
             
             mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mylat, longitude: mylong), zoomLevel: 17.9, animated: true)
             
             mapView.setCenterCoordinate(myloc.coordinate, animated: true)
             
             }
             
             */
        }
   
        
    }
    
    func GetZoom() -> Double {
        
        let CurrentZoom = mapView.zoomLevel()
        return Double(CurrentZoom)
        
    }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
        
        let TempZoomRadius = GetZoom()
        let TempZoomExp = 20 - TempZoomRadius
        
       
        
        if (mapChangedFromUserInteraction) {
            
            
            
            self.CenterOnUser = false
        
            print("user CHANGED map.")
            
            if TempZoomExp == 18 {
                
                print("ZOOMED IN TOO CLOSE, ZOOM OUT!")
                /*
                 if !AnnotationTapped {
                 
                 mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: 17.9, animated: true)
                 
                 let TempZoomRadiusTest = GetZoom()
                 let TempZoomExpTest = 20 - TempZoomRadiusTest
                 
                 //  print("Test Region Did Change: Allowed Zoom Radius (UserZoomRadius) = \(UserZoomRadiusTest)")
                 print("Test Region Did Change: Current Zoom Exponent = \(TempZoomExpTest)")
                 
                 }
                 
                 */
                
            } else {
                
                /*
                
                if TempZoomRadius <= (UserZoomRadius) {
                    // print("\(TempZoomRadius) <= \(UserZoomRadius)")
                    
                    print("Zoom is less than user zoom radius: current zoom - \(TempZoomRadius), max zoom - \(UserZoomRadius)")
                    
                    
                } else {
                    //print("\(TempZoomRadius) > \(UserZoomRadius)")
                    print("User Exceeded Zoom Radius, zooming in now")
                    
                    let subViews = self.view.subviews
                    for subview in subViews{
                        if subview.tag == 1000 {
                           // self.CapturingTerritory = false
                            subview.removeFromSuperview()
                        }
                    }
                    
                    DispatchQueue.main.async(execute: {
                        var view = MessageInfoView.instanceFromNib("View Range Exceeded")
                        view.tag = 1000
                        self.view.addSubview(view)
                    })
                    
                    //mapView.setCoordinateZoom(mapView.centerCoordinate, zoomLevel: (UserZoomRadius * 10), animated: true)
                    let NewZoomRadius = ConvertZoomRadius(UserZoomRadius)
                    
                    
                    print("New Room Radius = \(NewZoomRadius)")
                    
                    mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: (NewZoomRadius), animated: true)
                    
                    //mapView.setCenterCoordinateZoom(CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude), zoomLevel: (UserZoomRadius * 10), animated: true)
                    
                   // ShowZoomRadiusError()
                    
                    switch UserZoomRadius {
                    case 1:
                        regionRadius = (UserZoomRadius * 10000)
                    default:
                        regionRadius = (UserZoomRadius * 100)
                    }
                    // regionRadius = (UserZoomRadius * 1000)
                    //regionRadius = (UserZoomRadius * 100)
                    
                    //centerMapOnLocation(CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude))
                    //mapView.centerCoordinate.)
                    //   print("reset Region to center with zoom level of \(UserZoomRadius)")
                }
                
                */
            }
            
        } else {
            
            // print("Region Changed, NOT from manual interaction")
            var updateRegion: Bool = false
            
            // var locationTemp = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
            
            //  print("My Lat: \(mylat)")
            //   print("My Long: \(mylong)")
            
            var locationTemp = CLLocationCoordinate2D()
            
            if ShouldViewHQ {
            
            if HomeSet {
            
           // if prefs.value(forKey: "HomeLat") != nil {
                HomeLat = prefs.value(forKey: "HomeLat") as! Double
                HomeLong =  prefs.value(forKey: "HomeLong") as! Double
                HomeAlt = prefs.value(forKey: "HomeAlt") as! Double
                
                locationTemp = CLLocationCoordinate2D(latitude: HomeLat, longitude: HomeLong)
            } else {
                locationTemp = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
            }

            
            } else {
                
                var curLoc = CLLocation()
                var curLocManager = CLLocationManager()
                curLoc = curLocManager.location!
                var myLocNow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
                
                mylat = curLoc.coordinate.latitude
                mylong = curLoc.coordinate.longitude
                
                locationTemp = CLLocationCoordinate2D(latitude: self.mylat, longitude: self.mylong)
                
            }
            
            
            var spanTemp = MKCoordinateSpan()
            
            /*
            if CapturingTerritory {
                print("IS CAPTURIN TERRITORY")
                print("Span should be 0.001")
                spanTemp = MKCoordinateSpanMake (0.003, 0.003)
            } else {
                //  print("Span should be 0.005")
                spanTemp = MKCoordinateSpanMake (0.005, 0.005)
            }
            */
            
            
            spanTemp = MKCoordinateSpan (latitudeDelta: 0.001, longitudeDelta: 0.001)
            
            restrictedRegion = MKCoordinateRegion(center: locationTemp, span: spanTemp)
            
            
            if ((mapView.region.span.latitudeDelta > restrictedRegion.span.latitudeDelta * 4) || (mapView.region.span.longitudeDelta > restrictedRegion.span.longitudeDelta * 4) ) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.latitude - restrictedRegion.center.latitude) > restrictedRegion.span.latitudeDelta) {
                updateRegion = true
            }
            
            if (fabs(mapView.region.center.longitude - restrictedRegion.center.longitude) > restrictedRegion.span.longitudeDelta) {
                updateRegion = true
            }
            if (updateRegion) {
                //  self.manuallyChangingMap = true
                print("Updating region is true")
                self.mapChangedFromUserInteraction = true
                mapView.setRegion(restrictedRegion, animated:true)
                self.mapChangedFromUserInteraction = false
                
                self.AfterStartupLoad = true
                // self.manuallyChangingMap = false
            }
            
            
            
            
        }
        
        
        // print("REGION CHANGED")
        
    }
    
    func ConvertZoomRadius(_ UserZoomRadiusTemp: Double) -> Double {
        
        var NewZoomRadius = Double()
        
        switch UserZoomRadiusTemp {
            
        case 1:
            NewZoomRadius = 0.5
        case 2:
            NewZoomRadius = 17.5
        case 3:
            NewZoomRadius = 17
        case 4:
            NewZoomRadius = 16
        case 5:
            NewZoomRadius = 15
        case 6:
            NewZoomRadius = 14
        case 7:
            NewZoomRadius = 13
        case 8:
            NewZoomRadius = 12
        case 9:
            NewZoomRadius = 11
        case 10:
            NewZoomRadius = 10
        case 11:
            NewZoomRadius = 9
        case 12:
            NewZoomRadius = 8
        case 13:
            NewZoomRadius = 7
        case 14:
            NewZoomRadius = 6
        case 15:
            NewZoomRadius = 5
        case 16:
            NewZoomRadius = 4
        case 17:
            NewZoomRadius = 3
        case 18:
            NewZoomRadius = 2
        case 19:
            NewZoomRadius = 1
        case 20:
            NewZoomRadius = 0.01
        default:
            NewZoomRadius = 17.5
            
        }
        
        return NewZoomRadius
    }
    
    func ScrollViewSwipeDown(_ gesture: UIGestureRecognizer) {
        
        
        
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    //self.GoldAmountView.transform = CGAffineTransformIdentity
                    /*
                    self.ScrollItemsView.center.y = self.ScrollItemsView.center.y + 275
                    self.ScrollItemsViewBOTTOM.constant = -200
                    
                    self.ScrollItemsInView = false
                   */
                    
                    
                    // self.loadingView.hidden = true
                })
                
                DispatchQueue.main.async(execute: {
                    /*
                    for views in self.ScrollItemsView.subviews {
                        views.removeFromSuperview()
                    }
                    */
                })
                
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Checking status after first click")
        if status == .authorizedAlways {
            print("tracking accepted, tracking on")
            TrackingOn = true
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func FocusOnHomeLocation(_ missionLat: Double, missionLong: Double, homeSet: Bool, missionAlt: Double) {
        
       // self.mapView.removeAnnotations(self.mapView.annotations)
        
        //let ImageTemp = UIImage(named: "Camo Cream-48.png")!
        let ImageTemp = UIImage(named: "AgentS.png")!
        // let TargetAnnotation  = TargetLabel(title: "Unknown", userHealth: playerhealth as String, discipline: playername as String, stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: missionLat, longitude: missionLong), image: UIImage(named: "\(imageName).png")!, PinType: "player", GoldAmount: userGold)
        
        
        let TotalPlayerAttributesTemp = TotalPlayerAttributes(Awareness: 0.0, Charisma: 0.0, Credibility: 0.0, Endurance: 0.0, Intelligence: 0.0, Speed: 0.0, Strength: 0.0, Vision: 0.0)
        let killcount = "0"
        let killedcount = "0"
        
        if homeSet {
            
            
            let imageName = prefs.value(forKey: "HomeimageName") as! String
            let level = prefs.value(forKey: "HomeLevel") as! String
            let homename = prefs.value(forKey: "HomeName") as! String
            let homeID = prefs.value(forKey: "HomeID") as! String
            
            
            let missionMapURL = ""
            let missionObjectURL = ""
            let xp = "1"
            
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        let itemImage = UIImage(data:theImageData!)!
        
        let missionCoordinate = CLLocationCoordinate2DMake(missionLat, missionLong)
            
         let objective = "test"
            let missionLevel = "NA"
            //let imageName = "Tent"
        
            let TargetAnnotation  = HomeLabel(title: homename, objective: objective, discipline: "", level: level, coordinate: missionCoordinate, image: itemImage, PinType: "home", xp: xp, mapURL: missionMapURL, objectURL: missionObjectURL, isMission: false, missionID: homeID, missionLevel: missionLevel, imageName: imageName, TotalPlayerAttributesTemp: TotalPlayerAttributesTemp, killcount: killcount, killedcount: killedcount, altitude: missionAlt)
        
            let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: missionLat, longitude: missionLong).coordinate, latitudinalMeters: 5000.0, longitudinalMeters: 5000.0)
            
        mapView.addAnnotation(TargetAnnotation)
        mapView.setRegion(coordinateRegion, animated: true)
            
        } else {
            
           
            
            
            
            let TargetAnnotation  = TargetLabel(title: "Unknown", userHealth: "100", discipline: "Target", stealth: "stealth", coordinate: CLLocationCoordinate2D(latitude: missionLat, longitude: missionLong), image: ImageTemp, PinType: "player", GoldAmount: "0", isMission: false, missionID: "0", altitude: missionAlt)
            
            let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: missionLat, longitude: missionLong).coordinate, latitudinalMeters: 5000.0, longitudinalMeters: 5000.0)
            mapView.addAnnotation(TargetAnnotation)
            mapView.setRegion(coordinateRegion, animated: true)
            
            
        }
        
        
    }
    
    @IBAction func closeBTN(_ sender: Any) {
        
        if self.HomeReset {
            
            self.dismiss(animated: true, completion: nil)
        } else {
            
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DoNotUpdateMap"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func fixBTN(_ sender: Any) {
    
    self.performSegue(withIdentifier: "GoToFix", sender: self)
        
    
    }
    
    
    
    
    @IBAction func ShowGoldProductionInfo(_ sender: AnyObject) {
        
        
        let isupgradingTemp = false
        let upgradeAmountTemp = "2000"
        let upgradeNowAmountTemp = "15"
        
        ShowItemInfoMenu(3, IsUpgrading: isupgradingTemp, itemCategory: "HQSafe", upgradeAmount: upgradeAmountTemp, upgradeNowAmount: upgradeNowAmountTemp)
        
   
    }
    
    
    
    func ShowItemInfoMenu(_ NumViews: Int, IsUpgrading: Bool, itemCategory: String, upgradeAmount: String, upgradeNowAmount: String) {
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                //self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            var view = ItemOptionsView.instanceFromNib(NumViews, IsUpgrading: IsUpgrading, itemCategory: itemCategory, upgradeAmount: upgradeAmount, upgradeNowAmount: upgradeNowAmount)
            view.tag = 1000
            self.view.addSubview(view)
        })
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToFix" {
            
            if let FixViewController = segue.destination as? AttackLoadingViewController {
                //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
                FixViewController.isFixing = true
                FixViewController.UserObjective = "fixing"
                //FixViewController.myLong = self.mylong.description
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
