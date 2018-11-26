//
//  WeaponsViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

@objc protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(_ settingsViewController: WeaponsViewController)
}

class WeaponsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var TotalItemsArray = [NSString]()
    var ItemsInventoryArray = [ItemInventory]()
    var TotalItems = Int()
    let ServerURL = "http://\(ServerInfo.sharedInstance)/Apps/BattleField/Items/"
    
    let prefs:UserDefaults = UserDefaults.standard
    
    var ItemInventoryInfo = [ItemInventory]()
    var SavedItemsInventory = [NSManagedObject]()
    
    
    var MyWeaponsInventoryArrayFound = [MyWeaponsInventory]()
    var MyWeaponsInventoryArray = [MyWeaponsInventory]()
    /*

let dirpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
let path = dirpath.stringByAppendingPathComponent("PQTempMusic4.m4v") as String
print("LOADING URL FROM PATH \(path)")

//let audioPath = NSBundle.mainBundle().pathForResource("ComedicFun", ofType:"mp3")
let audioPath = dirpath.stringByAppendingPathComponent("ComedicFun.mp3") as String
let url = NSURL.fileURLWithPath(path)

*/

   //  var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var username = NSString()
    var email = NSString()
    var mdelegate: SettingsViewControllerDelegate?
    
    var AllItems = [NSArray]()
    
    /*
    var itemName = NSString()
    var itemID = NSString()
    var itemType = NSString()
    var itemCategory = NSString()
    var itemRange = NSString()
    var itemPower = NSString()
    var itemSpeed = NSString()
    var itemViewRange = NSString()
    */
    
    var itemNameArray = [NSString]()
    var itemIDArray = [NSString]()
    var itemTypeArray = [NSString]()
    var itemCategoryArray = [NSString]()
    var itemRangeArray = [NSString]()
    var itemPowerArray = [NSString]()
    var itemSpeedArray = [NSString]()
    var itemViewRangeArray = [NSString]()
    
    var itemNameInfo = [NSString]()
    var itemIDInfo = [NSString]()
    var itemTypeInfo = [NSString]()
    var itemCategoryInfo = [NSString]()
    var itemRangeInfo = [NSString]()
    var itemPowerInfo = [NSString]()
    var itemImageInfo = [UIImage]()
    var itemSpeedInfo = [NSString]()
    var itemViewRangeInfo = [NSString]()
    
    var RangeSelected = NSString()
    var PowerSelected = NSString()
    var SpeedSelected = NSString()
    var ViewRangeSelected = NSString()
    
    var myLat = String()
    var myLong = String()
    var myAlt = String()
    
    @IBOutlet weak var TableView: UITableView!
    
    var armorsImage = [UIImage]()
    
    var weaponsLabel = [NSString]()
    var weaponPKimage: UIImage!
    var weaponPKLabel: NSString!

    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RetrieveItems()
        
        let prefs:UserDefaults = UserDefaults.standard
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        TableView.delegate = self
        TableView.dataSource = self
        
        
        /*
        itemNameArray.append("Fist")
        itemIDArray.append("0")
        itemPowerArray.append("5")
        itemRangeArray.append("1")
        itemTypeArray.append("Fist")
        itemCategoryArray.append("Weapon")
        itemSpeedArray.append("0")
        itemViewRangeArray.append("1")
        armorsImage.append(UIImage(named: "Fist.png")!)
        */
        
        
        /*
        var Category = "Weapon"
        
        let MyInventoryURLData = GetInventory(self.email, Type: "all")
        MyWeaponsInventoryArray = FilterMyInventoryItems(MyInventoryURLData)

        var URLData = GetMyItems(username, category: Category)
        MyWeaponsInventoryArrayFound = FilterItems(URLData)
        
        //print("My Weapons Iventory = \(MyWeaponsInventoryArray)")
        
        
        for theItems in MyWeaponsInventoryArrayFound {
            
            
            let CoreFiltered = MyWeaponsInventoryArray.filter{$0.itemName == "\(theItems.itemName)"}
            
            
            if CoreFiltered.count == 0 {
                
             MyWeaponsInventoryArray.append(theItems)
                
            }
            
            
            
        }
        */
        
     
        
        
       // print("MyWeaponsInventoryArray : \(MyWeaponsInventoryArray)")
       // print("User Locations Updated")
        
        
        //  armorsImage.append(UIImage(named: "wood armor.png")!)
        //  armorsImage.append(UIImage(named: "black armor.png")!)
        //   weaponsImage.append(UIImage(named: "magnum gun.png")!)
        
        //   armorsLabel.append("Wood Armor")
        //   armorsLabel.append("Black Armor")
        // weaponsLabel.append("Magnum")
        
        /*
        itemNameInfo = itemInfo[0] as! [(NSString)]
        itemIDInfo = itemInfo[1] as! [(NSString)]
        itemTypeInfo = itemInfo[2] as! [(NSString)]
        itemCategoryInfo = itemInfo[3] as! [(NSString)]
        itemImageInfo = itemInfo[4] as! [(UIImage)]
        itemPowerInfo = itemInfo[5] as! [(NSString)]
        itemRangeInfo = itemInfo[6] as! [(NSString)]
        itemSpeedInfo = itemInfo[7] as! [(NSString)]
        itemViewRangeInfo = itemInfo[8] as! [(NSString)]
        */
       self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var Category = "Weapon"
        
        let MyInventoryURLData = GetInventory(self.email, Type: "all")
        MyWeaponsInventoryArray = FilterMyInventoryItems(MyInventoryURLData)
        
        var URLData = GetMyItems(username, category: Category as NSString)
        MyWeaponsInventoryArrayFound = FilterItems(URLData)
        
        //print("My Weapons Iventory = \(MyWeaponsInventoryArray)")
        
        
        for theItems in MyWeaponsInventoryArrayFound {
            
            
            let CoreFiltered = MyWeaponsInventoryArray.filter{$0.itemName == "\(theItems.itemName)"}
            
            
            if CoreFiltered.count == 0 {
                
                MyWeaponsInventoryArray.append(theItems)
                
            }
            
            
            
        }
        
        DispatchQueue.main.async(execute: {
            
            self.actInd.stopAnimating()
            self.TableView.reloadData()
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MyWeaponsInventoryArray.count;
    }
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        mdelegate?.settingsViewControllerFinished(self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var itemSelected: MyWeaponsInventory
        let row = indexPath.row
        
        
        let selectedResult = indexPath.item
        
        
        itemSelected = MyWeaponsInventoryArray[row]
        
        
      //  weaponPKimage = UIImage(named: "\(itemSelected.itemImageURL).png")  //itemImageInfo[row]
        weaponPKimage = itemSelected.itemImage  //UIImage(named: "knife.png")!
        
        print(weaponPKimage)
        //prefs.setValue(weaponPKLabel, forKey: "HOLDINGWEAPSON")
        
        
        
        weaponPKLabel = itemSelected.itemName as NSString! //itemNameInfo[row]
        print(weaponPKLabel)
        
        prefs.setValue(weaponPKLabel, forKey: "HOLDINGWEAPON")
        
        RangeSelected = itemSelected.itemRange as NSString //itemRangeInfo[row]
        print("item Range - \(RangeSelected)")
        let RangeSelectedInt = Int(RangeSelected as String)
        //prefs.setValue(RangeSelected, forKey: "PULSEWEAPONRANGE")
        prefs.set(Float(RangeSelectedInt!), forKey: "PULSEWEAPONRANGE")
        
        print("Setting PulseWeaponRange: \(RangeSelectedInt?.description)")
        
        print("Range Selected = \(RangeSelected)")
        PowerSelected = itemSelected.itemPower as NSString //itemPowerInfo[row]
        SpeedSelected = itemSelected.itemSpeed as NSString //itemSpeedInfo[row]
        ViewRangeSelected = itemSelected.itemViewRange as NSString  //itemViewRangeInfo[row]
        
        print("item View Range - \(ViewRangeSelected)")
        /*
        
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setObject(weaponPKimage, forKey: "SELECTEDWEAPON")
*/
      //  MapViewController.ToolsBTN.setImage(weaponsImage[row], forState: .Normal)
       
   //     mDelegate?.sendArrayToPreviousVC(weaponPKimage, weaponPKLabel)
        
    //   self.performSegueWithIdentifier("closeWeapons", sender: self)

        
      
        
        
        self.dismiss(animated: true, completion: {
        
    self.mdelegate?.settingsViewControllerFinished(self)
       
        })
        
        }
    
    func DropItem(_ sender: AnyObject) {
        
        //var ItemToDrop: PlaceItemInfo!
        let itemTag = sender.tag
        
        
        var itemSelected: MyWeaponsInventory
        

        itemSelected = MyWeaponsInventoryArray[itemTag!]
        
        
        let ItemToDropID = itemSelected.itemID //itemIDArray[itemTag]
        print("The id of the item to drop is \(ItemToDropID)")
        
        let ItemName = itemSelected.itemName
        
       
        
        //let my
        if ItemToDropID != "NA" {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Drop item?", message: "Are you sure you want to drop this item?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some stuff
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            
            if ItemName == self.prefs.value(forKey: "HOLDINGWEAPON") as! String {
                
                print("YOU ARE DROPPPING THE WEAPON  YOU ARE HOLDING")
                
               // self.prefs.setValue("Fist", forKey: "HOLDINGWEAPON")
                
                
                
                itemSelected = self.MyWeaponsInventoryArray[0]

                self.weaponPKimage = itemSelected.itemImage  //UIImage(named: "knife.png")!

                self.weaponPKLabel = itemSelected.itemName as NSString! //itemNameInfo[row]
                
                self.prefs.setValue(self.weaponPKLabel, forKey: "HOLDINGWEAPON")
                
                self.RangeSelected = itemSelected.itemRange as NSString //itemRangeInfo[row]

                let RangeSelectedInt = Int(self.RangeSelected as String)

                self.prefs.set(Float(RangeSelectedInt!), forKey: "PULSEWEAPONRANGE")
                
               // print("Setting PulseWeaponRange: \(RangeSelectedInt?.description)")
                
                
                self.PowerSelected = itemSelected.itemPower as NSString //itemPowerInfo[row]
                self.SpeedSelected = itemSelected.itemSpeed as NSString //itemSpeedInfo[row]
                self.ViewRangeSelected = itemSelected.itemViewRange as NSString  //itemViewRangeInfo[row]
                
                self.dismiss(animated: true, completion: {
                    
                    self.mdelegate?.settingsViewControllerFinished(self)
                    
                })
                
                
                
                
                
            }
            
            
            
            //  self.AttackingPlayer = user
            //   self.AttackingPlayersHealth = health
            
            // print("Picking up Item = \(self.itemname)")
            
            //self.performSegueWithIdentifier("goto_attack", sender: self)
            
            /*
            if itemName == "Gold" {
                
                
                let PickUpSuccess =  PickUpGold(self.username, id: itemID, amount: amount)
                print("Item Pick Up Success = \(PickUpSuccess)")
                
                
                
                if PickUpSuccess{
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success!"
                    alertView.message = "You Picked up the \(amount) coins"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    
                    let PreviousGold = self.prefs.valueForKey("GOLDAMOUNT") as! String
                    print("NSUSER DEFAULT GOLD AMOUNT = \(PreviousGold)")
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("UpdateMoney", object: nil, userInfo: ["previousAmount":"\(PreviousGold)","newAmount":"\(amount)"])
                    
                    
                    backgroundThread(background: {
                        //self.GetPublicTurns()
                        print("BACKGROUND THREAD - Updating Users' Info")
                        
                        print("Saving Images now")
                        
                        
                        let UserInfoNSData = GetUserInfo(email)
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            print("Creating Local Inventory Data")
                            CreateLocalInventory(UserInfoNSData)
                            
                        })
                        
                        
                        }, completion: {
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                //self.GetMyHUD.removeFromSuperview()
                                //  self.tableView.reloadData()
                                print("DISPATCH ASYNC - Finished Getting User's Info")
                            })
                            // print("Done Getting Steal Turns")
                            //   self.kolodaView.resetCurrentCardNumber()
                    })
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            } else {
                */
                
                //let PickUpSuccess =  PickUpItem(self.username, id: itemID)
               // print("Item Pick Up Success = \(PickUpSuccess)")
            
            self.myLat = self.prefs.value(forKey: "MYCURRENTLAT") as! String
            self.myLong = self.prefs.value(forKey: "MYCURRENTLONG") as! String
            self.myAlt = self.prefs.value(forKey: "MYCURRENTALT") as! String
            
                
            let dropSuccess = DropItemNow(self.username, id: ItemToDropID as NSString, lat: self.myLat, long: self.myLong, alt: self.myAlt)
 
            
                if dropSuccess{
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success!"
                    alertView.message = "You dropped the item" // up the \(itemName)"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                
        //    }
            //self.SubmitPic()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateMap"), object: nil)
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        // var v1Ctrl = MapViewController()
        
        self.present(actionSheetController, animated: true, completion: nil)
            
        } else {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Unable to Drop"
            alertView.message = "This item is not eligible to be dropped" // up the \(itemName)"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        }

    }
    
    func LevelUpItem(_ sender: AnyObject){
     
        let itemTag = sender.tag
        var itemSelected: MyWeaponsInventory
        itemSelected = MyWeaponsInventoryArray[itemTag!]
        let ItemName = itemSelected.itemName
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Level Up"
        alertView.message = "Coming Soon: Level Up for Item - \(ItemName)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    func AddAmmo(_ sender: AnyObject) {
        
        let itemTag = sender.tag
        var itemSelected: MyWeaponsInventory
        itemSelected = MyWeaponsInventoryArray[itemTag!]
        let ItemName = itemSelected.itemName
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Add Ammo"
        alertView.message = "Coming Soon: Add ammo for \(ItemName)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    func GetItemInfo(_ sender: AnyObject) {
        
        let itemTag = sender.tag
        var itemSelected: MyWeaponsInventory
        itemSelected = MyWeaponsInventoryArray[itemTag!]
        let ItemName = itemSelected.itemName
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Item Info"
        alertView.message = "Coming Soon: Info for \(ItemName)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        var itemSelected: MyWeaponsInventory
        let row = indexPath.row
        
        //let selectedResult = indexPath.item
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        itemSelected = MyWeaponsInventoryArray[row]
        
        cell.titleLabel?.text =  itemSelected.itemName //self.itemNameInfo[indexPath.row] as String
        
        let ItemName = itemSelected.itemName //self.itemNameInfo[indexPath.row] as String
        
        
        cell.infoView.layer.cornerRadius = 5
        cell.infoView.layer.masksToBounds = true
        cell.infoView.clipsToBounds = true
        cell.infoView2.layer.cornerRadius = 5
        cell.infoView2.layer.masksToBounds = true
        cell.infoView2.clipsToBounds = true
        
        
        cell.borderView.layer.cornerRadius = 5
        cell.borderView.layer.masksToBounds = true
        cell.borderView.clipsToBounds = true
        cell.borderView.layer.borderWidth = 2
        cell.borderView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        
        cell.countLBL.layer.cornerRadius = 9
        cell.countLBL.layer.borderColor = UIColor.white.cgColor
        cell.countLBL.layer.borderWidth = 1
       // cell.countLBL.layer.masksToBounds = true
      //  cell.countLBL.clipsToBounds = true
        
        
        if ItemName == "Fist" {
            cell.dropBTN.isHidden = true
        } else {
            cell.dropBTN.isHidden = false
        }
        cell.dropBTN.layer.cornerRadius = 5
        cell.dropBTN.layer.masksToBounds = true
        cell.dropBTN.tag = indexPath.row
        cell.dropBTN.addTarget(self, action: #selector(WeaponsViewController.DropItem(_:)), for: UIControlEvents.touchUpInside)
        cell.levelLBL.text = "Level: \(itemSelected.itemLevel)"
        
        
        cell.levelUpBTN.addTarget(self, action: #selector(WeaponsViewController.LevelUpItem(_:)), for: UIControlEvents.touchUpInside)
        cell.levelUpBTN.layer.cornerRadius = 5
        cell.levelUpBTN.layer.masksToBounds = true
        cell.levelUpBTN.tag = indexPath.row
        
        
        cell.itemInfoBTN.addTarget(self, action: #selector(WeaponsViewController.GetItemInfo(_:)), for: UIControlEvents.touchUpInside)
        cell.itemInfoBTN.layer.cornerRadius = 5
        cell.itemInfoBTN.layer.masksToBounds = true
        cell.itemInfoBTN.tag = indexPath.row

        
        if itemSelected.itemAmmoCount != "NA" {
            cell.ammoIMG.isHidden = false
            cell.ammoLBL.text = "\(itemSelected.itemAmmoCount)"
            cell.ammoLBL.isHidden = false
            cell.addAmmoBTN.isHidden = false
            cell.addAmmoBTN.tag = indexPath.row
            cell.addAmmoBTN.addTarget(self, action: #selector(WeaponsViewController.AddAmmo(_:)), for: UIControlEvents.touchUpInside)
        } else {
            if itemSelected.itemAmmoCount == "0" {
                cell.ammoLBL.textColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 1.0)
            } else {
                cell.ammoLBL.textColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 1.0)
            }
            cell.ammoIMG.isHidden = true
            cell.ammoLBL.isHidden = true
            cell.addAmmoBTN.isHidden = true
        }
        cell.countLBL.text = "\(itemSelected.itemCount)"
        //var filteredInventoryItems = ItemsInventoryArray.filter{$0.name == ItemName}
       // print("Preparing to Filter CoreData")
        let array = ItemsInventoryArray.filter() {
            ($0.name.lowercased() as NSString).contains(ItemName)
        }
        
        
        /*
        let CoreFiltered = ItemsInventoryArray.filter{$0.name == "\(ItemName)"}

        print("Array of filtered core data = \(CoreFiltered)")
        
        var theImageURL = String()
        
        for theItem in CoreFiltered {
            print("theItems in array: \(theItem)")
            theImageURL = theItem.imageURL
            print("the Item Image URL = \(theImageURL)")
        }
        
      //  print("FilteredItems \(filteredInventoryItems)")
        
      //  cell.TableImage?.image = self.itemImageInfo[indexPath.row] as UIImage
        
        print("The Image URL = \(theImageURL)")
        
        
        let dirpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
       
        let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(theImageURL).png")
        let theImageData = NSData(contentsOfURL: url)
        
        
       // let url = NSURL.fileURLWithPath(path)
        let ItemImage = UIImage(data: theImageData!)
        
        */
       
        cell.TableImage?.image = itemSelected.itemImage
        
        
       // cell.TableImage?.image = filteredInventoryItems.
        
        //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if segue.identifier == "closeWeapons" {
            
            if let destination = segue.destination as? MapViewController {
                if let SelectIndex = TableView.indexPathForSelectedRow?.row {
                    
               //     destination.tempImage = weaponsImage[SelectIndex]
                    
                    
               //     destination.weaponLabel.text = weaponsLabel[SelectIndex] as String
                    
                //}
            }
        }
    }
    
    func FilterMyInventoryItems(_ urlData: Data) -> [MyWeaponsInventory] {
        
       // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var MyWeaponsInventoryArrayTemp = [MyWeaponsInventory]()
        
        /*
         itemNameArray.append("Fist")
         itemIDArray.append("0")
         itemPowerArray.append("5")
         itemRangeArray.append("1")
         itemTypeArray.append("Fist")
         itemCategoryArray.append("weapon")
         itemSpeedArray.append("0")
         itemViewRangeArray.append("1")
         armorsImage.append(UIImage(named: "Fist.png")!)
         */
        
      //  MyWeaponsInventoryArrayTemp.append(MyWeaponsInventory(itemName: "Fist", itemID: "0", itemType: "Fist", itemCategory: "weapon", itemRange: "1", itemViewRange: "1", itemPower: "5", itemSpeed: "1", itemImageURL: "Fist", itemImage: UIImage(named: "Fist.png")!))
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["item"] != "NA") {
                
                let itemName = result["item"].stringValue
               // print("ITEM NAME = \(itemName)")
                let itemURL = result["itemURL"].stringValue
                let itemID = "NA"
                let itemType = itemName
                let itemURL100 = result["itemURL100"].stringValue
                let itemCategory = result["category"].stringValue
                let itemCount = result["count"].stringValue
                let itemAmmoCount = result["ammoCount"].stringValue
                let itemLevel = result["level"].stringValue
                let itemRange = result["range"].stringValue
                let itemViewRange = result["viewrange"].stringValue
                let itemPower = result["power"].stringValue
                let itemSpeed = result["speed"].stringValue
                
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                
                
                
                let CoreFiltered = ItemsInventoryArray.filter{$0.name == "\(itemName)"}
                
                // print("Array of filtered core data = \(CoreFiltered)")
                
                var theImageURL = String()
                
                for theItem in CoreFiltered {
                   //  print("theItems in array: \(theItem)")
                    theImageURL = theItem.imageURL
                   //   print("the Item Image URL = \(theImageURL)")
                }
                
                //  print("FilteredItems \(filteredInventoryItems)")
                
                //  cell.TableImage?.image = self.itemImageInfo[indexPath.row] as UIImage
                
                  print("The Image URL = \(theImageURL)")
                
                
                let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                
                
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(theImageURL).png")
                
                
                let theImageData = try? Data(contentsOf: url)
                
                
                // let url = NSURL.fileURLWithPath(path)
                let ItemImage = UIImage(data: theImageData!)
                
                
                
                
                MyWeaponsInventoryArrayTemp.append(MyWeaponsInventory(itemName: itemName, itemID: itemID, itemType: itemType, itemCategory: itemCategory, itemRange: itemRange, itemViewRange: itemViewRange, itemPower: itemPower, itemSpeed: itemSpeed, itemImageURL: itemImageURL, itemImage: ItemImage!, itemCount: itemCount, itemAmmoCount: itemAmmoCount, itemLevel: itemLevel))
                
                
                /*
                 itemNameArray.append(itemName)
                 itemIDArray.append(itemID)
                 itemTypeArray.append(itemType)
                 itemCategoryArray.append(itemCategory)
                 itemPowerArray.append(itemPower)
                 itemRangeArray.append(itemRange)
                 itemSpeedArray.append(itemSpeed)
                 itemViewRangeArray.append(itemViewRange)
                 
                 */
                // playerstealthArray.append(playerstealth)
                
            }
            
        }
        /*
         print("ITEMNAME ARRAY =\(itemNameArray)")
         AllItems.append(itemNameArray)
         AllItems.append(itemIDArray)
         AllItems.append(itemTypeArray)
         AllItems.append(itemCategoryArray)
         AllItems.append(armorsImage)
         AllItems.append(itemPowerArray)
         AllItems.append(itemRangeArray)
         AllItems.append(itemSpeedArray)
         
         print("Items View range = \(itemViewRangeArray)")
         AllItems.append(itemViewRangeArray)
         */
        
        return MyWeaponsInventoryArrayTemp
    }

    func FilterItems(_ urlData: Data) -> [MyWeaponsInventory] {
        
       // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var MyWeaponsInventoryArrayTemp = [MyWeaponsInventory]()
        
        /*
        itemNameArray.append("Fist")
        itemIDArray.append("0")
        itemPowerArray.append("5")
        itemRangeArray.append("1")
        itemTypeArray.append("Fist")
        itemCategoryArray.append("weapon")
        itemSpeedArray.append("0")
        itemViewRangeArray.append("1")
        armorsImage.append(UIImage(named: "Fist.png")!)
*/
        
     //   MyWeaponsInventoryArrayTemp.append(MyWeaponsInventory(itemName: "Fist", itemID: "0", itemType: "Fist", itemCategory: "weapon", itemRange: "1", itemViewRange: "1", itemPower: "5", itemSpeed: "1", itemImageURL: "Fist", itemImage: UIImage(named: "Fist.png")!, itemCount: "1", itemAmmoCount: "NA", itemLevel: "1"))
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Items"].arrayValue {
            
            if ( result["name"] != "NA") {
                
                let itemName = result["name"].stringValue
                print("ITEM NAME = \(itemName)")
                let itemID = result["id"].stringValue
                let itemType = result["type"].stringValue
                let itemCategory = result["category"].stringValue
                let itemRange = result["range"].stringValue
                let itemViewRange = result["viewrange"].stringValue
                let itemPower = result["power"].stringValue
                let itemSpeed = result["speed"].stringValue
                let itemImageURL = result["imageURL"].stringValue
                
                let itemCount = result["count"].stringValue
                let itemAmmoCount = result["ammoCount"].stringValue
                let itemLevel = result["level"].stringValue

                
                /*
                switch itemName {
                case "knife":
                    armorsImage.append(UIImage(named: "knife.png")!)
                case "binoculars":
                    armorsImage.append(UIImage(named: "binoculars.png")!)
                case "magnum":
                    armorsImage.append(UIImage(named: "magnum gun.png")!)
                case "brass knuckles":
                    armorsImage.append(UIImage(named: "brass knuckles.png")!)
                case "Sniper Rifle":
                    armorsImage.append(UIImage(named: "Sniper Rifle.png")!)
                case "power fist":
                    armorsImage.append(UIImage(named: "power fist.png")!)
                default:
                    armorsImage.append(UIImage(named: "Fist.png")!)
                    
                }
                */
                
                
                let CoreFiltered = ItemsInventoryArray.filter{$0.name == "\(itemName)"}
                
               // print("Array of filtered core data = \(CoreFiltered)")
                
                var theImageURL = String()
                
                for theItem in CoreFiltered {
                   // print("theItems in array: \(theItem)")
                    theImageURL = theItem.imageURL
                  //  print("the Item Image URL = \(theImageURL)")
                }
                
                //  print("FilteredItems \(filteredInventoryItems)")
                
                //  cell.TableImage?.image = self.itemImageInfo[indexPath.row] as UIImage
                
              //  print("The Image URL = \(theImageURL)")
                
                
                let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                
                
                let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(theImageURL).png")
                let theImageData = try? Data(contentsOf: url)
                
                
                // let url = NSURL.fileURLWithPath(path)
                let ItemImage = UIImage(data: theImageData!)

                
                
                
                MyWeaponsInventoryArrayTemp.append(MyWeaponsInventory(itemName: itemName, itemID: itemID, itemType: itemType, itemCategory: itemCategory, itemRange: itemRange, itemViewRange: itemViewRange, itemPower: itemPower, itemSpeed: itemSpeed, itemImageURL: itemImageURL, itemImage: ItemImage!, itemCount: itemCount, itemAmmoCount: itemAmmoCount, itemLevel: itemLevel))
                
                
                /*
                itemNameArray.append(itemName)
                itemIDArray.append(itemID)
                itemTypeArray.append(itemType)
                itemCategoryArray.append(itemCategory)
                itemPowerArray.append(itemPower)
                itemRangeArray.append(itemRange)
                itemSpeedArray.append(itemSpeed)
                itemViewRangeArray.append(itemViewRange)
                
                */
                // playerstealthArray.append(playerstealth)
                
            }
            
        }
        /*
        print("ITEMNAME ARRAY =\(itemNameArray)")
        AllItems.append(itemNameArray)
        AllItems.append(itemIDArray)
        AllItems.append(itemTypeArray)
        AllItems.append(itemCategoryArray)
        AllItems.append(armorsImage)
        AllItems.append(itemPowerArray)
        AllItems.append(itemRangeArray)
        AllItems.append(itemSpeedArray)
        
        print("Items View range = \(itemViewRangeArray)")
        AllItems.append(itemViewRangeArray)
        */
        
        return MyWeaponsInventoryArrayTemp
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func RetrieveItems() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let managedContextGroups = appDelegate.managedObjectContext
        let fetchGroups = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let errorGroups: NSError?
        
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
                
                let ItemName = items.value(forKey: "name") as! String
                let ItemURL = items.value(forKey: "imageURL") as! String
                let ItemURL100 = items.value(forKey: "imageURL100") as! String
                let ItemPower = items.value(forKey: "power") as! String
                let ItemSpeed = items.value(forKey: "speed") as! String
                let ItemRange = items.value(forKey: "range") as! String
                let ItemCategory = items.value(forKey: "category") as! String
                let ItemOrder = items.value(forKey: "itemOrder") as! String
                let viewRange = items.value(forKey: "viewRange") as! String
                let subCategory = items.value(forKey: "subCategory") as! String               
                
                let ItemURL3D = items.value(forKey: "imageURL3D") as! String
                
                
                
                ItemsInventoryArray.append(ItemInventory(name: ItemName, imageURL: ItemURL, category: ItemCategory, power: ItemPower, speed: ItemSpeed, range: ItemRange, imageURL100: ItemURL100, itemOrder: ItemOrder, viewRange: viewRange, subCategory: subCategory, imageURL3D: ItemURL3D, unlocked: true))
                
                //TotalItemsArray.append(ItemNameURL)
            }
            
            
            //print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    

}


struct MyWeaponsInventory {
    
    var itemName: String
    var itemID: String
    var itemType: String
    var itemCategory: String
    var itemRange: String
    var itemViewRange: String
    var itemPower: String
    var itemSpeed: String
    var itemImageURL: String
    var itemImage: UIImage
    var itemCount: String
    var itemAmmoCount: String
    var itemLevel: String

}
