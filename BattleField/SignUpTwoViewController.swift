//
//  SignUpTwoViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/12/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//
//  SignUpTwoViewController.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/24/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class SignUpTwoViewController: UIViewController {
    
    
    @IBOutlet var txtName : UITextField!
    @IBOutlet weak var signupButton: UIButton!
    let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Name"
        
        if let font = UIFont(name: "Verdana", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
       // navigationController!.navigationBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
          navigationController!.navigationBar.barTintColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        txtName.becomeFirstResponder()
        signupButton.layer.cornerRadius = 40
        
        signupButton.layer.shadowColor = UIColor.black.cgColor
        signupButton.layer.shadowOpacity = 1
        signupButton.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        signupButton.layer.shadowRadius = 7
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBTN(_ sender: AnyObject) {
        
        
        let name: NSString = txtName.text! as NSString
        if !name.isEqual(to: "") {
            
            prefs.set(name, forKey: "FULLNAME")
            
            self.performSegue(withIdentifier: "nextsegue", sender: self)
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Missing Name"
                alertView.message = "Please enter your name"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
               
                /*
                SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Name", subTitle: "Please enter your name", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                */
                
            })
            
        }
        
        
        
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
