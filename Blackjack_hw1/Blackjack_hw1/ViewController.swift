//
//  ViewController.swift
//  Blackjack_hw1
//
//  Created by Nicole Effendy on 2/16/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    
    
    var bet = 1.00
    var money = 100.00
    var deckOfCards = DeckOfCards()
    var numberofGames = 0
    
    var dealer:Array<Cards> = []
    var player:Array<Cards> = []
    
    
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
        var deckOfCards: Array<Cards> = []
        
        //func to get a new deck
        func getDeck(){
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
    
    //the game
    
    func gamePlay(){
        moneyLabel.text = "Money: " + NSString(format: "$%.2f", money)
        
        var playerHand = ""
        var playerVal = 0
        
        var dealerHand = ""
        var dealerVal = 0
        
        for card in player{
            playerHand += card.cardInfo() + "\n"
            playerVal += card.getInfo()
        }
        
        for card in dealer{
            dealerHand += card.cardInfo() + "\n"
            dealerVal += card.getInfo()
        }
        
        //place your bets, players!
        if (playerVal > 21) {
            money -= bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Bust")
        }
        
        else if (playerVal == 21) {
            money += bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Blackjack")

        }
        
        else if ((playerVal < 21) && (dealerVal < playerVal)){
            money += bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Player win")

            
        }
        
        //place your bets, dealers!
        if (dealerVal > 21) {
            money -= bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Bust")
        }
            
        else if (dealerVal == 21) {
            money += bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Blackjack")
            
        }
            
        else if ((dealerVal < 21) && (dealerVal > playerVal)){
            money += bet
            moneyText.text = "Money: " + NSString(format: "$%.2f", money)
            println("Dealer win")
            
            
        }
        
        
        
    }
    
    //new game
    
    func newGame(){
        player.removeAll()
        dealer.removeAll()
        deckOfCards.getDeck()
        player.append((deckOfCards.drawNewCard()))
        dealer.append((deckOfCards.drawNewCard()))
        
        gamePlay()
    }
    
    //shuffles after 5 games
    
    func deal(){
        numberofGames++
        player.removeAll()
        dealer.removeAll()
        
        player.append(deckOfCards.drawNewCard())
        dealer.append(deckOfCards.drawNewCard())
        
        player.append(deckOfCards.drawNewCard())
        dealer.append(deckOfCards.drawNewCard())
        
        
    }
    
    //calculates value of cards in hand
    
    func handValue(cards:Array<Cards>) -> Int{
        var handVal = 0
        for card in cards{
            handVal += card.getInfo()
        }
        return handVal
    }
    
    //dealer playing alg
    
    func dealerHand(){
        while true{
            println("Dealer playing")
            
            // making sure dealer hits at least 16
            if (handValue(dealer) <= 16){
                dealer.append(deckOfCards.drawNewCard())
                println("Hit")
                gamePlay()
            }
            
            
            if (handValue(dealer) == handValue(player)){
                dealer.append(deckOfCards.drawNewCard())
                println("Draw")
            }
            
            if (handValue(dealer) == 21){
                println("Blackjack")
            }
            
            if (handValue(dealer) > 21){
                println("Bust")
                break
            }
            
            
        }
    }
    
    //@IBAction functions

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
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

