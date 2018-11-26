//
//  Tile.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//import Foundation
//
//  Tile.swift
//  FPSControls
//
//  Created by Nick Lockwood on 09/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import Foundation

enum TileType {
    
    case rock
    case wall
    case floor
    case grass
    case unlock
}

struct FaceVisibility : OptionSet {
    
    let rawValue: UInt
    static let None = FaceVisibility(rawValue: 0)
    static let Top = FaceVisibility(rawValue: 1 << 0)
    static let Right = FaceVisibility(rawValue: 1 << 1)
    static let Bottom = FaceVisibility(rawValue: 1 << 2)
    static let Left = FaceVisibility(rawValue: 1 << 3)
}

class Tile {
    
    unowned let map: Map
    let x, y: Int
    var type: TileType = .rock
    
    var visibility: FaceVisibility {
        var visibility: FaceVisibility = .None
        if x > 0 && map.tile(x - 1, y).type == .floor {
            visibility.formUnion(.Left)
        }
        if x < map.width - 1 && map.tile(x + 1, y).type == .floor {
            visibility.formUnion(.Right)
        }
        if y > 0 && map.tile(x, y - 1).type == .floor {
            visibility.formUnion(.Top)
        }
        if y < map.height - 1 && map.tile(x, y + 1).type == .floor {
            visibility.formUnion(.Bottom)
        }
        return visibility
    }
    
    init(map: Map, x: Int, y: Int) {
        
        self.map = map
        self.x = x
        self.y = y
    }
}