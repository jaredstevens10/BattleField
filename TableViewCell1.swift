//
//  TableViewCell1.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/4/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData

class TableViewCell1: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    var TotalItemsInventoryArray = [ItemInventorySorted]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    //  var isOpen = Bool()
    
    // @IBOutlet weak var hideBTN: UIButton!
    // @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
            
            return TotalItemsInventoryArray.count
            
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellSmall", for: indexPath) as! ItemsCollectionViewCellSmall
        
        
        var itemTemp : ItemInventorySorted
        
        itemTemp = TotalItemsInventoryArray[indexPath.row]
        
        cell.backgroundColor = UIColor.clear
        //cell.imageView.image = UIImage(named: "knife.png")
        
        
        let imageName = itemTemp.imageURL100
        let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(imageName).png")
       // print("url for image = \(url)")
        let theImageData = try? Data(contentsOf: url)
        
        //TestImage = UIImage(data:theImageData!)!
        
        cell.imageView.image  = UIImage(data: theImageData!)!
        cell.itemName.text = itemTemp.name
        //  cell.itemPowerLBL.text = "Power: \(itemTemp.power)"
        //  cell.itemSpeedLBL.text = "Speed: \(itemTemp.speed)"
        //  cell.itemRangeLBL.text = "Range: \(itemTemp.range)"
        
        
        if itemTemp.category != "weapon" {
        if indexPath.row > 0 {
            cell.lockView.isHidden = false
        } else {
            cell.lockView.isHidden = true
        }
        } else {
            cell.lockView.isHidden = true
        }
        
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Item Selected Small"
            alertView.message = "Item \(indexPath.row) Selected"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            self.removeFromSuperview()
            
            
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         RetrieveImages()
        
        
        
        let columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
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
