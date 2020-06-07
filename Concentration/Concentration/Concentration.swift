//
//  Concentration.swift
//  Concentration
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import Foundation

struct Concentration {
    
    var cards = [ConcentrationCard]()
    var indexesOfFaceUpCards = [Int]()
    mutating func flipCard(index: Int) -> Int {
        indexesOfFaceUpCards.append(index)
        if indexesOfFaceUpCards.count == 1 {
            cards[index].isFaceUp = true
            return 0
        } else if indexesOfFaceUpCards.count == 2 {
            let firstIndex = indexesOfFaceUpCards.first!
            if cards[index].uniqueIdentifier == cards[firstIndex].uniqueIdentifier {
                cards[index].isMatched = true
                cards[firstIndex].isMatched = true
                cards[firstIndex].isFaceUp = true
                cards[index].isFaceUp = true
                return 2
            } else {
                var punishment = 0
                if cards[index].wasSeen == true {
                    punishment -= 1
                }
                if cards[firstIndex].wasSeen == true {
                    punishment -= 1
                }
                cards[index].isFaceUp = true
                cards[firstIndex].isFaceUp = true
                cards[index].wasSeen = true
                cards[firstIndex].wasSeen = true
                return punishment
            }
        }
        return 0 
    }
    init(_ numberOfPairs: Int) {
        cards.removeAll()
        var unShuffledCards = [ConcentrationCard]()
        for _ in 1...numberOfPairs {
            let card = ConcentrationCard()
            unShuffledCards += [card,card]
        }
        for _ in unShuffledCards {
            cards.append(unShuffledCards.remove(at: unShuffledCards.count.arc4random))
        }
    }
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
