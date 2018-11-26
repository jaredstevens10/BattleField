//
//  ShieldViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 8/3/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit


    protocol ShieldViewControllerDelegate: class {
        func ShieldViewControllerFinished(_ shieldviewController: ShieldViewController)
    }
    
    class ShieldViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        
        var prefs:UserDefaults = UserDefaults.standard
        var username = NSString()
        
        var sdelegate: ShieldViewControllerDelegate?
        
        var AllItems = [NSArray]()
        
        var itemName = NSString()
        var itemID = NSString()
        var itemType = NSString()
        var itemCategory = NSString()
        var itemRange = NSString()
        var itemPower = NSString()
        var itemSpeed = NSString()
        
        var itemNameArray = [NSString]()
        var itemIDArray = [NSString]()
        var itemTypeArray = [NSString]()
        var itemCategoryArray = [NSString]()
        var itemRangeArray = [NSString]()
        var itemPowerArray = [NSString]()
        var itemSpeedArray = [NSString]()
        
        var itemNameInfo = [NSString]()
        var itemIDInfo = [NSString]()
        var itemTypeInfo = [NSString]()
        var itemCategoryInfo = [NSString]()
        var itemRangeInfo = [NSString]()
        var itemPowerInfo = [NSString]()
        var itemImageInfo = [UIImage]()
        var itemSpeedInfo = [NSString]()
        
        var RangeSelected = NSString()
        var PowerSelected = NSString()
        var SpeedSelected = NSString()
        
        
        @IBOutlet weak var TableView: UITableView!
        
        var armorsImage = [UIImage]()
        
        var armorsLabel = [NSString]()
        var armorPKimage: UIImage!
        var armorPKLabel: NSString!
        
        @IBOutlet weak var testButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let prefs:UserDefaults = UserDefaults.standard
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            
            TableView.delegate = self
            TableView.dataSource = self
            
            var Category = "Shield"
            var URLData = GetMyItems(username, category: Category as NSString)
            print("URLData Refreshed: \(URLData)")
            var itemInfo = FilterItems(URLData)
            print("itemInfo : \(itemInfo)")
            print("User Locations Updated")
            
            
            //  armorsImage.append(UIImage(named: "wood armor.png")!)
            //  armorsImage.append(UIImage(named: "black armor.png")!)
            //   weaponsImage.append(UIImage(named: "magnum gun.png")!)
            
            //   armorsLabel.append("Wood Armor")
            //   armorsLabel.append("Black Armor")
            // weaponsLabel.append("Magnum")
            
            itemNameInfo = itemInfo[0] as! [(NSString)]
            itemIDInfo = itemInfo[1] as! [(NSString)]
            itemTypeInfo = itemInfo[2] as! [(NSString)]
            itemCategoryInfo = itemInfo[3] as! [(NSString)]
            itemImageInfo = itemInfo[4] as! [(UIImage)]
            itemPowerInfo = itemInfo[5] as! [(NSString)]
            itemRangeInfo = itemInfo[6] as! [(NSString)]
            itemSpeedInfo = itemInfo[7] as! [(NSString)]
            
            self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
            self.TableView.reloadData()
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.armorsImage.count;
        }
        
        @IBAction func close(_ sender: AnyObject) {
            dismiss(animated: true, completion: nil)
            sdelegate?.ShieldViewControllerFinished(self)
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let row = indexPath.row
            let selectedResult = indexPath.item
            armorPKimage = itemImageInfo[row]
            print(armorPKimage)
            
            
            armorPKLabel = itemNameInfo[row]
            
            prefs.setValue(armorPKLabel, forKey: "HOLDINGSHIELD")
            
            print(armorPKLabel)
            
            RangeSelected = itemRangeInfo[row]
            PowerSelected = itemPowerInfo[row]
            SpeedSelected = itemSpeedInfo[row]
            /*
            
            var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(armorPKimage, forKey: "SELECTEDSHIELD")
*/
            //  MapViewController.ToolsBTN.setImage(weaponsImage[row], forState: .Normal)
            
            //     mDelegate?.sendArrayToPreviousVC(weaponPKimage, weaponPKLabel)
            
            //   self.performSegueWithIdentifier("closeWeapons", sender: self)
            
            
            
            
            
            self.dismiss(animated: true, completion: nil)
            
            self.sdelegate?.ShieldViewControllerFinished(self)
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
            
            cell.TableImage?.image = self.itemImageInfo[indexPath.row] as UIImage
            
            cell.titleLabel?.text = self.itemNameInfo[indexPath.row] as String
            
            
            
            //  cell.TurnLabel!.text = self.UsersTurnInfo[indexPath.row] as String
            
            
            return cell
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //  if segue.identifier == "closeWeapons" {
            
            if let destination = segue.destination as? MapViewController {
                if let SelectIndex = TableView.indexPathForSelectedRow?.row {
                    
                    //     destination.tempImage = armorsImage[SelectIndex]
                    
                    
                    //     destination.weaponLabel.text = armorsLabel[SelectIndex] as String
                    
                    //}
                }
            }
            
            
        }
        
        func FilterItems(_ urlData: Data) -> [NSArray] {
            
            var traits = [NSString]()
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            var json = JSON(jsonData)
            
            //println("Json value: \(jsonData)")
            print("Json valueJSON: \(json)")
            
            for result in json["Items"].arrayValue {
                
                if ( result["id"] != "0") {
                    
                    itemName = result["name"].stringValue as NSString
                    itemID = result["id"].stringValue as NSString
                    itemType = result["type"].stringValue as NSString
                    itemCategory = result["category"].stringValue as NSString
                    itemRange = result["range"].stringValue as NSString
                    itemPower = result["power"].stringValue as NSString
                    itemSpeed = result["speed"].stringValue as NSString
                    
                    
                    switch itemName {
                    case "american shield":
                        armorsImage.append(UIImage(named: "American Shield.png")!)
                    case "blue shield":
                        armorsImage.append(UIImage(named: "blue shield.png")!)
                        print("blue shield image should show")
                    case "wooden shield":
                        armorsImage.append(UIImage(named: "wooden shield.png")!)
                    case "metal shield":
                        armorsImage.append(UIImage(named: "metal shield.png")!)

                        
                    default:
                        armorsImage.append(UIImage(named: "wooden shield.png")!)
                        
                    }
                    
                    
                    itemNameArray.append(itemName)
                    itemIDArray.append(itemID)
                    itemTypeArray.append(itemType)
                    itemCategoryArray.append(itemCategory)
                    itemPowerArray.append(itemPower)
                    itemRangeArray.append(itemRange)
                    itemSpeedArray.append(itemSpeed)
                    // playerstealthArray.append(playerstealth)
                    
                }
                
            }
            
            AllItems.append(itemNameArray as NSArray)
            AllItems.append(itemIDArray as NSArray)
            AllItems.append(itemTypeArray as NSArray)
            AllItems.append(itemCategoryArray as NSArray)
            AllItems.append(armorsImage as NSArray)
            AllItems.append(itemPowerArray as NSArray)
            AllItems.append(itemRangeArray as NSArray)
            AllItems.append(itemSpeedArray as NSArray)
            
            
            
            return AllItems
        }
}
