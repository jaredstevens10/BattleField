//
//  SignupViewController.swift
//  BattleField
//
//  Created by Jared Stevens on 7/28/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet var txtUsername : UITextField!
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!
    
    
    var level = NSString()
    var leveldata = NSString()
    var privacy = NSString()
    var Token = NSString()
    var deviceToken3 = Data()
    
    @IBOutlet weak var txtprivacy: UITextField!
    
    @IBOutlet var txtEmail : UITextField!
    
    var DifDropData: [String] = ["no", "yes"]
    
    let prefs:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  txtprivacy.delegate = self
       // pickerView.delegate = self
        
        signupButton.layer.cornerRadius = 10
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.borderWidth = 2
        
      //  txtprivacy.text = "no"
        
        leveldata = DifDropData[0] as NSString
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        Token = GetTokenInfo()
          //      username = prefs.valueForKey("devicetoken") as! NSString as String
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func savetoken(_ sender : UIButton) {
        
     //    MergeWithGameMembers(PLAYER as String, password: password as String, Token: FinalToken as String, PlayerID: playerid as String)
    }
    
    
    @IBAction func gotoLogin(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signupTapped(_ sender : UIButton) {
        var username:NSString = txtUsername.text! as NSString
        var password:NSString = txtPassword.text! as NSString
        var confirm_password:NSString = txtConfirmPassword.text! as NSString
        
        var email:NSString = txtEmail.text! as NSString
        
        privacy = "no"
         var urlData = Data()
        
        
        print("Token Old: \(Token)")
        
        var TokenNew2 = Token.replacingOccurrences(of: "<", with: "")
        var TokenNew = TokenNew2.replacingOccurrences(of: ">", with: "")
        //var PlayerID2 = PlayerID.stringByReplacingOccurrencesOfString(":", withString: "")
        
        print("Token - Spaces Removed: \(TokenNew)")
        
        
       // var privacy:NSString = txtprivacy.text as NSString
        
        if ( username.isEqual(to: "") || password.isEqual(to: "") ) {
            
            var alertview = JSSAlertView().show(self, title: "Sign Up Failed", text: "Please enter Username and Password", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
            alertview.setTextTheme(.light)
            
            /*
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            */
        } else if ( !password.isEqual(confirm_password) ) {
            
            var alertview = JSSAlertView().show(self, title: "Sign Up Failed", text: "Passwords do not Match", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
            alertview.setTextTheme(.light)
        } else {
            
            var post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)&email=\(email)&token=\(TokenNew)" as NSString
            
            NSLog("PostData: %@",post);
            
            var url:URL = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/GameSignUp.php")!
            
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
            
              urlData = try! NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                
             //   NSLog("Response code: %ld", res?.statusCode);
                
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
                        NSLog("Sign Up SUCCESS");
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        var alertview = JSSAlertView().show(self, title: "Sign Up Failed", text: error_msg as String, buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                        alertview.setTextTheme(.light)
                        /*
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        */
                        
                    }
                    
                } else {
                    var alertview = JSSAlertView().show(self, title: "Sign Up Failed", text: "Connection Failed", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                    alertview.setTextTheme(.light)                    }
            }  else {
                var alertview = JSSAlertView().show(self, title: "Sign Up Failed", text: "Connection Failed", buttonText: "Ok", color: UIColorFromHex(0xff6666, alpha:1))
                alertview.setTextTheme(.light)                    /*
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                */
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
       
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView.isHidden = false
        return false
    }
    
    func GetTokenInfo() -> NSString {
        
        if (prefs.value(forKey: "deviceToken") != nil) {
            deviceToken3 = prefs.value(forKey: "deviceToken") as! Data}
            
        else {
            print("error: DeviceToken was nil")
            // promptUserToRegisterPushNotifications()
            
            // let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
            // let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
            // UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            // UIApplication.sharedApplication().registerForRemoteNotifications()
            
            //application.
            //UIApplication.sharedApplication().registerForRemoteNotifications()
            //println("device token reprompted - \(deviceToken3)")
            // deviceToken3 = prefs.valueForKey("deviceToken") as! NSData
        }
        
      //  let TokenNew: NSString = deviceToken3.description.replacingOccurrences(of: " ", with: "") as NSString
        
        
        let TokenNew = deviceToken3.hex()
        print("Token New: \(TokenNew)")
        
        
     //   println("User's name is \(player)")
        print("Loging VC Device Token: \(deviceToken3)")
        
        return TokenNew as NSString
        
    }
    
    
}
