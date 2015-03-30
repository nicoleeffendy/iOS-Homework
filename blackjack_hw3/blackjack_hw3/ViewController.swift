//
//  ViewController.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sharedData: Singleton = Singleton.sharedInstance
    
    var players = Player()
    var dealer = Dealer()
    var artIntelligence = AI()
    var gameCount = 0
    

    func displayDealerCards(){
        var temp = " "
        for card in dealer.hand.hand{
            temp += card.getCardInfo()
        }
        DealerCards.text = temp
    }
    
    
    func displayPlayerCards(){
        var temp = " "
        for card in players.hand.hand{
            temp += card.getCardInfo()
        }
        PlayerCards.text = temp
    }
    
    func displayAICards(){
        var temp = " "
        for card in artIntelligence.hand.hand {
            temp += card.getCardInfo()
        }
    }
    
    func displayDealerHand(){
        DealerHand.text = "\(dealer.hand.score)"
    }
    
    func displayPlayerHand(){
        PlayerHand.text = "\(players.hand.score)"
    }
    
    func displayAIHand(){
        AIHand.text = "\(artIntelligence.hand.score)"
    }
    
    func displayDealerStatus(){
        if dealer.hand.score == 21{
            DealerStatus.text = "Blackjack"
        }
        else if dealer.hand.score > 21{
            DealerStatus.text = "Bust"
        }
        
    }
    
    func displayPlayerStatus(){
        if players.hand.score == 21{
            PlayerStatus.text = "Blackjack"
            
        }
        else if players.hand.score > 21{
            PlayerStatus.text = "Bust"
        }
        
    
    }
    
    func displayAIStatus(){
        if artIntelligence.hand.score == 21{
            AIStatus.text = "Blackjack"
            
        }
        else if artIntelligence.hand.score > 21{
            AIStatus.text = "Bust"
        }
        
        
    }
    
    func update(){
        displayDealerCards()
        displayPlayerCards()
        displayAICards()
        displayDealerHand()
        displayPlayerHand()
        displayAIHand()
        displayDealerStatus()
        displayPlayerStatus()
        displayAIStatus()
        displayMoney()
        
        
    }
    
    func getBet()-> Int {
        let bet:Int? = betLabel.text?.toInt()
        
        if bet != nil{
            return bet!
        }
        else{
            return 0
        }
    }
    
    func displayMoney(){
        var money = 100
        let bet = getBet()
        
        if players.hand.score == 21 {
            moneyLabel.text = "\(money + bet)"
        }
        else if players.hand.score > dealer.hand.score && players.hand.score < 21 && dealer.hand.score > 17{
            moneyLabel.text = "\(money + bet)"
        }
        else {
            moneyLabel.text = "\(money - bet)"
        }
    
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var deckCount = sharedData.deckCount
        sharedData.deck = Deck(num:deckCount)
        stepper.maximumValue = 100
        stepper.wraps = true
        stepper.autorepeat = true
        println(deckCount)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    //IBAC Functions
    
    @IBAction func HitButton(sender: AnyObject) {
        println("Hit")
        if players.hand.score < 21 {
            players.hand.hand.append(sharedData.deck.dealCard())}
        else {
            return
        }
        
        update()

    }
    
    
    @IBAction func StandButton(sender: AnyObject) {
        println("Stand")
        if players.hand.score < 21 {
            dealer.play() }
        update()
    }
    
    @IBAction func DealButton(sender: AnyObject) {
        println("Deal")
        players.hand.newHand()
        dealer.hand.newHand()
        gameCount += 1
        if gameCount >= 5 {
            sharedData.deck.shuffle()
            gameCount = 0
        }
        update()
        
        
        
    }
    
    @IBOutlet weak var AICards: UILabel!
    
    @IBOutlet weak var AIHand: UILabel!
    
    @IBOutlet weak var AIStatus: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var DealerStatus: UILabel!
   
    @IBOutlet weak var PlayerStatus: UILabel!
    
    @IBOutlet weak var DealerHand: UILabel!

    @IBOutlet weak var PlayerHand: UILabel!
   
    @IBOutlet weak var PlayerCards: UILabel!
    
    @IBOutlet weak var DealerCards: UILabel!
  
    @IBOutlet weak var betLabel: UILabel!

    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func BetStepper(sender: UIStepper) {
        betLabel.text = Int(sender.value).description
    }
//    @IBAction func BetStepper(sender: AnyObject) {
//        betLabel.text = Int(sender.value).description
//    }
    

}


