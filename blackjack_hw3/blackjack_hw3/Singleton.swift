//
//  Singleton.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Singleton {
    
    var deckCount = 1
    var deck = Deck(num:1)
    class var sharedInstance: Singleton {
        struct s {
            static let instance: Singleton = Singleton()
        }
        return s.instance
    }
    
}