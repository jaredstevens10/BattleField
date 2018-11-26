//
//  OppStatsViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class OppStatsViewController: UIViewController {
    @IBOutlet weak var OppName: UILabel!
    var TheirName = NSString()
    var StealthStatus = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Viewing Player: \(TheirName)")
        print("Stealth Status: \(StealthStatus)")
        OppName.text = TheirName as String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CloseBTN(_ sender: AnyObject) {

        self.dismiss(animated: true, completion: nil)
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
