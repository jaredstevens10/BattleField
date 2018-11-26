//
//  PlayerSubViews.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/17/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import Foundation


class AttributesItemCell: UITableViewCell {
    
    
    @IBOutlet weak var attributeImage: UIImageView!
    
    
    @IBOutlet weak var skillsDescriptionLBL: UILabel!
    @IBOutlet weak var skillsLevelLBL: UILabel!
    
    @IBOutlet weak var ViewHolder: UIView!
    @IBOutlet weak var skillsViewHolder: UIView!
    
    @IBOutlet weak var progressHolderView: UIView!
    @IBOutlet weak var skillsprogressHolderView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skillsprogressView: UIProgressView!
    
    @IBOutlet weak var skillsAmountLBL: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    @IBOutlet weak var skillsamountLBL: UILabel!
    
    @IBOutlet weak var itemStepper: UIStepper!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var skillsTitle: UILabel!
    //@IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var findItemBTN: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SkillsItemCell: UITableViewCell {
    
    @IBOutlet weak var lockedView: UIView!
    @IBOutlet weak var skillsDescriptionLBL: UILabel!
    @IBOutlet weak var skillsLevelLBL: UILabel!
    
    @IBOutlet weak var ViewHolder: UIView!
    @IBOutlet weak var skillsViewHolder: UIView!
    
    @IBOutlet weak var progressHolderView: UIView!
    @IBOutlet weak var skillsprogressHolderView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var skillsprogressView: UIProgressView!
    
    @IBOutlet weak var skillsAmountLBL: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    @IBOutlet weak var skillsamountLBL: UILabel!
    
    @IBOutlet weak var itemStepper: UIStepper!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var skillsTitle: UILabel!
    //@IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var findItemBTN: UIButton!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class AttributesView: UIView, UITableViewDelegate,  UITableViewDataSource {
    
    var attributesChanged = Bool()
    
    
    var MyTotalPlayerAttributes: TotalPlayerAttributes!
    
    var Awareness = Double()
    var Charisma = Double()
    var Credibility = Double()
    var Intelligence = Double()
    var Endurance = Double()
    var Speed = Double()
    var Strength = Double()
    var Vision = Double()
    
    var NewAwareness = Double()
    var NewCharisma = Double()
    var NewCredibility = Double()
    var NewIntelligence = Double()
    var NewEndurance = Double()
    var NewSpeed = Double()
    var NewStrength = Double()
    var NewVision = Double()
    
    var TempAwareness = Double()
    var TempCharisma = Double()
    var TempCredibility = Double()
    var TempIntelligence = Double()
    var TempEndurance = Double()
    var TempSpeed = Double()
    var TempStrength = Double()
    var TempVision = Double()
    
    var AttributeMinimum: Double = 0
    
    
    var AttributesArray = [PlayerAttributes]()
    
    @IBOutlet weak var hideBTN: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    var prefs:UserDefaults = UserDefaults.standard
    var username = NSString()
    var email = NSString()
    
    var title = String()
    
     @IBOutlet weak var TableViewHolder: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    @IBOutlet weak var availablePointsView: UIView!
    @IBOutlet weak var levelView: UIView!
    
//    @IBOutlet weak var view1: UIView!
//    @IBOutlet weak var label1: UILabel!
//    @IBOutlet weak var progress1: UIProgressView!
//    @IBOutlet weak var stepper1: UIStepper!
//    
//    @IBOutlet weak var view2: UIView!
//    @IBOutlet weak var label2: UILabel!
//    @IBOutlet weak var progress2: UIProgressView!
//    @IBOutlet weak var stepper2: UIStepper!
//    
//    @IBOutlet weak var view3: UIView!
//    @IBOutlet weak var label3: UILabel!
//    @IBOutlet weak var progress3: UIProgressView!
//    @IBOutlet weak var stepper3: UIStepper!
//    
//    @IBOutlet weak var view4: UIView!
//    @IBOutlet weak var label4: UILabel!
//    @IBOutlet weak var progress4: UIProgressView!
//    @IBOutlet weak var stepper4: UIStepper!
    
    var stepper1Progress = Double()
    var stepper2Progress = Double()
    var stepper3Progress = Double()
    var stepper4Progress = Double()
    
    var AvailablePoints = Double()
    
    var sender1Temp = Double()
    var sender2Temp = Double()
    var sender3Temp = Double()
    var sender4Temp = Double()
    
    var StartingPoints: Double!
    let MaxPoints: Double = 40
    
    var isLoggedIn = Int()
    
    @IBOutlet weak var availablePointsLBL: UILabel!
   // @IBOutlet weak var AdjustRatingsView: UIView!
    
    var NewPoints = Double()
    
    
    var titleText: String! {
        didSet {
            //  titleLBL.text = titleText
        }
        
    }
    

    override func awakeFromNib() {
        

        
        /*
         BGView.layer.cornerRadius = 10
         BGView.clipsToBounds = true
         BGView.layer.masksToBounds = true
         BGView.layer.borderWidth = 1
         BGView.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
         */
        
        
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString)
            StartingPoints = prefs.double(forKey: "MyAttributePoints")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
            
            if prefs.bool(forKey: "MyAttributePointsSet") {
                StartingPoints = prefs.double(forKey: "MyAttributePoints")
            } else {
            StartingPoints = 10.0
        }
        }
            
        
        

        // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        TableViewHolder.layer.borderWidth = 1
        TableViewHolder.layer.borderColor = UIColor.white.cgColor
        //TableViewHolder.layer.cornerRadius = 5
        TableViewHolder.layer.masksToBounds = true
        TableViewHolder.clipsToBounds = true
        

//        hideBTN.layer.borderWidth = 1
//        hideBTN.layer.borderColor = UIColor.white.cgColor
//        hideBTN.layer.cornerRadius = 30
//        hideBTN.layer.masksToBounds = true
//        hideBTN.clipsToBounds = true
        
        saveBTN.layer.borderWidth = 1
        saveBTN.layer.borderColor = UIColor.white.cgColor
        saveBTN.layer.cornerRadius = 20
        saveBTN.layer.masksToBounds = true
        saveBTN.clipsToBounds = true
        
        AvailablePoints = StartingPoints

        
  
        
        
        TableView.register(UINib(nibName: "AttributesItemCell", bundle: nil), forCellReuseIdentifier: "AttributesItemCell")
        
        self.TableView.allowsSelection = false
        self.TableView.backgroundColor = UIColor.clear
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        
        
        
        
        isLoggedIn = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            
            //self.saveBTN.isHidden = true
            
            let fullname =  prefs.value(forKey: "FULLNAME") as! String
            
            let title = "Agent Attributes"
            let message = "Throughout your career it's important to learn and further develop yourself.  Carefully allocate these points to reach your full potential."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            
            
            
        }
        
        
        
        
    }
    
    //  override func awake
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        
        AttributesArray.removeAll()
        
    
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.7
        })
        
        
      
        
        self.availablePointsView.layer.cornerRadius = 5
        self.levelView.layer.cornerRadius = 5
        
        availablePointsView.layer.borderWidth = 1
        availablePointsView.layer.borderColor = UIColor.white.cgColor
        
        levelView.layer.borderWidth = 1
        levelView.layer.borderColor = UIColor.white.cgColor
        
        sender1Temp = 5
        sender2Temp = 5
        sender3Temp = 5
        sender4Temp = 5
        
        AttributesArray.append(PlayerAttributes(title: "Awareness", currentAmount: Awareness, imageName: "Awareness"))
        AttributesArray.append(PlayerAttributes(title: "Charisma", currentAmount: Charisma, imageName: "Charisma"))
        AttributesArray.append(PlayerAttributes(title: "Credibility", currentAmount: Credibility, imageName: "Credibility"))
        AttributesArray.append(PlayerAttributes(title: "Endurance", currentAmount: Endurance, imageName: "Endurance"))
        AttributesArray.append(PlayerAttributes(title: "Intelligence", currentAmount: Intelligence, imageName: "Intelligence"))
        AttributesArray.append(PlayerAttributes(title: "Speed", currentAmount: Speed, imageName: "Speed"))
        AttributesArray.append(PlayerAttributes(title: "Strength", currentAmount: Strength, imageName: "Strength"))
        AttributesArray.append(PlayerAttributes(title: "Vision", currentAmount: Vision, imageName: "Vision"))
        
        TempAwareness = Awareness
        TempCharisma = Charisma
        TempCredibility = Credibility
        TempEndurance = Endurance
        TempIntelligence = Intelligence
        TempSpeed = Speed
        TempStrength = Strength
        TempVision = Vision
       
        
       // self.NextBTN.layer.cornerRadius = 40
//        self.AdjustRatingsView.layer.cornerRadius = 5
//        self.AdjustRatingsView.layer.borderWidth = 1
//        self.AdjustRatingsView.layer.borderColor = UIColor.white.cgColor
        
        
//        stepper1.wraps = false
//        stepper1.maximumValue = 100
        
        
        
        
        availablePointsLBL.text = Int(AvailablePoints).description
        
        
        
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
    /*
     override init (frame : CGRect) {
     super.init(frame : frame)
     addBehavior()
     }
     
     convenience init () {
     self.init(frame:CGRect.zero)
     }
     
     required init(coder aDecoder: NSCoder) {
     fatalError("This class does not support NSCoding")
     }
     
     func addBehavior (){
     print("Add all the behavior here")
     }
     
     */
    @IBAction func hideBTN(_ sender: AnyObject) {
        
       // let lastviewtopulse = "attributes"
        
//        if attributesChanged {
//        
//        let actionSheetController: UIAlertController = UIAlertController(title: "Close?", message: "Are you sure you want to close the attributes menu?  You will lose any unsaved changes.", preferredStyle: .alert)
//        
//        //Create and add the Cancel action
//        
//        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
//            
//            
//            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"\(lastviewtopulse)"])
//            
//            UIView.animate(withDuration: 0.5, animations: { () -> Void in
//                self.BGView.alpha = 0.0
//                self.isHidden = true
//            })
//            
//        }
//        
//        
//        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
//            
//            
//        }
//        
//        
//        
//        actionSheetController.addAction(cancelAction)
//        actionSheetController.addAction(yesAction)
//        
//        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheetController, animated: true, completion: nil)
//        
//        
//        } else {
        
         let lastviewtopulse = "attributes"
        
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"\(lastviewtopulse)"])
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.BGView.alpha = 0.0
                self.isHidden = true
            })
            
       // }
      
 
       // self.removeFromSuperview()
    }
    
    @IBAction func saveAttributePointsBTN(_ sender: Any) {
        
        attributesChanged = false
        
        prefs.set(AvailablePoints, forKey: "MyAttributePoints")
        prefs.set(true, forKey: "MyAttributePointsSet")

        prefs.set(TempAwareness, forKey: "MyAttributeAwareness")
        prefs.set(TempCharisma, forKey: "MyAttributeCharisma")
        prefs.set(TempCredibility, forKey: "MyAttributeCredibility")
        prefs.set(TempEndurance, forKey: "MyAttributeEndurance")
        prefs.set(TempIntelligence, forKey: "MyAttributeIntelligence")
        prefs.set(TempSpeed, forKey: "MyAttributeSpeed")
        prefs.set(TempStrength, forKey: "MyAttributeStrength")
        prefs.set(TempVision, forKey: "MyAttributeVision")
        
        
        let title = "Success"
        let message = "Your Attribute settings have been saved."
        let reference = ""
        
        DispatchQueue.main.async(execute: {
            let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
            view.tag = 1000
            self.addSubview(view)
        })
        
        prefs.set(true, forKey: "NewAgentAttributesComplete")
        
        if AvailablePoints == 0.0 {
        
         self.availablePointsLBL.isHidden = true
            
        } else {
            
         self.availablePointsLBL.text = Int(AvailablePoints).description
         self.availablePointsLBL.isHidden = false
            
        }
        
         if (isLoggedIn == 1) {
        
        let AttributeData = UpdateAttributes(self.email, id: "1", awareness: TempAwareness.description as NSString, charisma: TempCharisma.description as NSString, credibility: TempCredibility.description as NSString, endurance: TempEndurance.description as NSString, intelligence: TempIntelligence.description as NSString, speed: TempSpeed.description as NSString, strength: TempStrength.description as NSString, vision: TempVision.description as NSString, action: "update", currentPoints: AvailablePoints.description as NSString)
            
            
             NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTabBarItems"), object: nil)
            
        
         } else {
            
            
            let lastviewtopulse = "attributes"
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"\(lastviewtopulse)"])
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.BGView.alpha = 0.0
                self.isHidden = true
            })
            
            
        }
        //self.present(actionSheetControllerMission, animated: true, completion: nil)
        
        
       
        
        
        
    }
    
    
    
    
    class func setTitle(_ title: String) {
        //titleLBL.text = title
    }
    
    
    // class func instanceFromNib(title: String, itemImage: UIImage) -> ItemAnnotationView
    
    
    
    class func instanceFromNib(title: String, playerAttributes: TotalPlayerAttributes) -> AttributesView {
        // class func instanceFromNib(title: String) -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = AttributesView()
        // var itemTitle: String!
        // itemTitle = title
        
        
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        //  Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        Nib = UINib(nibName: "AttributesView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AttributesView
        
        Nib.title = title
        
        Nib.MyTotalPlayerAttributes = playerAttributes
        
        Nib.Awareness = playerAttributes.Awareness
        Nib.Charisma = playerAttributes.Charisma
        Nib.Credibility = playerAttributes.Credibility
        Nib.Intelligence = playerAttributes.Intelligence
        Nib.Endurance = playerAttributes.Endurance
        Nib.Speed = playerAttributes.Speed
        Nib.Strength = playerAttributes.Strength
        Nib.Vision = playerAttributes.Vision
        
       // Nib.BGView.alpha = 0.0
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    

    
    //STEPPER 1
   // @IBAction func stepper1ValueChanged(_ sender: UIStepper)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AttributesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "AttributesItemCell"
        
        var ItemSelected: PlayerAttributes
        ItemSelected = AttributesArray[indexPath.row]
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "AttributesItemCell") as! AttributesItemCell
        
        cell.skillsViewHolder.isHidden = true
        cell.ViewHolder.layer.borderColor = UIColor.gray.cgColor
        cell.ViewHolder.layer.borderWidth = 1
        cell.progressHolderView.layer.cornerRadius = 5
        cell.progressHolderView.layer.masksToBounds = true
        cell.progressHolderView.clipsToBounds = true
//        cell.backgroundColor = UIColor.clear
//        cell.BGView.layer.cornerRadius = 5
//        cell.BGView.layer.masksToBounds = true
//        cell.BGView.clipsToBounds = true
        
       // cell.itemLBL.text = ItemSelected.title
       // cell.tag = indexPath.row
        cell.attributeImage.image = UIImage(named: "\(ItemSelected.imageName)")!
        cell.attributeImage.contentMode = .scaleAspectFit
        
        cell.title.text = ItemSelected.title
        cell.amountLBL.text = round(ItemSelected.currentAmount).description
        
        let attProgress: Float = Float(ItemSelected.currentAmount / 100)
        
        cell.progressView.setProgress(attProgress, animated: true)
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        cell.itemStepper.value = ItemSelected.currentAmount
        
        
        cell.itemStepper.tag = indexPath.row
        cell.itemStepper.addTarget(self, action: #selector(AttributesView.attributeStepperValueChanged(_:)), for: UIControlEvents.valueChanged)
        
       // cell.itemStepper.addTarget(self, action:)
        
        
      //  let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(ItemSelected.imageName).png")
      //  let theImageData = try? Data(contentsOf: url)
        
        
      //  cell.itemImage.image = UIImage(data:theImageData!)!
      //  cell.selectionStyle = UITableViewCellSelectionStyle.none
        
      //  cell.findItemBTN.tag = indexPath.row
      //  cell.findItemBTN.addTarget(self, action: #selector(MissedItemsView.LocateItemBTN(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
        
    }
    
//    func StepperValueChanged(_ sender: AttributesItemCell) {
//        
//         var isHigher = Bool()
//         var TempPoints = Double()
//        
//        var index = sender.tag
//        
//        if let indexPath = TableView.indexPath(for: sender){
//            print(indexPath)
//            
//            var AttributeSelected: PlayerAttributes
//            AttributeSelected = AttributesArray[index]
//            
//            
//           // sender.progressView.value = sender.itemStepper.stepValue
//            
//            
//            
//            //AvailablePoints
//            
//            
//            
//            if sender.itemStepper.value > AttributeSelected.currentAmount {
//                isHigher = true
//            } else {
//                isHigher = false
//            }
//            print("Sender Value: \(sender.itemStepper.stepValue)")
//            var TempPoints = Double()
//            
//            
//            if isHigher {
//                TempPoints = AvailablePoints - sender.itemStepper.stepValue
//                
//            } else {
//                TempPoints = AvailablePoints + sender.itemStepper.stepValue
//            }
//
//            
//            if NewPoints >= 0 {
//                if NewPoints <= MaxPoints {
//                    // self.label4.text = "\(Int(stepper4.value).description)"
//                    // UpdateProgress4(self.stepper4Progress)
//                    sender.progressView.setProgress(1, animated: true)
//                }
//            }
//            
//            
//            
//        }
//        
//        
//    }

    
    func attributeStepperValueChanged(_ sender: UIStepper) {
        
        var ShowMessageAlert = Bool()
        
        print("Stepper value changed")
        
        var Index = sender.tag
        
        attributesChanged = true
        
        
        print("Sender Tag = \(sender.tag)")
        
        
        let path =  IndexPath(row: Index, section: 0)

        
        let cell = self.TableView.cellForRow(at: path) as! AttributesItemCell
        
        var ItemSelected: PlayerAttributes
        ItemSelected = AttributesArray[Index]
        
        print("Item Selected: \(ItemSelected)")
        
        
        var TempAttributePoints = Double()
        
        TempAttributePoints = ItemSelected.currentAmount
        var stepperIndex = sender.value
        
        // print("Segment Index = \(segmentIndex)")
        
        // SettingsSelected = SettingsArray[row!]
        
        
        //self.stepper4Progress = sender.value
        
        
        
        
        var TempPointsCategory = Double()
        var TempPointsCategoryStart = Double()
        var DoNotAdjustPoints = Bool()
        
        TempPointsCategory = sender.value
        TempPointsCategoryStart = sender.value
        print("Temp Points Category (as Sender.value): \(TempPointsCategory)")
        
        if TempPointsCategory < AttributeMinimum {
            TempPointsCategory = AttributeMinimum
            DoNotAdjustPoints = true
        }
        
        print("Temp Points Value Adjusted: \(TempPointsCategory)")
        
        var TempPointsForItem = Double()
        
        switch ItemSelected.title {
            
        case "Awareness":
          //  print("Stepper is awareness, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempAwareness
           // TempAwareness = TempPointsCategory
            //TempAttributePoints = ItemSelected.currentAmount
        case "Charisma":
          //  print("Stepper is charisma, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempCharisma
           // TempCharisma = TempPointsCategory
        case "Credibility":
          //  print("Stepper is cred, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempCredibility
          //  TempCredibility = TempPointsCategory
        case "Endurance":
          //  print("Stepper is edn, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempEndurance
           // TempEndurance = TempPointsCategory
        case "Intelligence":
          //  print("Stepper is int, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempIntelligence
           // TempIntelligence = TempPointsCategory
        case "Speed":
          //  print("Stepper is speed, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempSpeed
           // TempSpeed = TempPointsCategory
        case "Strength":
         //   print("Stepper is stren, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempStrength
           //  TempStrength = TempPointsCategory
        case "Vision":
          //  print("Stepper is vision, current Points = \(TempAttributePoints)")
            TempPointsForItem = TempVision
           //  TempVision = TempPointsCategory

        default:
            break
        }
        
        print("Temp Points Category = \(TempPointsCategory)")
        print("Temp Points Item = \(TempPointsForItem)")
        
        var isHigher = Bool()
        var isEqual = Bool()
        
        if TempPointsCategory > TempPointsForItem {
            isHigher = true

//            AttributeMinimum
            
        } else {
            if TempPointsCategoryStart == TempPointsForItem {
                isEqual = true
            }
            isHigher = false
            
            
        }
        //   sender4Temp = sender.value
        print("Sender Step Value: \(sender.stepValue)")
        print("Sender Value: \(sender.value)")
        
        
        var TempPoints = AvailablePoints
        
        
       // print("From Stepper - Available Points: \(AvailablePoints)")
        
        if !isEqual {
        
        if isHigher {
            TempPoints = AvailablePoints - sender.stepValue
           // TempPointsCategory = TempPointsCategory + sender.stepValue
           // print("Temp Points higher: \(TempPoints)")
        } else {
            ShowMessageAlert = true
            
            //if sender.value > TempPointsCategory {
                
            //} else {
            TempPoints = AvailablePoints + sender.stepValue
            //}
           // TempPointsCategory = TempPointsCategory - sender.stepValue
           // print("Temp Points lower: \(TempPoints)")
        }
            
        }
        
        if TempPoints < 0 {
            DoNotAdjustPoints = true
        }
        
        if TempPoints > StartingPoints {
            DoNotAdjustPoints = true
        }
        
        
      //  print("Do not adjust = \(DoNotAdjustPoints)")
        

        
      
        
        
        print("BEFORE****")
        print("Available Points: \(AvailablePoints)")
        print("TempAwareness: \(TempAwareness)")
        print("TempCharisma: \(TempCharisma)")
        print("TempCredibility: \(TempCredibility)")
        print("TempEndurance: \(TempEndurance)")
        print("TempIntelligence: \(TempIntelligence)")
        print("TempSpeed: \(TempSpeed)")
        print("TempStrength: \(TempStrength)")
        print("TempVision: \(TempVision)")
        
        
        
       
        if !DoNotAdjustPoints {
            
            
        
        AvailablePoints = TempPoints
        self.availablePointsLBL.text = AvailablePoints.description
       // var NewAmount = Double()
        
          
                
                switch ItemSelected.title {
                    
                case "Awareness":
                    // print("Stepper is awareness, current Points = \(TempAttributePoints)")
                    //TempPointsForItem = TempAwareness
                    TempAwareness = TempPointsCategory
                    
                //TempAttributePoints = ItemSelected.currentAmount
                case "Charisma":
                    //  print("Stepper is char, current Points = \(TempAttributePoints)")
                    // TempPointsForItem = TempCharisma
                    TempCharisma = TempPointsCategory
                case "Credibility":
                    //  print("Stepper is cred, current Points = \(TempAttributePoints)")
                    // TempPointsForItem = TempCredibility
                    TempCredibility = TempPointsCategory
                case "Endurance":
                    //  print("Stepper is end, current Points = \(TempAttributePoints)")
                    //  TempPointsForItem = TempEndurance
                    TempEndurance = TempPointsCategory
                case "Intelligence":
                    //  print("Stepper is inte, current Points = \(TempAttributePoints)")
                    //  TempPointsForItem = TempIntelligence
                    TempIntelligence = TempPointsCategory
                case "Speed":
                    //  print("Stepper is speed, current Points = \(TempAttributePoints)")
                    // TempPointsForItem = TempSpeed
                    TempSpeed = TempPointsCategory
                case "Strength":
                    //   print("Stepper is stre, current Points = \(TempAttributePoints)")
                    //  TempPointsForItem = TempStrength
                    TempStrength = TempPointsCategory
                case "Vision":
                    //  print("Stepper is visi, current Points = \(TempAttributePoints)")
                    //  TempPointsForItem = TempVision
                    TempVision = TempPointsCategory
                    
                default:
                    break
                }
                
        
            
            
            
        
        let newProgress: Float = Float(TempPointsCategory / 100)
        cell.progressView.setProgress(newProgress, animated: true)
        //cell.amountLBL.text = round(TempPointsCategory).description
       
            
            print("AFTER*****")
            print("Available Points: \(AvailablePoints)")
            print("TempAwareness: \(TempAwareness)")
            print("TempCharisma: \(TempCharisma)")
            print("TempCredibility: \(TempCredibility)")
            print("TempEndurance: \(TempEndurance)")
            print("TempIntelligence: \(TempIntelligence)")
            print("TempSpeed: \(TempSpeed)")
            print("TempStrength: \(TempStrength)")
            print("TempVision: \(TempVision)")
            
            
//            if (isLoggedIn != 1) {
//                
//                prefs.set(AvailablePoints, forKey: "MyAttributePoints")
//                prefs.set(TempAwareness, forKey: "MyAttributeAwareness")
//                prefs.set(TempCharisma, forKey: "MyAttributeCharisma")
//                prefs.set(TempCredibility, forKey: "MyAttributeCredibility")
//                prefs.set(TempEndurance, forKey: "MyAttributeEndurance")
//                prefs.set(TempIntelligence, forKey: "MyAttributeIntelligence")
//                prefs.set(TempSpeed, forKey: "MyAttributeSpeed")
//                prefs.set(TempStrength, forKey: "MyAttributeStrength")
//                prefs.set(TempVision, forKey: "MyAttributeVision")
//                
//            }
            
            
            AttributesArray[Index] = PlayerAttributes(title: ItemSelected.title, currentAmount: TempPointsCategory, imageName: ItemSelected.imageName)
            
            self.TableView.reloadData()
            
        }
        
        
        if AvailablePoints == 0.0 {
            
           // self.availablePointsView.layer.backgroundColor = UIColor(red: CGFloat(249/255), green: CGFloat(148/255), blue: CGFloat(148/255), alpha: 1.0).cgColor
            
            if ShowMessageAlert{
            
            let title = "Points!"
            let message = "You do not have any more available point to use."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            }
        
            
        } else {
            
            // self.availablePointsView.layer.backgroundColor = UIColor(red: CGFloat(49/255), green: CGFloat(142/255), blue: CGFloat(198/255), alpha: 1.0).cgColor
            
            //self.availablePointsView.layer.backgroundColor = UIColor(red: 49/255, green: 142/255, blue: 198/255, alpha: 1.0).cgColor
            
        }
        
        print("****----------****")
        //let NewPoints = UpdateAvailablePoints(TempPoints, stepperName: "stepper4", stepperValue: sender.value, indexPath: path)
        
//        if NewPoints >= 0 {
//            if NewPoints <= MaxPoints {
//               // self.label4.text = "\(Int(stepper4.value).description)"
//               // UpdateProgress4(self.stepper4Progress)
//                
//                let newProgress: Float = Float(NewPoints / 100)
//                
//                cell.progressView.setProgress(newProgress, animated: true)
//            }
//        }
    }
    
    
    func UpdateProgress(_ NewValue: Double) {
        let newProgress: Float = Float(NewValue / 100)
        //self.progress3.setProgress(newProgress, animated: true)
    }
    
    
    func LocateItemBTN (_ sender: AnyObject) {
        
        let row = sender.tag
        
        var ItemSelected: PlayerAttributes
        ItemSelected = AttributesArray[row!]
        
        
//        SearchItemName = ItemSelected.name
//        SearchItemImageName = ItemSelected.imageName
//        SearchItemLocation = ItemSelected.Location
        
        self.isHidden = true
        
        /*
         let alertView:UIAlertView = UIAlertView()
         alertView.title = "Coming Soon"
         alertView.message = "Will place on map item: \(SearchItemName) at Location: \(SearchItemLocation)"
         alertView.delegate = self
         alertView.addButton(withTitle: "OK")
         alertView.show()
         */
        
//        let msgTitletemp = "Item Alert"
//        let msgMSGtemp = "It may still be available...directions to this item?"
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowMessage"), object: nil, userInfo: ["msgTitle":"\(msgTitletemp)","msgMSG":"\(msgMSGtemp)","name":"\(SearchItemName)","lat":"\(SearchItemLocation.latitude)","long":"\(SearchItemLocation.longitude)"])
        
        
        
    }
    
    
    
}

struct TotalPlayerAttributes {
    
    
    var Awareness: Double
    var Charisma: Double
    var Credibility: Double
    var Endurance: Double
    var Intelligence: Double
    var Speed: Double
    var Strength: Double
    var Vision: Double
    
    
}

struct PlayerAttributes {
    
    var title: String
    var currentAmount: Double
    var imageName: String
    
    
}

struct PlayerSkills {
    
    var title: String
    var description: String
    var level: String
    var unlocked: Bool
    //var currentAmount: Double
    
    
}


class SkillsView: UIView, UITableViewDelegate,  UITableViewDataSource {
    
    
     @IBOutlet weak var availablePointsLBL: UILabel!
    
    @IBOutlet weak var availablePointsView: UIView!
    @IBOutlet weak var levelView: UIView!
    
    //var SkillsArray = [PlayerSkills]()
    
    @IBOutlet weak var hideBTN: UIButton!
    
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    var SkillInfoArray = [SkillInfo]()
    
    var prefs:UserDefaults = UserDefaults.standard
    //var isHidden = Bool()
    var username = NSString()
    var email = NSString()
    var title = String()

    
    @IBOutlet weak var TableViewHolder: UIView!
    @IBOutlet weak var TableView: UITableView!
    
    var isLoggedIn = Int()
    
    var titleText: String! {
        didSet {
            //  titleLBL.text = titleText
        }
        
    }
    
    
    override func awakeFromNib() {
        
        self.availablePointsView.isHidden = true
        self.levelView.isHidden = true
        
        
       // SkillsArray.append(PlayerSkills(title: "Skill 1", description: "TBD", level: "1"))
       // SkillsArray.append(PlayerSkills(title: "Skill 2", description: "TBD", level: "1"))
       // SkillsArray.append(PlayerSkills(title: "Skill 3", description: "TBD", level: "1"))
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString)
            email =  (prefs.value(forKey: "EMAIL") as! NSString)
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
//        let level = "1"
//        let status = "all"
//        let MissionURLData = GetSkills(self.email, level: level as NSString, status: status as NSString)
//        SkillInfoArray = FilterSkillItems(MissionURLData)
        
        /*
         BGView.layer.cornerRadius = 10
         BGView.clipsToBounds = true
         BGView.layer.masksToBounds = true
         BGView.layer.borderWidth = 1
         BGView.layer.borderColor = UIColor(red: 0, green: 166/255, blue: 81/255, alpha: 1).cgColor
         */
        
        
       
        
        
        // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        
//        hideBTN.layer.borderWidth = 1
//        hideBTN.layer.borderColor = UIColor.white.cgColor
//        hideBTN.layer.cornerRadius = 30
//        hideBTN.layer.masksToBounds = true
//        hideBTN.clipsToBounds = true
        
        saveBTN.layer.borderWidth = 1
        saveBTN.layer.borderColor = UIColor.white.cgColor
        saveBTN.layer.cornerRadius = 40
        saveBTN.layer.masksToBounds = true
        saveBTN.clipsToBounds = true
        

        // BGView.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        TableViewHolder.layer.borderWidth = 1
        TableViewHolder.layer.borderColor = UIColor.white.cgColor
       // TableViewHolder.layer.cornerRadius = 5
        TableViewHolder.layer.masksToBounds = true
        TableViewHolder.clipsToBounds = true
        
       
        
        
        
        
        isLoggedIn = self.prefs.integer(forKey: "ISLOGGEDIN") as Int
        
        if (isLoggedIn != 1) {
            
            let fullname =  prefs.value(forKey: "FULLNAME") as! String
            
            let title = "Agent Skills"
            let message = "As you progress you will have the opportunity to learn new skills.  They will be critical to your success."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.addSubview(view)
            })
            
            
            
            SkillInfoArray.append(SkillInfo(id: "1", title: "Lock Picking", description: "This ability helps with opening secured items and locations", level: "1", xp: "0", status: "locked", unlocked: false))
            
            SkillInfoArray.append(SkillInfo(id: "1", title: "Stealth", description: "The ability to move around with minimal detection", level: "1", xp: "0", status: "locked", unlocked: false))
            
        } else {
            
            
            
            let level = "1"
            let status = "all"
            let MissionURLData = GetSkills(self.email, level: level as NSString, status: status as NSString)
            SkillInfoArray = FilterSkillItems(MissionURLData)
            
        }
        
        
        
        
        TableView.register(UINib(nibName: "SkillsItemCell", bundle: nil), forCellReuseIdentifier: "SkillsItemCell")
        
        
        
        self.TableView.backgroundColor = UIColor.clear
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.TableView.allowsSelection = false
        
        
        
    }
    
    //  override func awake
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.7
        })
        
       
        
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
    
 
    
    @IBAction func hideBTN(_ sender: AnyObject) {
        
        prefs.set(true, forKey: "NewAgentSkillsComplete")
        
        let lastviewtopulse = "skills"
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdatePulsing"), object: nil, userInfo: ["lastPulsingView":"\(lastviewtopulse)"])
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateGestureRecognizers"), object: nil, userInfo: nil)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.BGView.alpha = 0.0
            self.isHidden = true
        })
        
       // self.removeFromSuperview()
    }
    
    
    
    
    
    class func setTitle(_ title: String) {
        //titleLBL.text = title
    }
    
    
    // class func instanceFromNib(title: String, itemImage: UIImage) -> ItemAnnotationView
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SkillInfoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // var cell = UITableViewCell()
        
        let identifier0 = "SkillsItemCell"
        
        var ItemSelected: SkillInfo
        ItemSelected = SkillInfoArray[indexPath.row]
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "SkillsItemCell") as! SkillsItemCell
        
        let SkillUnlocked = ItemSelected.unlocked!
        
        if SkillUnlocked {
           cell.lockedView.isHidden = true
        } else {
           cell.lockedView.isHidden = false
        }
        
    
       // cell.ViewHolder.isHidden = true
        cell.skillsViewHolder.isHidden = false
        //        cell.backgroundColor = UIColor.clear
        //        cell.BGView.layer.cornerRadius = 5
        //        cell.BGView.layer.masksToBounds = true
        //        cell.BGView.clipsToBounds = true
        
        // cell.itemLBL.text = ItemSelected.title
        cell.tag = indexPath.row
        
        
        
        cell.skillsTitle.text = ItemSelected.title
        cell.skillsDescriptionLBL.text = ItemSelected.description
        cell.skillsLevelLBL.text = ItemSelected.level
        
        //cell.skillsHolderView.layer.cornerRadius = 8
        cell.skillsViewHolder.clipsToBounds = true
        cell.skillsViewHolder.layer.masksToBounds = true
        cell.skillsViewHolder.layer.borderWidth = 1
        cell.skillsViewHolder.layer.borderColor = UIColor.black.cgColor
        
        cell.skillsLevelLBL.layer.cornerRadius = 12
        cell.skillsLevelLBL.clipsToBounds = true
        cell.skillsLevelLBL.layer.masksToBounds = true
        //cell.amountLBL.text = ItemSelected.currentAmount.description
        
       // cell.itemStepper.isHidden = true
        cell.skillsAmountLBL.isHidden = true
        cell.skillsprogressHolderView.isHidden = true
       
        
        let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
       // cell.itemStepper.addTarget(self, action: #selector(AttributesView.attributeStepperValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        // cell.itemStepper.addTarget(self, action:)
        
        
        //  let url = URL(fileURLWithPath: dirpath).appendingPathComponent("\(ItemSelected.imageName).png")
        //  let theImageData = try? Data(contentsOf: url)
        
        
        //  cell.itemImage.image = UIImage(data:theImageData!)!
        //  cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //  cell.findItemBTN.tag = indexPath.row
        //  cell.findItemBTN.addTarget(self, action: #selector(MissedItemsView.LocateItemBTN(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
        
    }

    
    
    class func instanceFromNib(title: String) -> SkillsView {
        // class func instanceFromNib(title: String) -> UIView {
        let bounds = UIScreen.main.bounds
        var Nib = SkillsView()
        // var itemTitle: String!
        // itemTitle = title
        
        let theFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        //  Nib = UINib(nibName: "ItemAnnotationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        Nib = UINib(nibName: "SkillsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SkillsView
        
        Nib.title = title
        
        // Nib.BGView.alpha = 0.0
        
        Nib.bounds = bounds
        return Nib
        
        //return UINib(nibName: "blurMenu", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
}
