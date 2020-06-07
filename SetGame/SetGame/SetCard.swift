//
//  SetCard.swift
//  SetGame
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import Foundation
import UIKit
struct SetCard: Equatable {
    
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.color == rhs.color && lhs.ammount == rhs.ammount && lhs.shape == rhs.shape && lhs.opacity == rhs.opacity
    }
    var ammount: Int
    var shape: String
    var opacity: Double
    var color: UIColor
    init(ammounts: Int,shapes: String,opacities: Double,colors: UIColor) {
        ammount = ammounts
        shape = shapes
        opacity = opacities
        color = colors
    }
}

