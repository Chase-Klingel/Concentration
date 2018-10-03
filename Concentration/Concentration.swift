//
//  Concentration.swift
//  Concentration
//
//  Created by Chase Klingel on 9/23/18.
//  Copyright © 2018 Chase Klingel. All rights reserved.
//

import Foundation

class Concentration {
    
    private var cards = [Card]()
    private(set) var shuffledCards = [Card]()
    
    private var indexOfOneFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            
            for index in shuffledCards.indices {
                if shuffledCards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        
        set {
            for index in shuffledCards.indices {
                shuffledCards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !shuffledCards[index].isMatched {
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index {
                if shuffledCards[matchIndex].identifier == shuffledCards[index].identifier {
                    shuffledCards[matchIndex].isMatched = true
                    shuffledCards[index].isMatched = true
                }
                
                shuffledCards[index].isFaceUp = true
            } else {
                indexOfOneFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
    }
}
