//
//  Settings.swift
//  Blackjack_hw1
//
//  Created by Nicole Effendy on 3/6/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    var numDeck = 3
    var numPlayer = 2
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperplayer: UIStepper!

   
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var deck: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 3
        
        stepperplayer.wraps = true
        stepperplayer.autorepeat = true
        stepperplayer.maximumValue = 2

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue"{
            var settings = segue.destinationViewController as ViewController
            settings.numberofDecks = numDeck
            settings.numberofPlayers = numPlayer
        }
    }


    @IBAction func stepperplayer(sender: UIStepper) {
        numPlayer = Int(sender.value)
        player.text = "\(player)"
        
    }
   
    
    @IBAction func stepper(sender: UIStepper) {
        numDeck = Int (sender.value)
        deck.text = "\(deck)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
