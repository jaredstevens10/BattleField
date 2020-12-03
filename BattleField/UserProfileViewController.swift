//
//  UserProfileViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/25/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

     var URLData = Data()
    var IsTarget = Bool()
    
    @IBOutlet weak var xpView: UIView!
    
    @IBOutlet weak var targetBTN: UIButton!
    
    
    @IBOutlet weak var xpProgress: UIProgressView!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelLBL: UILabel!
    @IBOutlet weak var xpLBL: UILabel!
    
    var TargetLat = String()
    var TargetLong = String()
    var TargetAlt = String()
    
    
    @IBOutlet weak var showMessageViewBTN: UIButton!
    
    @IBOutlet weak var segmentViewMenu: UIView!
    
    @IBOutlet weak var playerStatusLBL: UILabel!
    
    @IBOutlet weak var playerStatsView: UIView!
    
     @IBOutlet var segmentControl : ADVSegmentedControl!
    
    let now = CFAbsoluteTimeGetCurrent()
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var CreateMessageViewTOP: NSLayoutConstraint!
    
    @IBOutlet weak var CreateMessageView: UIView!
    
    @IBOutlet weak var sendMessageBTN: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    let prefs:UserDefaults = UserDefaults.standard
    var theMessage = NSString()
    var ShowingCreateMessageView = Bool()
    var username = NSString()
    var email = NSString()
    
  //  var toUsername = NSString()
  //  var toEmail = NSString()
    
    var TargetUserName = String()
    var TargetUserID = String()
    
    @IBOutlet weak var UserNameTitleLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.xpProgress.setProgress(0.5, animated: true)
        //segmentViewMenu.layer
        
        
        self.targetBTN.layer.cornerRadius = 5
        self.targetBTN.layer.masksToBounds = true
        self.targetBTN.clipsToBounds = true
        self.targetBTN.layer.borderWidth = 1
        self.targetBTN.layer.borderColor = UIColor.white.cgColor
        
        self.levelView.layer.cornerRadius = 15
        self.levelView.layer.masksToBounds = true
        self.levelView.clipsToBounds = true
        self.levelView.layer.borderWidth = 1
        self.levelView.layer.borderColor = UIColor.white.cgColor
        
        self.showMessageViewBTN.layer.cornerRadius = 25
        self.showMessageViewBTN.layer.borderWidth = 1
        self.showMessageViewBTN.layer.borderColor = UIColor.white.cgColor
        self.showMessageViewBTN.layer.masksToBounds = true
        self.showMessageViewBTN.clipsToBounds = true
        self.showMessageViewBTN.backgroundColor = UIColor.darkGray
        
        self.playerStatsView.layer.cornerRadius = 5
        self.playerStatsView.layer.masksToBounds = true
        self.playerStatsView.clipsToBounds = true
        self.playerStatsView.layer.borderWidth = 1
        self.playerStatsView.layer.borderColor = UIColor.darkGray.cgColor
        self.sendMessageBTN.layer.cornerRadius = 20
        
        self.messageTextView.layer.cornerRadius = 5
        UserNameTitleLBL.text = "\(TargetUserName)'s Profile"
        
        self.CreateMessageView.layer.borderWidth = 1
        self.CreateMessageView.layer.borderColor = UIColor.darkGray.cgColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserProfileViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(UserProfileViewController.keyboardWasShown(_:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserProfileViewController.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil);
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email = (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            
            let NowTimeStampTemp1 = Date()
            let NowTimeStamp1 = dateFormatter.string(from: NowTimeStampTemp1)
            
        } else {
            email = ""
            username = ""
        }
        
        segmentControl.items = ["Ally", "Neutral", "Enemy", "Unknown"]
        segmentControl.font = UIFont(name: "Verdana", size: 8)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        
       // segmentControl.thumbColor = UIColor.darkGrayColor()
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        
        //segmentControl.s
        segmentControl.selectedLabelColor = UIColor.black
        segmentControl.unselectedLabelColor = UIColor.white
        
        segmentControl.addTarget(self, action: #selector(UserProfileViewController.segmentValueChanged(_:)), for: .valueChanged)
       
        
        //let GetUserStatus = "enemy"
        if self.TargetUserName == "Unknown" {
            
            playerStatusLBL.text = "Unknown Person"
            playerStatusLBL.textColor = UIColor.white
            //playerStatusLBL.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7)
            playerStatusLBL.backgroundColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 0.7)
            segmentControl.selectedIndex = 3
            segmentControl.thumbColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
        } else {
        
        
        let TempUserStatus = CheckUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName)
        
        switch TempUserStatus {
        case "ally":
            playerStatusLBL.text = "Ally"
            playerStatusLBL.textColor = UIColor.white
            playerStatusLBL.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 0.7)
            segmentControl.selectedIndex = 0
            segmentControl.thumbColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
        case "enemy":
            playerStatusLBL.text = "Enemy"
            playerStatusLBL.textColor = UIColor.white
            playerStatusLBL.backgroundColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 0.7)
            segmentControl.selectedIndex = 2
             segmentControl.thumbColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
        case "unknown":
            playerStatusLBL.text = "Unknown Person"
            playerStatusLBL.textColor = UIColor.white
            //playerStatusLBL.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7)
            playerStatusLBL.backgroundColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 0.7)
            segmentControl.selectedIndex = 3
           // segmentControl.thumbColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 1.0)
            segmentControl.thumbColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
        case "neutral":
            playerStatusLBL.text = "Neutral"
            playerStatusLBL.textColor = UIColor.black
            playerStatusLBL.backgroundColor = UIColor(red: 243/255, green: 241/255, blue: 25/255, alpha: 0.7)
            segmentControl.selectedIndex = 1
            segmentControl.thumbColor = UIColor(red: 243/255, green: 241/255, blue: 25/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
        default:
            playerStatusLBL.text = "Unknown Person"
            playerStatusLBL.textColor = UIColor.white
            //playerStatusLBL.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7)
            playerStatusLBL.backgroundColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 0.7)
            segmentControl.selectedIndex = 3
            segmentControl.thumbColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            //segmentControl.thumbColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
        }
        
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       // if prefs.valueForKey("USERNAME") != nil {
        //    username = prefs.valueForKey("USERNAME") as! NSString as String
       //     email = prefs.valueForKey("EMAIL") as! NSString as String
            
            let NowTimeStampTemp2 = Date()
            let NowTimeStamp2 = dateFormatter.string(from: NowTimeStampTemp2)
            
      //  }
       // let level = "1"
        let level = prefs.value(forKey: "USERXPLEVEL") as! String
        let status = "incomplete"
        
        URLData = GetTargets(self.email, level: level as NSString, status: status as NSString)
        
        
        let IsThisUserTarget = FilterTargetNames(URLData)
        
        
        if IsThisUserTarget {
            targetBTN.setTitle("Remove As Target", for: .normal)
           targetBTN.layer.backgroundColor = UIColor.green.cgColor
           // targetBTN.setTitle("Remove As Target", forState: .normal)
        } else {
            //targetBTN.text = "Target This Player"
             targetBTN.setTitle("Target This Player", for: .normal)
            targetBTN.layer.backgroundColor = UIColor.red.cgColor
           // targetBTN.setTitle("Target This Player", forState: .normal)
        }
        
        print("Is this user a target: \(IsThisUserTarget)")
            
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            print("selected 0")
            
            playerStatusLBL.text = "Ally"
            playerStatusLBL.textColor = UIColor.white
            playerStatusLBL.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 0.7)
            
            segmentControl.selectedIndex = 0
            segmentControl.thumbColor = UIColor(red: 0/255, green: 166/255, blue: 81/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
            segmentControl.setSelectedColors()
            segmentControl.displayNewSelectedIndex()
           // segmentControl
            backgroundThread(background: {
               
                
                DispatchQueue.main.async(execute: {
                    //   print("Creating Local Inventory Data")
                    
                    if self.TargetUserName == "Unknown" {
                        
                    } else {
                    let ChangedAllyStatus = NewUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName, status: "ally", action: "updateStatus")
                    
                    }
                
                })
                
                
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                      print("Done Updating Target's status to Ally")
                    })
                   
            })
            
            
            
            
            DispatchQueue.main.async(execute: {
                //  self.actInd.hidden = true
                //   self.actInd.stopAnimating()
            })
            
        } else if segmentControl.selectedIndex == 1 {
            print("selected 1")
          segmentControl.selectedIndex = 1
            
            
            playerStatusLBL.text = "Neutral"
            playerStatusLBL.textColor = UIColor.black
            playerStatusLBL.backgroundColor = UIColor(red: 243/255, green: 241/255, blue: 25/255, alpha: 0.7)
        //segmentControl.thumbColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 1.0)
            segmentControl.thumbColor = UIColor(red: 243/255, green: 241/255, blue: 25/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
            segmentControl.setSelectedColors()
            segmentControl.displayNewSelectedIndex()
            
            backgroundThread(background: {
                
                
                DispatchQueue.main.async(execute: {
                    //   print("Creating Local Inventory Data")
                    if self.TargetUserName == "Unknown" {
                        
                    } else {
                    let ChangedAllyStatus = NewUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName, status: "neutral", action: "updateStatus")
                    }
                    
                })
                
                
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        print("Done Updating Target's status to neutral")
                    })
                    
            })
            
            
            DispatchQueue.main.async(execute: {
              
            })
            
        } else if segmentControl.selectedIndex == 2 {
            print("selected 2")
            segmentControl.selectedIndex = 2
            
            playerStatusLBL.text = "Enemy"
            playerStatusLBL.textColor = UIColor.white
            playerStatusLBL.backgroundColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 0.7)
            segmentControl.thumbColor = UIColor(red: 255/255, green: 95/255, blue: 92/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
            segmentControl.setSelectedColors()
            segmentControl.displayNewSelectedIndex()
            backgroundThread(background: {
                
                
                DispatchQueue.main.async(execute: {
                    //   print("Creating Local Inventory Data")
               
                    
                    if self.TargetUserName == "Unknown" {
                        
                    } else {
                    let ChangedAllyStatus = NewUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName, status: "enemy", action: "updateStatus")
                    }
                    
                })
                
                
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        print("Done Updating Target's status to enemy")
                    })
                    
            })
            
            
            
            DispatchQueue.main.async(execute: {
                
            })
            
        } else {
            
            segmentControl.selectedIndex = 3
            print("selected 3")
            
            playerStatusLBL.text = "Unknown Person"
            playerStatusLBL.textColor = UIColor.white
            //playerStatusLBL.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.7)
            playerStatusLBL.backgroundColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 0.8)
            
            
           // segmentControl.
            //segmentControl.thumbColor = UIColor(red: 71/255, green: 75/255, blue: 84/255, alpha: 1.0)
            segmentControl.thumbColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            segmentControl.selectedLabelColor = UIColor.black
            segmentControl.unselectedLabelColor = UIColor.white
            
            segmentControl.setSelectedColors()
            segmentControl.displayNewSelectedIndex()
            backgroundThread(background: {
                
                
                DispatchQueue.main.async(execute: {
                    //   print("Creating Local Inventory Data")
                    if self.TargetUserName == "Unknown" {
                        
                    } else {
                    let ChangedAllyStatus = NewUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName, status: "unknown", action: "updateStatus")
                    }
                    
                })
                
                
                }, completion: {
                    
                    DispatchQueue.main.async(execute: {
                        print("Done Updating Target's status to Unknown")
                    })
                    
            })
            
            
            DispatchQueue.main.async(execute: {
                //    self.actInd.hidden = true
                //    self.actInd.stopAnimating()
            })
           
        }
    }
    
    @objc func keyboardWasShown(_ notification: Notification) {
        print("KeyboardShown1")
        //EditingGameTitle = false
        
        sendMessageBTN.isHidden = false
        
        var info = notification.userInfo!
        
        
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            // self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 20
            // self.TableViewTOP.constant = 100
        })
        
        
        print("keyboard was shown")
        // if textView.textColor == UIColor.lightGrayColor() {
        
        if messageTextView.text == "Send a message..." {
            //println("textbox textcolor is light gray")
            messageTextView.text = ""
            messageTextView.textColor = UIColor.black
            messageTextView.textAlignment = .center //.Left
        }
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            // self.doneBTNBOTTOM.constant = -100
            //  self.TableViewTOP.constant = 5
            
        })
        
        sendMessageBTN.isHidden = true
        
        if messageTextView.text.isEmpty {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            messageTextView.text = "Send a message..."
            messageTextView.textColor = UIColor.lightGray
            messageTextView.textAlignment = .center
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SendUserMessage(_ sender: AnyObject) {
        
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            //self.GoldAmountView.transform = CGAffineTransformIdentity
            self.CreateMessageView.center.y = self.CreateMessageView.center.y - 1400
            
            self.CreateMessageViewTOP.constant = 100
        })
        
       // messageTextView.isFirstResponder()
        messageTextView.becomeFirstResponder()
        
        ShowingCreateMessageView = true
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Send User Message"
        alertView.message = "Coming Soon"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        //  alertView.show()
        
    }
    
    
    @IBAction func sendMessage(_ sender: AnyObject) {
        
        let theMessageTemp: NSString = messageTextView.text as NSString
        
        if theMessageTemp.isEqual(to: "") {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Message?"
            alertView.message = "Please enter a message to send"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
              alertView.show()
        } else {
            
            saveComment(theMessageTemp, messageType: "user")
        }
        
    }
    
    func saveComment(_ comment: NSString, messageType: String) {
        
        let ToUser = TargetUserName
        let ToUserID = TargetUserID
        let NowTimeStampTemp = Date()
        let NowTimeStamp = dateFormatter.string(from: NowTimeStampTemp)
        //let NowTimeStamp = dateFormatter.dateFromString(datetimeTemp)
        
        let NoTeamName = ""
        SaveCommentData(NoTeamName as NSString, fromUser: username, fromUserID: email, message: comment, toUser: ToUser as NSString, toUserID: ToUserID as NSString, dateTime: NowTimeStamp, messageType: messageType )
        // SaveCommentData(GameID, username: username, date: timestamp, comment: comment, reply: Reply, replyuser: ReplyUser, userid: userID, replyuserid: ReplyUserID)
        messageTextView.text = "Send a message..."
       // refreshDataTeam()
        view.endEditing(true)
    }

    
    
    @IBAction func AddTargetBTN(_ sender: Any) {
        
        
        
        
       // if !IsTarget {
        
        
        let CurrentNumberTargets = UserDefaults.standard.value(forKey: "CurrentNumberTargets") as! Int
        let CurrentTargetInt = CurrentNumberTargets + 1
        
        
        // let ChangedAllyStatus = NewUserStatus(self.TargetUserID, myUserID: self.email, targetUserName: self.TargetUserName, status: "ally", action: "updateStatus")
       // let emailTemp: NSString = "jaredstevens10@yahoo.com"
        let xpTemp: NSString = "50"
        let actionTemp: NSString = "add"
        let idTemp: NSString = CurrentTargetInt.description as NSString
        let latTemp: NSString = self.TargetLat as NSString
        let longTemp: NSString = self.TargetLong as NSString
        let altTemp: NSString = self.TargetAlt as NSString
        
        let levelTemp: NSString = "1"
        let objectiveTemp: NSString = "add"
        let nameTemp: NSString = self.TargetUserName as NSString
        let targetIDTemp: NSString = self.TargetUserID as NSString
        //let idTemp: NSString = self.TargetUserID as NSString
        
        
      //  print("Adding Target at Lat: \(latTemp) Long: \(longTemp)")
        
        if !IsTarget {
            
            let AddTargetStatus = AddTarget(self.email, username: self.username, id: idTemp, lat: latTemp, long: longTemp, level: levelTemp, status: "incomplete", objective: objectiveTemp, xp: xpTemp, action: actionTemp, name: nameTemp, targetID: targetIDTemp, alt: altTemp)
        
       // print("Add Target Status: \(AddTargetStatus)")
            
            
            if AddTargetStatus {
                  targetBTN.setTitle("Remove As Target", for: .normal)
                targetBTN.layer.backgroundColor = UIColor.green.cgColor
               // targetBTN.setTitle("Remove As Target", forState: .normal)
            }
            
            
        } else {
            
        let deleteTemp: NSString = "delete"
        let deleteID: NSString = "3"
            
            let DeleteTargetStatus = DeleteTarget(self.email, username: self.username, id: deleteID, lat: latTemp, long: longTemp, level: levelTemp, status: "incomplete", objective: objectiveTemp, xp: xpTemp, action: deleteTemp, name: nameTemp, targetID: targetIDTemp)
            
            if DeleteTargetStatus {
                
                //targetBTN.setTitle("Target This Player", forState: .normal)
                  targetBTN.setTitle("Target This Player", for: .normal)
                 targetBTN.layer.backgroundColor = UIColor.red.cgColor
                
            }
                
        print("Delete Target Status: \(DeleteTargetStatus)")
            
            
        }
        
        
        /*
        let alertController = UIAlertController(title: "Target Player", message: "Coming Soon...", preferredStyle: .alert)
        
       // let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
          //  println("you have pressed the Cancel button");
       // }
      //  alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
          //  println("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        
        self.present(alertController, animated: true, completion:nil)
    
 */
        }

        
  //  }
    
    
    
    @IBAction func closeBTn(_ sender: AnyObject) {
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DoNotUpdateMap"), object: nil)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
        
        if ShowingCreateMessageView {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.CreateMessageView.center.y = self.CreateMessageView.center.y + 1420
                
                self.CreateMessageViewTOP.constant = 1500
            })
            
            ShowingCreateMessageView = false
            
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

    func FilterTargetNames(_ urlData: Data) -> Bool {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        var TargetsCount: Int = 0
        
        var IsATarget = Bool()
        
        //var MyWeaponsInventoryArrayTemp = [HitInfo]()
        
        
        
        
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
                
                
                let status = result["status"].stringValue
                let level = result["level"].stringValue
                let objective = result["objective"].stringValue
                let xp = result["xp"].stringValue
                let lastdate = result["datetime"].stringValue
                let targetname = result["targetname"].stringValue
                //let itemID = "NA"
                
                var AddItem = Bool()
                
                let itemImageURL = "" //result["imageURL"].stringValue
                /*
                if self.ShowAllMissions {
                    AddItem = true
                } else {
                    */
                    if status == "incomplete" {
                        
                        if targetname == TargetUserName {
                            print("SHOULD BE A TARGET")
                            IsTarget = true
                            
                            IsATarget = true
                            
                        }
                        //AddItem = true
                        
                    }
                    
                        /*
                    else {
                        
                       // AddItem = false
                        
                    }
                */
                    
               // }
                
             //   if AddItem {
                    
                    //MyWeaponsInventoryArrayTemp.append(HitInfo(id: itemID, level: level, objective: objective, xp: xp, lat: lat!, long: long!, status: status, lastDate: lastdate, targetName: targetname))
                    
              //  }
                
            }
            
        }
        UserDefaults.standard.set(TargetsCount, forKey: "CurrentNumberTargets")
        
        return IsATarget
    }
    
}

func CheckUserStatus(_ targetUserID: String, myUserID: NSString, targetUserName: String) -> NSString {
    
    let action = "check"
    
    let post = "targetuserid=\(targetUserID)&myuserid=\(myUserID)&targetusername=\(targetUserName)&action=\(action)"
    
    var UserAllyStatus = NSString()
    
    UserAllyStatus = "unknown"
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/CheckTargetStatus.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
   //     NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
                UserAllyStatus = (jsonData["UserAllyStatus"] as? NSString)!
                
            } else {
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            
        }
    } else {
        
        
    }
    
    //return urlData
    return UserAllyStatus
}


func NewUserStatus(_ targetUserID: String, myUserID: NSString, targetUserName: String, status: String, action: String) -> Bool {
    
    var UpdateStatus = Bool()

    let post = "targetuserid=\(targetUserID)&myuserid=\(myUserID)&targetusername=\(targetUserName)&status=\(status)&action=\(action)"
    
    var UserAllyStatus = NSString()
    
    UserAllyStatus = "unknown"
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/CheckTargetStatus.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii)!
    
    let postLength:NSString = String( postData.count ) as NSString
    
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = postData
    request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var reponseError: NSError?
    var response: URLResponse?
    
    urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
    
    if ( urlData != nil ) {
        let res = response as! HTTPURLResponse!;
        
     //   NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                UpdateStatus = true
               // UserAllyStatus = (jsonData["UserAllyStatus"] as? NSString)!
                
            } else {
                var error_msg:NSString
                UpdateStatus = false
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
         UpdateStatus = false
        }
    } else {
        
     UpdateStatus = false
    }
    
    //return urlData
    return UpdateStatus
}
