//
//  Deck.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Deck {
    //properties
    var deck:[Card] = []
    
    //initialization
    init(num:Int){
        var suits = ["♠", "♥", "♦", "♣"]
        var cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        
        for numDeck in 0...num{
            for suit in suits{
                for card in cards{
                    var card_deck = Card(suit: suit, value: card)
                    deck.append(card_deck)
                }
            }
        }
        
    }
    
    //methods
    
    func shuffle() {
        var numCard = deck.count
       
        for i in 0...numCard {
            var randVal = Int(arc4random_uniform(UInt32(numCard - i)))
            var temp = deck[i]
            deck[i] = deck[randVal]
            deck[randVal] = temp
        }
        
    }
    
    func dealCard() -> Card {
        var randVal = Int(arc4random_uniform(UInt32(deck.count)))
        var temp = deck.removeAtIndex(randVal)
        return temp
    }
}

