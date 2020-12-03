//
//  LoginViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LoginViewController: UIViewController, CLLocationManagerDelegate {

    var prefs:UserDefaults = UserDefaults.standard
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    var LocManager = CLLocationManager()
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    
    @IBOutlet weak var resetPW: UIButton!
    
    var Admin = NSString()
    var Email = NSString()
    
     var TrackingOn = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
      //  signupButton.layer.cornerRadius = 10
      //  loginButton.layer.cornerRadius = 10
        
      //  loginButton.layer.borderWidth = 2
      //  signupButton.layer.borderWidth = 2
      //  loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        resetPW.layer.masksToBounds = true
        resetPW.layer.cornerRadius = 20
        resetPW.clipsToBounds = true
        
   
        loginButton.layer.cornerRadius = 40
        signupButton.layer.cornerRadius = 25
        
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        loginButton.layer.shadowRadius = 7
        
        
        signupButton.layer.shadowColor = UIColor.black.cgColor
        signupButton.layer.shadowOpacity = 1
        signupButton.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        signupButton.layer.shadowRadius = 7
        
        resetPW.layer.shadowColor = UIColor.black.cgColor
        resetPW.layer.shadowOpacity = 1
        resetPW.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        resetPW.layer.shadowRadius = 7
        
        txtUsername.layer.shadowColor = UIColor.black.cgColor
        txtUsername.layer.shadowOpacity = 1
        txtUsername.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        txtUsername.layer.shadowRadius = 7
        
        txtPassword.layer.shadowColor = UIColor.black.cgColor
        txtPassword.layer.shadowOpacity = 1
        txtPassword.layer.shadowOffset = CGSize(width: 5, height: 5) //CGSize.zero
        txtPassword.layer.shadowRadius = 7
        
        //signupButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkLocationAuthorizationStatus(_ manager: CLLocationManager!, status: CLAuthorizationStatus) -> Bool {
        switch status {
        case .authorizedAlways:
            print("Authorized")
            prefs.set(true, forKey: "TRACKINGON")
            return true
        case .authorizedWhenInUse, .denied, .restricted:
            return false
        case .notDetermined:
            print("NotDetermined")
            manager.requestAlwaysAuthorization()
        default:
            print("Default")
            return false
        }
        return false
    }
    
    
    
    
    @IBAction func ForgotPW(_ sender: AnyObject) {
        username = "testuser"
        // var password:NSString = txtPassword.text
        // let username: NSString = txtUsername.text!
        let password: NSString = txtPassword.text! as NSString
        let email: NSString = txtUsername.text! as NSString
        
        
        if ( email.isEqual(to: "") ) {
            
            DispatchQueue.main.async(execute: {
                
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Please enter Email and Password"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
                /*
                
                SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please enter your email address", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                
                */
                
            })
        } else {
            
            let post:NSString = "email=\(email)" as NSString
            
            NSLog("PostData: %@",post);
            
            let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/reset.php")!
            
            print("URL entered")
            
            let postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            
            let postLength:NSString = String( postData.count ) as NSString
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: URLResponse?
            
            var urlData: Data?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                
              //  NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData!, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    //Admin = jsonData.valueForKey("admin") as! NSString
                    
                    
                    
                    if(success == 1)
                    {
                        NSLog("Login SUCCESS");
                        
                        let prefs:UserDefaults = UserDefaults.standard
                        
                        //prefs.setObject(username, forKey: "USERNAME")
                        
                        DispatchQueue.main.async(execute: {
                            
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Password"
                            //alertView.message = "Sign in Error"
                            alertView.message = "Please check your email for instructions on how to reset your password"
                            alertView.delegate = self
                            alertView.addButton(withTitle: "OK")
                             alertView.show()
                            
                            /*
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Password", subTitle: "Please check your email for instructions to reset your password", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                            
                            */
                            
                        })
                        
                        // prefs.setInteger(1, forKey: "ISLOGGEDIN")
                        //   prefs.setBool(true, forKey: "ISLOGGEDIN")
                        //    prefs.synchronize()
                        
                        //  prefs.setValue(Admin, forKey: "ADMIN")
                        
                        //  Email = jsonData.valueForKey("email") as! NSString
                        
                        //    prefs.setValue(Email, forKey: "EMAIL")
                        
                        //    prefs.setValue(username, forKey: "USERNAME")
                        
                        //    self.dismissViewControllerAnimated(true, completion: nil)
                        print("sync view dismissed")
                        
                    } else {
                        var error_msg:NSString
                        
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        //alertView.message = "Sign in Error"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        // alertView.show()
                        
                        // txtEmail.text = ""
                        // txt
                        
                        DispatchQueue.main.async(execute: {
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign in Failed!"
                            alertView.message = "Please enter Email and Password"
                            alertView.delegate = self
                            alertView.addButton(withTitle: "OK")
                            alertView.show()
                            
                            /*
                            
                            SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "\(error_msg)", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                            
                            */
                            
                        })
                        
                        
                    }
                    
                } else {
                    DispatchQueue.main.async(execute: {
                        
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = "Please enter Email and Password"
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        /*
                        SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error!", subTitle: "The Connection Failed", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                        
                        */
                        
                    })
                }
            } else {
                
                DispatchQueue.main.async(execute: {
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Please enter Email and Password"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                    /*
                    SCLAlertView().showCustomOK(UIImage(named: "howtoIcon.png")!, color: UIColor(red: 0.9647, green: 0.34117, blue: 0.42745, alpha: 1.0), title: "Error", subTitle: "Please check your internet connection", duration: nil, completeText: "Ok", style: .Custom, colorStyle: 1, colorTextButton: 1)
                    
                    */
                    
                })
                
            }
        }
        
    }
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signinTapped(_ sender : UIButton) {
        var username = "testuser"
        //var username:NSString = txtUsername!.text!
        var password:NSString = txtPassword!.text! as NSString
        var email:NSString = txtUsername!.text! as NSString
        
        
        if ( email.isEqual(to: "") || password.isEqual(to: "") ) {
            /*
            var alertView = JSSAlertView().show(self, title: "Sign In Failed", text: "Please enter Username and Password", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
            alertView.setTextTheme(.Light)
            */
            
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Email and Password"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
            
        } else {
            
            var post:NSString = "username=\(username)&password=\(password)&email=\(email)" as NSString
            
            NSLog("PostData: %@",post);
            
            var url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/BattleField/GameLogin.php")!
            
            var postData:Data = post.data(using: String.Encoding.ascii.rawValue)!
            
            var postLength:NSString = String( postData.count ) as NSString
            
            var request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: URLResponse?
            
            var urlData = Data()
            
            urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                
              //  NSLog("Response code: %ld", res?.statusCode);
                
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    var responseData:NSString  = NSString(data:urlData, encoding:String.Encoding.utf8.rawValue)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = (try! JSONSerialization.jsonObject(with: urlData, options:JSONSerialization.ReadingOptions.mutableContainers )) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                    
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    
                    
                    if(success == 1)
                    {
                        NSLog("Login SUCCESS");
                        
                        
                        // let admin:NSString = jsonData.valueForKey("admin") as! NSString
                        
                        //Admin = jsonData.valueForKey("admin") as! NSString
                        
               //         
                        //var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        var Email = jsonData.value(forKey: "email") as! NSString
                        
                         let theUsername = jsonData.value(forKey: "theusername") as! NSString
                        
                        prefs.set(Email, forKey: "EMAIL")
                        print("Saving Email as \(Email)")
                        
                        
                        prefs.set(theUsername, forKey: "USERNAME")
                        prefs.set(1, forKey: "ISLOGGEDIN")
                        prefs.synchronize()
                        
                    //    prefs.setValue(Admin, forKey: "ADMIN")
                        
                     //   prefs.setValue(Email, forKey: "EMAIL")
                        
                        
                        
                        TrackingOn = checkLocationAuthorizationStatus(LocManager, status: CLLocationManager.authorizationStatus() )
                        
                        prefs.set(TrackingOn, forKey: "TRACKINGON")
                        
                        print("TRACKING ON - LOGIN = \(prefs.bool(forKey: "TRACKINGON"))")
                        
                        DispatchQueue.main.async(execute: {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                            
                        })
                        
                    } else {
                        var error_msg:NSString
                        
                        /*
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertview = JSSAlertView().show(self, title: "Sign in Failed", text: error_msg as String, buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                        alertview.setTextTheme(.Light)
                        */
                        
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        //alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButton(withTitle: "OK")
                        alertView.show()
                        
                        
                    }
                    
                } else {
                    
                    var alertview = JSSAlertView().show(self, title: "Sign in Failed", text: "Connection Failed", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                    alertview.setTextTheme(.light)
                    
                    
                }
            } else {
                /*
                var alertview = JSSAlertView().show(self, title: "Sign In Failed", text: "Connection Failure", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                alertview.setTextTheme(.Light)
                */
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}
