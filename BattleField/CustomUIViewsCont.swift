//
//  CustomUIViewsCont.swift
//  BattleField
//
//  Created by Jared Stevens2 on 5/9/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit


class MyWeaponsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var username = NSString()
    var email = NSString()
    
    var prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var itemsViewBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
 
    
    //@IBOutlet weak var collectionViewSmall: UICollectionView!
    
  //@IBOutlet weak var closeViewTap: UITapGestureRecognizer!
    
    
    var TestImage = UIImage()
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySortedWeapon]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    var isOpen = Bool()
    
    
    @IBOutlet weak var knifeBTN: UIButton!
    @IBOutlet weak var gunBTN: UIButton!
    @IBOutlet weak var allBTN: UIButton!
  //  @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
   
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        RetrieveImages()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        let imageName = "Gun100"
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
        let theImageData = try? Data(contentsOf: url)
        let GunImage = UIImage(data:theImageData!)!

        
        let imageNameKnife = "InfantryKnife"
        let urlKnife = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageNameKnife).png")
        let theImageDataKnife = try? Data(contentsOf: urlKnife)
        
        TestImage = UIImage(data:theImageData!)!
        let KnifeImage = UIImage(data:theImageDataKnife!)!
        
        knifeBTN.setImage(KnifeImage, for: UIControlState())
        gunBTN.setImage(GunImage, for: UIControlState())
        /*
         print("view 5 y awake = \(self.view5.center.y)")
         
         // self.view5.center.y = self.view5.center.y - 46
         self.view5B.constant = 46
         self.view5H.constant = 0
         self.view5W.constant = 0
         
         //self.view4.center.y = self.view4.center.y - 46
         self.view4B.constant = -60
         self.view4R.constant = -40
         self.view4H.constant = 0
         self.view4W.constant = 0
         
         self.view3B.constant = -60
         self.view3R.constant = -40
         self.view3H.constant = 0
         self.view3W.constant = 0
         
         
         buttonView.layer.cornerRadius = buttonView.frame.height / 2
         buttonView.clipsToBounds = true
         
         //buttonView.backgroundColor = UIColor.NewColors.Header
         
         view5BG.layer.cornerRadius = view5BG.frame.height / 2
         view5BG.clipsToBounds = true
         //view5BG.backgroundColor = UIColor.NewColors.Header
         
         view4BG.layer.cornerRadius = view4BG.frame.height / 2
         view4BG.clipsToBounds = true
         //view4BG.backgroundColor = UIColor.NewColors.Header
         
         view3BG.layer.cornerRadius = view3BG.frame.height / 2
         view3BG.clipsToBounds = true
         // view3BG.backgroundColor = UIColor.NewColors.Header
         
         
         view4BUTTON.imageView?.tintColor = UIColor.whiteColor()
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        //   self.collectionView.registerNib(UINib(nibName: "itemCollectionViewCell"), bundle: nil) forCellWithReuseIdentifier: <#T##String#>)
        
        
     //   var columnHeaderViewNIB = UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
    //    self.collectionView?.registerNib(columnHeaderViewNIB, forCellWithReuseIdentifier: "ItemCell")
        
     //   self.collectionView.backgroundColor = UIColor.clearColor()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        self.collectionView.backgroundColor = UIColor.clear
        
 
      //  self.collectionView.hidden = true
        
        // self.collectionView?.registerNib(columnHeaderViewNIB, forSupplementaryViewOfKind: columnHeaderViewIdentifier, withReuseIdentifier: columnHeaderViewIdentifier)
        //[self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
     //   hideBTN.layer.cornerRadius = 5
     //   hideBTN.layer.masksToBounds = true
     //   hideBTN.clipsToBounds = true
      //  BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        
     //   self.collectionView.reloadData()
        
    }
    
    @IBAction func SortAll(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon..."
        alertView.message = "Sort All - In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    
    @IBAction func SortKnife(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon..."
        alertView.message = "Sort Knife - In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    @IBAction func SortGun(_ sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon..."
        alertView.message = "Sort Guns - In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    func RetrieveImages() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
        do {
            let fetchedResultsGroups =  try managedContextGroups!.fetch(fetchGroups) as? [NSManagedObject]
            
            if let resultsGroups = fetchedResultsGroups {
                SavedItemsInventory = resultsGroups
                print("Saved items = \(SavedItemsInventory)")
            } else {
                //   print("Could not fetch\(errorGroups), \(errorGroups!.userInfo)")
            }
            
            for items in SavedItemsInventory as [NSManagedObject] {
                TotalItems += 1
                // ItemsInventoryArray.append(CurNumGroups)
                
                let ItemNameURL = items.value(forKey: "imageURL") as! String
                let ItemCategory = items.value(forKey: "category") as! String
                let ItemOrder = items.value(forKey: "itemOrder") as! String
                
                
                let itemname = items.value(forKey: "name") as! String
                let imageURL = items.value(forKey: "imageURL") as! String
                let category = items.value(forKey: "category") as! String
                let power = items.value(forKey: "power") as! String
                let speed = items.value(forKey: "speed") as! String
                let range = items.value(forKey: "range") as! String
                let health = items.value(forKey: "health") as! String
                let stamina = items.value(forKey: "stamina") as! String
                let imageURL100 = items.value(forKey: "imageURL100") as! String
                let itemOrder = items.value(forKey: "itemOrder") as! String
                let viewRange = items.value(forKey: "viewRange") as! String
                let subCategory = items.value(forKey: "subCategory") as! String
                
                let itemLevel = "1"
                var itemAvailable = Bool()
                if itemname == "Cannon" {
                    itemAvailable = false
                } else {
                    itemAvailable = true
                }
                let itemAmmo = "50"
                
                
                if (category == "weapon") && (itemOrder != "0") {
                    
                    print("Scroll View Append Item: \(itemname)")
                    TotalItemsInventoryArray.append(ItemInventorySortedWeapon(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, viewRange: viewRange, level: itemLevel, available: itemAvailable, ammo: itemAmmo, subCategory: subCategory, unlocked: true))
                    
                }
                
               
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sort { (lhs: ItemInventorySortedWeapon, rhs: ItemInventorySortedWeapon) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
         //   self.collectionView.reloadData()
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        
        knifeBTN.layer.cornerRadius = 5
        knifeBTN.layer.masksToBounds = true
        knifeBTN.clipsToBounds = true
        
        gunBTN.layer.cornerRadius = 5
        gunBTN.layer.masksToBounds = true
        gunBTN.clipsToBounds = true
        
        allBTN.layer.cornerRadius = 5
        allBTN.layer.masksToBounds = true
        allBTN.clipsToBounds = true
      /*
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.itemsView.center.y = self.itemsView.center.y - 170
            self.itemsViewBOTTOM.constant = 70
            
            
            // self.loadingView.hidden = true
        })
      */
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib() -> MyWeaponsView {
        let boundsTemp = UIScreen.main.bounds
        let BoundsW = boundsTemp.width
        
        let bounds = CGRect(x: 0, y: 0, width: BoundsW, height: 230.0)
        var Nib = MyWeaponsView()
        
       // let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "MyWeaponsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MyWeaponsView
        
   
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        /*
        if collectionView != collectionViewSmall {
            
            print("TotalItems Inventory Count = \(TotalItemsInventoryArray.count)")
            return TotalItemsInventoryArray.count
            
        } else {
            
            */
            print("ITEM COUNT = \(TotalItemsInventoryArray.count)")
            return TotalItemsInventoryArray.count
            
      //  }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        /*
        if collectionView != collectionViewSmall {
            
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemsCollectionViewCell
            
            
            var itemTemp : ItemInventorySorted
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clearColor()
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            var imageName = itemTemp.imageURL100
            let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = NSData(contentsOfURL: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            return cell
            
        } else {
            */
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellSmall", for: indexPath) as! ItemsCollectionViewCellSmall
            
            
            var itemTemp : ItemInventorySortedWeapon
            
            itemTemp = TotalItemsInventoryArray[indexPath.row]
            
            cell.backgroundColor = UIColor.clear
            //cell.imageView.image = UIImage(named: "knife.png")
            
            
            let imageName = itemTemp.imageURL100
            let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
            print("url for image = \(url)")
            let theImageData = try? Data(contentsOf: url)
            
            //TestImage = UIImage(data:theImageData!)!
            
            cell.imageView.image  = UIImage(data: theImageData!)!
            cell.itemName.text = itemTemp.name
            cell.useBTN.tag = indexPath.row
            cell.useBTN.addTarget(self, action: #selector(MyWeaponsView.SelectTheItem(_:)), for: UIControlEvents.touchUpInside)
        
        
            cell.levelLBL.text = "Level: \(itemTemp.level)"
            cell.ammoLBL.text = "Ammo: \(itemTemp.ammo)"
        
        
            cell.costViewBTN.tag = indexPath.row
            cell.costViewBTN.addTarget(self, action: #selector(MyWeaponsView.UpgradeItem(_:)), for: UIControlEvents.touchUpInside)
        
        
            cell.lockView.isHidden = itemTemp.available
            /*
            if itemTemp.category != "weapon" {
                if indexPath.row > 0 {
                    
                    cell.lockView.hidden = false
                    
                } else {
                    cell.lockView.hidden = true
                }
            } else {
                if indexPath.row == 4 {
                  cell.lockView.hidden = false
                } else {
                cell.lockView.hidden = true
                }
            }
            */
            
            //  cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
            //  cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
            //  cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
            
            return cell
            
            
            
       // }
        
        
    }
    
    func SelectTheItem(_ sender: AnyObject) {
        
        print("Selected Weapon")
        
        let itemTag = sender.tag
        
        
        var itemTemp : ItemInventorySortedWeapon
        
        itemTemp = TotalItemsInventoryArray[itemTag!]
        
        let nameTemp = itemTemp.name
        let imageURLTemp = itemTemp.imageURL
        let rangeTemp = itemTemp.range
        let powerTemp = itemTemp.power
        let speedTemp = itemTemp.speed
        let viewRangeTemp = itemTemp.viewRange
        
       // print("Item Selected: ")
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateWeapon"), object: nil, userInfo: ["itemName":"\(nameTemp)","itemImageURL":"\(imageURLTemp)","itemRange":"\(rangeTemp)","itemPower":"\(powerTemp)","itemSpeed":"\(speedTemp)","itemViewRange":"\(viewRangeTemp)"])
        
        
    }
    
    func UpgradeItem(_ sender: AnyObject) {
        let itemTag = sender.tag
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Coming Soon..."
        alertView.message = "In Development"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        /*
        if collectionView != collectionViewSmall {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            self.removeFromSuperview()
            
        } else {
            
            */
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected Small"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        
        self.hidden = true
        
        */
           // self.removeFromSuperview()
            
            
       // }
    }
    
    
    
    @IBAction func closeViewTap(_ sender: AnyObject) {
        //HideViews()
        
        
        /*
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = dispatch_time(DISPATCH_TIME_NOW, Int64(delayLoad))
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.itemsView.center.y = self.itemsView.center.y + 170
            self.itemsViewBOTTOM.constant = -100
            
            
            // self.loadingView.hidden = true
        })
        
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hidden = true
            
        })
        
        
        */
    }
    
    
    /*
     
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     let itemsPerRow:CGFloat = 4
     let hardCodedPadding:CGFloat = 5
     let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
     let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
     return CGSize(width: itemWidth, height: itemHeight)
     }
     */
    
    
    
    
}


class DistanceAttackView: UIView, MKMapViewDelegate {
    
    var isOpen = Bool()
    
     @IBOutlet weak var View1: UIView!
     @IBOutlet weak var View2: UIView!
     @IBOutlet weak var SceneView: UIView!
    
    @IBOutlet weak var dateLBL: UILabel!
    
    
    var itemLat = Double()
    var itemLong = Double()
    var itemAlt = Double()
    var datetimeTemp = String()
    var targetName = String()
    
   // var itemLat = 28.1347
   // var itemLong = -81.1316
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var missionMapView: MKMapView!
    var targetCoordinate = CLLocationCoordinate2D()
    
    let dateFormatter = DateFormatter()
   
    
    
    @IBOutlet weak var closeViewTap: UITapGestureRecognizer!
    
    
    var MissileImage = UIImage()
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
       // xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        //xibSetup()
    }
    
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        View1.layer.cornerRadius = 5
        View1.layer.masksToBounds = true
        View1.clipsToBounds = true
        
        View2.layer.cornerRadius = 5
        View2.layer.masksToBounds = true
        View2.clipsToBounds = true
        
        self.missionMapView.delegate = self
        self.missionMapView.mapType = MKMapType.hybrid
        self.missionMapView.isUserInteractionEnabled = false
        
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        /*
        print("***FINDING TARGET LOCATION at Lat: \(itemLat) Long: \(itemLong)***")
        
        FocusOnMissionLocation(itemLat, missionLong: itemLong)
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("Missile.png")
        print("url for image = \(url)")
        let theImageData = try? Data(contentsOf: url)
        
        //TestImage = UIImage(data:theImageData!)!
        
        MissileImage  = UIImage(data: theImageData!)!
        */
        
    }
    
    func FocusOnMissionLocation(_ missionLat: Double, missionLong: Double, missionAlt: Double) {
        
        let ImageTemp = UIImage(named: "AgentS.png")!
        
       // let TargetAnnotation  = TargetLabel(title: "Unknown", userHealth: playerhealth as String, discipline: playername as String, stealth: playerstealth as String, coordinate: CLLocationCoordinate2D(latitude: missionLat, longitude: missionLong), image: UIImage(named: "\(imageName).png")!, PinType: "player", GoldAmount: userGold)
        
        let TargetAnnotation  = TargetLabel(title: "Unknown", userHealth: "100", discipline: "Target", stealth: "stealth", coordinate: CLLocationCoordinate2D(latitude: missionLat, longitude: missionLong), image: ImageTemp, PinType: "player", GoldAmount: "0", isMission: false, missionID: "0", altitude: missionAlt)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocation(latitude: missionLat, longitude: missionLong).coordinate, 5000.0, 5000.0)
        missionMapView.addAnnotation(TargetAnnotation)
        missionMapView.setRegion(coordinateRegion, animated: true)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        print("self Frame = \(self.frame)")
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.View1.alpha = 1.0
        })
        
        
        print("***FROM LAYOUT SUB VIEWS, FINDING TARGET LOCATION at Lat: \(itemLat) Long: \(itemLong)***")
        FocusOnMissionLocation(itemLat, missionLong: itemLong, missionAlt: itemAlt)
        
       // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("Missile.png")
        print("url for image = \(url)")
        let theImageData = try? Data(contentsOf: url)
        
        //TestImage = UIImage(data:theImageData!)!
        
        MissileImage  = UIImage(data: theImageData!)!

        //let datetimeTemp = result["datetimestamp"].stringValue
        
        
        print("Date Time Stamp one: \(datetimeTemp)")
        let datetimeTempFormated = dateFormatter.date(from: self.datetimeTemp)
        
        let RightNow = Date()
        let FromTime = RightNow.offsetFrom(datetimeTempFormated!)
        
        self.dateLBL.text = "\(FromTime)"
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(lat: Double, long: Double, datetime: String, name: String, alt: Double) -> DistanceAttackView {
        let bounds = UIScreen.main.bounds
        var Nib = DistanceAttackView()
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
       
        
        print("Does this come first???")
        Nib = UINib(nibName: "DistanceAttackView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DistanceAttackView
        
        
        Nib.itemLat = lat
        Nib.itemLong = long
        Nib.itemAlt = alt
        Nib.datetimeTemp = datetime
        Nib.targetName = name
        
        
        print("******LOADING MAP DISTANCE VIEW****** lat: \(Nib.itemLat) long: \(Nib.itemLong)")
        
        Nib.View1.alpha = 0.0
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
    
    
    @IBAction func closeViewTap(_ sender: AnyObject) {
        HideViews()
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.isHidden = true
            
        })
        
        
        
    }
    
    func HideViews() {
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.View1.alpha = 0.0
            })
          
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.BGView.alpha = 0.0
            })
            
            
        })
        
        
    }
    
}



class AttackCompleteView: UIView {
    
    var isOpen = Bool()
    
    
    
    @IBOutlet weak var closeViewTap: UITapGestureRecognizer!
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var completedView: UIView!
    
    @IBOutlet weak var healthProgressView: VerticalProgressView!
    @IBOutlet weak var healthLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var statusLBL: UILabel!
    @IBOutlet weak var damageLBL: UILabel!
    var healthprogress = Float()
    var startHealth = Float()
    /*
     
     @IBOutlet weak var buttonView: UIView!
     
     @IBOutlet weak var view5: UIView!
     
     @IBOutlet weak var view5H: NSLayoutConstraint!
     @IBOutlet weak var view5W: NSLayoutConstraint!
     @IBOutlet weak var view5R: NSLayoutConstraint!
     @IBOutlet weak var view5B: NSLayoutConstraint!
     @IBOutlet weak var view5BG: UIView!
     
     @IBOutlet weak var view4: UIView!
     @IBOutlet weak var view4H: NSLayoutConstraint!
     @IBOutlet weak var view4W: NSLayoutConstraint!
     @IBOutlet weak var view4R: NSLayoutConstraint!
     @IBOutlet weak var view4B: NSLayoutConstraint!
     @IBOutlet weak var view4BG: UIView!
     
     @IBOutlet weak var view3: UIView!
     @IBOutlet weak var view3H: NSLayoutConstraint!
     @IBOutlet weak var view3W: NSLayoutConstraint!
     @IBOutlet weak var view3R: NSLayoutConstraint!
     @IBOutlet weak var view3B: NSLayoutConstraint!
     @IBOutlet weak var view3BG: UIView!
     
     
     @IBOutlet weak var buttonViewW: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewH: NSLayoutConstraint!
     
     @IBOutlet weak var theButton: UIButton!
     @IBOutlet weak var buttonViewBOTTOM: NSLayoutConstraint!
     
     @IBOutlet weak var buttonViewRIGHT: NSLayoutConstraint!
     
     
     @IBOutlet weak var view4BUTTON: UIButton!
     @IBOutlet weak var view3LBL: UILabel!
     @IBOutlet weak var view4LBL: UILabel!
     
     @IBOutlet weak var view5LBL: UILabel!
     
     */
    
    var buttonClicked = Bool()
    override func awakeFromNib() {
        
        
        
        BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        self.completedView.layer.cornerRadius = 5
        self.completedView.layer.masksToBounds = true
        self.completedView.clipsToBounds = true
        healthProgressView.layer.borderWidth = 1
        healthProgressView.layer.borderColor = UIColor.darkGray.cgColor
        UpdateHealthMeter()
        
        self.hideBTN.layer.cornerRadius = 25
        self.hideBTN.layer.masksToBounds = true
        self.hideBTN.clipsToBounds = true
        
     //   print("health progres view")
      //  self.healthProgressView.setProgress(self.healthprogress, animated: true)
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    
    @IBAction func closeViewTap(_ sender: AnyObject) {
        //HideViews()
        
        
        
        let seconds = 0.5
        let secondsLoad = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.isHidden = true
            
        })
        
        
        
    }
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        print("Attacked close tapped")
        self.isHidden = true
        
        //self.removeFromSuperview()
    }
    
    
    @IBAction func theButton(_ sender: AnyObject) {
        if buttonClicked {
            self.Off()
            buttonClicked = false
        } else {
            self.On()
            buttonClicked = true
        }
        
    }
    
    
    class func instanceFromNib(_ AttackedPlayer: String, AttackedResult: String, AttackedPower: String, AttackedNewHealth: String, AttackedStartHealth: String) -> AttackCompleteView {
        let bounds = UIScreen.main.bounds
        var Nib = AttackCompleteView()
        
        print("Should show attack view")
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        Nib = UINib(nibName: "AttackCompleteView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AttackCompleteView
        
        let NewHealthTemp = Int(AttackedNewHealth)!
        let NewHealthDouble: Double = Double(NewHealthTemp) / 100
        
        Nib.healthprogress = Float(NewHealthDouble)

        print("start health string: \(AttackedStartHealth)")
        let StartHealthTemp = Int(AttackedStartHealth)!
        
        let StartHealthDouble: Double = Double(StartHealthTemp) / 100
        print("Start health int \(StartHealthTemp)")
        print("Start health double \(StartHealthDouble)")

        
        Nib.startHealth = Float(StartHealthDouble)
        
        Nib.nameLBL.text = AttackedPlayer
        Nib.statusLBL.text = "Status: \(AttackedResult)"
        
        if Nib.healthprogress <= 0.0 {
        Nib.damageLBL.text = "Target Eliminated"
        } else {
        Nib.damageLBL.text = "Damage: \(AttackedPower)"
        }
        print("Start health is \(Nib.startHealth)")
        Nib.healthProgressView.progress = Nib.startHealth

        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func UpdateHealthMeter(){
        
        
        
        let seconds = 1.0
        let secondsLoad = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            // self.messageLBL.alpa
            self.healthProgressView.setProgress(self.healthprogress, animated: true)
            
        })
        
       
        
    }
    
    
    func On() {
        
        /*
         view4LBL.text = "Settings"
         view5LBL.text = "Share"
         view3LBL.text = "My Team"
         
         */
        
        /*
         self.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
         
         buttonViewBOTTOM.constant = 87
         buttonViewRIGHT.constant = 20
         */
        // theButton.setImage(UIImage(named: "plusIcon2.png"), forState: .Normal)
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor
            
            /*
             
             print("view 5 y on= \(self.view5.center.y)")
             
             self.view5.center.y = self.view5.center.y - 100
             self.view5B.constant = 40
             self.view5H.constant = 60
             self.view5W.constant = 40
             
             
             self.view4.center.y = self.view4.center.y - 73
             self.view4.center.x = self.view4.center.x - 70
             self.view4R.constant = 30
             self.view4B.constant = 13 //23
             self.view4H.constant = 60
             self.view4W.constant = 40
             
             
             // self.view4.center.y = self.view4.center.y - 73
             self.view3.center.x = self.view3.center.x - 100
             self.view3R.constant = 60
             self.view3B.constant = -60 //23
             self.view3H.constant = 60
             self.view3W.constant = 40
             
             */
            
            
            }, completion: { (Bool) -> Void in
        })
    }
    
    func Off() {
        
        /*
         
         BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
         
         
         //        theButton.setImage(UIImage(named: "plusIcon1.png"), forState: .Normal)
         
         /*
         buttonViewBOTTOM.constant = 0
         buttonViewRIGHT.constant = 0
         self.bounds = CGRect(x: (buttonViewRIGHT.constant + buttonViewW.constant), y: (buttonViewBOTTOM.constant + buttonViewH.constant), width: buttonViewW.constant, height: buttonViewH.constant)
         */
         //self.view5B.constant = 46
         
         UIView.animateWithDuration(0.5, animations: { () -> Void in
         
         print("view 5 y off = \(self.view5.center.y)")
         
         self.view5.center.y = self.view5.center.y + 100
         print("view 5 y off 2 = \(self.view5.center.y)")
         
         //self.view5B.constant = -60
         // self.view5H.constant = 0
         // self.view5W.constant = 0
         
         self.view4.center.y = self.view4.center.y + 73
         self.view4.center.x = self.view4.center.x + 70
         
         
         self.view3.center.x = self.view3.center.x + 100
         
         
         
         //self.view4R.constant = -40
         //   self.view4B.constant = -60
         //  self.view4H.constant = 0
         //   self.view4W.constant = 0
         
         }, completion: { (Bool) -> Void in
         })
         
         view4LBL.text = ""
         view5LBL.text = ""
         view4LBL.text = ""
         
         */
        
    }
}

