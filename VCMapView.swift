//
//  VCMapView.swift
//  
//
//  Created by Jared Stevens on 7/29/15.
//
//

import Foundation
import MapKit


class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

extension MapViewController {
    
    
    
    
    // 1
    func mapView(_ mapView: MKMapView!,
        viewFor annotation: MKAnnotation!) -> MKAnnotationView! {
            
            
          //  annotation.
            /*
            if !(annotation is MyLabel) {
                return nil
            }
            
            
            if !(annotation is ItemLabel) {
                return nil
            }
            
            if !(annotation is UserLabel) {
                return nil
            }
            */
            
            
            
           
            

           
            
            
            let AttackButton: UIButton = UIButton(type: UIButtonType.system)
            AttackButton.setTitle("Attack", for: UIControlState())
            AttackButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            AttackButton.backgroundColor = UIColor.red
            AttackButton.titleLabel?.textColor = UIColor.black
           // AttackButton.addTarget(self, action: "AttackClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            AttackButton.setTitleColor(UIColor.white, for: UIControlState())
            
            let StatsButton : UIButton = UIButton(type: UIButtonType.system)
            StatsButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            StatsButton.backgroundColor = UIColor.blue
            StatsButton.setTitle("Player Info", for: UIControlState())
         //   StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            StatsButton.setTitleColor(UIColor.white, for: UIControlState())
            
            
            let itemPickUpButton : UIButton = UIButton(type: UIButtonType.system)
            itemPickUpButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            itemPickUpButton.backgroundColor = UIColor.darkGray
            itemPickUpButton.setTitle("Pick Up Item", for: UIControlState())
            //   StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            itemPickUpButton.setTitleColor(UIColor.white, for: UIControlState())
            
            let itemInfoButton : UIButton = UIButton(type: UIButtonType.system)
            itemInfoButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            itemInfoButton.backgroundColor = UIColor.gray
            itemInfoButton.setTitle("Item Info", for: UIControlState())
            //   StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            itemInfoButton.setTitleColor(UIColor.white, for: UIControlState())
            
            let MyInfoButton : UIButton = UIButton(type: UIButtonType.system)
            MyInfoButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            MyInfoButton.backgroundColor = UIColor.blue
            MyInfoButton.setTitle("Info", for: UIControlState())
            //   StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            MyInfoButton.setTitleColor(UIColor.white, for: UIControlState())
            
            let MyStatsButton : UIButton = UIButton(type: UIButtonType.system)
            MyStatsButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            MyStatsButton.backgroundColor = UIColor.blue
            MyStatsButton.setTitle("Stats", for: UIControlState())
            //   StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            MyStatsButton.setTitleColor(UIColor.white, for: UIControlState())
            
            
            
            if (annotation is MKUserLocation) {
                
                let identifier = "Annotation"
                
      
                
                var meview: SVPulsingAnnotationView
                
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    //  as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    meview = dequeuedView as! SVPulsingAnnotationView
                } else {
                    meview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    //meview.canShowCallout = true
                    // meview.image = UIImage(named: "user.png")
                    meview.calloutOffset = CGPoint(x: -5, y: 5)
                    // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                    meview.annotationColor = UIColor.lightGray
                   // meview.annotationColor = UIColor(red: 76.0, green: 175.0, blue: 80.0, alpha: 1.0)
                    var weaponRange = Float()
                    
                    /*
                    print("PULSE WEAPON RANGE: \(prefs.floatForKey("PULSEWEAPONRANGE"))")
                    
                    if prefs.floatForKey("PULSEWEAPONRANGE") != 0 {
                        //print("Lat Stored in Core Data")
                        
                        if prefs.floatForKey("PULSEWEAPONRANGE") > 10 {
                           weaponRange = 10
                        } else {
                           weaponRange = prefs.floatForKey("PULSEWEAPONRANGE")
                        }
                        
                        // weaponRange = Float(weaponRangeTemp)
                        
                        // weaponRange = 5.3
                        
                    } else {
                        weaponRange = 5.3
                        
                    }
                    
                    */
                    
                    weaponRange = 5.3
                    
                    print("WEAPON RANGE \(weaponRange)")
                    
                    meview.pulseAnimationDuration = 0.5
                    meview.pulseScaleFactor = weaponRange
                    // meview.outerPulseAnimationDuration = weaponRange
                    // meview.outerColor = UIColor.greenColor()
                }
                
                
               // self.mapView.userLocation.title = "Me"
               // self.mapView.userLocation.
                meview.canShowCallout = true
                meview.leftCalloutAccessoryView = MyInfoButton as UIView
                meview.rightCalloutAccessoryView = MyStatsButton as UIView
                return meview
                
                //  return nil
                // self.mapView.userLocation.title = "My Current Location"
            }
            
            
            
            
            
            
            
            
        
            if let annotation = annotation as? UserLabel {
               // let identifier = "pin"
                
                let identifier = "mapPin"
               // var view: MKPinAnnotationView
               //  var view: MKAnnotationView
                var view: MapPin
                 //view.removeFromSuperview()
                //var view: MKAnnotation
           //     print("annotation is another user - \(annotation.title)")
                
                
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                  //  as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    
                    //view.canShowCallout = false
                      //  view = dequeuedView
                    
                    view = MapPin(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = false
                    
                   // itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                    
                    view.attackUserName = annotation.title
                    view.attackUserHealth = annotation.userHealth
                    view.attackUserID = annotation.discipline
                    view.attackUserLat = annotation.lat
                    view.attackUserLong = annotation.long
                    view.attackUserAlt = annotation.alt
                    //view.attackUserImage = UIImage(named: "Camo Cream-48")!
                    view.attackUserImage = UIImage(named: "AgentS")!
                    view.PinType = annotation.PinType
                    
                    view.itemName = "NA"
                    view.itemImage = UIImage(named: "AgentS")!
                    view.itemType = "NA"
                    view.itemID = "NA"
                    view.itemCode = "NA"
                    view.itemLat = annotation.lat
                    view.itemLong = annotation.long
                    view.amount = annotation.GoldAmount
                    
                    /*
                    view.missionXP = ""
                    view.missionLevel = ""
                    view.missionObjective = ""
                    view.missionMapURL = ""
                    view.missionObjectURL = ""
                    view.missionID = ""
                    view.missionTitle = ""
                    */
                    
                    view.missionXP = annotation.xp
                    view.missionLevel = annotation.missionLevel
                    view.missionObjective = annotation.objective
                    view.missionMapURL = annotation.imageName
                    view.missionObjectURL = ""
                    view.missionID = annotation.missionID
                    view.missionTitle = ""
                    view.isMission = annotation.isMission
                    
                    view.category = ""
                    view.count = ""
                    view.level = ""
                    view.health = ""
                    view.stamina = ""
                    view.ammoCount = ""
                    view.speed = ""
                    view.power = ""
                    view.range = ""
                    view.viewrange = ""
                    //view.ki
                    
                    view.killcount = annotation.killcount
                    view.killedcount = annotation.killedcount
                    view.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                    
                    
                } else {
                    // 3
                    /*
                    let AttackButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                    AttackButton.addTarget(self, action: "AttackClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                    AttackButton.setTitleColor(UIColor.redColor(), forState: .Normal)
                    
                    let StatsButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                    StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                    StatsButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
                    */
                    //view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    
                    view = MapPin(annotation: annotation, reuseIdentifier: identifier)
                   // view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = false
                    
                    view.attackUserName = annotation.title
                    view.attackUserHealth = annotation.userHealth
                    print("USER HEALTH = \(annotation.userHealth)")
                    view.attackUserID = annotation.discipline
                    view.attackUserLat = annotation.lat
                    view.attackUserLong = annotation.long
                    view.attackUserImage = UIImage(named: "AgentS")!
                    view.PinType = annotation.PinType
                    
                    
                    view.itemName = "NA"
                    view.itemImage = UIImage(named: "AgentS")!
                    view.itemType = "NA"
                    view.itemID = "NA"
                    view.itemCode = "NA"
                    view.itemLat = annotation.lat
                    view.itemLong = annotation.long
                    view.amount = "0"
                    
                    /*
                    view.missionXP = ""
                    view.missionLevel = ""
                    view.missionObjective = ""
                    view.missionMapURL = ""
                    view.missionObjectURL = ""
                    view.missionID = ""
                    view.missionTitle = ""
                    */
                    
                    view.missionXP = annotation.xp
                    view.missionLevel = annotation.missionLevel
                    view.missionObjective = annotation.objective
                    view.missionMapURL = annotation.imageName
                    view.missionObjectURL = ""
                    view.missionID = annotation.missionID
                    view.missionTitle = ""
                    view.isMission = annotation.isMission
                    
                    view.category = ""
                    view.count = ""
                    view.level = ""
                    view.health = ""
                    view.stamina = ""
                    view.ammoCount = ""
                    view.speed = ""
                    view.power = ""
                    view.range = ""
                    view.viewrange = ""
                    
                    view.killcount = annotation.killcount
                    view.killedcount = annotation.killedcount
                    view.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                    
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                    
                
                }
                
                
                
                for views in view.subviews {
                    views.removeFromSuperview()
                }
               
                
                
                
                
                //uncomment below
                //view.pinColor = annotation.pinColor()
                
                
            //    view.leftCalloutAccessoryView = AttackButton as UIView
            //    view.rightCalloutAccessoryView = StatsButton as UIView
                
                let imgView = UIImageView()
                
                var r: CGRect = imgView.frame
                r.size.height = 40
                r.size.width = 40
                imgView.frame = r
                
                
                /*
                
                let image = annotation.image
                
                let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
                let hasAlpha = false
                let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
                
                UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
                image.drawInRect(CGRect(origin: CGPointZero, size: size))
                
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                

                imgView.image = scaledImage
                
                */
                
                imgView.image = annotation.image
                
                //view.frame = scaledImage
                
                //view.addSubview(imgView)
                
                view.image = annotation.image
              //  view.image = scaledImage
              //  let cpa = annotation as CustomPointAnnotation
             //   view.image = UIImage(named: cpa.imageName)
                
                return view
   
            }
        
 
        /*
        
        if let annotation = annotation as? ItemLabel {
            
            var view: MKAnnotationView!
            
          //  var customView = (NSBundle.mainBundle().loadNibNamed("ItemAnnotationView", owner: self, options: nil))[0] as! ItemAnnotationView;
            
           
            var customView = NSBundle.mainBundle().loadNibNamed("ItemAnnotationView", owner: self, options: nil).first as? ItemAnnotationView
            
        //    var customView = ItemAnnotationView.instanceFromNib()
           // self.view.addSubview(view)
            
            
            var calloutViewFrame = customView!.frame;
            calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
            customView!.frame = calloutViewFrame;
            //customView.tit
            customView!.titleLBL.text = annotation.title
            
            //customView.
            
           // let cpa = view.annotation as? ItemLabel
            //You can add set vlaues for  here
            //cpa.title
            //cpa.postCode
            //cpa.street
            
            view.addSubview(customView!)
            
            //zoom map to show callout
            let spanX = 0.0000000000000001
            let spanY = 0.0000000000000001
            
            var newRegion = MKCoordinateRegion(center:annotation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            self.mapView?.setRegion(newRegion, animated: true)
            
            return view
            
        }
        
        */
        
            if let annotation = annotation as? MyLabel {
                
         //       print("annotation is Me - \(annotation.title)")
                let identifier = "pin"
//                var myview: MKPinAnnotationView
                var myview: MKAnnotationView
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                  //  as? MKAnnotationView { // 2
                    
                        dequeuedView.annotation = annotation
                        myview = dequeuedView
                } else {
                    // 3
                    /*
                    let AttackButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                    AttackButton.addTarget(self, action: "AttackClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                    AttackButton.setTitleColor(UIColor.redColor(), forState: .Normal)
                    
                    let StatsButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                    StatsButton.addTarget(self, action: "StatsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                    StatsButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
                    */
                    myview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    myview.canShowCallout = true
                    myview.calloutOffset = CGPoint(x: -5, y: 5)
                    //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                }
                //myview.pinColor = annotation.pinColor()
                //myview.leftCalloutAccessoryView = AttackButton as UIView
                myview.rightCalloutAccessoryView = StatsButton as UIView
                myview.image = UIImage(named: "user.png")
                
                return myview
            }
        
        
        if let annotation = annotation as? ItemLabel {
            
            //   print("annotation is Item - \(annotation.title)")
            
            //let identifier = "pin"
            let identifier = "pin"
            var TheItemType = String()
            
            if annotation.title == "Gold" {
                TheItemType = annotation.amount
            } else {
                TheItemType = annotation.subtitle!
            }
            
            
            // var itemview: MKAnnotationView
            var itemview: MapPin
            
            
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                
                
                //    as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                //  itemview = dequeuedView
                
                itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                
                itemview.itemName = annotation.title!
                itemview.itemImage = annotation.image
                itemview.itemType = annotation.itemType
                itemview.itemID = annotation.itemID
                itemview.itemCode = annotation.itemCode
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = annotation.amount
                itemview.PinType = annotation.PinType
                itemview.category = annotation.category
                itemview.count = annotation.count
                itemview.level = annotation.level
                itemview.health = annotation.health
                itemview.stamina = annotation.stamina
                itemview.ammoCount = annotation.ammoCount
                itemview.speed = annotation.speed
                itemview.power = annotation.power
                itemview.range = annotation.range
                itemview.viewrange = annotation.viewrange
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                /*
                 itemview.missionXP = ""
                 itemview.missionLevel = ""
                 itemview.missionObjective = ""
                 itemview.missionMapURL = ""
                 itemview.missionObjectURL = ""
                 itemview.missionID = ""
                 itemview.missionTitle = ""
                 */
                
                /*
                 self.isMission = isMission
                 self.missionID = missionID
                 self.xp = xp
                 self.objective = objective
                 self.missionLevel = missionLevel
                 */
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.missionLevel
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.imageName
                itemview.missionObjectURL = ""
                itemview.missionID = annotation.missionID
                itemview.missionTitle = ""
                itemview.isMission = annotation.isMission
                
                itemview.killcount = annotation.killcount
                itemview.killedcount = annotation.killedcount
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
               
                
                // itemview.
                itemview.canShowCallout = false
            } else {
                // 3
                // itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview.canShowCallout = false
                itemview.calloutOffset = CGPoint(x: -5, y: 5)
                
                itemview.itemName = annotation.title!
                itemview.itemImage = annotation.image
                itemview.itemType = annotation.itemType
                itemview.itemID = annotation.itemID
                itemview.itemCode = annotation.itemCode
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = annotation.amount
                itemview.PinType = annotation.PinType
                
                /*
                itemview.category = ""
                itemview.count = ""
                itemview.level = annotation.level
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                */
                
                itemview.category = annotation.category
                itemview.count = annotation.count
                itemview.level = annotation.level
                itemview.health = annotation.health
                itemview.stamina = annotation.stamina
                itemview.ammoCount = annotation.ammoCount
                itemview.speed = annotation.speed
                itemview.power = annotation.power
                itemview.range = annotation.range
                itemview.viewrange = annotation.viewrange
                
                
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                /*
                itemview.missionXP = ""
                itemview.missionLevel = ""
                itemview.missionObjective = ""
                itemview.missionMapURL = ""
                itemview.missionObjectURL = ""
                itemview.missionID = ""
                itemview.missionTitle = ""
                */
                
                /*
                 self.isMission = isMission
                 self.missionID = missionID
                 self.xp = xp
                 self.objective = objective
                 self.missionLevel = missionLevel
                 */
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.missionLevel
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.imageName
                itemview.missionObjectURL = ""
                itemview.missionID = annotation.missionID
                itemview.missionTitle = ""
                itemview.isMission = annotation.isMission
                
                itemview.killcount = annotation.killcount
                itemview.killedcount = annotation.killedcount
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
               
                
                // itemview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            //  view.pinColor = annotation.pinColor()
            
            /*
             switch TheItemType {
             case "sniper rifle":
             itemview.image = UIImage(named: "Sniper Rifle.png")
             case "knife":
             itemview.image = UIImage(named: "knife.png")
             case "magnum":
             itemview.image = UIImage(named: "magnum gun.png")
             case "brass knuckles":
             itemview.image = UIImage(named: "")
             default:
             itemview.image = UIImage(named: "")
             }
             
             */
            
            // itemview.leftCalloutAccessoryView = itemPickUpButton as UIView
            // itemview.rightCalloutAccessoryView = itemInfoButton as UIView
            
            /*
             if #available(iOS 9.0, *) {
             itemview.detailCalloutAccessoryView?.hidden = true
             } else {
             // Fallback on earlier versions
             }
             */
            
            
            let itemIMGView = UIImageView()
            
            var r: CGRect = itemIMGView.frame
            r.size.height = 40
            r.size.width = 40
            itemIMGView.frame = r
            
            
            /*
             let image = annotation.image
             
             let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
             let hasAlpha = false
             let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
             
             UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
             image.drawInRect(CGRect(origin: CGPointZero, size: size))
             
             let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             
             */
            
            itemIMGView.image = annotation.image
            //itemview.frame = r
            
            
            
            // itemview.addSubview(itemIMGView)
            
            
            //itemview.frame = CGRectMake(100, 200, 100, 100)
            
            itemview.image = annotation.image
            
            return itemview
        }
        
        
            if let annotation = annotation as? MissionLabel {
                
             //   print("annotation is Item - \(annotation.title)")
               
                //let identifier = "pin"
                let identifier = "pin"
                var TheItemType = String()
                
               
                
                
               // var itemview: MKAnnotationView
                var itemview: MapPin
                
              
                
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    
                
                //    as? MKPinAnnotationView { // 2
                        dequeuedView.annotation = annotation
                      //  itemview = dequeuedView

                    itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                    
                    itemview.itemName = ""
                    itemview.itemImage = annotation.image
                    itemview.itemType = ""
                    itemview.itemID = ""
                    itemview.itemCode = ""
                    itemview.itemLat = annotation.lat
                    itemview.itemLong = annotation.long
                    itemview.amount = ""
                    itemview.PinType = annotation.PinType
                    
                    
                    itemview.attackUserName = "NA"
                    itemview.attackUserHealth = "NA"
                    itemview.attackUserID = "NA"
                    itemview.attackUserLat = annotation.lat
                    itemview.attackUserLong = annotation.long
                    itemview.attackUserAlt = annotation.alt
                    itemview.attackUserImage = UIImage(named: "AgentS")!
                    
                    itemview.missionXP = annotation.xp
                    itemview.missionLevel = annotation.level
                    itemview.missionObjective = annotation.objective
                    itemview.missionMapURL = annotation.mapURL
                    print("Annotation Map URL: \(annotation.mapURL)")
                    
                    itemview.missionObjectURL = annotation.objectURL
                    itemview.missionID = annotation.missionID
                    itemview.missionTitle = annotation.title
                    itemview.isMission = annotation.isMission
                    
                    itemview.category = ""
                    itemview.count = ""
                    itemview.level = ""
                    itemview.health = ""
                    itemview.stamina = ""
                    itemview.ammoCount = ""
                    itemview.speed = ""
                    itemview.power = ""
                    itemview.range = ""
                    itemview.viewrange = ""
                    
                    itemview.killcount = annotation.killcount
                    itemview.killedcount = annotation.killedcount
                    itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                    
                   // itemview.
                    itemview.canShowCallout = false
                } else {
                    // 3
                   // itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                    itemview.canShowCallout = false
                    itemview.calloutOffset = CGPoint(x: -5, y: 5)
                    
                    itemview.itemName = ""
                    itemview.itemImage = annotation.image
                    itemview.itemType = ""
                    itemview.itemID = ""
                    itemview.itemCode = ""
                    itemview.itemLat = annotation.lat
                    itemview.itemLong = annotation.long
                    itemview.amount = ""
                    itemview.PinType = annotation.PinType
                    
                    itemview.attackUserName = "NA"
                    itemview.attackUserHealth = "NA"
                    itemview.attackUserID = "NA"
                    itemview.attackUserLat = annotation.lat
                    itemview.attackUserLong = annotation.long
                    itemview.attackUserAlt = annotation.alt
                    itemview.attackUserImage = UIImage(named: "AgentS")!
                    
                    itemview.missionXP = annotation.xp
                    itemview.missionLevel = annotation.level
                    itemview.missionObjective = annotation.objective
                    itemview.missionMapURL = annotation.mapURL
                    itemview.missionObjectURL = annotation.objectURL
                    itemview.missionID = annotation.missionID
                    itemview.missionTitle = annotation.title
                    itemview.isMission = annotation.isMission
                    
                    itemview.category = ""
                    itemview.count = ""
                    itemview.level = ""
                    itemview.health = ""
                    itemview.stamina = ""
                    itemview.ammoCount = ""
                    itemview.speed = ""
                    itemview.power = ""
                    itemview.range = ""
                    itemview.viewrange = ""
                    
                    itemview.killcount = annotation.killcount
                    itemview.killedcount = annotation.killedcount
                    itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                    
                   // itemview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                    //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                }
              //  view.pinColor = annotation.pinColor()
                
                /*
                switch TheItemType {
                    case "sniper rifle":
                        itemview.image = UIImage(named: "Sniper Rifle.png")
                    case "knife":
                        itemview.image = UIImage(named: "knife.png")
                    case "magnum":
                        itemview.image = UIImage(named: "magnum gun.png")
                    case "brass knuckles":
                        itemview.image = UIImage(named: "")
                    default:
                        itemview.image = UIImage(named: "")
                }
                
                */
                
               // itemview.leftCalloutAccessoryView = itemPickUpButton as UIView
               // itemview.rightCalloutAccessoryView = itemInfoButton as UIView
                
                /*
                if #available(iOS 9.0, *) {
                    itemview.detailCalloutAccessoryView?.hidden = true
                } else {
                    // Fallback on earlier versions
                }
                */
                
                
                let itemIMGView = UIImageView()
                
                var r: CGRect = itemIMGView.frame
                r.size.height = 40
                r.size.width = 40
                itemIMGView.frame = r
                
                
                /*
                let image = annotation.image
                
                let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
                let hasAlpha = false
                let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
                
                UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
                image.drawInRect(CGRect(origin: CGPointZero, size: size))
                
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                */
                
                itemIMGView.image = annotation.image
                //itemview.frame = r
                

                
               // itemview.addSubview(itemIMGView)
                
                
                //itemview.frame = CGRectMake(100, 200, 100, 100)
               
                itemview.image = annotation.image
                
                return itemview
            }
        
        
        
        
        if let annotation = annotation as? CameraLabel {
            
            //   print("annotation is Item - \(annotation.title)")
            
            //let identifier = "pin"
            let identifier = "pin"
            var TheItemType = String()
            
           // var itemview: SVPulsingAnnotationView
            
            
            //var itemview: MKAnnotationView
           // var itemview: MapPin
            var itemview: CameraViewPin
            
            
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                
                
                dequeuedView.annotation = annotation
               // itemview = dequeuedView as! SVPulsingAnnotationView
                
                // itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //    as? MKPinAnnotationView { // 2
               // dequeuedView.annotation = annotation
                //  itemview = dequeuedView
                
                
              //  itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = CameraViewPin(annotation: annotation, reuseIdentifier: identifier)
                
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                print("Annotation Map URL: \(annotation.mapURL)")
                
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.
                itemview.canShowCallout = false
                
            } else {
                // 3
          
                
                /*
                itemview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //meview.canShowCallout = true
                // meview.image = UIImage(named: "user.png")
                
                 let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                let imageName = "Camera"
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                let theImageData = try? Data(contentsOf: url)
                let itemImage = UIImage(data:theImageData!)!
                
                itemview.image = itemImage
                
                
                itemview.calloutOffset = CGPoint(x: -5, y: 5)
                // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                itemview.annotationColor = UIColor.blue
                
                var weaponRange = Float()
                
                if prefs.float(forKey: "PULSEWEAPONRANGE") != 0 {
                    //print("Lat Stored in Core Data")
                  //  weaponRange = prefs.float(forKey: "PULSEWEAPONRANGE")
                    
                    // weaponRange = Float(weaponRangeTemp)
                    
                     weaponRange = 5.3
                    
                } else {
                    weaponRange = 5.3
                    
                }
                print("WEAPON RANGE Label Pulse \(weaponRange)")
                
                itemview.pulseAnimationDuration = 0.5
                itemview.pulseScaleFactor = weaponRange
*/
                
               
              //  itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                //itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = CameraViewPin(annotation: annotation, reuseIdentifier: identifier)
                itemview.canShowCallout = false
                itemview.calloutOffset = CGPoint(x: -5, y: 5)
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            //  view.pinColor = annotation.pinColor()
            
            /*
             switch TheItemType {
             case "sniper rifle":
             itemview.image = UIImage(named: "Sniper Rifle.png")
             case "knife":
             itemview.image = UIImage(named: "knife.png")
             case "magnum":
             itemview.image = UIImage(named: "magnum gun.png")
             case "brass knuckles":
             itemview.image = UIImage(named: "")
             default:
             itemview.image = UIImage(named: "")
             }
             
             */
            
            // itemview.leftCalloutAccessoryView = itemPickUpButton as UIView
            // itemview.rightCalloutAccessoryView = itemInfoButton as UIView
            
            /*
             if #available(iOS 9.0, *) {
             itemview.detailCalloutAccessoryView?.hidden = true
             } else {
             // Fallback on earlier versions
             }
             */
            
            
            let itemIMGView = UIImageView()
            
            var r: CGRect = itemIMGView.frame
            r.size.height = 40
            r.size.width = 40
            itemIMGView.frame = r
            
            
            /*
             let image = annotation.image
             
             let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
             let hasAlpha = false
             let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
             
             UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
             image.drawInRect(CGRect(origin: CGPointZero, size: size))
             
             let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             
             */
            
            itemIMGView.image = annotation.image
            //itemview.frame = r
            
         //   addHalo(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
            
           //  itemview.addSubview(itemIMGView)
            
            
           // itemview.frame = CGRectMake(100, 200, 100, 100)
            
            itemview.image = annotation.image
            
            return itemview
        }
        
        if let annotation = annotation as? OtherCameraLabel {
            
            //   print("annotation is Item - \(annotation.title)")
            
            //let identifier = "pin"
            let identifier = "pin"
            var TheItemType = String()
            
            // var itemview: SVPulsingAnnotationView
            
            
            //var itemview: MKAnnotationView
            // var itemview: MapPin
            var itemview: OtherCameraViewPin
            
            
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                
                
                dequeuedView.annotation = annotation
                // itemview = dequeuedView as! SVPulsingAnnotationView
                
                // itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //    as? MKPinAnnotationView { // 2
                // dequeuedView.annotation = annotation
                //  itemview = dequeuedView
                
                
                //  itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = OtherCameraViewPin(annotation: annotation, reuseIdentifier: identifier)
                
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                print("Annotation Map URL: \(annotation.mapURL)")
                
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.
                itemview.canShowCallout = false
                
            } else {
                // 3
                
                
                /*
                 itemview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                 //meview.canShowCallout = true
                 // meview.image = UIImage(named: "user.png")
                 
                 let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                 let imageName = "Camera"
                 let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                 let theImageData = try? Data(contentsOf: url)
                 let itemImage = UIImage(data:theImageData!)!
                 
                 itemview.image = itemImage
                 
                 
                 itemview.calloutOffset = CGPoint(x: -5, y: 5)
                 // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                 itemview.annotationColor = UIColor.blue
                 
                 var weaponRange = Float()
                 
                 if prefs.float(forKey: "PULSEWEAPONRANGE") != 0 {
                 //print("Lat Stored in Core Data")
                 //  weaponRange = prefs.float(forKey: "PULSEWEAPONRANGE")
                 
                 // weaponRange = Float(weaponRangeTemp)
                 
                 weaponRange = 5.3
                 
                 } else {
                 weaponRange = 5.3
                 
                 }
                 print("WEAPON RANGE Label Pulse \(weaponRange)")
                 
                 itemview.pulseAnimationDuration = 0.5
                 itemview.pulseScaleFactor = weaponRange
                 */
                
                
                //  itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                //itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = OtherCameraViewPin(annotation: annotation, reuseIdentifier: identifier)
                itemview.canShowCallout = false
                itemview.calloutOffset = CGPoint(x: -5, y: 5)
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            //  view.pinColor = annotation.pinColor()
            
            /*
             switch TheItemType {
             case "sniper rifle":
             itemview.image = UIImage(named: "Sniper Rifle.png")
             case "knife":
             itemview.image = UIImage(named: "knife.png")
             case "magnum":
             itemview.image = UIImage(named: "magnum gun.png")
             case "brass knuckles":
             itemview.image = UIImage(named: "")
             default:
             itemview.image = UIImage(named: "")
             }
             
             */
            
            // itemview.leftCalloutAccessoryView = itemPickUpButton as UIView
            // itemview.rightCalloutAccessoryView = itemInfoButton as UIView
            
            /*
             if #available(iOS 9.0, *) {
             itemview.detailCalloutAccessoryView?.hidden = true
             } else {
             // Fallback on earlier versions
             }
             */
            
            
            let itemIMGView = UIImageView()
            
            var r: CGRect = itemIMGView.frame
            r.size.height = 40
            r.size.width = 40
            itemIMGView.frame = r
            
            
            /*
             let image = annotation.image
             
             let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
             let hasAlpha = false
             let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
             
             UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
             image.drawInRect(CGRect(origin: CGPointZero, size: size))
             
             let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             
             */
            
            itemIMGView.image = annotation.image
            //itemview.frame = r
            
            //   addHalo(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
            
            //  itemview.addSubview(itemIMGView)
            
            
            // itemview.frame = CGRectMake(100, 200, 100, 100)
            
            itemview.image = annotation.image
            
            return itemview
        }
        
        
        if let annotation = annotation as? HomeLabel {
            
            //   print("annotation is Item - \(annotation.title)")
            
            //let identifier = "pin"
            let identifier = "pin"
            var TheItemType = String()
            
            // var itemview: SVPulsingAnnotationView
            
            
            //var itemview: MKAnnotationView
            // var itemview: MapPin
            var itemview: HomePin
            
            
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                
                
                dequeuedView.annotation = annotation
                // itemview = dequeuedView as! SVPulsingAnnotationView
                
                // itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //    as? MKPinAnnotationView { // 2
                // dequeuedView.annotation = annotation
                //  itemview = dequeuedView
                
                
                //  itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = HomePin(annotation: annotation, reuseIdentifier: identifier)
                
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                print("Annotation Map URL: \(annotation.mapURL)")
                
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.
                itemview.canShowCallout = false
                
            } else {
                // 3
                
                
                /*
                 itemview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                 //meview.canShowCallout = true
                 // meview.image = UIImage(named: "user.png")
                 
                 let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                 let imageName = "Camera"
                 let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
                 let theImageData = try? Data(contentsOf: url)
                 let itemImage = UIImage(data:theImageData!)!
                 
                 itemview.image = itemImage
                 
                 
                 itemview.calloutOffset = CGPoint(x: -5, y: 5)
                 // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                 itemview.annotationColor = UIColor.blue
                 
                 var weaponRange = Float()
                 
                 if prefs.float(forKey: "PULSEWEAPONRANGE") != 0 {
                 //print("Lat Stored in Core Data")
                 //  weaponRange = prefs.float(forKey: "PULSEWEAPONRANGE")
                 
                 // weaponRange = Float(weaponRangeTemp)
                 
                 weaponRange = 5.3
                 
                 } else {
                 weaponRange = 5.3
                 
                 }
                 print("WEAPON RANGE Label Pulse \(weaponRange)")
                 
                 itemview.pulseAnimationDuration = 0.5
                 itemview.pulseScaleFactor = weaponRange
                 */
                
                
                //  itemview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                //itemview = MapPin(annotation: annotation, reuseIdentifier: identifier)
                itemview = HomePin(annotation: annotation, reuseIdentifier: identifier)
                itemview.canShowCallout = false
                itemview.calloutOffset = CGPoint(x: -5, y: 5)
                
                itemview.itemName = ""
                itemview.itemImage = annotation.image
                itemview.itemType = ""
                itemview.itemID = ""
                itemview.itemCode = ""
                itemview.itemLat = annotation.lat
                itemview.itemLong = annotation.long
                itemview.amount = ""
                itemview.PinType = annotation.PinType
                
                itemview.attackUserName = "NA"
                itemview.attackUserHealth = "NA"
                itemview.attackUserID = "NA"
                itemview.attackUserLat = annotation.lat
                itemview.attackUserLong = annotation.long
                itemview.attackUserAlt = annotation.alt
                itemview.attackUserImage = UIImage(named: "AgentS")!
                
                itemview.missionXP = annotation.xp
                itemview.missionLevel = annotation.level
                itemview.missionObjective = annotation.objective
                itemview.missionMapURL = annotation.mapURL
                itemview.missionObjectURL = annotation.objectURL
                itemview.missionID = annotation.missionID
                itemview.missionTitle = annotation.title
                itemview.isMission = annotation.isMission
                
                itemview.category = ""
                itemview.count = ""
                itemview.level = ""
                itemview.health = ""
                itemview.stamina = ""
                itemview.ammoCount = ""
                itemview.speed = ""
                itemview.power = ""
                itemview.range = ""
                itemview.viewrange = ""
                
                itemview.killcount = ""
                itemview.killedcount = ""
                itemview.TotalPlayerAttributesTemp = annotation.TotalPlayerAttributesTemp
                
                
                // itemview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            //  view.pinColor = annotation.pinColor()
            
            /*
             switch TheItemType {
             case "sniper rifle":
             itemview.image = UIImage(named: "Sniper Rifle.png")
             case "knife":
             itemview.image = UIImage(named: "knife.png")
             case "magnum":
             itemview.image = UIImage(named: "magnum gun.png")
             case "brass knuckles":
             itemview.image = UIImage(named: "")
             default:
             itemview.image = UIImage(named: "")
             }
             
             */
            
            // itemview.leftCalloutAccessoryView = itemPickUpButton as UIView
            // itemview.rightCalloutAccessoryView = itemInfoButton as UIView
            
            /*
             if #available(iOS 9.0, *) {
             itemview.detailCalloutAccessoryView?.hidden = true
             } else {
             // Fallback on earlier versions
             }
             */
            
            
            let itemIMGView = UIImageView()
            
            var r: CGRect = itemIMGView.frame
            r.size.height = 40
            r.size.width = 40
            itemIMGView.frame = r
            
            
            /*
             let image = annotation.image
             
             let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
             let hasAlpha = false
             let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
             
             UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
             image.drawInRect(CGRect(origin: CGPointZero, size: size))
             
             let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             
             */
            
            itemIMGView.image = annotation.image
            //itemview.frame = r
            
            //   addHalo(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
            
            //  itemview.addSubview(itemIMGView)
            
            
            // itemview.frame = CGRectMake(100, 200, 100, 100)
            
            itemview.image = annotation.image
            
            return itemview
        }
        
        /*
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        */
        
        

        
         //  if annotation is mapView.userLocation {
            if annotation.isKind(of: MyLabelPulse.self) {
          //  if annotation is MKUserLocation {
                let identifier = "Annotation"
                
               // var meview: MKAnnotationView
                
                
                
                var meview: SVPulsingAnnotationView
                
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                    //  as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    meview = dequeuedView as! SVPulsingAnnotationView
                } else {
                    meview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    //meview.canShowCallout = true
                   // meview.image = UIImage(named: "user.png")
                    meview.calloutOffset = CGPoint(x: -5, y: 5)
                   // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                    //meview.annotationColor = UIColor.green
                    meview.annotationColor = UIColor.lightGray
                   // meview.annotationColor = UIColor(red: 76.0, green: 175.0, blue: 80.0, alpha: 1.0)
                  
                    var weaponRange = Float()
                    
                    if prefs.float(forKey: "PULSEWEAPONRANGE") != 0 {
                        //print("Lat Stored in Core Data")
                        weaponRange = prefs.float(forKey: "PULSEWEAPONRANGE")
                        
                       // weaponRange = Float(weaponRangeTemp)
                        
                       // weaponRange = 5.3
                        
                    } else {
                        weaponRange = 5.3
 
                    }
                    print("WEAPON RANGE Label Pulse \(weaponRange)")
                    
                    meview.pulseAnimationDuration = 0.5
                    meview.pulseScaleFactor = weaponRange
                    
                    
                   // meview.outerPulseAnimationDuration = weaponRange
                   // meview.outerColor = UIColor.greenColor()
                }

                
                // meview = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)!
                
                /*
                if(meview == nil) {
                 meview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                 meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                
                }
                */
               
               // meview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               // meview.annotation.
               // meview.annotationColor = UIColor(red: 161.0, green: 6.0, blue: 32.0, alpha: 1.0)
                
                
                
                meview.canShowCallout = true
                meview.leftCalloutAccessoryView = MyInfoButton as UIView
                meview.rightCalloutAccessoryView = MyStatsButton as UIView
                return meview
            }
            
            
            /*
            if annotation is MKUserLocation {
                let identifier = "Annotation"
                var meview: MKAnnotationView
                
                // var meview: SVPulsingAnnotationView
                
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                    //  as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    meview = dequeuedView
                } else {
                    meview = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    meview.canShowCallout = true
                    meview.image = UIImage(named: "user.png")
                    meview.calloutOffset = CGPoint(x: -5, y: 50)
                }
                meview.leftCalloutAccessoryView = MyInfoButton as UIView
                meview.rightCalloutAccessoryView = MyStatsButton as UIView
                return meview
            }
            
            */
            
            return nil
           // return meview
            
    }
    
    /*
    func addHalo(location: CLLocation) {
        
        //let center = location
        let center = CGPoint(x: 10, y: 10)
        
        let pulsator = Pulsator()
        pulsator.position = center
        pulsator.numPulse = 5
        pulsator.radius = 40
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor(red: 0, green: 0.455, blue: 0.756, alpha: 1).cgColor
        layer.addSublayer(pulsator)
        pulsator.start()
    }
    */
 
    
    //OPENS MAP ON BUTTON CLICK

    
    func mapView(_ mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
       AnnotationTapped = true
        
        if view.annotation!.isKind(of: ItemLabel.self) {
            
            
            return
            /*
            
            let item = view.annotation as! ItemLabel
            let itemName = item.title
            
            //let itemName = "item"
            let itemType = item.itemType
            let itemLat = item.lat
            let itemLong = item.long
            let itemCode = item.itemCode
            let itemID = item.itemID
            let amount = item.amount
            
        
        if control == view.rightCalloutAccessoryView{
          //  performSegueWithIdentifier("StatViewInfo", sender: self)
            print("item Info")
            print("name = \(itemName)")
          //  StatsClicked(itemName, stealth: stealthstatus, sender: view)
        }
        
        if control == view.leftCalloutAccessoryView{
          //  performSegueWithIdentifier("Attacking", sender: self)
            print("Picking Up Item: \(itemName)")
            PickUpClicked(username, itemName: itemName!, itemLat: itemLat, itemLong: itemLong, itemType: itemType, itemCode: itemCode, itemID: itemID, amount: amount)
        
        }
            
            */
            
        } else if view.annotation!.isKind(of: UserLabel.self) {
            
            let location = view.annotation as! UserLabel
            let name = location.discipline
            let health = location.userHealth
            let stealthstatus = location.stealth
            
            if control == view.rightCalloutAccessoryView{
                //  performSegueWithIdentifier("StatViewInfo", sender: self)
                print("Stats Segue")
                print("name = \(name)")
                StatsClicked(name as NSString, stealth: stealthstatus as NSString, sender: view)
            }
            
            if control == view.leftCalloutAccessoryView{
                //  performSegueWithIdentifier("Attacking", sender: self)
                print("Attack Segue - attacking: \(name)")
                AttackClicked(name as NSString, health: health as NSString)
                
            }
            
        } else if view.annotation!.isKind(of: MyLabelPulse.self) {
            
            
            
            let location = view.annotation as! MyLabelPulse
            
            //  let location = view.annotation as! MKUserLocation
            let name = location.discipline
            let health = location.userHealth
            let stealthstatus = location.stealth
            
            if control == view.rightCalloutAccessoryView{
                //  performSegueWithIdentifier("StatViewInfo", sender: self)
                print("Stats Segue")
                print("name = \(name)")
                //   StatsClicked(name, stealth: stealthstatus, sender: view)
            }
            
            if control == view.leftCalloutAccessoryView{
                //  performSegueWithIdentifier("Attacking", sender: self)
                print("Attack Segue - attacking: \(name)")
                //  AttackClicked(name, health: health)
                
            }
            
            
            
        } else if view.annotation!.isKind(of: MyLabel.self) {
            
            
            let location = view.annotation as! MyLabel
            
          //  let location = view.annotation as! MKUserLocation
          let name = location.discipline
          let health = location.userHealth
          let stealthstatus = location.stealth
            
            if control == view.rightCalloutAccessoryView{
                //  performSegueWithIdentifier("StatViewInfo", sender: self)
                print("Stats Segue")
                print("name = \(name)")
             //   StatsClicked(name, stealth: stealthstatus, sender: view)
            }
            
            if control == view.leftCalloutAccessoryView{
                //  performSegueWithIdentifier("Attacking", sender: self)
                print("Attack Segue - attacking: \(name)")
              //  AttackClicked(name, health: health)
                
            }

            
            
        } else {
            
            /*
            let location = self.MKUserLocation
            
            //  let location = view.annotation as! MKUserLocation
            let name = location.discipline
            let health = location.userHealth
            let stealthstatus = location.stealth
            
            */
            
            if control == view.rightCalloutAccessoryView{
                print("Right button tapped")
                //  performSegueWithIdentifier("StatViewInfo", sender: self)
              //  print("Stats Segue")
              //  print("name = \(name)")
                //   StatsClicked(name, stealth: stealthstatus, sender: view)
            }
            
            if control == view.leftCalloutAccessoryView{
                
                print("Left button tapped")
                //  performSegueWithIdentifier("Attacking", sender: self)
               // print("Attack Segue - attacking: \(name)")
                //  AttackClicked(name, health: health)
                
            }
            
            
        }
        
        /*
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
*/
    }
 
    
    
    /*
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    
        if view.annotation!.isKindOfClass(MKUserLocation){
            return
        }
        
        if view.annotation!.isKindOfClass(ItemLabel) {
        
       // if view.annotation == view.annotation as? ItemLabel {
            
       //var customView = (NSBundle.mainBundle().loadNibNamed("ItemAnnotationView", owner: self, options: nil))[0] as! ItemAnnotationView;
            
            
        //    dispatch_async(dispatch_get_main_queue(), {
            
            
        var customView = ItemAnnotationView.instanceFromNib()
              //  self.view.addSubview(view)
        //    })
            
       // var customView = (NSBundle.mainBundle().loadNibNamed("SubView", owner: self, options: nil))[0] as CustomSubView;
        
      //  let frame = CGRect(x: 50, y: 50, width: 200, height: 200)
            
        //var calloutViewFrame = customView.frame;
        var calloutViewFrame = self.view.frame;
        //calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
        calloutViewFrame.origin = CGPointMake(0, 0)
            
       // calloutViewFrame.origin = CGPointMake(50, 100)
        customView.frame = calloutViewFrame;
        customView.tag = 100
        customView.userInteractionEnabled = true
            
        let aSelector : Selector = "removeSubview"
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        customView.addGestureRecognizer(tapGesture)
            
        
        let cpa = view.annotation as! ItemLabel
            
           // customView.ti
        //You can add set values here
        //cpa.title
        //cpa.postCode
        //cpa.street
        
        view.addSubview(customView)
        //CustomItemAnnotationView.addSubview(customView)
        //zoom map to show callout
        let spanX = 0.0000000000000001
        let spanY = 0.0000000000000001
            
      //      let spanX = 0.1
      //      let spanY = 0.1
        
      //  var newRegion = MKCoordinateRegion(center:view.annotation!.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            
     //   self.mapView?.setRegion(newRegion, animated: true)
            
        } else {
            return
        }
    }
    */
 
    
    /*
    //WORKING ANNOTATION POPOVER VIEW
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        var sender = view
        
        if view.annotation!.isKindOfClass(MKUserLocation){
            return
        }
        
        if view.annotation!.isKindOfClass(ItemLabel) {
    
            
            
            let annotationInfo = view.annotation as! ItemLabel
        
            
          //  let oppstatsinfoController = storyboard?.instantiateViewControllerWithIdentifier("OppStats") as! OppStatsViewController
            
         //   oppstatsinfoController.TheirName = SelectedOpponentName as String
            
         //   oppstatsinfoController.StealthStatus = SelectedOppStealthStatus
            
            
            
    
    let savingsInformationViewController = storyboard?.instantiateViewControllerWithIdentifier("GameItemView") as! ItemAnnotationViewController
    
     savingsInformationViewController.itemTitle = annotationInfo.title!
     savingsInformationViewController.itemImage = annotationInfo.image
            
    //let savingsInformationViewController = WeaponsViewController(nibName: "WeaponsMenu", bundle: nil)
    //  savingsInformationViewController.delegate=self
    
    //   savingsInformationViewController.weaponPKLabel=weaponLabel.text
    savingsInformationViewController.itemannotationdelegate = self
    
    
    savingsInformationViewController.modalPresentationStyle = .Popover
    if let popoverController2 = savingsInformationViewController.popoverPresentationController {
        popoverController2.sourceView = sender as! UIView
        
        popoverController2.sourceRect = sender.bounds
        
        popoverController2.permittedArrowDirections = .Any
        popoverController2.presentingViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        
        popoverController2.delegate = self
    }
    presentViewController(savingsInformationViewController, animated: true, completion: nil)
    
        } else {
            return
        }
        
    }
    
    
    */
    
    func mapView(_ mapView: MKMapView!, didSelect view: MKAnnotationView!) {
        
        
        
       // print("Annotation Selected: \(view.annotation)")
      //  let SelectedAnnotation = view.annotation
       // prefs.setObject(view, forKey: "SELECTEDANNOTATIONVIEW")
        
     //   print("View Selected: \(view)")
        
        
        if view.annotation!.isKind(of: MKUserLocation.self){
            print("Did select user pin")
            return
        }
        
        if view.annotation!.isKind(of: ItemLabel.self) {
        print("Did select item pin")
        
            /*
        if let mapPin = view as? MapPin {
            print("View should show as mappin")
            
            updatePinPosition(mapPin)
        }
 */
            
            /*
            if let mapPinPlayer = view as? MapPinPlayer {
                if mapPinPlayer.preventDeselection {
                    mapView.selectAnnotation(view.annotation!, animated: false)
                }
            }
            
            if let mapPin = view as? MapPin {
                if mapPin.preventDeselection {
                    mapView.selectAnnotation(view.annotation!, animated: false)
                }
            }
            */
            
           // mapView.removeAnnotation(view.annotation!)
        //    mapView.removeAnnotations(self.mapView.annotations)
            
            let mapPin = view as? MapPin
            
           // mapPin!.frame = CGRectMake(0, mapPin!.frame.size.height - 40, 320, 40)
            
                print("View should show as map pin")
                
            updatePinPosition(mapPin!)
            
            //return mapPin
        
        } else if view.annotation!.isKind(of: UserLabel.self) {
            print("Did select user player pin")
            
            /*
             if let mapPin = view as? MapPin {
             print("View should show as mappin")
             
             updatePinPosition(mapPin)
             }
             */
            
            
            /*
            if let mapPinPlayer = view as? MapPinPlayer {
                if mapPinPlayer.preventDeselection {
                    mapView.selectAnnotation(view.annotation!, animated: false)
                }
            }
            
            if let mapPin = view as? MapPin {
                if mapPin.preventDeselection {
                    mapView.selectAnnotation(view.annotation!, animated: false)
                }
            }
            
            */
            
          //  mapView.removeAnnotations(self.mapView.annotations)
           // mapView.remove
            
            
            /*
            let mapPinPlayer = view as? MapPinPlayer
            
            // mapPin!.frame = CGRectMake(0, mapPin!.frame.size.height - 40, 320, 40)
            
            print("View should show as map pin")
            
            updatePinPositionPlayer(mapPinPlayer!)
            */
            
            
            
            let mapPin = view as? MapPin
            
            // mapPin!.frame = CGRectMake(0, mapPin!.frame.size.height - 40, 320, 40)
            
            print("View should show as map pin")
            
            updatePinPosition(mapPin!)
            
            
            
            //return mapPin
            
        } else if view.annotation!.isKind(of: MissionLabel.self) {
    print("Did select user player pin")
    
       
    
    let mapPin = view as? MapPin
    
    // mapPin!.frame = CGRectMake(0, mapPin!.frame.size.height - 40, 320, 40)
    
    print("View should show as map pin")
    
    updatePinPosition(mapPin!)
    
    
    
    //return mapPin
    
    } else {
    
    
    
    
            print("Did select other player pin")
    return
    }
    
    
    
    }

    func mapView(_ mapView: MKMapView!, didDeselect view: MKAnnotationView!) {
        
        AnnotationTapped = false
        
        print("is class title \(view.annotation?.title)")
        
        
        
        print("is class view \(view) for map view \(mapView)")
        
        
        if view.annotation!.isKind(of: MKUserLocation.self) || view.annotation!.isKind(of: UserLabel.self) {
            
         if view.annotation!.isKind(of: MKUserLocation.self){
            print("User Location annotation deselected")
            return
        }
        
        if view.annotation!.isKind(of: ItemLabel.self) {
        
        if let mapPin = view as? MapPin {
            if mapPin.preventDeselection {
                
                print("Map pin prevent deselection")
                
                mapView.selectAnnotation(view.annotation!, animated: false)
            }
        }
        }  //else
            
            if view.annotation!.isKind(of: UserLabel.self) {
            
            print("is kind of class userLabel")
            
                
                if let mapPin = view as? MapPin {
                    if mapPin.preventDeselection {
                        
                        print("Map pin prevent deselection")
                        
                        mapView.selectAnnotation(view.annotation!, animated: false)
                    }
                }
                
                
                
                /*
            if let mapPinPlayer = view as? MapPinPlayer {
                
                print("is MapPinPlayer Label")
                
                if mapPinPlayer.preventDeselection {
                    
                    print("Map pin player prevent deselection")
                    
                    mapView.selectAnnotation(view.annotation!, animated: false)
                }
            }
                
                */
        }
            
        }  else {
            print("Other Player annotation deselected")
    return
            
    }

    }
        
    
    func updatePinPosition(_ pin:MapPin) {
        let defaultShift:CGFloat = 50
        let pinPosition = CGPoint(x: pin.frame.midX, y: pin.frame.maxY)
        
        let y = pinPosition.y - defaultShift
        
        let controlPoint = CGPoint(x: pinPosition.x, y: y)
        let controlPointCoordinate = mapView.convert(controlPoint, toCoordinateFrom: mapView)
        
        mapView.setCenter(controlPointCoordinate, animated: true)
    }
    
    
    func updatePinPositionPlayer(_ pin:MapPinPlayer) {
        let defaultShift:CGFloat = 50
        let pinPosition = CGPoint(x: pin.frame.midX, y: pin.frame.maxY)
        
        let y = pinPosition.y - defaultShift
        
        let controlPoint = CGPoint(x: pinPosition.x, y: y)
        let controlPointCoordinate = mapView.convert(controlPoint, toCoordinateFrom: mapView)
        
        mapView.setCenter(controlPointCoordinate, animated: true)
    }

    
}



