//
//  ItemsCell.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class ItemsCell: UITableViewCell {

    
    @IBOutlet weak var segmentControl: ADVSegmentedControl!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var dropBTN: UIButton!
    
    @IBOutlet weak var TableViewCell: UIView!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var TableImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoView2: UIView!
    
     @IBOutlet weak var levelUpCostLBL: UILabel!
    @IBOutlet weak var levelUpBTN: UIButton!
    
     @IBOutlet weak var itemInfoBTN: UIButton!
    
    @IBOutlet weak var ammoLBL: UILabel!
    @IBOutlet weak var addAmmoBTN: UIButton!
    
    @IBOutlet weak var ammoIMG: UIImageView!
    @IBOutlet weak var levelLBL: UILabel!
    @IBOutlet weak var countLBL: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var userLBLView: UIView!
    @IBOutlet weak var distanceLBL: UILabel!
    
    @IBOutlet weak var replyBTN: UIButton!
    
    
    @IBOutlet weak var mapBTN: UIButton!
    @IBOutlet weak var targetImage: UIImageView!
    
    @IBOutlet weak var CompletedView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
