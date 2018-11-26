//
//  ItemsCollectionViewCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/3/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemDesc: UILabel!
    
    @IBOutlet weak var alertBTN: UIButton!
    
    @IBOutlet weak var itemPowerLBL: UILabel!
    @IBOutlet weak var itemSpeedLBL: UILabel!
    @IBOutlet weak var itemRangeLBL: UILabel!
    
    @IBOutlet weak var lockedView: UIView!
    @IBOutlet weak var costView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        BGView.layer.cornerRadius = 5
        BGView.layer.masksToBounds = true
        BGView.clipsToBounds = true
        BGView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        BGView.layer.borderWidth = 2
        
        lockedView.layer.cornerRadius = 5
        lockedView.layer.masksToBounds = true
        lockedView.clipsToBounds = true
        //lockedView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        //lockedView.layer.borderWidth = 2
        
        infoView.layer.cornerRadius = 5
        infoView.layer.masksToBounds = true
        infoView.clipsToBounds = true
        
        costView.layer.cornerRadius = 5
        costView.layer.masksToBounds = true
        costView.clipsToBounds = true

        
        // Initialization code
    }

}
