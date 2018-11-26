//
//  EndUserAgreementViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/12/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//
//  EndUserAgreementViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/11/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class EndUserAgreementViewController: UIViewController {
    
    
    //http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/EULA.html
    
    
    @IBOutlet var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let localfilePath = NSBundle.mainBundle().URLForResource("home", withExtension: "html");
        let url = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/Pics&Quotes/EULA.html")
        
        let myRequest = URLRequest(url: url!);
        myWebView.loadRequest(myRequest)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
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
