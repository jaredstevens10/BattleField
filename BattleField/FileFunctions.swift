//
//  FileFunctions.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/12/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation


func UploadGameFileData(_ imageData2: String, FileName: String, Type: String)
{
    
    
    
    let myUrl = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/UploadGameFile.php");
    //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
    
    let request = NSMutableURLRequest(url:myUrl!);
    request.httpMethod = "POST";
    
    let param = [
        "firstName"  : "Sergey",
        "lastName"    : "Kargopolov",
        "userId"    : "9"
    ]
    
    let boundary = generateBoundaryString()
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    
    // let imageData = UIImageJPEGRepresentation(UploadImage, 1)
    
    let imageData = Data(base64Encoded: imageData2 as String, options: NSData.Base64DecodingOptions(rawValue: 0))
    
    if(imageData==nil)  { return; }
    
    request.httpBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary, filenameTemp: FileName, Type: "\(Type)")
    
    
    
    //  myActivityIndicator.startAnimating();

    let task = URLSession.shared.dataTask(with: request as URLRequest) {data,response,error in
        // let task = URLSession.shared.dataTask(with: request, completionHandler: {
        //    data, response, error in
        
        if error != nil {
            print("error=\(error)")
            return
        }
        
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("****** response data = \(responseString!)")
        
        var err: NSError?
        
        do {
            var json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
        } catch {
            print("error = \(error)")
        }
        
        DispatchQueue.main.async(execute: {
            // self.myActivityIndicator.stopAnimating()
            //UploadImage = nil;
        });
        
        /*
         if let parseJSON = json {
         var firstNameValue = parseJSON["firstName"] as? String
         println("firstNameValue: \(firstNameValue)")
         }
         */
        
}


    /*
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        
        if error != nil {
            print("error=\(error)")
            return
        }
        
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8)
        print("****** response data = \(responseString!)")
        
        var err: NSError?
        
        do {
            var json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
        } catch {
            print("error = \(error)")
        }
        
        DispatchQueue.main.async(execute: {
            // self.myActivityIndicator.stopAnimating()
            // self.myImageView.image = nil;
        });
        
        /*
         if let parseJSON = json {
         var firstNameValue = parseJSON["firstName"] as? String
         println("firstNameValue: \(firstNameValue)")
         }
         */
        
    })
    
    */
    
    task.resume()
    
}



func UploadGameFile(_ UploadImage: UIImage, FileName: String, Type: String)
{
    
    let myUrl = URL(string: "http://\(ServerInfo.sharedInstance)/Apps/BattleField/UploadGameFile.php");
    //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
    
    let request = NSMutableURLRequest(url:myUrl!);
    request.httpMethod = "POST";
    
    let param = [
        "firstName"  : "Sergey",
        "lastName"    : "Kargopolov",
        "userId"    : "9"
    ]
    
    let boundary = generateBoundaryString()
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    
    let imageData = UIImageJPEGRepresentation(UploadImage, 1)
    
    if(imageData==nil)  { return; }
    
    request.httpBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary, filenameTemp: FileName, Type: "\(Type)")
    
    
    
    //  myActivityIndicator.startAnimating();
    let task = URLSession.shared.dataTask(with: request as URLRequest) {data,response,error in
        // let task = URLSession.shared.dataTask(with: request, completionHandler: {
        //    data, response, error in
        
        if error != nil {
            print("error=\(error)")
            return
        }
        
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("****** response data = \(responseString!)")
        
        var err: NSError?
        
        do {
            var json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
        } catch {
            print("error = \(error)")
        }
        
        DispatchQueue.main.async(execute: {
            // self.myActivityIndicator.stopAnimating()
            //UploadImage = nil;
        });
        
        /*
         if let parseJSON = json {
         var firstNameValue = parseJSON["firstName"] as? String
         println("firstNameValue: \(firstNameValue)")
         }
         */
        
    }//)
    
    /*
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        
        if error != nil {
            print("error=\(error)")
            return
        }
        
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8)
        print("****** response data = \(responseString!)")
        
        var err: NSError?
        
        do {
            var json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
        } catch {
            print("error = \(error)")
        }
        
        DispatchQueue.main.async(execute: {
            // self.myActivityIndicator.stopAnimating()
            //UploadImage = nil;
        });
        
        /*
         if let parseJSON = json {
         var firstNameValue = parseJSON["firstName"] as? String
         println("firstNameValue: \(firstNameValue)")
         }
         */
        
    })
    */
    
    
    task.resume()
    
}


func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String, filenameTemp: String, Type: String) -> Data {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
    }
    
    var filename = String()
    var mimetype = String()
    
    switch Type {
    case "image":
        mimetype = "image/jpg"
        filename = "\(filenameTemp).jpg"
        
    case "audio":
        mimetype = "audio/mpeg"
        filename = "\(filenameTemp).mp3"
        
        
    case "gif":
        
        mimetype = "image/gif"
        filename = "\(filenameTemp).gif"
        
        
    default:
        break
    }
    
    
    /*
     if Type == "image" {
     
     mimetype = "image/jpg"
     filename = "\(filenameTemp).jpg"
     }
     
     if Type == "audio" {
     mimetype = "audio/mpeg"
     filename = "\(filenameTemp).mp3"
     }
     
     */
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey)
    body.appendString("\r\n")
    
    
    
    body.appendString("--\(boundary)--\r\n")
    
    return body as Data
}




func generateBoundaryString() -> String {
    return "Boundary-\(UUID().uuidString)"
}


extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


func CreateImagePHP (_ GameID: NSString, mediaType: NSString, turnNumber: NSString) -> Bool {
    
    var isSuccess = Bool()
    
    let post:NSString = "gameid=\(GameID)&mediatype=\(mediaType)&turnnumber=\(turnNumber)" as NSString
    
   // NSLog("PostData: %@",post);
    print("Creating PHP Image File from Template")
    
    let url:URL = URL(string:"http://\(ServerInfo.sharedInstance)/Apps/TelePictionary/CreateHTMLforImage.php")!
    
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
            
            if success == 1 {
                isSuccess = true
            }
            
            //[jsonData[@"success"] integerValue];
            
            //  NSLog("Success: %ld", success);
            
            //Admin = jsonData.valueForKey("admin") as! NSString
            
            
            /*
             if(success == 1)
             {
             //  NSLog("Member Found - Success");
             
             //   let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
             
             // prefs.setObject(user, forKey: "USERNAME")
             
             //   prefs.setInteger(1, forKey: "ISLOGGEDIN")
             //   prefs.synchronize()
             
             //  prefs.setValue(Admin, forKey: "ADMIN")
             
             // self.dismissViewControllerAnimated(true, completion: nil)
             } else {
             // var error_msg:NSString
             
             
             
             
             
             }
             */
        } else {
            
        }
    } else {
        
    }
    return isSuccess
}




func requestImage(_ url: String, success: @escaping (UIImage?) -> Void) {
    requestURL(url, success: { (data) -> Void in
        if let d = data {
            success(UIImage(data: d))
        }
    })
}

func requestURL(_ url: String, success: @escaping (Data?) -> Void, error: ((NSError) -> Void)? = nil) {
    NSURLConnection.sendAsynchronousRequest(
        URLRequest(url: URL (string: url)!),
        queue: OperationQueue.main,
        completionHandler: { response, data, err in
            if let e = err {
                error?(e as NSError)
            } else {
                success(data)
            }
    })
}

func fileExists(_ url : URL!) -> Bool {
    
    let req = NSMutableURLRequest(url: url)
    req.httpMethod = "HEAD"
    req.timeoutInterval = 1.0 // Adjust to your needs
    
    var response : URLResponse?
    var responseError: NSError?
    
    do {
        try NSURLConnection.sendSynchronousRequest(req as URLRequest, returning:&response)
    } catch let error as NSError {
        responseError = error
        // urlData = nil
    }
    
    //NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: nil)
    
    return ((response as? HTTPURLResponse)?.statusCode ?? -1) == 200
}
