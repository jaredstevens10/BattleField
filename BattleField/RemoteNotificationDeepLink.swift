//
//  RemoteNotificationDeepLink.swift
//  BattleField
//
//  Created by Jared Stevens on 7/30/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit

let RemoteNotificationDeepLinkAppSectionKey : String = "article"

class RemoteNotificationDeepLink: NSObject {
    
    var article : String = ""
    
    class func create(_ userInfo : [AnyHashable: Any]) -> RemoteNotificationDeepLink?
    {
        let info = userInfo as NSDictionary
        
        let articleID = info.object(forKey: RemoteNotificationDeepLinkAppSectionKey) as! String
        
        print("Article ID: \(articleID)")
        
        var ret : RemoteNotificationDeepLink? = nil
        if !articleID.isEmpty
        {
            ret = RemoteNotificationDeepLinkArticle(articleStr: articleID)
        }
        return ret
    }
    
    fileprivate override init()
    {
        self.article = ""
        super.init()
    }
    
    fileprivate init(articleStr: String)
    {
        self.article = articleStr
        super.init()
    }
    
    final func trigger()
    {
        DispatchQueue.main.async
            {
                //NSLog("Triggering Deep Link - %@", self)
                self.triggerImp()
                    { (passedData) in
                        // do nothing
                }
        }
    }
    
    fileprivate func triggerImp(_ completion: ((AnyObject?)->(Void)))
    {
        
        completion(nil)
    }
}

class RemoteNotificationDeepLinkArticle : RemoteNotificationDeepLink
{
    var articleID : String!
    
    override init(articleStr: String)
    {
        self.articleID = articleStr
        super.init(articleStr: articleStr)
        print("ArticleStr: \(articleID)")
    }
    
    fileprivate override func triggerImp(_ completion: ((AnyObject?)->(Void)))
    {
        super.triggerImp()
            { (passedData) in
                
                var vc = UIViewController()
                
                // Handle Deep Link Data to present the Article passed through
                
                if self.articleID == "A"
                {
             //       vc = MyGamesViewController()
                    print("sent to my games VC")
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Artilce A"
                    alertView.message = "You are led to My Games"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                    
                }
                else if self.articleID == "B"
                {
           //         vc = ImageViewController()
                    print("Sent to Image VC")
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Artilce B"
                    alertView.message = "You are led ImageView"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
                else if self.articleID == "C"
                {
             //       vc = MyFriendsViewController()
                    print("Sent to My friends VC")
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Artilce C"
                    alertView.message = "You are led to My Friends"
                    alertView.delegate = self
                    alertView.addButton(withTitle: "OK")
                    alertView.show()
                }
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
             //   appDelegate.window?.addSubview(vc.view)
                
                
                completion(nil)
        }
    }
    
    
    
}
