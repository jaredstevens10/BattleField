//
//  CharacterViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, YSSegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var TableViewTOP: NSLayoutConstraint!
    
    @IBOutlet weak var actIndView: UIView!
    @IBOutlet weak var lockedBlurView: UIView!
    
    @IBOutlet weak var lockedBlurViewW: NSLayoutConstraint!
    
    var ShowingCreateMessageView = Bool()
    var pickerItem = false
    
    
    @IBOutlet weak var actIndViewX: NSLayoutConstraint!
    
    @IBOutlet weak var actIndX: NSLayoutConstraint!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var segementIDString = String()
    var groupUnlocked = Bool()
    
    @IBOutlet weak var CreateMessageView: UIView!
    
    @IBOutlet weak var CreateMessageViewTOP: NSLayoutConstraint!
    
    @IBOutlet weak var lockIconRIGHT: NSLayoutConstraint!
    @IBOutlet weak var lockIcon: UIImageView!
    
    let now = CFAbsoluteTimeGetCurrent()
    let dateFormatter = DateFormatter()
    var refreshControl:UIRefreshControl!
    @IBOutlet var commentTXT: UITextView!
    @IBOutlet var submitBTN: UIButton!
    @IBOutlet weak var myTeamLBL: UILabel!
    var MyTeamName = NSString()
    var theComment = NSString()
    var MessageInfoArray = [MessageInfo]()
    var username = NSString()
    var email = NSString()
    @IBOutlet weak var TableView: UITableView!
    
  //  @IBOutlet weak var YSSegmentControl: YSSegmentedControl!
    
    @IBOutlet var segmentControl : ADVSegmentedControl!
    
    let prefs:UserDefaults = UserDefaults.standard
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("messages View did appear")
        
    
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email = (prefs.value(forKey: "EMAIL") as! NSString)
        
            
            let NowTimeStampTemp1 = Date()
            let NowTimeStamp1 = dateFormatter.string(from: NowTimeStampTemp1)
            print("Now Date Time Stamp: \(NowTimeStamp1)")
            
        
       if Reachability.isConnectedToNetwork() {
        
        if prefs.bool(forKey: "PartOfTeam") {
        //if prefs.value(forKey: "MyTeamName") != nil {
            
            
            self.segmentControl.selectedIndex = 1
            self.segmentControl.displayNewSelectedIndex()
            
            
            
            MyTeamName = prefs.value(forKey: "MyTeamName") as! NSString
            print("adding array data")
            let URLData = GetCommentData(MyTeamName, messageType: "team", email: self.email as String)
            MessageInfoArray = FilterCommentData(URLData)
          //  segmentControl.selectedIndex == 0
            
            self.TableView.reloadData()
            self.actIndView.isHidden = true
            
            
            if !self.ShowingCreateMessageView {
                print("Not Showing Message View, should show now")
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    //self.GoldAmountView.transform = CGAffineTransformIdentity
                    self.CreateMessageView.center.y = self.CreateMessageView.center.y + 1000
                    self.CreateMessageViewTOP.constant = 0
                    self.TableViewTOP.constant = 100
                })
                
                self.ShowingCreateMessageView = true
                
            }
            
            self.segementIDString = "team"
            
            //self.actInd.stopAnimating()
        } else {
            self.segementIDString = "user"
            self.segmentControl.selectedIndex = 0
            self.segmentControl.displayNewSelectedIndex()
          //  segmentControl.selectedIndex == 1
            refreshDataUser()
            
            
        }
        
       } else {
        
        
        
        }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString)
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
      //  self.segementIDString = "user"
        
        self.refreshControl = UIRefreshControl()
        
        let device = UIScreen.main.bounds
        let width = device.size.width
        let RevealWidth = width - 60

        self.lockedBlurViewW.constant = (width - 60) / 2
      // self.lockIconRIGHT.constant = width / 5
        
        actIndViewX.constant = RevealWidth / 2
        
        if prefs.bool(forKey: "PartOfTeam") {
            print("Part of a team")
       // if prefs.value(forKey: "MyTeamName") != nil {
            MyTeamName = prefs.value(forKey: "MyTeamName") as! NSString
            segmentControl.selectedIndex == 0
            self.lockedBlurView.isHidden = true
            self.groupUnlocked = true
            
        } else {
             print("Not Part of a team")
            self.lockedBlurView.isHidden = false
            segmentControl.selectedIndex == 1
            refreshDataUser()
        }

        
        myTeamLBL.text = MyTeamName as String
        
        
        self.commentTXT.layer.cornerRadius = 5
        self.commentTXT.layer.masksToBounds = true
        self.commentTXT.clipsToBounds = true
        
        //if commentTXT.text.isEmpty {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            commentTXT.text = "Message to the team..."
            commentTXT.textColor = UIColor.lightGray
            commentTXT.textAlignment = .center
      //  }
        
        
        
       // prefs.setValue("JSCoalition", forKey: "MyTeamName")
        
        
        
        
        
        
        
    //    MessageInfoArray.append(MessageInfo(fromUser: "Jared", message: "This is a test message...", messageTime: "today"))
        
       // YSSegmentControl.delegate = self
       //YSSegmentControl.titles = ["My Team", "Private"]
        
        /*
        let segmented = YSSegmentedControl(
            frame: CGRect(
                x: 0,
                y: 64,
                width: view.frame.size.width,
                height: 44),
            titles: [ "Private",
                "My Team"],
            action: {
                control, index in
                print ("segmented did pressed \(index)")
        })
        
        YSSegmentControl = segmented
        
        YSSegmentControl.delegate = self
        */
        
        segmentControl.items = ["Private", "My Team"]
        segmentControl.font = UIFont(name: "Verdana", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.thumbColor = UIColor.darkGray
        segmentControl.backgroundColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        //UIColor(red: 0.0, green: 0.65098, blue: 0.317647, alpha: 1.0)
        segmentControl.selectedLabelColor = UIColor.white
        segmentControl.addTarget(self, action: #selector(CharacterViewController.segmentValueChanged(_:)), for: .valueChanged)
        
        
       // YSSegmentControl.backgroundColor = UIColor.blackColor()
        //YSSegmentControl.font
        self.submitBTN.layer.cornerRadius = 15
        self.submitBTN.layer.masksToBounds = true
        self.submitBTN.clipsToBounds = true
        
        self.TableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.refreshControl.addTarget(self, action: #selector(CharacterViewController.RefreshCommentData(_:)), for: UIControl.Event.valueChanged)
        self.TableView.addSubview(refreshControl)
        
       
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.TableView.estimatedRowHeight = 80
        self.TableView.rowHeight = UITableView.automaticDimension
        self.TableView.reloadData()

        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CharacterViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(CharacterViewController.keyboardWasShown(_:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(CharacterViewController.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil);
      //  titleLabel.text = prefs.valueForKey("USERNAME") as! NSString as String
        // Do any additional setup after loading the view.
        
        
       

        
        
        
    }
    
    
    @objc func keyboardWasShown(_ notification: Notification) {
        print("KeyboardShown1")
        //EditingGameTitle = false
        
        submitBTN.isHidden = false
        
        var info = notification.userInfo!
        
        
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
           // self.doneBTNBOTTOM.constant = keyboardFrame.size.height + 20
           // self.TableViewTOP.constant = 100
        })
        
        
        print("keyboard was shown")
        // if textView.textColor == UIColor.lightGrayColor() {
        
        if commentTXT.text == "Message to the team..." {
            //println("textbox textcolor is light gray")
            commentTXT.text = ""
            commentTXT.textColor = UIColor.black
            commentTXT.textAlignment = .center //.Left
        }
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
           // self.doneBTNBOTTOM.constant = -100
          //  self.TableViewTOP.constant = 5
            
        })
        
        submitBTN.isHidden = true
        
        if commentTXT.text.isEmpty {
            //if NewGameQuote.isEqualToString("Enter Your Quote Here") {
            //(StartSegment.subviews[0] as! UIView).tintColor = UIColor.greenColor()
            commentTXT.text = "Message to the team..."
            commentTXT.textColor = UIColor.lightGray
            commentTXT.textAlignment = .center
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    @objc func RefreshCommentData(_ sender:AnyObject) {
       
        if self.segementIDString == "team" {
        refreshDataTeam()
        } else {
        refreshDataUser()
        }
        
        print("Refreshing: Segment ID String: \(self.segementIDString)")
        
        
        DispatchQueue.main.async(execute: {
        self.refreshControl.endRefreshing()
        })
    }
    
    func refreshDataTeam() {
        
        MessageInfoArray.removeAll()
        self.actIndView.isHidden = false
       // self.actInd.startAnimating()
       // self.actInd.hidden = false
        
        if Reachability.isConnectedToNetwork() {
            
             if prefs.bool(forKey: "PartOfTeam") {
            //if prefs.value(forKey: "MyTeamName") != nil {
                
                print("adding array data: Team refresh, has team")
                //let URLData = GetCommentData(MyTeamName)
                let URLData = GetCommentData(MyTeamName, messageType: "team", email: self.email as String)
                MessageInfoArray = FilterCommentData(URLData)
                
                
                self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
               // self.actInd.stopAnimating()
                self.actIndView.isHidden = true
                })
               // self.actInd.hidden = false
                
            }
            
        } else {
            
            
            self.segmentControl.selectedIndex = 0
            self.segmentControl.displayNewSelectedIndex()
            
            print("adding array data: User Refresh, no team")
            //let URLData = GetCommentData(MyTeamName)
            let URLData = GetCommentData("", messageType: "user", email: self.email as String)
            MessageInfoArray = FilterCommentData(URLData)
            
            
            self.TableView.reloadData()
            DispatchQueue.main.async(execute: {
                //self.actInd.stopAnimating()
                self.actIndView.isHidden = true
            })
            
        }
        
    }
    
    
    func refreshDataUser() {
        
        MessageInfoArray.removeAll()
        self.actInd.startAnimating()
        self.actIndView.isHidden = false
      //  self.actInd.hidden = false
        
        if Reachability.isConnectedToNetwork() {
             if prefs.bool(forKey: "PartOfTeam") {
            //if prefs.value(forKey: "MyTeamName") != nil {
                
                print("adding array data: User refresh, has team")
                //let URLData = GetCommentData(MyTeamName)
                let URLData = GetCommentData(MyTeamName, messageType: "user", email: self.email as String)
                MessageInfoArray = FilterCommentData(URLData)
                
                
                self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                //self.actInd.stopAnimating()
                self.actIndView.isHidden = true
                })
             } else {
                
                print("adding array data: User Refresh, no team")
                //let URLData = GetCommentData(MyTeamName)
                print("user email: \(email)")
                let URLData = GetCommentData("", messageType: "user", email: self.email as String)
                MessageInfoArray = FilterCommentData(URLData)
                
                
                self.TableView.reloadData()
                DispatchQueue.main.async(execute: {
                    //self.actInd.stopAnimating()
                    self.actIndView.isHidden = true
                })
                
            }
            
        } else {
            
        }
        
    }
    
    
    
    
    
    @IBAction func submitBTN(_ sender: AnyObject) {
        theComment = commentTXT.text as NSString
        
        
        
        if theComment.isEqual(to: "") {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Message?"
            alertView.message = "Please enter a message"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
           // let AC = JSController("No Comment", MyMessage: "Please enter a comment to post",Color: "Red")
          //  self.presentViewController(AC, animated: true, completion: nil)
        } else {
            saveComment(theComment, messageType: "team")
            
        }
        
        /*
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Attack??", message: "Are you sure you want to Attack?", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("UpdateMap", object: nil)
            //Do some stuff
        }
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Attack!", style: .Default) { action -> Void in
            
            self.AttackingPlayer = user
            self.AttackingPlayersHealth = health
            self.AttackStatus = "new"
            
            print("Attacking Player = \(self.AttackingPlayer)")
            
            self.performSegueWithIdentifier("goto_attack", sender: self)
            
            
            
            /*
             let yesSuccess =  Attack(user, self.AttackPower)
             println("Attack Success = \(yesSuccess)")
             
             
             
             if yesSuccess{
             var alertView:UIAlertView = UIAlertView()
             alertView.title = "Attack Success!"
             alertView.message = "Nice Job!"
             alertView.delegate = self
             alertView.addButtonWithTitle("OK")
             alertView.show()
             
             }
             //self.SubmitPic()
             */
            
        }
        
        
        actionSheetController.addAction(nextAction)
        actionSheetController.addAction(cancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        */
    }
    
    func saveComment(_ comment: NSString, messageType: String) {
        
        let ToUser = "NA"
        let ToUserID = "NA"
        let NowTimeStampTemp = Date()
        let NowTimeStamp = dateFormatter.string(from: NowTimeStampTemp)
        //let NowTimeStamp = dateFormatter.dateFromString(datetimeTemp)
        
        
        SaveCommentData(MyTeamName, fromUser: username, fromUserID: email, message: comment, toUser: ToUser as NSString, toUserID: ToUserID as NSString, dateTime: NowTimeStamp, messageType: messageType )
       // SaveCommentData(GameID, username: username, date: timestamp, comment: comment, reply: Reply, replyuser: ReplyUser, userid: userID, replyuserid: ReplyUserID)
        commentTXT.text = ""
        refreshDataTeam()
        view.endEditing(true)
    }
    
    
    func FilterCommentData(_ urlData: Data) -> [MessageInfo] {
        
        //  var traits = [NSString]()
        var messageDataTemp = [MessageInfo]()
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        // println("Json valueJSON: \(json)")
        
        
        
        for result in json["Data"].arrayValue {
            
            
            if ( result["id"] != "NA") {
                
                let idtemp = result["id"].stringValue
                let teamNametemp = result["toTeam"].stringValue
                let ToUserIDTemp = result["toUserID"].stringValue
                let ToUserTemp = result["toUser"].stringValue
                let FromUserIDTemp = result["fromUserID"].stringValue
                let FromUserTemp = result["fromUser"].stringValue
                let commentTemp3 = result["message"].stringValue
                
                let commentTemp2 = Data(base64Encoded: commentTemp3 as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                
                let commentTemp = NSString(data: commentTemp2, encoding: String.Encoding.utf8.rawValue)!
                let messageTimeTemp = result["datetimestamp"].stringValue
                
                
                
                //let dateTemp = result["datestamp"].stringValue
                let datetimeTemp = result["datetimestamp"].stringValue
                print("Date Time Stamp one: \(datetimeTemp)")
                let datetimeTempFormated = dateFormatter.date(from: datetimeTemp)
                print("Date Time Stamp: \(datetimeTempFormated)")
                
                messageDataTemp.append(MessageInfo(fromUser: FromUserTemp, fromUserID: FromUserIDTemp, toUser: ToUserTemp, toUserID: ToUserIDTemp, teamName: teamNametemp, message: commentTemp as String, messageTime: messageTimeTemp, messageID: idtemp, DateTimeStamp: datetimeTempFormated!))
                
                //let Temp = result["username"].stringValue
                //let userTemp = result["username"].stringValue
               
                
                
            }
        }
        
        
        //  }
        //print("Comment Data count = \(messageDataTemp)")
        return messageDataTemp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentedControlWillPressItemAtIndex(_ segmentedControl: YSSegmentedControl, index: Int) {
        print ("[Delegate] segmented will press \(index)")
    }
    
    func segmentedControlDidPressedItemAtIndex(_ segmentedControl: YSSegmentedControl, index: Int) {
        print ("[Delegate] segmented did pressed \(index)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        cell.replyBTN.isHidden = true
        
        var messageData: MessageInfo!
        messageData = MessageInfoArray[indexPath.row]
        cell.userLBLView.layer.cornerRadius = 5
        cell.userLBLView.layer.masksToBounds = true
        cell.userLBLView.clipsToBounds = true
        cell.userLBLView.layer.borderWidth = 1
        cell.userLBLView.layer.borderColor = UIColor.white.cgColor
       // cell.titleLabel.sizeToFit()
        
        cell.messageLBL?.text = messageData.message as String
        cell.messageLBL?.sizeToFit()
        cell.titleLabel?.text = messageData.fromUser as String
        let RightNow = Date()
        let FromTime = RightNow.offsetFrom(messageData.DateTimeStamp)
        cell.dateLabel?.text = "\(FromTime)"
        
        cell.replyBTN.tag = indexPath.row
        cell.replyBTN.addTarget(self, action: #selector(CharacterViewController.ReplyToMessage(_:)), for: UIControl.Event.touchUpInside)
        cell.replyBTN.layer.cornerRadius = 5
        cell.replyBTN.layer.borderWidth = 1
        cell.replyBTN.layer.borderColor = UIColor.white.cgColor
        
        if self.segementIDString == "user" {
            cell.replyBTN.isHidden = false
        } else {
            cell.replyBTN.isHidden = true
        }
        
        return cell
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    @objc func ReplyToMessage(_ sender: AnyObject) {
        
        let tag = sender.tag
        
        
        var messageData: MessageInfo!
        messageData = MessageInfoArray[tag!]
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Reply To Message"
        alertView.message = "....Coming Soon: (From User: \(messageData.fromUser), messageID: \(messageData.messageID) )"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
        
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
           print("User Selected")
            
            if self.ShowingCreateMessageView {
                print("Showing Message View, should hide now")
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    //self.GoldAmountView.transform = CGAffineTransformIdentity
                    self.CreateMessageView.center.y = self.CreateMessageView.center.y - 1000
                    self.CreateMessageViewTOP.constant = -1000
                    self.TableViewTOP.constant = 0
                })
                
                self.ShowingCreateMessageView = false
                
            }
            
            
            
            
            self.segementIDString = "user"
            /*
            self.actInd.hidden = false
            self.actInd.startAnimating()
            self.SegmentValueString = "All"
            self.OnlyInProcess = true
            self.RemoveGameArrayData()
            print("Segment = \(self.SegmentValueString)")
            */
            
            
            refreshDataUser()
            
            
            //  dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
             //   self.refreshMyGames()
            } else {
             //   self.refreshPublicGames()
            }
            // })
            //salesValue.text = "$23,399"
            
            DispatchQueue.main.async(execute: {
              //  self.actInd.hidden = true
             //   self.actInd.stopAnimating()
            })
            
            //filterContentForSearchText("", scope: "All")
            
        //} else {
            
      } else if segmentControl.selectedIndex == 1 {
            
            print("Team Selected")
            
            
          //  self.OnlyInProcess = false
         //   self.actInd.hidden = false
         //   self.actInd.startAnimating()
         //   self.SegmentValueString = "My Turns"
         //   self.RemoveGameArrayData()
        //    print("Segment = \(self.SegmentValueString)")
            
            if !groupUnlocked {
              self.segementIDString = "user"
                segmentControl.selectedIndex == 0
                segmentControl.displayNewSelectedIndex()
               // segmentControl.
                
            } else {
                print("Team is unlocked")
                
                if !self.ShowingCreateMessageView {
                    print("Not Showing Message View, should show now")
                    UIView.animate(withDuration: 0.5, animations: { () -> Void in
                        //self.GoldAmountView.transform = CGAffineTransformIdentity
                        self.CreateMessageView.center.y = self.CreateMessageView.center.y + 1000
                        self.CreateMessageViewTOP.constant = 0
                        self.TableViewTOP.constant = 100
                    })
                    
                    self.ShowingCreateMessageView = true
                    
                }
                
                
                self.segementIDString = "team"
                refreshDataTeam()
                
                
            }
            
            
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
             //   self.refreshMyGames()
            } else {
             //   self.refreshPublicGames()
            }
            //  })
            DispatchQueue.main.async(execute: {
            //    self.actInd.hidden = true
            //    self.actInd.stopAnimating()
            })
            //filterContentForSearchText("", scope: "Complete")
            //salesValue.text = "$81,295"
        } else {
         //   self.OnlyInProcess = false
        //    self.actInd.hidden = false
        //    self.actInd.startAnimating()
            
          //  self.SegmentValueString = "Completed"
          //  self.RemoveGameArrayData()
          //  print("Segment = \(self.SegmentValueString)")
            
            //actInd.hidden = false
            
            
            
            //   dispatch_async(dispatch_get_main_queue(), {
            if !self.pickerItem {
              //  self.refreshMyGames()
            } else {
              //  self.refreshPublicGames()
            }
            
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

struct MessageInfo {
    
    var fromUser: String
    var fromUserID: String
    var toUser: String
    var toUserID: String
    var teamName: String
    var message: String
    var messageTime: String
    var messageID: String
    var DateTimeStamp: Date
    
}

func DeleteCommentData (_ Comment_ID: NSString) -> Data {
    
    
    let post:NSString = "commentid=\(Comment_ID)" as NSString
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/DeleteComment.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
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
        
       // NSLog("Response code: %ld", res?.statusCode);
        
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
    
    return urlData
}

func GetCommentData (_ TeamName: NSString, messageType: String, email: String) -> Data {
    
    var post = NSString()
    
    if messageType == "team" {
    post = "teamName=\(TeamName)" as NSString
    } else {
    post = "email=\(email)" as NSString
    }
    
    
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GetComments.php")!
    
    let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
    
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
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
        if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
        {
            let responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
            
            NSLog("Get User Comment Data Response ==> %@", responseData);
            
            var error: NSError?
            
            let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
            
            
            let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
                NSLog("Login SUCCESS");
                
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
    
    return urlData
}

func SaveCommentData (_ toTeam: NSString, fromUser: NSString, fromUserID: NSString, message: NSString, toUser: NSString, toUserID: NSString, dateTime: String, messageType: String) -> Bool {
    
    
    var MessageSaved = Bool()
    
    let post_old:NSString = "toTeam=\(toTeam)&fromUser=\(fromUser)&fromUserID=\(fromUserID)&message=\(message)&toUser=\(toUser)&toUserID=\(toUserID)&dateTime=\(dateTime)&messageType=\(messageType)" as NSString
    
    let post = post_old.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
    
    var urlData = Data()
    
    //&password=\(password)"
    
    NSLog("PostData: %@",post);
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/AddComments.php")!
    
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
        
      //  NSLog("Response code: %ld", res?.statusCode);
        
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
               // NSLog("Login SUCCESS");
                MessageSaved = true
                
            } else {
                
                MessageSaved = false
                var error_msg:NSString
                
                if jsonData["error_message"] as? NSString != nil {
                    error_msg = jsonData["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                
                
            }
            
        } else {
            MessageSaved = false
        }
    } else {
        
        MessageSaved = false
    }
    
    return MessageSaved // urlData
}

extension Date {
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        
        if hoursFrom(date)   > 0 {
            print("Hours From Date: \(hoursFrom(date).description)")
            print("Minutes From Date: \(minutesFrom(date).description)")
            print("Seconds From Date: \(secondsFrom(date).description)")
            return "\(hoursFrom(date))h"
        }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}
