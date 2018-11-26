//
//  AllianceViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import CoreLocation

class AllianceViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var TableHeaderMessage: UILabel!
    
    @IBOutlet weak var CreateJoinMessageLBL: UILabel!
    var TeamAction = String()
    @IBOutlet weak var blurView: UIView!
    var MyTeamName = String()
    var ShowingTable = Bool()
    
    @IBOutlet weak var hideTableBTN: UIButton!
    
    var TeamInfoArray = [TeamInfo]()
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var TableViewHolder: UIView!
    
    @IBOutlet weak var TableViewHolderTOP: NSLayoutConstraint!
    @IBOutlet weak var TableViewHolderBOTTOM: NSLayoutConstraint!
    
    var ShowingCreateMessageView = Bool()
    @IBOutlet weak var CreateMessageView: UIView!
    @IBOutlet weak var CreateMessageViewTOP: NSLayoutConstraint!
    @IBOutlet weak var commentTXT: UITextField!
    
    var username = NSString()
    var email = NSString()
    var mylat = Double()
    var mylong = Double()
    var myalt = Double()
    
    @IBOutlet weak var submitTeamBTN: UIButton!
    
    @IBOutlet weak var JoinView: UIView!
    
    @IBOutlet weak var joinTeamView: UIView!
    @IBOutlet weak var createTeamView: UIView!
    
    @IBOutlet weak var joinTeamViewLEAD: NSLayoutConstraint!
    @IBOutlet weak var createTeamViewLEAD: NSLayoutConstraint!
    var memberOfTeam = Bool()
    
    let prefs:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var myteamMG: UIImageView!
    
    @IBOutlet weak var rightmenuButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var membersView: UIView!
    @IBOutlet weak var assetsView: UIView!
    @IBOutlet weak var missionsView: UIView!
    
    @IBOutlet weak var manageView: UIView!
    
    
    @IBOutlet weak var missionsViewLEAD: NSLayoutConstraint!
    @IBOutlet weak var assetsViewLEAD: NSLayoutConstraint!
    @IBOutlet weak var membersViewTRAIL: NSLayoutConstraint!
    
    @IBOutlet weak var manageTeamViewTOP: NSLayoutConstraint!
    
     @IBOutlet weak var manageTeamViewBOTTOM: NSLayoutConstraint!
    
    @IBOutlet weak var joinTeamViewTOP: NSLayoutConstraint!
    
     @IBOutlet weak var joinTeamViewBOTTOM: NSLayoutConstraint!
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        
        TableView.delegate = self
        TableView.dataSource = self
        TableViewHolder.isHidden = true
        
        blurView.isHidden = true
        submitTeamBTN.layer.cornerRadius = 25
        submitTeamBTN.clipsToBounds = true
        submitTeamBTN.layer.masksToBounds = true
        
        super.viewDidLoad()
        
        /*
        if prefs.value(forKey: "MyTeamName") != nil {
            memberOfTeam = true
        }
        */
        
        memberOfTeam = prefs.bool(forKey: "PartOfTeam")
        
        if memberOfTeam {
            MyTeamName = prefs.value(forKey: "MyTeamName") as! String
        }
        
        myteamMG.contentMode = UIViewContentMode.scaleAspectFit
        UITabBar.appearance().backgroundColor = UIColor(red: 249.0, green: 148.0, blue: 148.0, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        //navigationController!.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)

        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Verdana", size: 25)!, NSForegroundColorAttributeName: UIColor(red: 0.7, green: 0.1, blue: 0.1, alpha: 1.0)]       // navigationController!.navigationItem.ba

        
      //  self.revealViewController().rearViewRevealWidth = 200
        
        let device = UIScreen.main.bounds
        
        let deviceH = device.size.height
        let deviceW = device.size.width
        
        let RevealWidth = deviceW - 50
        
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            rightmenuButton.target = self.revealViewController()
            rightmenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 130
             self.revealViewController().rearViewRevealWidth = RevealWidth
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        missionsView.layer.cornerRadius = 80
        missionsView.layer.borderColor = UIColor.darkGray.cgColor
        missionsView.layer.borderWidth = 2
        missionsView.layer.masksToBounds = true
        missionsView.clipsToBounds = true
        
        assetsView.layer.cornerRadius = 80
        assetsView.layer.borderColor = UIColor.darkGray.cgColor
        assetsView.layer.borderWidth = 2
        assetsView.layer.masksToBounds = true
        assetsView.clipsToBounds = true

        
        membersView.layer.cornerRadius = 80
        membersView.layer.borderColor = UIColor.darkGray.cgColor
        membersView.layer.borderWidth = 2
        membersView.layer.masksToBounds = true
        membersView.clipsToBounds = true
        
        createTeamView.layer.cornerRadius = 80
        createTeamView.layer.borderColor = UIColor.darkGray.cgColor
        createTeamView.layer.borderWidth = 2
        createTeamView.layer.masksToBounds = true
        createTeamView.clipsToBounds = true
        
        
        joinTeamView.layer.cornerRadius = 80
        joinTeamView.layer.borderColor = UIColor.darkGray.cgColor
        joinTeamView.layer.borderWidth = 2
        joinTeamView.layer.masksToBounds = true
        joinTeamView.clipsToBounds = true
        
        
        let seconds = 2.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
      // let secondsLoad = 2.0
      //  let delayLoad = secondsLoad * Double(NSEC_PER_SEC)  // nanoseconds per seconds
      //  let dispatchTimeLoad = DispatchTime.now() + Double(Int64(delayLoad)) / Double(NSEC_PER_SEC)
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
          //  self.performSegue(withIdentifier: "AttackPlayer", sender: self)
            
        })

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CharacterViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)

        
        if prefs.value(forKey: "USERNAME") != nil {
            username = prefs.value(forKey: "USERNAME") as! NSString
            email = prefs.value(forKey: "EMAIL") as!  NSString
        } else {
            username = "guest"
            email = "guest"
        }
        
        self.TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        var curLocTemp = CLLocation()
        var curLocManagerTemp = CLLocationManager()
        curLocTemp = curLocManagerTemp.location!
        mylat = curLocTemp.coordinate.latitude
        mylong = curLocTemp.coordinate.longitude
        myalt = curLocTemp.altitude
        //var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.assetsViewLEAD.constant = -500
        self.missionsViewLEAD.constant = -500
        self.membersViewTRAIL.constant = -500
        self.joinTeamViewLEAD.constant = -500
        
        self.joinTeamViewTOP.constant = -1000
        self.joinTeamViewBOTTOM.constant = 1000
        
        
        self.createTeamViewLEAD.constant = -500
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let value = UIInterfaceOrientation.portrait.rawValue // .LandscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        
        if memberOfTeam {
            
        self.JoinView.isHidden = true
        self.joinTeamViewTOP.constant = -1000
        self.joinTeamViewBOTTOM.constant = 1000
       // self.joinTeamViewTOP.constant = -1000
       // self.joinTeamViewBOTTOM.constant = 1000
        
        let device = UIScreen.main.bounds
        
        let deviceH = device.size.height
        let deviceW = device.size.width
        
        let middleMissions = (deviceW / 2) - 80
        
      
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            //print("view 5 y off = \(self.view5.center.y)")
            
            self.assetsView.center.x = self.assetsView.center.x + 607
            self.assetsViewLEAD.constant = 5
            
        })
        
        
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            
            //print("view 5 y off = \(self.view5.center.y)")
            
            self.membersView.center.x = self.membersView.center.x - 607
            self.membersViewTRAIL.constant = 5
            
        })
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            
            //print("view 5 y off = \(self.view5.center.y)")
            
            self.missionsView.center.x = self.missionsView.center.x + 607
            self.missionsViewLEAD.constant = middleMissions
            
        })
        
        } else {
            
            
            manageView.isHidden = true
            self.manageTeamViewTOP.constant = -1000
            self.manageTeamViewBOTTOM.constant = 1000
            
            let device = UIScreen.main.bounds
            
            let deviceH = device.size.height
            let deviceW = device.size.width
            
            let middleMissions = (deviceW / 2) - 80
            
            self.joinTeamViewTOP.constant = 0
            self.joinTeamViewBOTTOM.constant = 0
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.joinTeamView.center.x = self.joinTeamView.center.x + 607
                self.joinTeamViewLEAD.constant = middleMissions - 25
                
            })
            
            
            UIView.animate(withDuration: 0.7, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.createTeamView.center.x = self.createTeamView.center.x + 607
                self.createTeamViewLEAD.constant = middleMissions + 25
                
            })
            
          

        }
        
        //RefreshTableTeams()()
    }
    
    func TeamSelected(_ sender: AnyObject) {
        
        let row = sender.tag
       // var TargetPicked: TeamMembersInfo
        
        var TeamSelected: TeamInfo
        
        TeamSelected = TeamInfoArray[row!]
        
        var  TeamMembersInfoTemp = TeamSelected.members
        
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            var view = TeamInfoView.instanceFromNib(TeamSelected)
            view.tag = 1000
            self.view.addSubview(view)
        })
        
    }
    
    /*
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        
        var TeamSelected: TeamInfo
        
        TeamSelected = TeamInfoArray[indexPath.row]
        
        var  TeamMembersInfoTemp = TeamSelected.members
        
        
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            var view = TeamInfoView.instanceFromNib(TeamSelected)
            view.tag = 1000
            self.view.addSubview(view)
        })
        
        
       // var segmentIndex = sender.selectedIndex
        
       // self.performSegueWithIdentifier("yourIdentifier", sender: self)
    }
    
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TeamInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! ItemsCell
        
        
        var teamSelected: TeamInfo
        let row = indexPath.row
        
        teamSelected = TeamInfoArray[row]
        
        cell.titleLabel.text = teamSelected.teamname
        
        cell.itemInfoBTN.tag = indexPath.row
        
        cell.itemInfoBTN.addTarget(self, action: #selector(AllianceViewController.TeamSelected(_:)), for: UIControlEvents.touchUpInside)
        cell.distanceLBL.text = "mi: \(teamSelected.milesaway.description)"
        
        
        /*
        //let selectedResult = indexPath.item
        
        
        itemSelected = MissionInfoArray[row]
        
        cell.subtitleLabel.text = itemSelected.teamTitle
        
        cell.mapBTN.tag = indexPath.row
        
        cell.mapBTN.addTarget(self, action: #selector(TeamMembersViewController.TargetSelected(_:)), for: UIControlEvents.touchUpInside)
        
        
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
        */
        
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CreateNewTeamBTN(_ sender: Any) {
        
        self.CreateJoinMessageLBL.text = "Create A Team"
        self.TeamAction = "CreateTeam"
        self.submitTeamBTN.setTitle("Create", for: .normal)
        self.blurView.isHidden = false
        self.blurView.alpha = 0.0
        if !self.ShowingCreateMessageView {
            print("Not Showing Message View, should show now")
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.CreateMessageView.center.y = self.CreateMessageView.center.y + 1000
                self.CreateMessageViewTOP.constant = 0
                self.blurView.alpha = 0.5
               // self.TableViewTOP.constant = 100
            })
            
            self.ShowingCreateMessageView = true
            self.commentTXT.becomeFirstResponder()
        }
        
       
    }
    @IBAction func JoinTeamBTN(_ sender: Any) {
        
        self.CreateJoinMessageLBL.text = "Team Search"
        self.TeamAction = "JoinTeam"
        self.submitTeamBTN.setTitle("Search", for: .normal)
        self.blurView.isHidden = false
        self.blurView.alpha = 0.0
        
        
        if !self.ShowingCreateMessageView {
            print("Not Showing Message View, should show now")
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.CreateMessageView.center.y = self.CreateMessageView.center.y + 1000
                self.CreateMessageViewTOP.constant = 0
                self.blurView.alpha = 0.5
                self.TableViewHolder.isHidden = false
                self.RefreshTableTeams()
               
               // self.hideTableBTN.setImage(UIImage(named: "whiteArrowDown"), forState: UIControlState.normal)
                // self.TableViewTOP.constant = 100
            })
            
            self.TableViewHolder.isHidden = false
            
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.TableViewHolder.center.y = self.assetsView.center.y - 1000
                self.TableViewHolderTOP.constant = 0
                self.TableViewHolderBOTTOM.constant = 0
                
                if self.ShowingTable {
                    
                } else {
                   // self.hideTableBTN.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }
                 self.ShowingTable = true
            })
            
            
            
            
            
            
            
            self.ShowingCreateMessageView = true
            //self.commentTXT.becomeFirstResponder()
        }
        
    }
    
    func RefreshTableTeams() {
        
        let level = prefs.value(forKey: "USERLEVEL") as! String
        let status = "incomplete"
        
        let lat: Double = mylat
        let long: Double = mylong
        let alt: Double = myalt
        
//        let lat: Double = 28.0
//        let long: Double = -81.0
//        let alt: Double = 0.0
        let radius: Int = 1000
        
        
        
        let URLData = GetNearbyTeams(self.username, latitude: lat, longitude: long, radius: radius, altitude: alt)
        //GetTargets(self.email, level: level as NSString, status: status as NSString)
        
        
        TeamInfoArray = FilterTeamItems(URLData)
        
        self.TableView.reloadData()
        
    }
   
    
    func DismissKeyboard(){
        
        /*
        self.blurView.alpha = 0.5
        if self.ShowingCreateMessageView {
            print("Not Showing Message View, should show now")
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.CreateMessageView.center.y = self.CreateMessageView.center.y - 1000
                self.CreateMessageViewTOP.constant = -1000
                self.blurView.alpha = 0.0
                // self.TableViewTOP.constant = 100
            })
            
            self.ShowingCreateMessageView = false
            
            if ShowingTable {
                
                self.ShowingTable = false
               // self.hideTableBTN.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                //   self.hideTableBTN.setImage(UIImage(named: "whiteArrowDown"), forState: UIControlState.normal)
                
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    //print("view 5 y off = \(self.view5.center.y)")
                    
                    self.TableViewHolder.center.y = self.assetsView.center.y + 1000
                    self.TableViewHolderTOP.constant = 1000
                    self.TableViewHolderBOTTOM.constant = -1000
                })
                
                
                
                self.TableViewHolder.isHidden = true
            }
            
        }
        
        self.blurView.isHidden = true
 */
        
        view.endEditing(true)
    }
    
    
    
    @IBAction func submitBTN(_ sender: AnyObject) {
        let theCommentTemp = commentTXT.text
        
        let theComment: NSString = theCommentTemp as! NSString
        
        
        
        if theComment.isEqual(to: "") {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Team Name?"
            alertView.message = "Please enter a team name"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
            // let AC = JSController("No Comment", MyMessage: "Please enter a comment to post",Color: "Red")
            //  self.presentViewController(AC, animated: true, completion: nil)
        } else {
            
                
                switch self.TeamAction {
                    case "CreateTeam":
                        
                        if prefs.value(forKey: "HomeLat") != nil {
                            let myLatHQTemp = prefs.value(forKey: "HomeLat") as! Double
                            let myLongHQTemp = prefs.value(forKey: "HomeLong") as! Double
                            let myAltHQTemp = prefs.value(forKey: "HomeAlt") as! Double
                            
                            let myLatHQ = myLatHQTemp.description as! NSString
                            let myLongHQ = myLongHQTemp.description as! NSString
                            let myAltHQ = myAltHQTemp.description as! NSString
                            
                            saveTeamName(theComment, teamLat: myLatHQ, teamLong: myLongHQ, myLat: myLatHQ, myLong: myLongHQ, myAlt: myAltHQ)
                            
                        } else {
                            
                            let actionSheetController: UIAlertController = UIAlertController(title: "Your HQ?", message: "In order to create a team you first need to establish your own HQ", preferredStyle: .alert)
                            
                            //Create and add the Cancel action
                            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                                
                            }
                            
                            actionSheetController.addAction(cancelAction)
                            
                            self.present(actionSheetController, animated: true, completion: nil)
                            
                    }
                    
                    case "JoinTeam":
                    print("Join Team")
                    
                    if prefs.value(forKey: "HomeLat") != nil {
                        let myLatHQTemp = prefs.value(forKey: "HomeLat") as! Double
                        let myLongHQTemp = prefs.value(forKey: "HomeLong") as! Double
                        let myAltHQTemp = prefs.value(forKey: "HomeAlt") as! Double
                        
                        let myLatHQ = myLatHQTemp.description as! NSString
                        let myLongHQ = myLongHQTemp.description as! NSString
                        let myAltHQ = myAltHQTemp.description as! NSString
                        
                       // saveTeamName(theComment, teamLat: myLatHQ, teamLong: myLongHQ, myLat: myLatHQ, myLong: myLongHQ)
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Coming Soon"
                        alertView.message = "In Development..."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        
                    } else {
                        
                        let actionSheetController: UIAlertController = UIAlertController(title: "Your HQ?", message: "In order to join a team you first need to establish your own HQ", preferredStyle: .alert)
                        
                        //Create and add the Cancel action
                        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                            
                        }
                        
                        actionSheetController.addAction(cancelAction)
                        
                        self.present(actionSheetController, animated: true, completion: nil)
                        
                    }
                    
                default:
                    break
                }
               
            
            
        }
        
        
    }
    
    func saveTeamName(_ teamName: NSString, teamLat: NSString, teamLong: NSString, myLat: NSString, myLong: NSString, myAlt: NSString) {
        
        let ToUser = "NA"
        let ToUserID = "NA"
        let NowTimeStampTemp = Date()
       // let NowTimeStamp = dateFormatter.string(from: NowTimeStampTemp)
        //let NowTimeStamp = dateFormatter.dateFromString(datetimeTemp)
        
        let TeamNameAvailable = CheckTeamName(self.email as String, teamName: teamName as String)
        
        if TeamNameAvailable {
        
            let TeamCreated = CreateNewTeam(username, email: self.email, teamName: teamName, teamlat: teamLat, teamlong: teamLong, mylat: myLat, mylong: myLong, myalt: myAlt)
            
            if TeamCreated {
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Success", message: "Your team \(teamName) has been created.", preferredStyle: .alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                    
                }
                
                actionSheetController.addAction(cancelAction)
                
                self.present(actionSheetController, animated: true, completion: nil)
                
            } else {
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Error", message: "There was an error creating your team, please try again.", preferredStyle: .alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                    
                }
                
                actionSheetController.addAction(cancelAction)
                
                self.present(actionSheetController, animated: true, completion: nil)
                
            }
        
       // SaveCommentData(MyTeamName, fromUser: username, fromUserID: email, message: comment, toUser: ToUser as NSString, toUserID: ToUserID as NSString, dateTime: NowTimeStamp, messageType: messageType )
        // SaveCommentData(GameID, username: username, date: timestamp, comment: comment, reply: Reply, replyuser: ReplyUser, userid: userID, replyuserid: ReplyUserID)
        commentTXT.text = ""
       // refreshDataTeam()
        view.endEditing(true)
            
        } else {
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Team Name", message: "This Team name is already in use, select another team name.", preferredStyle: .alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
                
            }
            
            actionSheetController.addAction(cancelAction)
            
            self.present(actionSheetController, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    @IBAction func TeamMembersBTN(_ sender: Any) {
    
        self.performSegue(withIdentifier: "TeamMembers", sender: self)
    
    }
    
    @IBAction func QuiteTeam(_ sender: Any) {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Leave Team", message: "Are you sure you want to quit your team", preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            self.prefs.set(false, forKey: "PartOfTeam")
            
            self.JoinView.isHidden = false
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.manageView.center.x = self.manageView.center.x - 1000
                self.manageTeamViewTOP.constant = -1064
                self.manageTeamViewBOTTOM.constant = 1064
                
            })
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.JoinView.center.x = self.JoinView.center.x + 1000
                self.joinTeamViewTOP.constant = 0
                self.joinTeamViewBOTTOM.constant = 0
                
            })
            
            
           self.manageView.isHidden = true
            
        }
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            
            
        }
        actionSheetController.addAction(yesAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    
    func FilterTeamItems(_ urlData: Data) -> [TeamInfo] {
        
        // print("Item Inventory before filter: \(ItemsInventoryArray)")
        
        var TargetsCount: Int = 0
        
        var MyWeaponsInventoryArrayTemp = [TeamInfo]()
        
        
        
        let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
        
        var json = JSON(jsonData)
        
        //println("Json value: \(jsonData)")
        print("Teams Json valueJSON: \(json)")
        
        var membersArray = [String]()
        
        var missionsArray = [String]()
        var adminsArray = [String]()
        
        for result in json["Data"].arrayValue {
            
            if ( result["id"] != "NA") {
                TargetsCount += 1
                let itemID = result["id"].stringValue
                // print("ITEM NAME = \(itemName)")
                let latTemp = result["latitude"].stringValue
                let lat = Double(latTemp)
                
                let longTemp = result["longitude"].stringValue
                let long = Double(longTemp)
                
                
                let teamnametemp = result["teamname"].stringValue
                let level = result["level"].stringValue
                let health = result["health"].stringValue
                
                //let itemID = "NA"
               // for result in json["Data"].arrayValue {
                
                
                for members in result["members"].arrayValue {
                    
                    
                    if ( members["id"] != "NA") {
                        
                        let memberName = members["name"].stringValue
                        membersArray.append(memberName)
                    }
                }
                
                for missions in result["missions"].arrayValue {
                    if ( missions["id"] != "NA") {
                        
                        let missionName = missions["name"].stringValue
                        missionsArray.append(missionName)
                    }
                }
                
                
                for admin in result["admins"].arrayValue {
                    if ( admin["id"] != "NA") {
                        
                        let adminName = admin["name"].stringValue
                        adminsArray.append(adminName)
                    }
                }
                
                print("***MEMBERS***: \(membersArray)")
               
                
                let membercount = Int()
                
                var AddItem = Bool()
                
                let itemImageURL = "" //result["imageURL"].stringValue
                
                AddItem = true
                /*
                if self.ShowAllMissions {
                    AddItem = true
                } else {
                    if status == "incomplete" {
                        AddItem = true
                    } else {
                        AddItem = false
                    }
                    
                }
                */
                
                
                
                var curLoc = CLLocation()
                var curLocManager = CLLocationManager()
                curLoc = curLocManager.location!
                
                var mylocnow = CLLocation(latitude: curLoc.coordinate.latitude, longitude: curLoc.coordinate.longitude)
                
                var itemLocation = CLLocation(latitude: lat!,longitude: long!)
                var dist = Double()
                var distance = mylocnow.distance(from: itemLocation)
                print("distance: \(distance)")
                var miles = distance / 1609.34
                print("miles: \(miles)")
                
                dist = Double(round(1000*miles)/1000)
                /*
                if (miles < 1) {
                    dist = Double(round(1000*(miles * 5280))/1000)
                    
                    print("Dist = \(dist)")
                    if (dist < 1) {
                        // distanceLBL.text = ("Distance: \(dist.description) Foot")
                        print("foot: \(distance)")
                       // CanPickUp = true
                    } else {
                        //distanceLBL.text = ("Distance: \(dist.description) Feet")
                        if (dist < 100) {
                          //  CanPickUp = true                }
                    }
                    
                } else {
                    dist = Double(round(1000*miles)/1000)
                    // distanceLBL.text = ("Distance: \(dist.description) Miles")
                }
                    */
                
                
                
                
                
                if AddItem {
                    
                    MyWeaponsInventoryArrayTemp.append(TeamInfo(id: itemID, level: level, teamname: teamnametemp, lat: lat!, long: long!, health: health, members: membersArray, missions: missionsArray, admins: adminsArray, membercount: membercount, milesaway: dist))
                    
                }
                
            }
            
        }
        
        //UserDefaults.standard.set(TargetsCount, forKey: "CurrentNumberTargets")
        
        return MyWeaponsInventoryArrayTemp
    }
    
    
    @IBAction func HideShowTableBTN(_ sender: Any) {
        
        self.blurView.alpha = 0.5
        if self.ShowingCreateMessageView {
            print("Not Showing Message View, should show now")
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                //self.GoldAmountView.transform = CGAffineTransformIdentity
                self.CreateMessageView.center.y = self.CreateMessageView.center.y - 1000
                self.CreateMessageViewTOP.constant = -1000
                self.blurView.alpha = 0.0
                // self.TableViewTOP.constant = 100
            })
            
            self.ShowingCreateMessageView = false
            
            if ShowingTable {
                
                self.ShowingTable = false
              //  self.hideTableBTN.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                //   self.hideTableBTN.setImage(UIImage(named: "whiteArrowDown"), forState: UIControlState.normal)
                
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    //print("view 5 y off = \(self.view5.center.y)")
                    
                    self.TableViewHolder.center.y = self.assetsView.center.y + 1000
                    self.TableViewHolderTOP.constant = 1000
                    self.TableViewHolderBOTTOM.constant = -1000
                })
                
                
                
                self.TableViewHolder.isHidden = true
            }
            
        }
        self.blurView.isHidden = true
        /*
        
        if ShowingTable {
            
            self.ShowingTable = false
            self.hideTableBTN.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
         //   self.hideTableBTN.setImage(UIImage(named: "whiteArrowDown"), forState: UIControlState.normal)
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.TableViewHolder.center.y = self.assetsView.center.y + 1000
                self.TableViewHolderTOP.constant = 1000
                self.TableViewHolderBOTTOM.constant = -1000
            })
            
            
            
            self.TableViewHolder.isHidden = true
        } else {
            self.TableViewHolder.isHidden = false
            
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //print("view 5 y off = \(self.view5.center.y)")
                
                self.TableViewHolder.center.y = self.assetsView.center.y - 1000
                self.TableViewHolderTOP.constant = 0
                self.TableViewHolderBOTTOM.constant = 0
            })
            
            
            self.ShowingTable = true
            self.hideTableBTN.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
       //     self.hideTableBTN.setImage(UIImage(named: "whiteArrowDown"), forState: UIControlState.normal)
            
            
            
            
            
            
        }
        */
        
        view.endEditing(true)
 
    }
    

}

struct TeamInfo {
    
    var id: String
    var level: String
    var teamname: String
    var lat: Double
    var long: Double
    var health: String
    var members: [String]
    var missions: [String]
    var admins: [String]
    var membercount: Int
    var milesaway: Double
    
}
