//
//  ViewController.swift
//  Concentration
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var choosenTheme = Theme()
    private lazy var game = Concentration(ButtonsArray.count / 2)
    var flipCount = 0 {
        didSet {
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var scoreCount = 0 {
        didSet {
            ScoreLabel.text = "Score: \(scoreCount)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FlipCountLabel.textColor = choosenTheme.mainColor
        NewGameButton.setTitleColor(choosenTheme.mainColor, for: .normal)
        ScoreLabel.textColor = choosenTheme.mainColor
        view.backgroundColor = choosenTheme.backgroundColor
        for button in ButtonsArray {
            button.backgroundColor = choosenTheme.mainColor
            button.setTitle("", for: .normal)
            button.alpha = 1
        }
    }
    @IBOutlet weak var NewGameButton: UIButton!
    @IBOutlet private var ButtonsArray: [UIButton]!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBAction private func StartNewGame(_ sender: UIButton) {
        game.cards.removeAll()
        choosenTheme = Theme()
        game = Concentration(ButtonsArray.count/2)
        scoreCount = 0
        flipCount = 0
        viewDidLoad()
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        let index = ButtonsArray.index(of: sender)!
        if !game.cards[index].isMatched && !game.cards[index].isFaceUp && game.indexesOfFaceUpCards.count < 2 {
            flipCount += 1
            scoreCount += game.flipCard(index: index)
            updateView()
        }
    }
    private func updateView() {
        let index = game.indexesOfFaceUpCards.first!
        let button = ButtonsArray[index]
        if game.indexesOfFaceUpCards.count == 1 {
            let emoji = choosenTheme.cardTitles[game.cards[index].uniqueIdentifier]
            UIView.transition(
                with: button,
                duration: 0.6,
                options: .transitionFlipFromLeft,
                animations: {
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.setTitle(emoji, for: .normal)
            })
        } else {
            let secondIndex = game.indexesOfFaceUpCards.last!
            let secondButton = ButtonsArray[secondIndex]
            let emoji = choosenTheme.cardTitles[game.cards[secondIndex].uniqueIdentifier]
            if game.cards[index].isMatched == true {
                UIView.transition(
                    with: secondButton,
                    duration: 0.5,
                    options: .transitionFlipFromLeft,
                    animations: {
                        secondButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        secondButton.setTitle(emoji, for: .normal)
                },
                    completion: { finished in
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.5,
                            delay: 0,
                            options: .transitionFlipFromLeft,
                            animations: {
                                button.alpha = 0
                                secondButton.alpha = 0
                        },
                            completion: { finished in
                                self.game.indexesOfFaceUpCards.removeAll()
                        })
                })
            } else {
                UIView.transition(
                with: secondButton,
                duration: 0.5,
                options: .transitionFlipFromLeft,
                animations: {
                    secondButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    secondButton.setTitle(self.choosenTheme.cardTitles[self.game.cards[secondIndex].uniqueIdentifier], for: .normal)
                }, completion: { finished in
                    UIView.transition(
                        with: button,
                        duration: 0.5,
                        options: .transitionFlipFromLeft,
                        animations: {
                            button.backgroundColor = self.choosenTheme.mainColor
                            button.setTitle("", for: .normal)
                    }, completion: { finished in
                        self.game.cards[index].isFaceUp = false
                        self.game.indexesOfFaceUpCards.removeFirst()
                    })
                    UIView.transition(
                        with: secondButton,
                        duration: 0.5,
                        options: .transitionFlipFromLeft,
                        animations: {
                            secondButton.backgroundColor = self.choosenTheme.mainColor
                            secondButton.setTitle("", for: .normal)
                    }, completion: { finished in
                        self.game.cards[secondIndex].isFaceUp = false
                        self.game.indexesOfFaceUpCards.removeLast()
                    })
                })
            }
        }
    }

    @IBOutlet weak var FlipCountLabel: UILabel! {
        didSet {
            FlipCountLabel.text = "Flips: 0"
        }
    }
}

