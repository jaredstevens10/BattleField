//
//  MissedItemsCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class MissedItemsCell: UITableViewCell {
    
    
   @IBOutlet weak var BGView: UIView!
   @IBOutlet weak var itemLBL: UILabel!
   @IBOutlet weak var itemImage: UIImageView!
    
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
