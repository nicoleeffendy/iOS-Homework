
//
//  Player.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Player {
//    var name:String
    var money:Int = 100
    var hand = Hand()
    
    //initialization
    init() {
    }
    
    var sharedData:Singleton = Singleton.sharedInstance

    //methods (action)
    func hit(){
     var newCard = sharedData.deck.dealCard()
        hand.hand.append(newCard)
        
    }
    
    func stand(){
        return
    }
    
    
    func gameplay(){
        if hand.score == 21{
            println("Blackjack")
        }
            
        else if hand.score > 21 {
            println("BUST")
        }
            
    }
    
    
    
}