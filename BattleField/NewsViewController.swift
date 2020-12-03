//
//  NewsViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 1/14/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YSSegmentedControlDelegate {
    @IBOutlet weak var TableView: UITableView!
    
    
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var username = NSString()
    var email = NSString()
    var NewsInfoArray = [NewsInfo]()
    var InProcessMissionsInfoArray = [NewsInfo]()
    let prefs:UserDefaults = UserDefaults.standard
    var URLData = Data()
    var ShowAllNews = Bool()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
        email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
        
        
        segmentControl.items = ["New", "all"]
        segmentControl.font = UIFont(name: "Verdana", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor.darkGray
        segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(NewsViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let level = prefs.value(forKey: "USERXPLEVEL") as! String
        let status = "incomplete"
        
        URLData = GetNews(self.email)
        
        
        NewsInfoArray = FilterNewsItems(URLData)
        DispatchQueue.main.async(execute: {
            self.actInd.stopAnimating()
        })
        
        self.TableView.reloadData()
        
    }
    
    func FilterNewsItems(_ urlData: Data) -> [NewsInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        
        
        var MyWeaponsInventoryArrayTemp = [NewsInfo]()
        
        
        
        
        var traits = [NSString]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("News Json valueJSON: \(json)")
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                
                let newsID = result["id"].stringValue
                let newsTitleTemp3 = result["title"].stringValue
                let newsDescTemp3 = result["description"].stringValue
                let linkTemp3 = result["link"].stringValue
                let imageURL = result["imageURL"].stringValue
 
                
                
                let newsTitleTemp2 = Data(base64Encoded: newsTitleTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let newsDescTemp2 = Data(base64Encoded: newsDescTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let linkTemp2 = Data(base64Encoded: linkTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                
                let newsTitle = NSString(data: newsTitleTemp2, encoding: String.Encoding.utf8.rawValue)!
                let newsDescription = NSString(data: newsDescTemp2, encoding: String.Encoding.utf8.rawValue)!
                let link = NSString(data: linkTemp2, encoding: String.Encoding.utf8.rawValue)!
                
                var newsViewed = Bool()
                
                var AddItem = Bool()
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                if self.ShowAllNews {
                    AddItem = true
                } else {
//                    if status == "incomplete" {
//                        AddItem = true
//                    } else {
//                        AddItem = false
//                    }
                    AddItem = false
                }
                
                if AddItem {
                    
                    MyWeaponsInventoryArrayTemp.append(NewsInfo(id: newsID, title: newsTitle as String, description: newsDescription as String, imageURL: imageURL, link: link as String, viewed: false))
                    
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
        return NewsInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        
        var itemSelected: NewsInfo
        let row = indexPath.row
        
        //let selectedResult = indexPath.item
        
        
        itemSelected = NewsInfoArray[row]
        
        cell.subtitleLabel.text = itemSelected.description
      //  cell.titleLabel.text = itemSelected.title
        
        
//        if itemSelected.status == "complete" {
//            cell.TableImage.isHidden = false
//        } else {
//            cell.TableImage.isHidden = true
//        }
        
        
        
        return cell
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
            
            self.ShowAllNews = false
            
            
            NewsInfoArray = FilterNewsItems(URLData)
            DispatchQueue.main.async(execute: {
                // self.actInd.stopAnimating()
            })
            
            self.TableView.reloadData()
            
            
            
        } else if segmentControl.selectedIndex == 1 {
            
            print("all")
            
            
            self.ShowAllNews = true
            
            /*
             let level = prefs.value(forKey: "USERXPLEVEL") as! String
             let status = "incomplete"
             
             let URLData = GetMission(self.email, level: level as NSString, status: status as NSString)
             
             
             MissionInfoArray = FilterMissionItems(URLData)
             DispatchQueue.main.async(execute: {
             self.actInd.stopAnimating()
             })
             */
            
            NewsInfoArray = FilterNewsItems(URLData)
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



struct NewsInfo {
    
    var id: String
    var title: String
    var description: String
    var imageURL: String
    var link: String
    var viewed: Bool
    //var status: String
    
    
}
