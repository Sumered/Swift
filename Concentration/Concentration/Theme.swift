//
//  Theme.swift
//  Concentration
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import Foundation
import UIKit
struct Theme {
    var backgroundColor: UIColor
    var mainColor: UIColor
    var cardTitles: [String]
    private let hallowenTheme = (backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), mainColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),cardTitles: ["👻","🎃","☠️","🧛🏻‍♂️","🧟‍♂️","🦇","🕷","🧙🏻‍♂️","😈"])
    private let sportTheme = (backgroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), mainColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),cardTitles: ["⚽️","🏀","🏈","⚾️","🎾","🥇","🏆","🎱","🥊"])
    private let jobTheme = (backgroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), mainColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),cardTitles: ["👮🏻‍♀️","👩🏻‍🌾","🕵🏻‍♀️","👩🏻‍🍳","👩🏼‍💻","👩🏻‍🔬","👩🏼‍⚖️","👩🏼‍💼","👩🏼‍🎓"])
    private let emojiTheme = (backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), mainColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardTitles: ["😃","🤣","😘","😎","🤬","😱","😈","🤩","😍"])
    private let foodTheme = (backgroundColor: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), mainColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), cardTitles: ["🍟","🍔","🌯","🍕","🍙","🍱","🥥","🌽","🥓"])
    private let animalTheme = (backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), mainColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardTitles: ["🦁","🦉","🦊","🐯","🐗","🐧","🦈","🐥","🐺"])
    init() {
        let themes = [hallowenTheme,sportTheme,jobTheme,emojiTheme,foodTheme,animalTheme]
        let choosenTheme = themes.count.arc4random
        backgroundColor = themes[choosenTheme].backgroundColor
        mainColor = themes[choosenTheme].mainColor
        cardTitles = themes[choosenTheme].cardTitles
    }
}
