//
//  BasicCollectionViewCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/8/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BGView: UIView!
    
    
    @IBOutlet weak var selectItemBTN: UIButton!
    
    @IBOutlet weak var countLBL: UILabel!
    @IBOutlet weak var itemIMG: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countLBL.layer.cornerRadius = 10
        BGView.layer.masksToBounds = true
        BGView.clipsToBounds = true
        // Initialization code
    }

}
