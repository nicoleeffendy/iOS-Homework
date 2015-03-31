//
//  ViewController.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/29/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit

var money = 100

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
    
    func hideDealer(){
        var temp:String = "DEALER'S CARDS"
        DealerCards.text = temp
        
        DealerStatus.text = nil
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
        
        AICards.text = temp
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
    
    func revealDealer(){
        displayDealerCards()
        displayDealerHand()
    }
    
    func update(){
        //displayDealerCards()
        displayPlayerCards()
        displayAICards()
//      displayDealerHand()
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
        
        //println("before: \(money)")
        
        let bet = getBet()
        
        if players.hand.score == 21 { //blackjack
            money += bet
            moneyLabel.text = "\(money + bet)"
            
        }
        else if ((players.hand.score > dealer.hand.score) && (dealer.hand.score > 17) && (players.hand.score < 21)) { //player is higher scorer than dealer and did not bust
            money += bet
            moneyLabel.text = "\(money + bet)"
            
            
        }
            
        else if dealer.hand.score > 21 { //dealer goes bust
            money += bet
            moneyLabel.text="\(money + bet)"
            
        }
            
//        else {
//            moneyLabel.text = "\(money - bet)"
//            money -= bet
//        }
        
       // println("after: \(money)")
    
       
        
    }
    
    func displayBet(){
        let bet = getBet()
        moneyLabel.text = "\(money - bet)"
        money -= bet
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //share data for number of decks
        var deckCount = sharedData.deckCount
        sharedData.deck = Deck(num:deckCount)
        println(deckCount)
        
        //stepper for bet
        stepper.maximumValue = 100
        stepper.minimumValue = 1
        stepper.wraps = true
        stepper.autorepeat = true
       
        //settings
        PlayerStatus.text = nil
        AIStatus.text = nil
        DealerStatus.text = nil
        betLabel.text = "1"
        
        
        //displayMoney()
        displayBet()
        
        //displayDealerCards()
        displayPlayerCards()
        displayAICards()
        displayPlayerHand()
        displayAIHand()
        
        
        
        
        
//        if PlayerStatus.text == "Bust" {
//            artIntelligence.play()
//            dealer.play()
//            println("player bust")
//        }
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
        
        
        
        //displayMoney()
        update()

    }
    
    
    @IBAction func StandButton(sender: AnyObject) {
        println("Stand")
       // if players.hand.score < 21 {
            println("AI PLAY")
            artIntelligence.play()
            println("DEALER PLAY")
            revealDealer()
            println("Dealer revealed")
            dealer.play()
            println("dealer finish playing")
        
        
       // }
        
//        while artIntelligence.play(){
//            if //AI stands {
//            dealer.play()
//        }
        update()
        displayMoney()
       // displayBet()
        println("finish update")
        
       
    }
    
  
    
    @IBOutlet weak var DealButton: UIButton!
    
    @IBOutlet weak var StandButton: UIButton!
    @IBOutlet weak var HitButton: UIButton!
    
    @IBAction func DealButton(sender: AnyObject) {
        println("Deal")
        
        
        players.hand.newHand()
        dealer.hand.newHand()
        artIntelligence.hand.newHand()
        gameCount += 1
        if gameCount >= 5 {
            sharedData.deck.shuffle()
            gameCount = 0
        }
        PlayerStatus.text = nil
        AIStatus.text = nil
        DealerStatus.text = nil
        
        
        displayBet()
        //displaymoney()
        update()
        
        hideDealer()
        
        println("hide dealer")
        
        
        
        
        
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

    

}


