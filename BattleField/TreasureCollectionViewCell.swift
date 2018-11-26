//
//  TreasureCollectionViewCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/13/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import StoreKit

class TreasureCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var GrayBGView: UIView!
    @IBOutlet weak var purchaseBTN: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemDesc: UILabel!
    
    
    
    
    func setSelected(_ selected: Bool, animated: Bool) {
        self.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var buyButtonHandler: ((_ product: SKProduct) -> ())?
    
    var product: SKProduct? {

        didSet {
            guard let product = product else {
                print("PRODUCT HANDLER: Product does not equal product")
                return
            }
            
            
            print("PRODUCT HANDLER: Product Handler Started")
            itemName?.text = product.localizedTitle
            
            if RageProducts.store.isProductPurchased(product.productIdentifier) {
               // accessoryType = .Checkmark
             //   accessoryView = nil
             //   detailTextLabel?.text = ""
            } else if IAPHelper.canMakePayments() {
                TreasureCollectionViewCell.priceFormatter.locale = product.priceLocale
             //   detailTextLabel?.text = TreasureTableViewCell.priceFormatter.stringFromNumber(product.price)
                
             //   accessoryType = .None
             //   accessoryView = self.newBuyButton()
            } else {
             //   detailTextLabel?.text = "Not available"
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemName?.text = ""
       // detailTextLabel?.text = ""
       // accessoryView = nil
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        BGView.layer.cornerRadius = 5
        BGView.layer.masksToBounds = true
        BGView.clipsToBounds = true
        BGView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        BGView.layer.borderWidth = 2
        
        GrayBGView.layer.cornerRadius = 5
        GrayBGView.layer.masksToBounds = true
        GrayBGView.clipsToBounds = true
        GrayBGView.layer.borderColor = UIColor(red: 60/255, green: 160/255, blue: 209/255, alpha: 1.0).cgColor
        GrayBGView.layer.borderWidth = 2
        
        purchaseBTN.layer.cornerRadius = 5
        purchaseBTN.layer.masksToBounds = true
        purchaseBTN.clipsToBounds = true
        // Initialization code
    }

}
