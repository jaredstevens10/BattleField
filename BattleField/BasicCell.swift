//
//  BasicCell.swift
//  BattleField
//
//  Created by Jared Stevens on 7/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet weak var TableViewCell: UIView!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var TableImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
