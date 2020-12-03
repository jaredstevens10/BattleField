//
//  TeamMembersViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/19/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import UIKit



class TeamMembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YSSegmentedControlDelegate {
    @IBOutlet weak var TableView: UITableView!
    
    
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var username = NSString()
    var email = NSString()
    var MissionInfoArray = [TeamMembersInfo]()
    var InProcessMissionsInfoArray = [TeamMembersInfo]()
    let prefs:UserDefaults = UserDefaults.standard
    var URLData = Data()
    var ShowAllMissions = Bool()
    
    
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        
        
        segmentControl.items = ["All", "Admin", "New Recruits"]
        segmentControl.font = UIFont(name: "Verdana", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor.darkGray
        segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(HitListViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        URLData = GetTargets(self.email, level: level as NSString, status: status as NSString)
        
        
        MissionInfoArray = FilterMissionItems(URLData)
        DispatchQueue.main.async(execute: {
            self.actInd.stopAnimating()
        })
        
        self.TableView.reloadData()
        
    }
    
    func FilterMissionItems(_ urlData: Data) -> [TeamMembersInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        var TargetsCount: Int = 0
        
        var MyWeaponsInventoryArrayTemp = [TeamMembersInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                TargetsCount += 1
                let itemID = result["id"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                let altTemp = result["altitude"].stringValue
                let alt = Double(altTemp)
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let objective = result["objective"].stringValue
                let xp = result["xp"].stringValue
                let lastdate = result["datetime"].stringValue
                let targetname = result["targetname"].stringValue
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
                    
                    MyWeaponsInventoryArrayTemp.append(TeamMembersInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status, lastDate: lastdate, teamTitle: targetname, alt: alt!))
                    
                }
                
            }
            
        }
        
        //UserDefaults.standard.set(TargetsCount, forKey: "CurrentNumberTargets")
        
        return MyWeaponsInventoryArrayTemp
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func TargetSelected(_ sender: AnyObject) {
        
        let row = sender.tag
        var TargetPicked: TeamMembersInfo
        
        TargetPicked = MissionInfoArray[row!]
        
        // self.theJobTitle = JobSelected.jobtitle
        // self.theJobImage = JobSelected.jobImage
        // self.theJobDescription = JobSelected.jobDescription
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                //self.CapturingTerritory = false
                subview.removeFromSuperview()
            }
        }
        
        var itemLat = TargetPicked.lat
        var itemLong = TargetPicked.long
        var itemAlt = TargetPicked.alt
        var datetime = TargetPicked.lastDate
        var name = TargetPicked.teamTitle
        
        
        // var itemLat = 28.1347
        //  var itemLong = -81.1316
        
        DispatchQueue.main.async(execute: {
            let view = DistanceAttackView.instanceFromNib(lat: itemLat, long: itemLong, datetime: datetime, name: name, alt: itemAlt)
            view.tag = 1000
            
            self.view.addSubview(view)
        })
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MissionInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        
        var itemSelected: TeamMembersInfo
        let row = indexPath.row
        
        //let selectedResult = indexPath.item
        
        
        itemSelected = MissionInfoArray[row]
        
        cell.subtitleLabel.text = itemSelected.teamTitle
        
        cell.mapBTN.tag = indexPath.row
        
        cell.mapBTN.addTarget(self, action: #selector(TeamMembersViewController.TargetSelected(_:)), for: UIControl.Event.touchUpInside)
        
        
        // print("Date Time Stamp one: \(datetimeTemp)")
        let datetimeTempFormated = dateFormatter.date(from: itemSelected.lastDate)
        
        let RightNow = Date()
        let FromTime = RightNow.offsetFrom(datetimeTempFormated!)
        
        print("Cell \(indexPath.row) FROM TIME: \(FromTime)")
        
        
        if itemSelected.status == "complete" {
            cell.TableImage.isHidden = false
            cell.CompletedView.isHidden = false
        } else {
            cell.TableImage.isHidden = true
            cell.CompletedView.isHidden = true
        }
        
        
        
        return cell
    }
    
    
    @IBAction func closeBTn(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func segmentValueChanged(_ sender: AnyObject?){
        
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

struct TeamMembersInfo {
    
    var id: String
    var level: String
    var objective: String
    var xp: String
    var lat: Double
    var long: Double
    var status: String
    var lastDate: String
    var teamTitle: String
    var alt: Double
    
    
}

