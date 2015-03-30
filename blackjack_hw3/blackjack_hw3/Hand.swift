//
//  Hand.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Hand {
    
    var hand:[Card] = []
    var bet:Int = 1
    var score:Int {
        get{
            var sum = 0
            for card in hand {
                sum += card.getValue()
            }
            return sum
        }
    }
    
    var sharedData:Singleton = Singleton.sharedInstance
    
    //initialization
    init(){
        hand = []
        hand.append(sharedData.deck.dealCard())
        hand.append(sharedData.deck.dealCard())
    }
    
    //methods
    
    func newHand(){
        hand.removeAll()
        hit()
        hit()
    }
    
    func hit(){
        hand.append(sharedData.deck.dealCard())
    }
    

    
  
}