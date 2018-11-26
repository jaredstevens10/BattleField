//
//  BasicItemCollectionViewCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class BasicItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var theButton: UIButton!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var descriptionLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}



class BasicItemCollectionViewCellHeader: UICollectionReusableView {
    
  @IBOutlet weak var label: UILabel!
    
}