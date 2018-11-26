//
//  Entity.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

enum EntityType {
    
    case hero
    case monster
    case enemy
    case box
    case missionItem
}

class Entity {
    
    var type: EntityType
    var x, y: Float
    
    init(type: EntityType, x: Float, y: Float) {
        
        self.type = type
        self.x = x
        self.y = y
    }
}
