//
//  Concentration.swift
//  Concentration
//
//  Created by Liu bo on 27/08/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation


struct Concentration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUp: Int? {
        get {
            return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard (at index: Int) {
        assert(cards.indices.contains(index),"Concentration.chooseCard(at \(index)")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp , matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else {
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0,"init(\(numberOfPairsOfCards)")

        let resetCard = Card()
        resetCard.resetIdentifier()
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        var shuffled = [Card]();
        for _ in cards.indices{
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards[rand])
            cards.remove(at: rand)
        }
        cards = shuffled
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
