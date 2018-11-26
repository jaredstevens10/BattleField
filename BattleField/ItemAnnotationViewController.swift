//
//  ItemAnnotationViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

protocol ItemAnnotationViewControllerDelegate: class {
    func itemannotationViewControllerFinished(_ itemannotationViewController: ItemAnnotationViewController)
}

class ItemAnnotationViewController: UIViewController {
    
    
    @IBOutlet weak var itemLBL: UILabel!
    var itemTitle = NSString()
    var DistanceToItem = NSString()
    var itemImage = UIImage()
    @IBOutlet weak var pickUpBTN: UIButton!

    @IBOutlet weak var itemIMG: UIImageView!
    
    var itemannotationdelegate: ItemAnnotationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickUpBTN.layer.cornerRadius = 5
        pickUpBTN.layer.masksToBounds = true
        pickUpBTN.clipsToBounds = true
        itemLBL.text = itemTitle as String
        itemIMG.image = itemImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PickUpItem(_ sender: AnyObject) {
        
        let message = "\(itemTitle) picked up"
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Success!"
        alertView.message = "\(message)"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
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
