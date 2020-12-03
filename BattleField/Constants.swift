//
//  Constants.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/30/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//import Foundation

enum ZPosition: Int {
    case background, stockItemsBackground, stockItemsForeground, hudBackground, hudForeground
}



let TimeScale: Float = 1

enum State: Int {
    case empty, stocking, stocked, selling
}
