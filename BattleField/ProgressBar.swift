//
//  ProgressBar.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/30/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import SpriteKit

protocol ProgressBar {
    
    var node : SKNode {get}
    func setProgress(percentage: Float)
    
}
