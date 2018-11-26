//
//  EditBodyCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/20/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditBodyCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     var prefs:UserDefaults = UserDefaults.standard
    
    var BodyCategory = String()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var optionsArray = [BodyInfo_Eyes]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    //  var isOpen = Bool()
    
    // @IBOutlet weak var hideBTN: UIButton!
    // @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        
        //return TotalItemsInventoryArray.count
        return optionsArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditBodyItemCell", for: indexPath) as! EditBodyItemCell
        
        
        var ItemSelected: BodyInfo_Eyes
        ItemSelected = optionsArray[indexPath.row]
        
        cell.title.text = ItemSelected.title as! String
        cell.imageView.image = UIImage(named: "\(ItemSelected.imageName)")
        
//        var itemTemp : ItemInventorySorted
//        
//        itemTemp = TotalItemsInventoryArray[indexPath.row]
//        
//        cell.backgroundColor = UIColor.clear
//        //cell.imageView.image = UIImage(named: "knife.png")
//        let imageName = itemTemp.imageURL100
//        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
//        let theImageData = try? Data(contentsOf: url)
//        cell.imageView.image  = UIImage(data: theImageData!)!
//        cell.itemName.text = itemTemp.name
//
//        
//        if itemTemp.category != "weapon" {
//            if indexPath.row > 0 {
//                cell.lockView.isHidden = false
//            } else {
//                cell.lockView.isHidden = true
//            }
//        } else {
//            cell.lockView.isHidden = true
//        }
        
        
        
        

        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Item Selected Small"
        alertView.message = "Item \(indexPath.row) Selected"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
        //self.removeFromSuperview()
        
        
      //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateEditBodyLayout"), object: nil)
        
      //  self.removeFromSuperview()
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      //  RetrieveImages()
        
        if prefs.value(forKey: "EditCharacterInfo") != nil {
        BodyCategory = prefs.value(forKey: "EditCharacterInfo") as! String
        } else {
        BodyCategory = "eyes"
        }
        
        optionsArray.append(BodyInfo_Eyes(title: "blue", imageName: "EyeIcon_Blue", nodeName: "TBD"))
        optionsArray.append(BodyInfo_Eyes(title: "green", imageName: "EyeIcon_Green", nodeName: "TBD"))
        optionsArray.append(BodyInfo_Eyes(title: "brown", imageName: "EyeIcon_Brown", nodeName: "TBD"))
        
        print("BODY CATEGORY  = \(BodyCategory)")
        
        let columnHeaderViewNIBSmall = UINib(nibName: "EditBodyItemCell", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "EditBodyItemCell")
        
        self.collectionView.backgroundColor = UIColor.clear
        
        
        // Initialization code
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
                // print("Saved items = \(SavedItemsInventory)")
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
                
                
                if (category == "armorgloves") && (itemOrder != "0") {
                    
                    
                    TotalItemsInventoryArray.append(ItemInventorySorted(name: itemname, imageURL: imageURL, category: category, power: power, speed: speed, range: range, imageURL100: imageURL100, itemOrder: itemOrder, itemOrderNum: Int(itemOrder)!, health: health, stamina: stamina, viewRange: viewRange, subCategory: subCategory, unlocked: true))
                    
                }
            }
            
            //    print("TotalItemsInventoryArray - PreSorted - \(TotalItemsInventoryArray)")
            
            
            
            TotalItemsInventoryArray.sort { (lhs: ItemInventorySorted, rhs: ItemInventorySorted) -> Bool in
                // you can have additional code here
                return lhs.itemOrderNum < rhs.itemOrderNum
            }
            
            
            
            //  print("TotalItemsInventoryArray - Sorted - \(TotalItemsInventoryArray)")
            
            
            // print("Current items IMAGE URL =\(TotalItemsArray)")
            
            
            
            if self.SavedItemsInventory.count > 0 {
                //  GroupInfoLBL.hidden = true
            } else {
                //  GroupInfoLBL.hidden = false
            }
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

struct BodyInfo_Eyes {
    
    var title: String
    var imageName: String
    var nodeName: String
}


class EditBodyItemCell: UICollectionViewCell {
    

    
  //  @IBOutlet weak var BGView: UIView!
  
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        BGView.layer.cornerRadius = 5
//        BGView.layer.masksToBounds = true
//        BGView.clipsToBounds = true
        
        
        
        
        // Initialization code
    }
    
    
    
    
}
