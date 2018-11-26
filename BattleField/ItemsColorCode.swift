//
//  ItemsColorCode.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/7/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

func ReturnItemsColorCode(_ itemName: String) -> (UInt8, UInt8, UInt8) {

    var newRed = UInt8()
    var newGreen = UInt8()
    var newBlue = UInt8()
    
    
    switch itemName {
        
    case "Box":
        newRed = 200
        newGreen = 200
        newBlue = 0
    case "Bomb":
        newRed = 190
        newGreen = 190
        newBlue = 0
        
    default:
        break
    }
    
return (newRed, newGreen, newBlue)

}
