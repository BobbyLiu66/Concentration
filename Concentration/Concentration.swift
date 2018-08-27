//
//  Concentration.swift
//  Concentration
//
//  Created by Liu bo on 27/08/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation


class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp , matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            }else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
    
    init (numbersOfPairsOfCards: Int){
        for _ in 1...numbersOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle the card
        var shuffled = [Card]();
        
        for _ in cards.indices{
            
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            
            shuffled.append(cards[rand])
            
            cards.remove(at: rand)
        }
        cards = shuffled

    }
}
