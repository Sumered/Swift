//
//  SetViewController.swift
//  SetGame
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {

    let game = SetGame()
    var colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
    var opacities = [0.20,0.50,1.0]
    var shapes = ["▲","◼︎","●"]
    var CardsOnScreen = 12
    var AI = false
    var oneTurnTime: TimeInterval = 0.0
    var iphoneTime: Timer = Timer.init()
    var score = 0 {
        didSet {
            ScoreLabel.setTitle("Score: \(score)", for: .normal)
        }
    }
    //MARK: AI stuff
    var iphoneScore = 0 {
        didSet {
            IphoneAI.text = "Iphone Score: \(iphoneScore)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if AI == true {
            HintButton.isUserInteractionEnabled = false
            IphoneAI.text = "Iphone Score: \(iphoneScore)"
            if game.checkInVisibleCard(cards: ButtonsAttributes, capability: canChooseButton).0 {
                iphoneTime = Timer.scheduledTimer(withTimeInterval: oneTurnTime, repeats: false, block: {_ in
                    self.iphoneMove()
                })
            }
        }
    }
    private func iphoneMove() {
        let iphonepicks = self.game.checkInVisibleCard(cards: self.ButtonsAttributes, capability: self.canChooseButton)
        if iphonepicks.0 {
            iphoneTime = Timer.scheduledTimer(withTimeInterval: oneTurnTime, repeats: false, block: {_ in
                self.iphoneMove()
            })
            self.iphoneScore += 3
            for index in iphonepicks.1 {
                self.SetCards[index].layer.borderWidth = 0
                if self.cards.count == 0 {
                    canChooseButton[index] = false
                }
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.7,
                    delay: 0,
                    options: .allowUserInteraction,
                    animations: {
                        self.SetCards[index].alpha = 0
                },
                    completion: { finished in
                        if self.cards.count > 0 {
                            self.ButtonsAttributes.remove(at: index)
                            self.canChooseButton.remove(at: index)
                            self.ButtonCreate(index: index)
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.7,
                                delay: 0,
                                options: .allowUserInteraction,
                                animations: {
                                    self.SetCards[index].alpha = 1
                            }
                            )
                        } else {
                            self.SetCards[index].isUserInteractionEnabled = false
                            self.SetCards[index].backgroundColor = UIColor.clear
                            self.SetCards[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                        }
                })
            }
        }
    }
    //MARK: Touching Card
    var choosenIndexes = [Int]()
    @IBAction func TouchCard(_ sender: UIButton) {
        let index = SetCards.index(of: sender)!
        if choosenIndexes.contains(index) {
            score -= 1
            sender.layer.borderWidth = 0
            let indexInIndexes = choosenIndexes.index(of: index)!
            choosenIndexes.remove(at: indexInIndexes)
        } else {
            choosenIndexes.append(index)
            if choosenIndexes.count < 3 {
                sender.layer.borderWidth = 5.0
                sender.layer.borderColor = UIColor.gray.cgColor
            } else if choosenIndexes.count == 3 {
                let firstCard = ButtonsAttributes[choosenIndexes[0]]
                let secondCard = ButtonsAttributes[choosenIndexes[1]]
                let thirdCard = ButtonsAttributes[choosenIndexes[2]]
                if game.tryToMatch(firstCard: firstCard,secondCard: secondCard,thirdCard: thirdCard) {
                    if AI == true {
                        iphoneTime.invalidate()
                        iphoneTime = Timer.scheduledTimer(withTimeInterval: oneTurnTime, repeats: false, block: {_ in
                            self.iphoneMove()
                        })
                    }
                    score += 3
                    for index in choosenIndexes {
                        SetCards[index].layer.borderWidth = 0
                        if cards.count == 0 {
                            canChooseButton[index] = false
                        }
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.7,
                            delay: 0,
                            options: .allowUserInteraction,
                            animations: {
                                self.SetCards[index].alpha = 0
                        },
                            completion: { finished in
                                if self.cards.count > 0 {
                                    self.ButtonsAttributes.remove(at: index)
                                    self.canChooseButton.remove(at: index)
                                    self.ButtonCreate(index: index)
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.7,
                                        delay: 0,
                                        options: .allowUserInteraction,
                                        animations: {
                                            self.SetCards[index].alpha = 1
                                    }
                                    )
                                } else {
                                    self.SetCards[index].isUserInteractionEnabled = false
                                    self.SetCards[index].backgroundColor = UIColor.clear
                                    self.SetCards[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                                }
                        })
                    }
                } else {
                    score -= 5
                    for index in choosenIndexes {
                        SetCards[index].layer.borderWidth = 0
                    }
                }
                choosenIndexes.removeAll()
            }
        }
    }
    
    
    lazy var cards: [SetCard] = createDeck()
    // MARK: deck creation,buttons setup and all of that stuff
    private func createDeck() -> [SetCard] {
        var array = [SetCard]()
        for ammount in 1...3 {
            for color in colors {
                for shape in shapes {
                    for opacity in opacities {
                        let card = SetCard(ammounts: ammount,shapes: shape,opacities: opacity,colors: color)
                        array.append(card)
                    }
                }
            }
        }
        return array
    }
    
    private func ButtonCreate(index: Int) {
        let button = SetCards[index]
        let card = cards.remove(at: cards.count.arc4random)
        ButtonsAttributes.insert(card, at: index)
        canChooseButton.insert(true,at: index)
        //print(cards.count)
        createButtonText(button: button,card: card)
    }
    func createButtonText(button: UIButton,card: SetCard) {
        var text = String()
        for _ in 1...card.ammount {
            text += card.shape
        }
        if card.opacity == 0.5 {
            let attributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : card.color,
                .strokeColor : card.color,
                .strokeWidth: 5.0
            ]
            let title = NSAttributedString(string: text, attributes: attributes)
            button.setAttributedTitle(title, for: .normal)
        }
        else {
            let attributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : card.color.withAlphaComponent(CGFloat(card.opacity)),
                ]
            let title = NSAttributedString(string: text, attributes: attributes)
            button.setAttributedTitle(title, for: .normal)
        }
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    func ButtonsSetup() {
        for index in 0...11 {
                ButtonCreate(index: index)
            }
        for index in 12...23 {
            let button = SetCards[index]
            button.isUserInteractionEnabled = false
            button.setTitle("",for: .normal)
            button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0)
        }
    }
    var canChooseButton: [Bool] = [] //for endgame purposes
    var ButtonsAttributes: [SetCard] = [] //Holder of info about Buttons
    @IBOutlet var SetCards: [UIButton]! {
        didSet {
            for button in SetCards {
                button.layer.cornerRadius = 8.0
            }
            ButtonsSetup()
        }
    }
    
    //MARK: Deal 3 more,start new game and hint, EXTRAS
    
    @IBOutlet weak var Deal3MoreButton: UIButton!
    @IBAction func StartNewGame(_ sender: UIButton) {
        for button in SetCards {
            button.layer.borderWidth = 0
        }
        cards = createDeck()
        score = 0
        ButtonsSetup()
        Deal3MoreButton.setTitle("Deal 3 more", for: .normal)
        //Deal3MoreButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @IBAction func GiveHint(_ sender: UIButton) {
        let matchedSet = game.checkInVisibleCard(cards: ButtonsAttributes,capability: canChooseButton)
        if matchedSet.0 {
            score -= 3
            for index in matchedSet.1 {
                SetCards[index].layer.borderWidth = 8.0
                SetCards[index].layer.borderColor = UIColor.green.cgColor
            }
        }
    }
    @IBAction func Deal3More(_ sender: UIButton) {
        if CardsOnScreen != 24 {
            if game.checkInVisibleCard(cards: ButtonsAttributes, capability: canChooseButton).0 {
                score -= 1
            }
            for index in CardsOnScreen..<(CardsOnScreen+3) {
                SetCards[index].isUserInteractionEnabled = true
                ButtonCreate(index: index)
            }
            if AI == true {
                iphoneTime.invalidate()
                iphoneTime = Timer.scheduledTimer(withTimeInterval: oneTurnTime, repeats: false, block: {_ in
                    self.iphoneMove()
                })
            }
            CardsOnScreen += 3
            if CardsOnScreen == 24 {
                Deal3MoreButton.setTitle("", for: .normal)
                //Deal3MoreButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
    }
    @IBOutlet weak var HintButton: UIButton!
    @IBOutlet weak var ScoreLabel: UIButton!
    @IBOutlet weak var IphoneAI: UILabel!
}
extension Int {
    var arc4random:Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
