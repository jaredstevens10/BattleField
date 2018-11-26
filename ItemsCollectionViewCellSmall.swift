//
//  ItemsCollectionViewCellSmall.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/4/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class ItemsCollectionViewCellSmall: UICollectionViewCell {
    
    @IBOutlet weak var lockViewBG: UIView!
    @IBOutlet weak var lockView: UIView!
    
    @IBOutlet weak var levelLBL: UILabel!
    @IBOutlet weak var ammoLBL: UILabel!
    
    @IBOutlet weak var costLBL: UILabel!
    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemDesc: UILabel!
    
    @IBOutlet weak var costViewLBL: UILabel!
    @IBOutlet weak var costViewBTN: UIButton!
    
    @IBOutlet weak var itemPowerLBL: UILabel!
    @IBOutlet weak var itemSpeedLBL: UILabel!
    @IBOutlet weak var itemRangeLBL: UILabel!
    
    @IBOutlet weak var useView: UIView!
    @IBOutlet weak var useBTN: UIButton!
    @IBOutlet weak var useLBL: UILabel!
    
    @IBOutlet weak var upgradeTimerLBL: UILabel!
    
    @IBOutlet weak var costView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        BGView.layer.cornerRadius = 5
        BGView.layer.masksToBounds = true
        BGView.clipsToBounds = true
        
        useView.layer.cornerRadius = 5
        useView.layer.masksToBounds = true
        useView.clipsToBounds = true
        
        imageView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 1
        BGView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        BGView.layer.borderWidth = 2
        /*
        infoView.layer.cornerRadius = 5
        infoView.layer.masksToBounds = true
        infoView.clipsToBounds = true
        */
        
        infoView.layer.backgroundColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor

        costView.layer.cornerRadius = 5
        costView.layer.masksToBounds = true
        costView.clipsToBounds = true
        
        
        // Initialization code
    }

    
   

}
