//
//  ViewController.swift
//  Concentration
//
//  Created by Chase Klingel on 8/14/18.
//  Copyright © 2018 Chase Klingel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    /*
      lazy: as soon as somoene tries to use game, the property will be initialized.
            The compiler "sees" it as initialized however so that ViewController can be invoked.
     
      One Caveat: Can't use property observers with lazy vars
    */
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return ((cardButtons.count + 1) / 2)
    }
    
    private(set) var flipCount: Int = 0 {
        // property observer
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    // MARK: - Touch And Flip Methods
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.shuffledCards[index]
            
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                print("what does emoji return? \(emoji(for: card))")
            } else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9381620884, green: 0.758045733, blue: 0.05096117407, alpha: 1)
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    private var emojiChoices = ["😜", "😎", "😤", "👩‍🚀", "🥑", "🏀", "🥊", "🏂", "🚔", "✈️"]
    
    private var emoji = [Int : String]()
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

