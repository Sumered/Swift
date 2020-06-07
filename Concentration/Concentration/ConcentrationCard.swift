//
//  ConcentrationCard.swift
//  Concentration
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import Foundation

struct ConcentrationCard {
    
    var isFaceUp = false
    var wasSeen = false
    var uniqueIdentifier: Int
    var isMatched = false
    static var identifierGenerator = 0
    init() {
        self.uniqueIdentifier = ConcentrationCard.identifierGenerator + 1
        ConcentrationCard.identifierGenerator += 1
        ConcentrationCard.identifierGenerator = ConcentrationCard.identifierGenerator % 8
    }
}
