//
//  Dealer.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Dealer {
    var hand = Hand()
    

    //methods
    func play() {
        while hand.score < 21 {
            if hand.score == 21 {
                return
            }
            
            else if hand.score > 21 {
                return
            }
            
            else if hand.score < 17 {
                hand.hit()
            }
            else{
                return
            }
        }
    }

}