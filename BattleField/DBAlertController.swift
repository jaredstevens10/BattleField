//
//  DBAlertController.swift
//  BattleField
//
//  Created by Jared Stevens on 8/5/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

class DBAlertController: UIAlertController {
    
    fileprivate lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindowLevelAlert + 1
        return window
    }()
    
    /*
: param: flag pass ture to animate the presentation
: param:
 */    
    func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController!.present(self, animated: flag, completion: completion)
    }
}
