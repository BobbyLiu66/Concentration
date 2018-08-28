//
//  ViewController.swift
//  Concentration
//
//  Created by Liu bo on 26/08/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    var seenEmoji = Set<String>()
    
    
    private(set) var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flip:\(flipCount)"
        }
    }
    
    private(set) var scoreCount: Int = 0 {
        didSet{
            scoreLabel.text = "Score:\(scoreCount)"
        }
    }
    

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton){
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print(seenEmoji)
        }
        
    }
    
    @IBAction func resetToOriginalState(_ sender: UIButton) {
        resetModel()
    }
    
    private func resetModel(){
        flipCount = 0
        scoreCount = 0
        seenEmoji.removeAll()
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    
    private func updateViewFromModel(){
        var flagOfFacedUp = false
        var numberOfFacedUp : [Int] = []
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]

            if card.isFaceUp {
                //TODO: need test score system
                numberOfFacedUp.append(index)
                flagOfFacedUp = card.isMatched
                seenEmoji.insert(emoji(for: card))
                
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        print(flagOfFacedUp)
        if numberOfFacedUp.count == 2{
            if flagOfFacedUp{
                
                seenEmoji.remove(emoji(for: game.cards[numberOfFacedUp.first!]))
                scoreCount += 2
                
            }
            else{
                //TODO get card emoji
//                if numberOfFacedUp.last != nil{
//                    if seenEmoji.contains(emoji(for: game.cards[numberOfFacedUp.last!])) {
//                        scoreCount -= 1
//                    }
//                }
            }
        }
        
//        if flagOfFacedUp {
//            scoreCount += 2
//        }
//        else if numberOfFacedUp == 2 {
//            //TODO: check emoji seen list
//
//        }
    }
    
    
    private var emojiChoices = ["⚽️","👻","🎃","🚒","🐶","⭐️","🍎"]
    
    private var emoji = Dictionary<Int, String>()
    
    private func emoji(for card: Card) ->String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
        
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

