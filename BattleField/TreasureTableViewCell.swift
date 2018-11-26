//
//  TreasureTableViewCell.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/13/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class TreasureTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let DiamondsImage = [UIImage(named: "diamond100.png")!,UIImage(named: "bagDiamonds10.png")!,UIImage(named: "ChestDiamondsIMG.png")!]
    
    //let DiamondsImage = [UIImage(named: "diamond100.png")!,UIImage(named: "bagDiamonds10.png")!,UIImage(named: "bagDiamonds10.png")!,UIImage(named: "ChestDiamondsIMG.png")!]
    
    @IBOutlet weak var collectionViewLEAD: NSLayoutConstraint!
    
    var device = UIScreen.main.bounds
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var TotalItems = Int()
    var TotalItemsArray = [NSString]()
    
    var UpgradeItemsLBLArray = [String]()
    var SavedItemsInventory = [NSManagedObject]()
    
    var itemImages = [UIImage]()
    var itemImagesName = [String]()
    
    var products = [SKProduct]()
    
   // var product = SKProduct()
    
    //  var isOpen = Bool()
    
    // @IBOutlet weak var hideBTN: UIButton!
    // @IBOutlet weak var BGView: UIView!
    
    
    let dirpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        
      //  return UpgradeItemsLBLArray.count
        return products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TreasureCell", for: indexPath) as! TreasureCollectionViewCell
        
        
        let product = products[indexPath.row]
        
        
       // var itemTemp : ItemInventorySorted
        
       // itemTemp = TotalItemsInventoryArray[indexPath.row]
        //cell.itemName.text = UpgradeItemsLBLArray[indexPath.row]
        cell.itemName.text = product.localizedTitle
        //cell.product
        cell.itemDesc.text = product.localizedDescription
        
        
        cell.product = product
        cell.imageView.image = DiamondsImage[indexPath.row]
        print("Product = \(product)")
        cell.purchaseBTN.tag = indexPath.row
        cell.purchaseBTN.setTitle("$\(product.price)", for: UIControlState())
        cell.purchaseBTN.addTarget(self, action: #selector(TreasureTableViewCell.PurchaseDiamonds(_:)), for: UIControlEvents.touchUpInside)
        
        cell.backgroundColor = UIColor.clear
        //cell.imageView.image = UIImage(named: "knife.png")
        cell.buyButtonHandler = { product in RageProducts.store.buyProduct(product)
        }
        
        /*
        var imageName = itemTemp.imageURL100
        let url = NSURL(fileURLWithPath: dirpath).URLByAppendingPathComponent("\(imageName).png")
        // print("url for image = \(url)")
        let theImageData = NSData(contentsOfURL: url)
        
        */
        
        //TestImage = UIImage(data:theImageData!)!
        
      //  cell.imageView.image  = UIImage(data: theImageData!)!
      //  cell.itemName.text = itemTemp.name
     
        
        
        return cell
        
        
        
        
    }
    
    
    /*
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Item Selected Small"
        alertView.message = "Item \(indexPath.row) Selected"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
        
        self.removeFromSuperview()

        
    }
    */
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // RetrieveImages()
        reload()
        
        UpgradeItemsLBLArray.append("Diamond Upgrade 1")
        UpgradeItemsLBLArray.append("Diamond Upgrade 2")
        UpgradeItemsLBLArray.append("Diamond Upgrade 3")
        UpgradeItemsLBLArray.append("Diamond Upgrade 4")
        UpgradeItemsLBLArray.append("Diamond Upgrade 5")
        UpgradeItemsLBLArray.append("Diamond Upgrade 6")
        
        
        let halfW = device.width / 2
        //collectionViewLEAD.constant = halfW - 100
        
        let columnHeaderViewNIBSmall = UINib(nibName: "TreasureCollectionViewCell", bundle: nil)
        
        self.collectionView?.register(columnHeaderViewNIBSmall, forCellWithReuseIdentifier: "TreasureCell")
        
        self.collectionView.backgroundColor = UIColor.clear
        
        
        // Initialization code
    }
    
    

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
            guard let product = product else { return }
            
            textLabel?.text = product.localizedTitle
            
            if RageProducts.store.isProductPurchased(product.productIdentifier) {
                accessoryType = .checkmark
                accessoryView = nil
                detailTextLabel?.text = ""
            } else if IAPHelper.canMakePayments() {
                TreasureTableViewCell.priceFormatter.locale = product.priceLocale
                detailTextLabel?.text = TreasureTableViewCell.priceFormatter.string(from: product.price)
                
                accessoryType = .none
                accessoryView = self.newBuyButton()
            } else {
                detailTextLabel?.text = "Not available"
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        accessoryView = nil
    }
    
    func reload() {
        products = []
        
        collectionView.reloadData()
        
        RageProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
                
                self.collectionView.reloadData()
            }
            self.actInd.stopAnimating()
            //self.refreshControl?.endRefreshing()
        }
    }
    
    func newBuyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(tintColor, for: UIControlState())
        button.setTitle("Buy", for: UIControlState())
        button.addTarget(self, action: #selector(TreasureTableViewCell.buyButtonTapped(_:)), for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }
    
    func buyButtonTapped(_ sender: AnyObject) {
        buyButtonHandler?(product!)
    }
    
    
    func PurchaseDiamonds(_ sender: AnyObject) {
        print("Purchase Button Tapped")
        
        
        
        print("Product: \(product)")
        
       buyButtonHandler?(product!)
  
    }
    
    
    
    
}












public struct RageProducts {
    
    // TODO:  Change this to the BundleID chosen when registering this app's App ID in the Apple Member Center.
    fileprivate static let Prefix = "com.ClavenSolutions.BattleField."
    
    public static let BagDiamonds10 = Prefix + "diamondsbag10"
    public static let BagDiamonds50 = Prefix + "diamondsbag2_50"
    public static let BagDiamonds100 = Prefix + "diamondsbag3_100"
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [RageProducts.BagDiamonds10, RageProducts.BagDiamonds50, RageProducts.BagDiamonds100]
    
    // TODO: This is the code that would be used if you added iPhoneRage, NightlyRage, and UpdogRage to the list of purchasable
    //       products in iTunesConnect.
    /*
     public static let GirlfriendOfDrummerRage = Prefix + "GirlfriendOfDrummerRage"
     public static let iPhoneRage              = Prefix + "iPhoneRage"
     public static let NightlyRage             = Prefix + "NightlyRage"
     public static let UpdogRage               = Prefix + "UpdogRage"
     
     private static let productIdentifiers: Set<ProductIdentifier> = [RageProducts.GirlfriendOfDrummerRage,
     RageProducts.iPhoneRage,
     RageProducts.NightlyRage,
     RageProducts.UpdogRage]
     */
    public static let store = IAPHelper(productIds: RageProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> ()

open class IAPHelper : NSObject  {
    
    fileprivate let productIdentifiers: Set<ProductIdentifier>
    fileprivate var purchasedProductIdentifiers = Set<ProductIdentifier>()
    
    fileprivate var productsRequest: SKProductsRequest?
    fileprivate var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    
    static let IAPHelperPurchaseNotification = "IAPHelperPurchaseNotification"
    
    public init(productIds: Set<ProductIdentifier>) {
        self.productIdentifiers = productIds
        
        for productIdentifier in productIds {
            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
            if purchased {
                purchasedProductIdentifiers.insert(productIdentifier)
                print("Previously purchased: \(productIdentifier)")
            } else {
                print("Not purchased: \(productIdentifier)")
            }
        }
        
        super.init()
        
        SKPaymentQueue.default().add(self)
    }
}

// MARK: - StoreKit API

extension IAPHelper {
    
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct) {
        print("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
        return purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Loaded list of products...")
        let products = response.products
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
        
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    fileprivate func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                completeTransaction(transaction)
                break
            case .failed:
                failedTransaction(transaction)
                break
            case .restored:
                restoreTransaction(transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            }
        }
    }
    
    fileprivate func completeTransaction(_ transaction: SKPaymentTransaction) {
        print("completeTransaction...")
        deliverPurchaseNotificatioForIdentifier(transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func restoreTransaction(_ transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        print("restoreTransaction... \(productIdentifier)")
        deliverPurchaseNotificatioForIdentifier(productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func failedTransaction(_ transaction: SKPaymentTransaction) {
        print("failedTransaction...")
        
        if transaction.error!._code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(transaction.error?.localizedDescription)")
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    fileprivate func deliverPurchaseNotificatioForIdentifier(_ identifier: String?) {
        guard let identifier = identifier else { return }
        
        purchasedProductIdentifiers.insert(identifier)
        UserDefaults.standard.set(true, forKey: identifier)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification), object: identifier)
    }
}

