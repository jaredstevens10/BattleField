//
//  CharacterStatsViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CharacterStatsViewController: UIViewController {
    
    var theJobTitle = String()
     var theJobDescription = String()
    var theJobImage = UIImage()
    
    @IBOutlet weak var jobImage: UIImageView!
    
    @IBOutlet weak var jobTitleLBL: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        jobTitleLBL.text = theJobTitle
        jobImage.image = theJobImage
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func CloseBTN(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
