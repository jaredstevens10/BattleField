//
//  GameStateDelegate.swift
//  BattleField
//
//  Created by Jared Stevens2 on 3/30/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

protocol GameStateDelegate {
    
    func gameStateDelegateChangeMoneyBy(delta: Int) -> Bool
    func gameStateServeCustomerWithItemOfType(type: String, flavor: String)
    
}
