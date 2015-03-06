//
//  ViewController.swift
//  Blackjack_hw2
//
//  Created by Nicole Effendy on 2/16/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //variables
    
    //var bet = 1.00
    //var money = 100.00
    
    var deckOfCards = DeckOfCards()
    var numberofGames = 0
    var numberofDecks: Int!
    var numberofPlayers: Int!
    var currentPlayer: Int!
    
    var dealer: Dealer!
    var player:[Player] = []
    
    
    //UILabels
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    //class for the cards
    
    class Cards : NSObject {
        var num:String = ""
        var suit:String = ""
        
        init(num:String, suit:String){
            self.num = num
            self.suit = suit
        }
        
        
        func cardInfo()-> String {
            return self.num + self.suit
        }
        
        func getInfo()-> Int {
            var cardVal: Int = 0;
            switch num {
                case "A":
                cardVal = 1
                
                case "2":
                cardVal = 2
                
                case "3":
                cardVal = 3
                
                case "4":
                cardVal = 4
                
                case "5":
                cardVal = 5
                
                case "6":
                cardVal = 6
                
                case "7":
                cardVal = 7
                
                case "8":
                cardVal = 8
                
                case "9":
                cardVal = 9
                
                case "10":
                cardVal = 10
                
                case "J":
                cardVal = 10
                
                case "Q":
                cardVal = 10
                
                case "K":
                cardVal = 10
                
                default:
                cardVal = 0
            }
            
            return cardVal
        }
    
    }
    
    // class for handling a deck of cards
    class DeckOfCards {
        var deckOfCards:[Cards] = []
        
        //func to get a new deck
        func getDeck(num:Int){
            deckOfCards.removeAll()
            var nums = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
            var suits = ["♠", "♥", "♦", "♣"]
            
            for suit in suits{
                for num in nums{
                    deckOfCards.append(Cards(num:num, suit:suit))
                }
            }
        }
        
        
        func drawNewCard() -> Cards{
            //random function is copied from a forum post in stackoverflow
            
            let randomNum = arc4random_uniform(UInt32(deckOfCards.count))
            let randomCard = deckOfCards[randomNum.hashValue]
            
            deckOfCards.removeAtIndex(randomNum.hashValue)
            
            return randomCard
            
        }
    }
    
    
    //hw2: class for player/dealer's hand
    
    class Hand {
        var cardsInHand:[Cards] = []
        var deckOfCards = DeckOfCards()
        
        init(){
            cardsInHand.append(deckOfCards.drawNewCard())
            cardsInHand.append(deckOfCards.drawNewCard())
        }

        
        func drawNewCard(){
            cardsInHand.append(deckOfCards.drawNewCard())
        }
        
        var handValue: Int{
            var score = 0
            for card in cardsInHand {
                score += card.getInfo()
            }
            return score
        }
        
           }
    
    //hw2: class for dealer
    
    
    class Dealer {
        
        var dealerHand:Hand = Hand ()
        
        
        func dealerPlay(){
            while (dealerHand.handValue < 17){
                dealerHand.drawNewCard()
            }
            if (dealerHand.handValue >= 21){
               return
            }
        }
        
        
        func showCards() -> String {
            var show = dealerHand.cardsInHand[1..<dealerHand.cardsInHand.count]
            
            var display = ""
            
            for card in show{
                display += card.cardInfo() + " "
            }
            return display
        }
    }
    
    //hw2: player class
    
    class Player {
        var playerHand:Hand = Hand()
        var playerName: String
        
        func hit(){
            playerHand.drawNewCard()
        }
        
        func stand (){
            return
            
        }
        
        func showCards() -> String {
            
            var display = ""
            
            for card in playerHand.cardsInHand{
                display += card.cardInfo() + " "
            }
            return display
        }
        
        init(playerName:String){
            self.playerName = playerName
        }
        
    }

    //hw2 changes
    
        

    
    
     //@IBAction functions for gameplay
    
    @IBOutlet weak var STAND: UIButton!
    @IBOutlet weak var HIT: UIButton!
    @IBOutlet weak var SHUFFLER: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stand(sender: AnyObject) {
        dealerHand()
        println("Stand")
    }
    
    @IBAction func hit(sender: AnyObject) {
        player.append(deckOfCards.drawNewCard())
        println("Hit")
    }
    
    @IBAction func shuffle(sender: AnyObject) {
        if (numberofGames > 5){
            numberofGames = 0
            newGame()
        }
            
        else{
            deal()
        }
    }
    
    @IBAction func betAmt(sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        deckOfCards.getDeck(numberofDecks)
        println(deckOfCards)
        for index in 1...numberofPlayers {
            player.append(Player(playerName:"\(index)"))
        }
        
        dealer = Dealer()
        newGame()
        currentPlayer = 0
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = 1
    }
    
    
    func playerSetting(number:String, value:String){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

