//
//  Cards.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import Foundation

class Card{
    //properties
    var suit: String
    var value: String
    
    //initialization
    init(suit: String, value: String){
        self.suit = suit
        self.value = value
    }
    
    //methods
    
    func getCardInfo() ->String{
        return self.suit + self.value
    }
    
    func getValue() ->Int {
        var cardVal:Int = 0
        
        if value == "2"{
            cardVal = 2
        }
            
        else if value == "A"{
            cardVal = 11
        }
        
        else if value == "3"{
            cardVal = 3
        }
        
        else if value == "4"{
            cardVal = 4
        }
        
        else if value == "5"{
            cardVal = 5
        }
        
        else if value == "6"{
            cardVal = 6
        }
        
        else if value == "7"{
            cardVal = 7
        }
        
        else if value == "8"{
            cardVal = 8
        }
        
        else if value == "9"{
            cardVal = 9
        }
        
        else {
            cardVal = 10
        }
        
        return cardVal
    }
    
}



