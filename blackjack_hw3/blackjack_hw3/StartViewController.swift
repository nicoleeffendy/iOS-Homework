//
//  StartViewController.swift
//  blackjack_hw3
//
//  Created by Nicole Effendy on 3/30/15.
//  Copyright (c) 2015 Nicole Effendy. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var sharedData: Singleton = Singleton.sharedInstance
    var deckCount :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        
        stepper.maximumValue = 3
        stepper.minimumValue = 1
        stepper.wraps = true
        stepper.autorepeat = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDeck() ->Int {
        let deckCount: Int? = DeckLabel.text?.toInt()
        if deckCount != nil {
            return deckCount!
        }
        else {
            return 0
        }
    }
    
    
    @IBOutlet weak var DeckLabel: UILabel!

    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func DeckStepper(sender: UIStepper) {
        DeckLabel.text = Int(sender.value).description
        sharedData.deckCount = Int(sender.value)
        
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
