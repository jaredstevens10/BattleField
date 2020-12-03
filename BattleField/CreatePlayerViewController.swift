//
//  CreatePlayerViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/13/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CreatePlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    
    @IBOutlet weak var TraitView1: UIView!
    @IBOutlet weak var TraitView2: UIView!
    @IBOutlet weak var TraitView3: UIView!
    
    
    var HairTraitArray = [BodyTraitColorInfo]()
    var EyeTraitArray = [BodyTraitColorInfo]()
    var SkinTraitArray = [BodyTraitColorInfo]()
    
   let prefs = UserDefaults.standard
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var stepper1: UIStepper!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var stepper2: UIStepper!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var stepper3: UIStepper!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var progress4: UIProgressView!
    @IBOutlet weak var stepper4: UIStepper!
    
    
    
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
    
    
    @IBOutlet weak var Armor_Chest: UIImageView!
    @IBOutlet weak var Armor_Boot_Right: UIImageView!
    @IBOutlet weak var Armor_Boot_Left: UIImageView!

    @IBOutlet weak var SkinBTN_W: UIButton!
    @IBOutlet weak var SkinBTN_B: UIButton!
    @IBOutlet weak var SkinBTN_T: UIButton!
    
    @IBOutlet weak var eyeBlackBTN: UIButton!
    @IBOutlet weak var eyeBrownBTN: UIButton!
    @IBOutlet weak var eyeBlueBTN: UIButton!
    @IBOutlet weak var eyeGreenBTN: UIButton!
    
    @IBOutlet weak var hairBlackBTN: UIButton!
    @IBOutlet weak var hairLightBrownBTN: UIButton!
    @IBOutlet weak var hairBrownBTN: UIButton!
    @IBOutlet weak var hairGrayBTN: UIButton!
    @IBOutlet weak var hairOrangeBTN: UIButton!
    
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
    
    
    var T_Chest = UIImage(named: "ItemsCharacter_Chest_Tan.png")!
    var T_ArmLeft = UIImage(named: "ItemsCharacter_Arm_Left_Tan.png")!
    var T_ArmRight = UIImage(named: "ItemsCharacter_Arm_Right_Tan.png")!
    var T_LegLeft = UIImage(named: "ItemsCharacter_Leg_Left_Tan.png")!
    var T_LegRight = UIImage(named: "ItemsCharacter_Leg_Right_Tan.png")!
    //  var W_HandLeft = UIImage(named: "ItemsCharacter_Hand_Left.png")!
    //   var W_HandRight = UIImage(named: "ItemsCharacter_Hand_Right.png")!
    var T_Head = UIImage(named: "ItemsCharacter_Head_Tan.png")!
    var T_Hair_Brown = UIImage(named: "ItemsCharacter_Hair_Brown.png")!
    var T_Mouth = UIImage(named: "ItemsCharacter_Mouth_Tan.png")!
    
    
    
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
    var EyesBrown = UIImage(named: "ItemsCharacter_Eyes_Brown.png")!
    var EyesBlue = UIImage(named: "ItemsCharacter_Eyes_Blue.png")!
    var EyesGreen = UIImage(named: "ItemsCharacter_Eyes_Green.png")!
    
    var HairLightBrown = UIImage(named: "ItemsCharacter_Hair_Light_Brown.png")!
    var HairBrown = UIImage(named: "ItemsCharacter_Hair_Brown.png")!
    var HairGray = UIImage(named: "ItemsCharacter_Hair_Gray.png")!
    var HairOrange = UIImage(named: "ItemsCharacter_Hair_Orange.png")!
    
    var SelectedChest = UIImage()
    var SelectedArmLeft = UIImage()
    var SelectedArmRight = UIImage()
    var SelectedLegLeft = UIImage()
    var SelectedLegRight = UIImage()
    var SelectedHead = UIImage()
    var SelectedHair = UIImage()
    var SelectedMouth = UIImage()
    var SelectedEyes = UIImage()
    
    
    @IBOutlet weak var NextBTN: UIButton!
    @IBOutlet weak var AdjustRatingsView: UIView!
    
    @IBOutlet weak var NavBackBTN: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetSkinTraits()
        GetEyeTraits()
        GetHairTraits()
        
        if let font = UIFont(name: "Verdana", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        // navigationController!.navigationBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)

        self.AdjustRatingsView.layer.cornerRadius = 5
        self.AdjustRatingsView.layer.borderWidth = 1
        self.AdjustRatingsView.layer.borderColor = UIColor.white.cgColor
        
        self.NextBTN.layer.cornerRadius = 40
        
        TraitView1.layer.cornerRadius = 5
        TraitView1.layer.borderWidth = 1
        TraitView1.layer.borderColor = UIColor.white.cgColor
        TraitView1.layer.masksToBounds = true
        TraitView1.clipsToBounds = true
        
        TraitView2.layer.cornerRadius = 5
        TraitView2.layer.borderWidth = 1
        TraitView2.layer.borderColor = UIColor.white.cgColor
        TraitView2.layer.masksToBounds = true
        TraitView2.clipsToBounds = true
        
        TraitView3.layer.cornerRadius = 5
        TraitView3.layer.borderWidth = 1
        TraitView3.layer.borderColor = UIColor.white.cgColor
        TraitView3.layer.masksToBounds = true
        TraitView3.clipsToBounds = true
        
        
    /*
        
        SkinBTN_W.layer.cornerRadius = 15
        SkinBTN_W.layer.borderWidth = 1
        SkinBTN_W.layer.borderColor = UIColor.blackColor().CGColor
        
        
        SkinBTN_B.layer.cornerRadius = 15
        SkinBTN_B.layer.borderWidth = 1
        SkinBTN_B.layer.borderColor = UIColor.blackColor().CGColor
        
        SkinBTN_T.layer.cornerRadius = 15
        SkinBTN_T.layer.borderWidth = 1
        SkinBTN_T.layer.borderColor = UIColor.blackColor().CGColor

        
        
        eyeBlackBTN.layer.cornerRadius = 15
        eyeBlackBTN.layer.borderWidth = 1
        eyeBlackBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        eyeBrownBTN.layer.cornerRadius = 15
        eyeBrownBTN.layer.borderWidth = 1
        eyeBrownBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        eyeBlueBTN.layer.cornerRadius = 15
        eyeBlueBTN.layer.borderWidth = 1
        eyeBlueBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        eyeGreenBTN.layer.cornerRadius = 15
        eyeGreenBTN.layer.borderWidth = 1
        eyeGreenBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        hairLightBrownBTN.layer.cornerRadius = 15
        hairLightBrownBTN.layer.borderWidth = 1
        hairLightBrownBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        hairBrownBTN.layer.cornerRadius = 15
        hairBrownBTN.layer.borderWidth = 1
        hairBrownBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        hairGrayBTN.layer.cornerRadius = 15
        hairGrayBTN.layer.borderWidth = 1
        hairGrayBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        hairOrangeBTN.layer.cornerRadius = 15
        hairOrangeBTN.layer.borderWidth = 1
        hairOrangeBTN.layer.borderColor = UIColor.blackColor().CGColor
        
        hairBlackBTN.layer.cornerRadius = 15
        hairBlackBTN.layer.borderWidth = 1
        hairBlackBTN.layer.borderColor = UIColor.blackColor().CGColor
*/
        
        
        
        Armor_Chest.isHidden = true
        Armor_Chest_Hidden = true
        
        
        CharacterView.layer.cornerRadius = 5
        CharacterView.layer.borderWidth = 1
        CharacterView.layer.borderColor = UIColor.white.cgColor
        
        
        
        SelectedChest = W_Chest
        SelectedArmLeft = W_ArmLeft
        SelectedArmRight = W_ArmRight
        SelectedLegLeft = W_LegLeft
        SelectedLegRight = W_LegRight
        SelectedHead = W_Head
        SelectedHair = W_Hair_Brown
        SelectedMouth = W_Mouth
        SelectedEyes = EyesBlack
        
        
        
        
        self.collectionView1.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView1.backgroundColor = UIColor.clear
        self.collectionView1.reloadData()

        self.collectionView2.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView2.backgroundColor = UIColor.clear
        self.collectionView2.reloadData()
        
        self.collectionView3.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView3.backgroundColor = UIColor.clear
        self.collectionView3.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func GetSkinTraits() {
        
        SkinTraitArray.append(BodyTraitColorInfo(colorName: "White", color: UIColor(red: 251/255, green: 187/255, blue: 132/255, alpha: 1), traitName: "skin"))
        
        SkinTraitArray.append(BodyTraitColorInfo(colorName: "Brown", color: UIColor(red: 64/255, green: 33/255, blue: 16/255, alpha: 1), traitName: "skin"))
        
        SkinTraitArray.append(BodyTraitColorInfo(colorName: "Tan", color: UIColor(red: 194/255, green: 151/255, blue: 96/255, alpha: 1), traitName: "skin"))
        
        
    }
    
    func GetEyeTraits() {
        
        EyeTraitArray.append(BodyTraitColorInfo(colorName: "Black", color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), traitName: "eye"))
        
        EyeTraitArray.append(BodyTraitColorInfo(colorName: "Brown", color: UIColor(red: 64/255, green: 33/255, blue: 16/255, alpha: 1), traitName: "eye"))
        
        EyeTraitArray.append(BodyTraitColorInfo(colorName: "Blue", color: UIColor(red: 49/255, green: 40/255, blue: 210/255, alpha: 1), traitName: "eye"))
        
        EyeTraitArray.append(BodyTraitColorInfo(colorName: "Green", color: UIColor(red: 36/255, green: 155/255, blue: 59/255, alpha: 1), traitName: "eye"))
        
    }
    
    func GetHairTraits() {
        
        HairTraitArray.append(BodyTraitColorInfo(colorName: "Black", color: UIColor(red: 0/255, green:  0/255, blue: 0/255, alpha: 1), traitName: "hair"))
        
        HairTraitArray.append(BodyTraitColorInfo(colorName: "Brown", color: UIColor(red: 64/255, green: 33/255, blue: 16/255, alpha: 1), traitName: "hair"))
        
        HairTraitArray.append(BodyTraitColorInfo(colorName: "Light Brown", color: UIColor(red: 184/255, green: 102/255, blue: 54/255, alpha: 1), traitName: "hair"))
        
        HairTraitArray.append(BodyTraitColorInfo(colorName: "Gray", color: UIColor(red: 55/255, green: 58/255, blue: 66/255, alpha: 1), traitName: "hair"))
        
        HairTraitArray.append(BodyTraitColorInfo(colorName: "Red", color: UIColor(red: 184/255, green: 55/255, blue: 16/255, alpha: 1), traitName: "hair"))
        
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
    
    
    
    /*
    @IBAction func SetSkinBlack(sender: AnyObject) {
        
        SetSkinTone("black")
    }
    
    @IBAction func SetSkinWhite(sender: AnyObject) {
        
        SetSkinTone("white")
    }
    
    @IBAction func SetSkinTan(sender: AnyObject) {
        
        SetSkinTone("tan")
    }
    
    
    @IBAction func SetEyesBlue(sender: AnyObject) {
        
        SetEyeColor("blue")
    }
    
    @IBAction func SetEyesGreen(sender: AnyObject) {
        
        SetEyeColor("green")
    }
    
    @IBAction func SetEyesBrown(sender: AnyObject) {
        
        SetEyeColor("brown")
    }
    
    @IBAction func SetEyesBlack(sender: AnyObject) {
        
        SetEyeColor("black")
    }
    
    
    
    @IBAction func SetHairOrange(sender: AnyObject) {
        
        SetHairColor("orange")
    }
    
    
    @IBAction func SetHairGray(sender: AnyObject) {
        
        SetHairColor("gray")
    }
    
    @IBAction func SetHairLightBrown(sender: AnyObject) {
        
        SetHairColor("lightbrown")
    }
    
    @IBAction func SetHairBrown(sender: AnyObject) {
        
        SetHairColor("brown")
    }
    
    @IBAction func SetHairBlack(sender: AnyObject) {
        
        SetHairColor("black")
    }
    
    func SetEyeColor(eyeColor: String) {
        
        switch eyeColor {
        case "green":
            self.Body_Eyes.image = EyesGreen
            SelectedEyes = EyesGreen
        
        case "black":
            self.Body_Eyes.image = EyesBlack
          SelectedEyes = EyesBlack
            
        case "blue":
            self.Body_Eyes.image = EyesBlue
            SelectedEyes = EyesBlue
        
        case "brown":
            self.Body_Eyes.image = EyesBrown
            SelectedEyes = EyesBrown
            
            
        default:
            break
        }
        
        
        
    }

    func SetHairColor(hairColor: String) {
        
        switch hairColor {
        case "orange":
            self.Body_Hair.image = HairOrange
            SelectedHair = HairOrange
            
        case "gray":
            self.Body_Hair.image = HairGray
            SelectedHair = HairGray
            
        case "lightbrown":
            self.Body_Hair.image = HairLightBrown
            SelectedHair = HairLightBrown
            
        case "brown":
            self.Body_Hair.image = HairBrown
            SelectedHair = HairBrown
            
            
        default:
            break
        }
        
        
        
    }
    
    
    func SetSkinTone(skinColor: String) {
        
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
            
            
            
            SelectedChest = W_Chest
            SelectedArmLeft = W_ArmLeft
            SelectedArmRight = W_ArmRight
            SelectedLegLeft = W_LegLeft
            SelectedLegRight = W_LegRight
            SelectedHead = W_Head
            SelectedHair = W_Hair_Brown
            SelectedMouth = W_Mouth
            SelectedEyes = EyesBlack
            
            
            
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
            
            
            
            SelectedChest = B_Chest
            SelectedArmLeft = B_ArmLeft
            SelectedArmRight = B_ArmRight
            SelectedLegLeft = B_LegLeft
            SelectedLegRight = B_LegRight
            SelectedHead = B_Head
            SelectedHair = B_Hair_Brown
            SelectedMouth = B_Mouth
            SelectedEyes = EyesBlack
            
        case "tan":
            
            self.Body_Chest.image = T_Chest
            self.Body_Head.image = T_Head
            self.Body_Hair.image = T_Hair_Brown
            self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = T_LegLeft
            self.Body_Leg_Right.image = T_LegRight
            self.Body_Arm_Left.image = T_ArmLeft
            self.Body_Arm_Right.image = T_ArmRight
            //  self.Body_Hand_Left.image = W_HandLeft
            //  self.Body_Hand_Right.image = W_HandRight
            self.Body_Mouth.image = T_Mouth
            
            
            
            SelectedChest = T_Chest
            SelectedArmLeft = T_ArmLeft
            SelectedArmRight = T_ArmRight
            SelectedLegLeft = T_LegLeft
            SelectedLegRight = T_LegRight
            SelectedHead = T_Head
            SelectedHair = T_Hair_Brown
            SelectedMouth = T_Mouth
            SelectedEyes = EyesBlack
            
            
        default:
            break
        }
        
        
        
    }
    
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNext" {
            
            if let CreateViewController = segue.destination as? CreatePlayerCareerViewController {
                //  let WeaponsViewController = segue.destinationViewController as? WeaponsViewController //UIViewController
                CreateViewController.SelectedChest = self.SelectedChest
                CreateViewController.SelectedArmLeft = self.SelectedArmLeft
                CreateViewController.SelectedArmRight = self.SelectedArmRight
                CreateViewController.SelectedLegLeft = self.SelectedLegLeft
                CreateViewController.SelectedLegRight = self.SelectedLegRight
                CreateViewController.SelectedHead = self.SelectedHead
                CreateViewController.SelectedHair = self.SelectedHair
                CreateViewController.SelectedMouth = self.SelectedMouth
                CreateViewController.SelectedEyes = self.SelectedEyes

                
            }
            
        }
    }
    
    /*
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "BasicItemCollectionViewCellHeader", forIndexPath: indexPath) as! BasicItemCollectionViewCellHeader
            
            return headerView
        default:
            assert(false, "unexpected element kind")
            
            
        }
    }
    
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        if collectionView == collectionView1 {
                    return SkinTraitArray.count
        } else if collectionView == collectionView2 {
                    return HairTraitArray.count
        } else {
                    return EyeTraitArray.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicItemCollectionCell", for: indexPath) as! BasicItemCollectionViewCell
        
        var TraitSelected: BodyTraitColorInfo
        
        
        
        if collectionView == collectionView1 {
            TraitSelected = SkinTraitArray[indexPath.row]
            cell.theButton.tag = indexPath.row
            cell.theButton.addTarget(self, action: #selector(CreatePlayerViewController.UpdateTraitSelectedSkin(_:)), for: UIControl.Event.touchUpInside)
            
        } else if collectionView == collectionView2 {
            
            TraitSelected = HairTraitArray[indexPath.row]
            cell.theButton.tag = indexPath.row
            cell.theButton.addTarget(self, action: #selector(CreatePlayerViewController.UpdateTraitSelectedHair(_:)), for: UIControl.Event.touchUpInside)
            
        } else {
            TraitSelected = EyeTraitArray[indexPath.row]
            
            cell.theButton.tag = indexPath.row
            cell.theButton.addTarget(self, action: #selector(CreatePlayerViewController.UpdateTraitSelectedEye(_:)), for: UIControl.Event.touchUpInside)
            
        }

        
        
        cell.BGView.layer.cornerRadius = 5
        cell.BGView.layer.borderWidth = 1
        cell.BGView.layer.borderColor = UIColor.white.cgColor
        
       
        cell.titleLBL.text = TraitSelected.colorName
        
        
        cell.colorView.backgroundColor = TraitSelected.color
        cell.colorView.layer.cornerRadius = 20
        cell.colorView.layer.borderColor = UIColor.white.cgColor
        cell.colorView.layer.borderWidth = 1
        
        
      //  cell.theButton.tag = indexPath.row
      //  cell.theButton.addTarget(self, action: "UpdateTraitSelected:", forControlEvents: UIControl.Event.TouchUpInside)
        
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

    
    @objc func UpdateTraitSelectedSkin(_ sender: AnyObject) {
        
        let row = sender.tag
        
        var TraitSelected: BodyTraitColorInfo

            TraitSelected = SkinTraitArray[row!]
        
        switch TraitSelected.colorName {
         case "White":
            
            self.Body_Chest.image = W_Chest
            self.Body_Head.image = W_Head
         //   self.Body_Hair.image = W_Hair_Brown
          //  self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = W_LegLeft
            self.Body_Leg_Right.image = W_LegRight
            self.Body_Arm_Left.image = W_ArmLeft
            self.Body_Arm_Right.image = W_ArmRight
            //  self.Body_Hand_Left.image = W_HandLeft
            //  self.Body_Hand_Right.image = W_HandRight
            self.Body_Mouth.image = W_Mouth
            
            
            
            SelectedChest = W_Chest
            SelectedArmLeft = W_ArmLeft
            SelectedArmRight = W_ArmRight
            SelectedLegLeft = W_LegLeft
            SelectedLegRight = W_LegRight
            SelectedHead = W_Head
         //   SelectedHair = W_Hair_Brown
            SelectedMouth = W_Mouth
            SelectedEyes = EyesBlack
            
        case "Brown":
            
            self.Body_Chest.image = B_Chest
            self.Body_Head.image = B_Head
            self.Body_Hair.image = B_Hair_Brown
          //  self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = B_LegLeft
            self.Body_Leg_Right.image = B_LegRight
            self.Body_Arm_Left.image = B_ArmLeft
            self.Body_Arm_Right.image = B_ArmRight
            //self.Body_Hand_Left.image = B_HandLeft
            //self.Body_Hand_Right.image = B_HandRight
            self.Body_Mouth.image = B_Mouth
            
            
            
            SelectedChest = B_Chest
            SelectedArmLeft = B_ArmLeft
            SelectedArmRight = B_ArmRight
            SelectedLegLeft = B_LegLeft
            SelectedLegRight = B_LegRight
            SelectedHead = B_Head
          //  SelectedHair = B_Hair_Brown
            SelectedMouth = B_Mouth
            SelectedEyes = EyesBlack
            
        case "Tan":
            
            self.Body_Chest.image = T_Chest
            self.Body_Head.image = T_Head
           // self.Body_Hair.image = T_Hair_Brown
           // self.Body_Eyes.image = EyesBlack
            self.Body_Leg_Left.image = T_LegLeft
            self.Body_Leg_Right.image = T_LegRight
            self.Body_Arm_Left.image = T_ArmLeft
            self.Body_Arm_Right.image = T_ArmRight
            //  self.Body_Hand_Left.image = W_HandLeft
            //  self.Body_Hand_Right.image = W_HandRight
            self.Body_Mouth.image = T_Mouth
            
            
            
            SelectedChest = T_Chest
            SelectedArmLeft = T_ArmLeft
            SelectedArmRight = T_ArmRight
            SelectedLegLeft = T_LegLeft
            SelectedLegRight = T_LegRight
            SelectedHead = T_Head
          //  SelectedHair = T_Hair_Brown
            SelectedMouth = T_Mouth
            SelectedEyes = EyesBlack
            
            
        default: break
            
        }

       
        
    }
    
    @objc func UpdateTraitSelectedHair(_ sender: AnyObject) {
        
        let row = sender.tag
        
        var TraitSelected: BodyTraitColorInfo
        
        TraitSelected = HairTraitArray[row!]

        switch TraitSelected.colorName {
        case "Red":
            self.Body_Hair.image = HairOrange
            SelectedHair = HairOrange
            
        case "Gray":
            self.Body_Hair.image = HairGray
            SelectedHair = HairGray
            
        case "Light Brown":
            self.Body_Hair.image = HairLightBrown
            SelectedHair = HairLightBrown
            
        case "Brown":
            self.Body_Hair.image = HairBrown
            SelectedHair = HairBrown
            
            
        default:
            break
        }
        
    }
    
    @objc func UpdateTraitSelectedEye(_ sender: AnyObject) {
        
        let row = sender.tag
        
        var TraitSelected: BodyTraitColorInfo
        

        TraitSelected = EyeTraitArray[row!]
        
        
        
        switch TraitSelected.colorName {
        case "Green":
            self.Body_Eyes.image = EyesGreen
            SelectedEyes = EyesGreen
            
        case "Black":
            self.Body_Eyes.image = EyesBlack
            SelectedEyes = EyesBlack
            
        case "Blue":
            self.Body_Eyes.image = EyesBlue
            SelectedEyes = EyesBlue
            
        case "Brown":
            self.Body_Eyes.image = EyesBrown
            SelectedEyes = EyesBrown
            
            
        default:
            break
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


struct BodyTraitColorInfo {
    
    var colorName: String
    var color: UIColor
    var traitName: String

    
}
