//
//  MissionListViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/20/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class MissionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YSSegmentedControlDelegate {
  @IBOutlet weak var TableView: UITableView!
    
    
@IBOutlet var segmentControl : ADVSegmentedControl!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var username = NSString()
    var email = NSString()
    var MissionInfoArray = [MissionInfo]()
    var InProcessMissionsInfoArray = [MissionInfo]()
    let prefs:UserDefaults = UserDefaults.standard
    var URLData = Data()
    var ShowAllMissions = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString

        
        segmentControl.items = ["incomplete", "all"]
        segmentControl.font = UIFont(name: "Verdana", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor.darkGray
        segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(MissionListViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
         self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let level = prefs.value(forKey: "USERXPLEVEL") as! String
        let status = "incomplete"
        
        URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
        
        
        MissionInfoArray = FilterMissionItems(URLData)
        DispatchQueue.main.async(execute: {
            self.actInd.stopAnimating()
        })
        
        self.TableView.reloadData()
        
    }
    
    func FilterMissionItems(_ urlData: Data) -> [MissionInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var MyWeaponsInventoryArrayTemp = [MissionInfo]()
        

        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                let itemID = result["id"].stringValue
                let name = result["name"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                
                 let status = result["status"].stringValue
                 let level = result["level"].stringValue
                 let objective = result["objective"].stringValue
                 let xp = result["xp"].stringValue
                //let itemID = "NA"
               
                var AddItem = Bool()
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                if self.ShowAllMissions {
                    AddItem = true
                } else {
                    if status == "incomplete" {
                        AddItem = true
                    } else {
                        AddItem = false
                    }
                    
                }
                
                if AddItem {
                
                    MyWeaponsInventoryArrayTemp.append(MissionInfo(id: itemID, name: name, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                    
                }

            }
            
        }
       
        
        return MyWeaponsInventoryArrayTemp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MissionInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        
        var itemSelected: MissionInfo
        let row = indexPath.row
        
        //let selectedResult = indexPath.item
        
        
        itemSelected = MissionInfoArray[row]
        
        cell.subtitleLabel.text = itemSelected.objective
        
        cell.titleLabel.text = itemSelected.name
        cell.mapBTN.tag = row
        
        cell.mapBTN.addTarget(self, action: #selector(MissionListViewController.UpdateMissionLocation(_:)), for: UIControl.Event.touchUpInside)
        
       // cell.mapBTN.layer.cornerRadius = 20
        
        if itemSelected.status == "complete" {
            cell.TableImage.isHidden = false
            cell.mapBTN.isHidden = true
        } else {
            cell.TableImage.isHidden = true
            cell.mapBTN.isHidden = true
        }
        
        
        
        return cell
    }
    
    @objc func UpdateMissionLocation(_ sender: AnyObject) {
        
        let row = sender.tag
        var MissionSelected: MissionInfo
        
        
        
        let alertController = UIAlertController(
            title: "Coming Soon!",
            message: "In Development.",
            preferredStyle: .alert)
        
        //  let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        //  alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
        
       // self.performSegue(withIdentifier: "CharacterInfo", sender: self)
        
        
    }
    
    
    @IBAction func closeBTn(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
      
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            print("incomplete")
            
  
            /*
            

            let level = prefs.value(forKey: "USERXPLEVEL") as! String
            let status = "incomplete"
            
            let URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
            
            
            MissionInfoArray = FilterMissionItems(URLData)
            DispatchQueue.main.async(execute: {
                self.actInd.stopAnimating()
            })
            */
            
            self.ShowAllMissions = false
            
            
            MissionInfoArray = FilterMissionItems(URLData)
            DispatchQueue.main.async(execute: {
               // self.actInd.stopAnimating()
            })
            
            self.TableView.reloadData()
            
            
            
        } else if segmentControl.selectedIndex == 1 {
            
            print("all")
            
            
            self.ShowAllMissions = true
            
            /*
            let level = prefs.value(forKey: "USERXPLEVEL") as! String
            let status = "incomplete"
            
            let URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
            
            
            MissionInfoArray = FilterMissionItems(URLData)
            DispatchQueue.main.async(execute: {
                self.actInd.stopAnimating()
            })
            */
            
            MissionInfoArray = FilterMissionItems(URLData)
            DispatchQueue.main.async(execute: {
                // self.actInd.stopAnimating()
            })

            
            self.TableView.reloadData()
            //salesValue.text = "$81,295"
        } else {
         
            /*
            if !self.pickerItem {
                //  self.refreshMyGames()
            } else {
                //  self.refreshPublicGames()
            }
            */
            
            DispatchQueue.main.async(execute: {
                //    self.actInd.hidden = true
                //    self.actInd.stopAnimating()
            })
            //   })
            // filterContentForSearchText("", scope: "In Process")
            //salesValue.text = "$199,392"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct MissionInfo {
    

    var id: String
    var name: String
    var level: String
    var objective: String
    var xp: String
    var lat: Double
    var long: Double
    var status: String

    
}


struct CameraInfo {
    
    var id: String
    var level: String
   // var objective: String
   // var xp: String
    var lat: Double
    var long: Double
    var status: String
    var owner: String
    var startTime: Date
    var endTime: Date
    var radius: Double
    var range: Double
    
    
}
