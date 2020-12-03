//
//  SignUpAgentViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 2/20/17.
//  Copyright © 2017 Claven Solutions. All rights reserved.
//

import UIKit
import SceneKit
import Foundation

class SignUpAgentViewController: UIViewController {
    
    
    var AgentItemsComplete = Bool()
    @IBOutlet weak var loadingView: UIView!
    
    var username = NSString()
    var email = NSString()
    
    @IBOutlet weak var SceneView: UIView!
    
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var nextBTN: UIBarButtonItem!
    
    let prefs = UserDefaults.standard
    
    var token = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.loadingView.isHidden = false
        
        self.title = "New Agent"
        
        if let font = UIFont(name: "Verdana", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        // navigationController!.navigationBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        
        if prefs.value(forKey: "USERNAME") != nil {
            username = (prefs.value(forKey: "USERNAME") as! NSString) as String as String as NSString
            email =  (prefs.value(forKey: "EMAIL") as! NSString) as String as String as NSString
            print("Email From VC = \(email)")
        } else {
            username = "UnknownUsername"
            email = "UnknownEmail"
        }
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(SignUpAgentViewController.AgentProfileComplete(_:)), name: NSNotification.Name(rawValue: "AgentProfileComplete"),  object: nil)
        
        
       // txtEmail.becomeFirstResponder()
       // signupButton.layer.cornerRadius = 40
         LoadMyPlayer()
        // Do any additional setup after loading the view.
    }
    
    @objc func AgentProfileComplete(_ notification: Notification) {
        
        
        var info = notification.userInfo
        let IsCompleteString = info!["AgentItemsComplete"] as! String
        
        var IsComplete = Bool()
        
        if IsCompleteString == "true" {
            IsComplete = true
        }
        
        AgentItemsComplete = IsComplete

        
    }
    
  
    
    
    func LoadMyPlayer() {
        //        let subViews = self.view.subviews
        //        for subview in subViews{
        //            if subview.tag == 1000 {
        //                subview.removeFromSuperview()
        //            }
        //        }
        
        let sceneSubViews = self.SceneView.subviews
        for subview in sceneSubViews{
            if subview.tag == 1000 {
                subview.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.async(execute: {
            
            
            // self.tabBarItemPlayer.isEnabled = false
            // self.tabBarItemTeam.isEnabled = false
            var wp = String()
            
            if self.prefs.value(forKey: "HOLDINGWEAPON") == nil {
                wp = "Fist"
            } else {
                wp = self.prefs.value(forKey: "HOLDINGWEAPON") as! String
            }
            
            print("wp: \(wp)")
            
            let CharacterInfoTemp = CharacterInfo(name: self.username as String, skinTone: "white", health: "100", currentWeapon: wp)
            
            
            var view = MyPlayerView.instanceFromNib(characterInfo: CharacterInfoTemp)
            view.tag = 1000
            
            self.SceneView.addSubview(view)
            self.loadingView.isHidden = true
            // self.view.addSubview(view)
        })
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closeBTN(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    func CheckEmail(_ email: String) -> Bool {
//        
//        var isOk = Bool()
//        
//        var post:NSString = "email=\(email)&setting=checkemail" as NSString
//        
//        NSLog("PostData: %@",post);
//        
//        var url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/GameSignUp.php")!
//        
//        var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
//        
//        var postLength:NSString = String( postData.count ) as NSString
//        
//        var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = postData
//        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        
//        var reponseError: NSError?
//        var response: URLResponse?
//        
//        //var urlData = NSData()
//        
//        var urlData: Data?
//        do {
//            urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
//        } catch let error as NSError {
//            reponseError = error
//            urlData = nil
//        }
//        
//        
//        if ( urlData != nil ) {
//            let res = response as! HTTPURLResponse!;
//            
//            //  NSLog("Response code: %ld", res?.statusCode);
//            
//            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
//            {
//                var responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
//                
//                NSLog("Response ==> %@", responseData);
//                
//                var error: NSError?
//                
//                let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
//                
//                
//                let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
//                
//                //  let uniqueIDtemp: NSInteger = jsonData.valueForKey("uniqueID") as! NSInteger
//                //  let uniqueID = uniqueIDtemp.description
//                //[jsonData[@"success"] integerValue];
//                
//                NSLog("Success: %ld", success);
//                
//                if(success == 1)
//                {
//                    isOk = true
//                    print("Email is available")
//                    
//                    
//                } else {
//                    
//                    isOk = false
//                    
//                    /*
//                     var error_msg:NSString
//                     
//                     if jsonData["error_message"] as? NSString != nil {
//                     error_msg = jsonData["error_message"] as! NSString
//                     } else {
//                     error_msg = "Unknown Error"
//                     }
//                     var alertView:UIAlertView = UIAlertView()
//                     alertView.title = "Sign Up Failed!"
//                     alertView.message = error_msg as String
//                     alertView.delegate = self
//                     alertView.addButtonWithTitle("OK")
//                     // alertView.show()
//                     
//                     dispatch_async(dispatch_get_main_queue(),{
//                     
//                     
//                     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
//                     
//                     })
//                     */
//                    
//                }
//                
//            } else {
//                DispatchQueue.main.async(execute: {
//                    
//                    let alertView:UIAlertView = UIAlertView()
//                    alertView.title = "Error!"
//                    alertView.message = "The Connection Failed"
//                    alertView.delegate = self
//                    alertView.addButton(withTitle: "OK")
//                    alertView.show()
//                    
//                    /*
//                     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
//                     */
//                    
//                })
//            }
//        }  else {
//            DispatchQueue.main.async(execute: {
//                
//                let alertView:UIAlertView = UIAlertView()
//                alertView.title = "Error!"
//                alertView.message = "Please check your internet connection"
//                alertView.delegate = self
//                alertView.addButton(withTitle: "OK")
//                alertView.show()
//                
//                /*
//                 SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
//                 
//                 */
//                
//            })
//        }
//        
//        
//        return isOk
//    }
    
    
    @IBAction func nextSegueBTN(_ sender: Any) {
        
        
        if prefs.bool(forKey: "NewAgentBodyComplete") {
            if prefs.bool(forKey: "NewAgentSkillsComplete") {
                if prefs.bool(forKey: "NewAgentAttributesComplete") {
                   AgentItemsComplete = true
                } else {
                    
                    let title = "New Agent"
                    let message = "Please complete the allocation of your Agent attributes."
                    let reference = ""
                    
                    DispatchQueue.main.async(execute: {
                        let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                        view.tag = 1000
                        self.view.addSubview(view)
                    })
                    
                }
            } else {
                
                
                let title = "New Agent"
                let message = "Please review your current skills."
                let reference = ""
                
                DispatchQueue.main.async(execute: {
                    let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                    view.tag = 1000
                    self.view.addSubview(view)
                })
                
                
            }
        } else {
            
            
            
            let title = "New Agent"
            let message = "Please complete your physical modifications."
            let reference = ""
            
            DispatchQueue.main.async(execute: {
                let view = MessageView.instanceFromNib(title: title, message: message, reference: reference)
                view.tag = 1000
                self.view.addSubview(view)
            })
            
            
        }
        
        
        
        
        
        if AgentItemsComplete {
        
        self.performSegue(withIdentifier: "nextsegue", sender: self)
        
        }
        
//        else {
//            
//            
//            DispatchQueue.main.async(execute: {
//                
//                
//                let alertView:UIAlertView = UIAlertView()
//                alertView.title = "Error"
//                alertView.message = "Please complete your Agent setup."
//                alertView.delegate = self
//                alertView.addButton(withTitle: "OK")
//                alertView.show()
//                
//
//            })
//            
//            
//        }
    }
    
    
    
    @IBAction func nextBTN(_ sender: AnyObject) {
        
        let email = txtEmail.text
        let email2: NSString = txtEmail.text! as NSString
        if !email2.isEqual(to: "") {
            if ((email?.contains("@")) != nil) {
                
                prefs.set(email, forKey: "EMAILADDRESS")
                
                
                
                
                
             //   if CheckEmail(email!) {
                  if 1 == 1 {
                    
                    
                    
                    
                    self.performSegue(withIdentifier: "nextsegue", sender: self)
                    
                } else {
                    
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Email"
                        alertView.message = "This email address is already in use."
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        /*
                         SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "This Email address is already in use.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                         */
                        
                    })
                    
                }
                
            } else {
                
                DispatchQueue.main.async(execute: {
                    
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Email"
                    alertView.message = "Please enter a valid email address."
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                    /*
                     
                     SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "Please enter a valid email address", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                     */
                    
                })
                
            }
            
        } else {
            
            DispatchQueue.main.async(execute: {
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Email"
                alertView.message = "Please enter a valid email address."
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                /*
                 
                 SCLAlertView().showCustomOKSIGN(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Email", subTitle: "Please enter a valid email address", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                 */
                
            })
            
        }
        
    }
    
    /*
     @IBAction func signupTapped(sender : UIButton) {
     
     let Token = self.token
     let TokenNew2 = Token.description.stringByReplacingOccurrencesOfString("<", withString: "")
     let TokenNew3 = TokenNew2.stringByReplacingOccurrencesOfString(">", withString: "")
     let TokenNew = TokenNew3.stringByReplacingOccurrencesOfString(" ", withString: "")
     
     // var firstname:NSString = txtFirstname.text! as NSString
     // var lastname:NSString = txtLastname.text! as NSString
     // var username:NSString = txtUsername.text! as NSString
     // var password:NSString = txtPassword.text! as NSString
     // var confirm_password:NSString = txtConfirmPassword.text! as NSString
     
     var email:NSString = txtEmail.text! as NSString
     
     if ( username.isEqualToString("") || password.isEqualToString("") || firstname.isEqualToString("") || lastname.isEqualToString("") ) {
     
     dispatch_async(dispatch_get_main_queue(),{
     
     
     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please complete all the fields.", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
     
     })
     } else if ( !password.isEqual(confirm_password) ) {
     
     dispatch_async(dispatch_get_main_queue(),{
     
     
     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "The passwords do not match", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
     
     })
     } else {
     
     var base64Image = String()
     
     if ProfilePictureAdded {
     let image = self.ProfileImage.image
     
     let imageData = UIImageJPEGRepresentation(image!, 1.0)
     
     
     if MediaType == "gif" {
     
     base64Image = gifNSData.base64EncodedStringWithOptions([])
     
     } else {
     
     base64Image = imageData!.base64EncodedStringWithOptions([])
     
     }
     DoUpload = true
     }
     
     
     var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)&email=\(email)&token=\(TokenNew)&playerid=\(email)&privacy=no"
     
     NSLog("PostData: %@",post);
     
     var url:NSURL = NSURL(string: "http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/PQSignUp.php")!
     
     var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
     
     var postLength:NSString = String( postData.length )
     
     var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
     request.HTTPMethod = "POST"
     request.HTTPBody = postData
     request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
     request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
     request.setValue("application/json", forHTTPHeaderField: "Accept")
     
     
     var reponseError: NSError?
     var response: NSURLResponse?
     
     //var urlData = NSData()
     
     var urlData: NSData?
     do {
     urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
     } catch let error as NSError {
     reponseError = error
     urlData = nil
     }
     
     
     if ( urlData != nil ) {
     let res = response as! NSHTTPURLResponse!;
     
     NSLog("Response code: %ld", res.statusCode);
     
     if (res.statusCode >= 200 && res.statusCode < 300)
     {
     var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
     
     NSLog("Response ==> %@", responseData);
     
     var error: NSError?
     
     let jsonData:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers)) as! NSDictionary
     
     
     let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
     
     let uniqueIDtemp: NSInteger = jsonData.valueForKey("uniqueID") as! NSInteger
     let uniqueID = uniqueIDtemp.description
     //[jsonData[@"success"] integerValue];
     
     NSLog("Success: %ld", success);
     
     if(success == 1)
     {
     NSLog("Sign Up SUCCESS");
     prefs.setBool(true, forKey: "ISLOGGEDIN")
     
     
     if MediaType == "gif" {
     
     UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "gif")
     
     } else {
     
     print("SHOULD UPLOAD IMAGE NOW")
     print("BASE 64 DATA IS = \(base64Image)")
     UploadGameFileData(base64Image as String, FileName: "player\(uniqueID)", Type: "image")
     }
     
     
     
     
     self.dismissViewControllerAnimated(true, completion: nil)
     } else {
     var error_msg:NSString
     
     if jsonData["error_message"] as? NSString != nil {
     error_msg = jsonData["error_message"] as! NSString
     } else {
     error_msg = "Unknown Error"
     }
     var alertView:UIAlertView = UIAlertView()
     alertView.title = "Sign Up Failed!"
     alertView.message = error_msg as String
     alertView.delegate = self
     alertView.addButtonWithTitle("OK")
     // alertView.show()
     
     dispatch_async(dispatch_get_main_queue(),{
     
     
     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
     
     })
     
     
     }
     
     } else {
     dispatch_async(dispatch_get_main_queue(),{
     
     
     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
     
     })
     }
     }  else {
     dispatch_async(dispatch_get_main_queue(),{
     
     
     SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
     
     })
     }
     }
     
     }
     
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
