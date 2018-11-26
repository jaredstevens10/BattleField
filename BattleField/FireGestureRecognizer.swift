//
//  FireGestureRecognizer.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

//
//  FireGestureRecognizer.swift
//  FPSControls
//
//  Created by Nick Lockwood on 09/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class FireGestureRecognizer: UIGestureRecognizer {
    
    var timeThreshold = 0.15
    var distanceThreshold = 5.0
    fileprivate var startTimes = [Int:TimeInterval]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        
        
        
        
        //record the start times of each touch
        for touch in touches {
            
            
            startTimes[touch.hash] = touch.timestamp
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
        //discard any touches that have moved
        for touch in touches {
            
            let newPos = touch.location(in: view)
            let oldPos = touch.previousLocation(in: view)
            let distanceDelta = Double(max(abs(newPos.x - oldPos.x), abs(newPos.y - oldPos.y)))
            if distanceDelta >= distanceThreshold {
                startTimes[touch.hash] = nil
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        
        for touch in touches {
            
            let startTime = startTimes[touch.hash]
            if let startTime = startTime {
                
                //check if within time
                let timeDelta = touch.timestamp - startTime
                if timeDelta < timeThreshold {
                    
                    //recognized
                    state = .ended
                }
            }
        }
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        
        reset()
    }
    
    override func reset() {
        
        if state == .possible {
            state = .failed
        }
    }
}


/*
class placeItemGestureRecognizer: UIGestureRecognizer {
    
   // var sceneView: SCNView!
    
    var timeThreshold = 1.00
    var distanceThreshold = 5.0
    private var startTimes = [Int:NSTimeInterval]()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        
        //record the start times of each touch
        for touch in touches {
            if let sceneView =
            var location = touch.locationInView(self.sceneView)
            print("Place Item Touches Began")
            //startTimes[touch.hash] = touch.timestamp
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        
        //discard any touches that have moved
        for touch in touches {
            
            
            print("Place item touches moved")
            /*
            let newPos = touch.locationInView(view)
            let oldPos = touch.previousLocationInView(view)
            let distanceDelta = Double(max(abs(newPos.x - oldPos.x), abs(newPos.y - oldPos.y)))
            if distanceDelta >= distanceThreshold {
                startTimes[touch.hash] = nil
            }
 */
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        
        for touch in touches {
            print("place item touches ended")
            /*
            let startTime = startTimes[touch.hash]
            if let startTime = startTime {
                
                //check if within time
                let timeDelta = touch.timestamp - startTime
                if timeDelta < timeThreshold {
                    
                    //recognized
                    state = .Ended
                }
            }
            */
        }
        reset()
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        print("place item touches cancelled")
        reset()
    }
    
    override func reset() {
        
        if state == .Possible {
            state = .Failed
        }
    }
}
*/
