//
//  MoveButton.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation
import GameKit
import UIKit


class swipeback : UIGestureRecognizer {
    
    let requiredSwipes = 2
    let distanceForSwipeGesture:CGFloat = 25.0
    //dragStartPositionRelativeToCenter : CGPoint?
    
    enum Direction:Int {
        case directionUnknow = 0
        case directLeft
        case directionRight
        
    }
    
    
    var SwipCount:Int = 0
    var curSwipeStart: CGPoint = CGPoint.zero
    var lastDirection:Direction = .directionUnknow
}
