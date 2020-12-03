//
//  CreatePlayerCareerViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 5/4/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CreatePlayerCareerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
      @IBOutlet weak var collectionView: UICollectionView!
     var TotalJobsArray = [CharacterJobInfo]()
    
    var theJobTitle = String()
    var theJobDescription = String()
    var theJobImage = UIImage()
    
    
    
    @IBOutlet weak var CharacterView: UIView!
    
    
    @IBOutlet weak var Body_Chest: UIImageView!
    @IBOutlet weak var Body_Head: UIImageView!
    @IBOutlet weak var Body_Hair: UIImageView!
    @IBOutlet weak var Body_Eyes: UIImageView!
    @IBOutlet weak var Body_Underwear: UIImageView!
    @IBOutlet weak var Body_Leg_Left: UIImageView!
    @IBOutlet weak var Body_Leg_Right: UIImageView!
    @IBOutlet weak var Body_Arm_Left: UIImageView!
    @IBOutlet weak var Body_Arm_Right: UIImageView!
    @IBOutlet weak var Body_Boots_Left: UIImageView!
    @IBOutlet weak var Body_Boots_Right: UIImageView!
    @IBOutlet weak var Body_Mouth: UIImageView!
    @IBOutlet weak var Body_Shirt: UIImageView!
    @IBOutlet weak var Body_Pants: UIImageView!
    @IBOutlet weak var Body_Belt: UIImageView!
    
    @IBOutlet weak var Body_Job_Clothes: UIImageView!
    
    @IBOutlet weak var Armor_Chest: UIImageView!
    @IBOutlet weak var Armor_Boot_Right: UIImageView!
    @IBOutlet weak var Armor_Boot_Left: UIImageView!
    
   // @IBOutlet weak var SkinBTN_W: UIButton!
   // @IBOutlet weak var SkinBTN_B: UIButton!
    
    
    
    
    var Shirt_Hidden = Bool()
    var Armor_Chest_Hidden = Bool()
    
    
    var W_Chest = UIImage(named: "ItemsCharacter_Chest.png")!
    var W_ArmLeft = UIImage(named: "ItemsCharacter_Arm_Left.png")!
    var W_ArmRight = UIImage(named: "ItemsCharacter_Arm_Right.png")!
    var W_LegLeft = UIImage(named: "ItemsCharacter_Left_Left.png")!
    var W_LegRight = UIImage(named: "ItemsCharacter_Leg_Right.png")!
    //  var W_HandLeft = UIImage(named: "ItemsCharacter_Hand_Left.png")!
    //   var W_HandRight = UIImage(named: "ItemsCharacter_Hand_Right.png")!
    var W_Head = UIImage(named: "ItemsCharacter_Head.png")!
    var W_Hair_Brown = UIImage(named: "ItemsCharacter_Hair_Brown.png")!
    var W_Mouth = UIImage(named: "ItemsCharacter_Mouth.png")!
    
    
    var B_Chest = UIImage(named: "ItemsCharacter_Chest_African.png")!
    var B_ArmLeft = UIImage(named: "ItemsCharacter_Arm_Left_African.png")!
    var B_ArmRight = UIImage(named: "ItemsCharacter_Arm_Right_African.png")!
    var B_LegLeft = UIImage(named: "ItemsCharacter_Leg_Left_African.png")!
    var B_LegRight = UIImage(named: "ItemsCharacter_Leg_Right_African.png")!
    //  var B_HandLeft = UIImage(named: "ItemsCharacter_Hand_Left_African.png")!
    //   var B_HandRight = UIImage(named: "ItemsCharacter_Hand_Right_African.png")!
    var B_Head = UIImage(named: "ItemsCharacter_Head_African.png")!
    var B_Hair_Brown = UIImage(named: "ItemsCharacter_Hair_African.png")!
    var B_Mouth = UIImage(named: "ItemsCharacter_Mouth_African.png")!
    
    var EyesBlack = UIImage(named: "ItemsCharacter_Eyes_Black.png")!
    
    
    
    var Clothes_Docter = UIImage(named: "Clothes_Doctor.png")!
    var Clothes_Police = UIImage(named: "Clothes_Doctor.png")!
    var Clothes_Farmer = UIImage(named: "Clothes_Overalls.png")!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    @IBOutlet weak var NextBTN: UIButton!
   // @IBOutlet weak var AdjustRatingsView: UIView!
    
  
     let prefs = UserDefaults.standard
    
    
    
    var SelectedChest = UIImage()
    var SelectedArmLeft = UIImage()
    var SelectedArmRight = UIImage()
    var SelectedLegLeft = UIImage()
    var SelectedLegRight = UIImage()
    var SelectedHead = UIImage()
    var SelectedHair = UIImage()
    var SelectedMouth = UIImage()
    var SelectedEyes = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Body_Job_Clothes.isHidden = true

        if let font = UIFont(name: "Verdana", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        // navigationController!.navigationBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
     //   self.AdjustRatingsView.layer.cornerRadius = 5
     //   self.AdjustRatingsView.layer.borderWidth = 1
     //   self.AdjustRatingsView.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.NextBTN.layer.cornerRadius = 40
        
        /*
        SkinBTN_W.layer.cornerRadius = 15
        SkinBTN_W.layer.borderWidth = 1
        SkinBTN_W.layer.borderColor = UIColor.blackColor().CGColor
        
        
        SkinBTN_B.layer.cornerRadius = 15
        SkinBTN_B.layer.borderWidth = 1
        SkinBTN_B.layer.borderColor = UIColor.blackColor().CGColor
        */
        
        Armor_Chest.isHidden = true
        Armor_Chest_Hidden = true
        
        
        let UnderWearWhite = UIImage(named: "ItemsCharacter_Underwear.png")!
        
        Body_Chest.image = SelectedChest
        Body_Arm_Left.image =  SelectedArmLeft
        Body_Arm_Right.image =  SelectedArmRight
        Body_Leg_Left.image =  SelectedLegLeft
        Body_Leg_Right.image =  SelectedLegRight
        Body_Head.image =  SelectedHead
        Body_Hair.image =  SelectedHair
        Body_Mouth.image =  SelectedMouth
        Body_Eyes.image =  SelectedEyes
        Body_Underwear.image = UnderWearWhite
        
        
        CharacterView.layer.cornerRadius = 5
        CharacterView.layer.borderWidth = 1
        CharacterView.layer.borderColor = UIColor.white.cgColor
        
        self.Armor_Boot_Left.transform = self.Armor_Boot_Left.transform.scaledBy(x: -1, y: 1)
        Armor_Boot_Right.isHidden = true
        Armor_Boot_Left.isHidden = true
        
      //  var columnHeaderViewNIBSmall = UINib(nibName: "ItemsCollectionViewCellSmall", bundle: nil)
        
     //   self.collectionView?.registerNib(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "ItemCellSmall")
        
        
        
        
        
        
        
        
        
        let PoliceImage = UIImage(named: "CharacterPoliceIcon.png")!
        let SurgeonImage = UIImage(named: "CharacterSurgeonIcon.png")!
        let EngImage = UIImage(named: "CharacterEngineerIcon.png")!
        let ConstructionImage = UIImage(named: "CharacterConstructionIcon.png")!
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Police Officer", jobImage: PoliceImage, jobDescription: "Coming Soon (Understand of firearms etc)"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Doctor", jobImage: SurgeonImage, jobDescription: "Coming Soon (Can Create special potions etc)"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Farmer", jobImage: EngImage, jobDescription: "Coming Soon"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Construction Worker", jobImage: ConstructionImage, jobDescription: "Coming Soon (Experienced builder etc)"))
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        self.collectionView.backgroundColor = UIColor.clear
        
        self.collectionView.reloadData()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func NextBTN(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "CreateNext", sender: self)
    }
    
    
    @IBAction func SetSkinBlack(_ sender: AnyObject) {
        
        SetSkinTone("black")
    }
    
    @IBAction func SetSkinWhite(_ sender: AnyObject) {
        
        SetSkinTone("white")
    }
    
    func SetSkinTone(_ skinColor: String) {
        
        switch skinColor {
        case "white":
            
            self.Body_Chest.image = W_Chest
            self.Body_Head.image = W_Head
            self.Body_Hair.image = W_Hair_Brown
            self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = W_LegLeft
            self.Body_Leg_Right.image = W_LegRight
            self.Body_Arm_Left.image = W_ArmLeft
            self.Body_Arm_Right.image = W_ArmRight
            //  self.Body_Hand_Left.image = W_HandLeft
            //  self.Body_Hand_Right.image = W_HandRight
            self.Body_Mouth.image = W_Mouth
            
            
            
            
        case "black":
            
            self.Body_Chest.image = B_Chest
            self.Body_Head.image = B_Head
            self.Body_Hair.image = B_Hair_Brown
            self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = B_LegLeft
            self.Body_Leg_Right.image = B_LegRight
            self.Body_Arm_Left.image = B_ArmLeft
            self.Body_Arm_Right.image = B_ArmRight
            //self.Body_Hand_Left.image = B_HandLeft
            //self.Body_Hand_Right.image = B_HandRight
            self.Body_Mouth.image = B_Mouth
            
            
            
        default:
            break
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        
        return TotalJobsArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicItemCollectionCell", for: indexPath) as! BasicItemCollectionViewCell
        
        var JobSelected: CharacterJobInfo
        
        JobSelected = TotalJobsArray[indexPath.row]
        cell.BGView.layer.cornerRadius = 5
        cell.BGView.layer.borderWidth = 1
        cell.BGView.layer.borderColor = UIColor.white.cgColor
        
        cell.imageView.image = JobSelected.jobImage
        cell.titleLBL.text = JobSelected.jobtitle
        cell.theButton.tag = indexPath.row
        cell.theButton.addTarget(self, action: #selector(CreatePlayerCareerViewController.JobSelected(_:)), for: UIControl.Event.touchUpInside)
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Job Selected"
        alertView.message = "Item \(indexPath.row) Selected"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
        
        
        // self.removeFromSuperview()
        
        
        
    }
    
    @objc func JobSelected(_ sender: AnyObject) {
        
        let row = sender.tag
        var JobSelected: CharacterJobInfo
        
        JobSelected = TotalJobsArray[row!]
        
        self.theJobTitle = JobSelected.jobtitle
        self.theJobImage = JobSelected.jobImage
        self.theJobDescription = JobSelected.jobDescription
        
        
        
        switch JobSelected.jobtitle {
        case "Doctor":
            self.Body_Job_Clothes.isHidden = false
            self.Body_Job_Clothes.image = self.Clothes_Docter
        case "Police Officer":
            self.Body_Job_Clothes.isHidden = false
             self.Body_Job_Clothes.image = self.Clothes_Police
        case "Farmer":
            
            self.Body_Job_Clothes.isHidden = false
             self.Body_Job_Clothes.image = self.Clothes_Farmer
            
            
        default:
            break
        }
        
        
      //  self.performSegueWithIdentifier("CharacterInfo", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNext" {
            
            if let WeaponsViewController = segue.destination as? WeaponsViewController {
                //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
                //WeaponsViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
               // WeaponsViewController.popoverPresentationController!.delegate = self
                
              //  WeaponsViewController.myLat = self.mylat.description
              //  WeaponsViewController.myLong = self.mylong.description
              //
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
