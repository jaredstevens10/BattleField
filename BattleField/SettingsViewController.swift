//
//  SettingsViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/16/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import UIKit
import GoogleSignIn
//import GIDSignIn

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YSSegmentedControlDelegate {
    @IBOutlet weak var TableView: UITableView!
    
     var tracking = GPSTrackingManager()
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    var previouslySelectedHeaderIndex: Int?
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    
    var cells: SwiftyAccordionCells!
    
    @IBOutlet weak var versionLBL: UILabel!
    
    let version = "1.0.0"
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var username = NSString()
    var email = NSString()
    var SettingsArray = [SettingsInfo]()
    var InProcessMissionsInfoArray = [SettingsInfo]()
    let prefs:UserDefaults = UserDefaults.standard
    var URLData = Data()
    var ShowAllMissions = Bool()
    var memberOfTeam = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if prefs.value(forKey: "MyTeamName") != nil {
            memberOfTeam = true
        }
        
        cells = SwiftyAccordionCells()
        
        self.setup()
       // self.TableView.estimatedRowHeight = 45
        self.TableView.rowHeight = UITableViewAutomaticDimension
        print("UITableViewAutomaticDimension = \(UITableViewAutomaticDimension)")
       // self.TableView.allowsMultipleSelection = true
        
        TableView.delegate = self
        TableView.dataSource = self
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        
        versionLBL.text = "Version: \(version)"
        
        if memberOfTeam {
        
        segmentControl.items = ["My Settings", "Team Settings"]
        } else {
        segmentControl.items = ["My Settings"]
        }
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
    
    func setup() {
        //self.enter.layer.cornerRadius = 4
        
        /*
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Notifications"))
        SettingsArray.append(SettingsInfo(id: "1", title: "Notifications", status: "Header", category: "test"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Location Updates"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 4"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 5"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 4"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 6"))
        */
        
        //HEADER
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Notifications"))
        SettingsArray.append(SettingsInfo(id: "1", title: "Notifications", status: "Header", category: "test", isTitle: true, desc: ""))
        
        self.cells.append(SwiftyAccordionCells.Item(value: "Nearby Items Radius"))
         SettingsArray.append(SettingsInfo(id: "2", title: "Nearby Items Radius", status: "Sub", category: "test", isTitle: false, desc: ""))
        
        self.cells.append(SwiftyAccordionCells.Item(value: "Under Attack"))
         SettingsArray.append(SettingsInfo(id: "3", title: "Under Attack", status: "Sub", category: "test", isTitle: false, desc: ""))
        
        //HEADER
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Location Tracking"))
         SettingsArray.append(SettingsInfo(id: "4", title: "Location Updates", status: "Header", category: "test", isTitle: true, desc: ""))
        
        self.cells.append(SwiftyAccordionCells.Item(value: "Background Updating"))
         SettingsArray.append(SettingsInfo(id: "5", title: "Background Updates", status: "Sub", category: "test", isTitle: false, desc: ""))
        
        
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Graphics"))
        SettingsArray.append(SettingsInfo(id: "6", title: "Graphics", status: "Header", category: "test", isTitle: true, desc: ""))
        
        self.cells.append(SwiftyAccordionCells.Item(value: "Display Blood Graphics"))
        SettingsArray.append(SettingsInfo(id: "7", title: "Display Blood Graphics", status: "Sub", category: "test", isTitle: false, desc: ""))
        
      
        
        
        
   /*
        
        //HEADER
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 3"))
         SettingsArray.append(SettingsInfo(id: "8", title: "Notifications", status: "Header", category: "test", isTitle: true))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
         SettingsArray.append(SettingsInfo(id: "9", title: "Notifications", status: "Sub", category: "test", isTitle: false))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
         SettingsArray.append(SettingsInfo(id: "10", title: "Notifications", status: "Sub", category: "test", isTitle: false))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
         SettingsArray.append(SettingsInfo(id: "11", title: "Notifications", status: "Sub", category: "test", isTitle: false))
        
        //HEADER
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 4"))
         SettingsArray.append(SettingsInfo(id: "12", title: "Notifications", status: "Sub", category: "test", isTitle: true))
*/
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let level = prefs.value(forKey: "USERXPLEVEL") as! String
        let status = "incomplete"
        
       // URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
        
        SettingsArray.append(SettingsInfo(id: "1", title: "Coming Soon", status: status, category: "test", isTitle: true, desc: ""))
        
        
        //MissionInfoArray = FilterMissionItems(URLData)
        DispatchQueue.main.async(execute: {
            self.actInd.stopAnimating()
        })
        
        self.TableView.reloadData()
        
    }
    
    @IBAction func TermsBTN(_ sender: Any) {
        
        
    }
    
    @IBAction func privacyBTN(_ sender: Any) {
        
        
    }
    
    func FilterMissionItems(_ urlData: Data) -> [SettingsInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var SettingsArrayTemp = [SettingsInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                let itemID = result["id"].stringValue
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
                    
                   // SettingsArrayTemp.append(SettingsInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status))
                    
                }
                
            }
            
        }
        
        
        return SettingsArrayTemp
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //UserDefaults.standard.Bool(forKey: "ImproveBatteryPauseTracking")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.items.count
        //return SettingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        let value = item.value
        let isChecked = item.isChecked as Bool
        
        
        
       // var selectedSetting = SettingsInfo()
        let row = indexPath.row
        
        var selectedSettingItem = SettingsArray[row]
        
        
       // itemSelected = SettingsArray[row]
        
        //cell.subtitleLabel.text = selectedSetting.title
        cell.subtitleLabel.text = value
        cell.titleLabel.text = value
        cell.messageLBL.text = ""
        
        if selectedSettingItem.isTitle {
            cell.subtitleLabel.isHidden = true
            cell.titleLabel.isHidden = false
            cell.segmentControl.isHidden = true
        } else {
            cell.subtitleLabel.isHidden = false
            cell.titleLabel.isHidden = true
            
            switch selectedSettingItem.title {
                
                case "Background Updates":
                cell.segmentControl.isHidden = false
                cell.segmentControl.items = ["Always", "Sometimes", "Never"]
                cell.segmentControl.font = UIFont(name: "Verdana", size: 12)
                cell.segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
                
                if UserDefaults.standard.bool(forKey: "DoNotTrackInBackground") {
                    cell.segmentControl.selectedIndex = 2
                    cell.messageLBL.text = "You will not be alert when nearby items"
                } else {
                    if UserDefaults.standard.bool(forKey: "ImproveBatteryPauseTracking") {
                        cell.segmentControl.selectedIndex = 1
                        cell.messageLBL.text = "Location updated when you move"
                    } else {
                        cell.segmentControl.selectedIndex = 0
                        cell.messageLBL.text = "Constant tracking"
                    }
                }
                
                
                //cell.segmentControl.selectedIndex = 0
                cell.segmentControl.thumbColor = UIColor.darkGray
                cell.segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
                
                case "Nearby Items Radius":
                cell.segmentControl.isHidden = false
                cell.segmentControl.items = ["100 Feet", "200 Feet", "300 Feet"]
                cell.segmentControl.font = UIFont(name: "Verdana", size: 12)
                cell.segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
                
               
                
                cell.segmentControl.selectedIndex = 1
                cell.segmentControl.thumbColor = UIColor.darkGray
                cell.segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
                
                case "Under Attack":
                cell.segmentControl.isHidden = false
                cell.segmentControl.items = ["Yes", "No"]
                cell.segmentControl.font = UIFont(name: "Verdana", size: 12)
                cell.segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
                cell.segmentControl.selectedIndex = 0
                cell.segmentControl.thumbColor = UIColor.darkGray
                cell.segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
                
                
                case "Display Blood Graphics":
                    cell.segmentControl.isHidden = false
                    cell.segmentControl.items = ["Yes", "No"]
                    cell.segmentControl.font = UIFont(name: "Verdana", size: 12)
                    cell.segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
                    //cell.segmentControl.selectedIndex = 0
                    cell.segmentControl.thumbColor = UIColor.darkGray
                    cell.segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
                
                
                    if UserDefaults.standard.bool(forKey: "ShowBlood") {
                        cell.segmentControl.selectedIndex = 0
                    } else {
                        cell.segmentControl.selectedIndex = 1
                    }
                
                
                
            default:
                cell.segmentControl.isHidden = true
            }
            
        }
        
        cell.TableImage.isHidden = true
        cell.segmentControl.tag = indexPath.row
        cell.segmentControl.addTarget(self, action: #selector(SettingsViewController.segmentValueChangedClicked(_:)), for: UIControlEvents.valueChanged)
        
        /*
        
        if itemSelected.status == "complete" {
            cell.TableImage.isHidden = false
        } else {
            cell.TableImage.isHidden = true
        }
        */
        
        
        return cell
    }
    
    
    @IBAction func LogOutBTN(_ sender: Any) {
        
        
        
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            self.prefs.set(true, forKey: "SettingsLoggingOut")
            
            //self.navigationController?.popToRootViewController(animated: true)
            
            GIDSignIn.sharedInstance().signOut()
            
            
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "UnwindToStart"), object: nil)
            })
            
            
        }
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            
            
        }
        actionSheetController.addAction(yesAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
        
    }
    
    
    func segmentValueChangedClicked(_ sender: AnyObject){
        
       
        let row = sender.tag
        var SettingsSelected: SettingsInfo
        
        
        var segmentIndex = sender.selectedIndex
        
        print("Segment Index = \(segmentIndex)")
        
        SettingsSelected = SettingsArray[row!]
        
        if segmentIndex == 0 {
            
            switch SettingsSelected.title {
                
            case "Background Updates":
                UserDefaults.standard.set(false, forKey: "ImproveBatteryPauseTracking")
                UserDefaults.standard.set(false, forKey: "DoNotTrackInBackground")
                
                tracking.startTracking()
                
            case "Nearby Items Radius":
                print("Nearby Items 100 Feet")
                UserDefaults.standard.set(100.0, forKey: "NotificationsNearbyItemsRadius")
            
            case "Under Attack":
                print("under attack")
                
            case "Display Blood Graphics":
                print("Display Blood Graphics")
                UserDefaults.standard.set(true, forKey: "ShowBlood")
                
            default:
                break
            }
            

        } else if segmentIndex == 1 {
            
            switch SettingsSelected.title {
                
                case "Background Updates":
                UserDefaults.standard.set(true, forKey: "ImproveBatteryPauseTracking")
                UserDefaults.standard.set(false, forKey: "DoNotTrackInBackground")
                
                tracking.startTracking()
                
            case "Nearby Items Radius":
                print("Nearby Items 200 Feet")
                UserDefaults.standard.set(200.0, forKey: "NotificationsNearbyItemsRadius")
                
                case "Display Blood Graphics":
                print("Display Blood Graphics")
                UserDefaults.standard.set(false, forKey: "ShowBlood")
                
            default:
                break
            }
          
        } else if segmentIndex == 2 {
            
            switch SettingsSelected.title {
                
            case "Background Updates":
                UserDefaults.standard.set(false, forKey: "ImproveBatteryPauseTracking")
                UserDefaults.standard.set(true, forKey: "DoNotTrackInBackground")
                
            case "Nearby Items Radius":
                print("Nearby Items 300 Feet")
                UserDefaults.standard.set(300.0, forKey: "NotificationsNearbyItemsRadius")
                
                tracking.startTracking()
                
            default:
                break
            }
            
        } else {
            
          
        }
    }
    
    
    @IBAction func closeBTn(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            print("My Settings")
            
            self.cells.removeAll()
            self.SettingsArray.removeAll()
            
            self.setup()
            
             self.TableView.reloadData()
            
        } else if segmentControl.selectedIndex == 1 {
            
            print("Team Settings")
            
            
            self.ShowAllMissions = true
            
            self.cells.removeAll()
            self.SettingsArray.removeAll()
            
            self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Coming Soon"))
            SettingsArray.append(SettingsInfo(id: "1", title: "Coming Soon", status: "Header", category: "test", isTitle: true, desc: ""))
            
            
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
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            return 70
        } else if (item.isHidden) {
            return 0
        } else {
            //return UITableViewAutomaticDimension
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.cells.items[(indexPath as NSIndexPath).row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            if self.selectedHeaderIndex == nil {
                self.selectedHeaderIndex = (indexPath as NSIndexPath).row
            } else {
                self.previouslySelectedHeaderIndex = self.selectedHeaderIndex
                self.selectedHeaderIndex = (indexPath as NSIndexPath).row
            }
            
            if let previouslySelectedHeaderIndex = self.previouslySelectedHeaderIndex {
                self.cells.collapse(previouslySelectedHeaderIndex)
            }
            
            if self.previouslySelectedHeaderIndex != self.selectedHeaderIndex {
                self.cells.expand(self.selectedHeaderIndex!)
            } else {
                self.selectedHeaderIndex = nil
                self.previouslySelectedHeaderIndex = nil
            }
            
            self.TableView.beginUpdates()
            self.TableView.endUpdates()
            
        } else {
            if (indexPath as NSIndexPath).row != self.selectedItemIndex {
                let cell = self.TableView.cellForRow(at: indexPath)
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
                
                if let selectedItemIndex = self.selectedItemIndex {
                    let previousCell = self.TableView.cellForRow(at: IndexPath(row: selectedItemIndex, section: 0))
                    previousCell?.accessoryType = UITableViewCellAccessoryType.none
                    cells.items[selectedItemIndex].isChecked = false
                }
                
                self.selectedItemIndex = (indexPath as NSIndexPath).row
                cells.items[self.selectedItemIndex!].isChecked = true
            }
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

struct SettingsInfo {
    
    var id: String
    var title: String
    var status: String
    var category: String
    var isTitle: Bool
    var desc: String
    
    
}
