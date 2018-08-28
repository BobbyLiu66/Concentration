//
//  Card.swift
//  Concentration
//
//  Created by Liu bo on 27/08/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    
    var hashValue: Int {return identifier}
    
    static func == (lhs:Card,rhs:Card)->Bool{
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    func resetIdentifier(){
        Card.identifierFactory = 0
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
