//
//  SetGame.swift
//  SetGame
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import Foundation

struct SetGame {
    func tryToMatch(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        return checkForMatch(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard)
    }
    func checkInVisibleCard(cards: [SetCard],capability: [Bool]) -> (Bool,[Int]) {
        for firstCard in cards {
            for secondCard in cards {
                for thirdCard in cards {
                    let firstBool = capability[cards.index(of: firstCard)!]
                    let secondBool = capability[cards.index(of: secondCard)!]
                    let thirdBool = capability[cards.index(of: thirdCard)!]
                    if firstBool && secondBool && thirdBool {
                        if firstCard != secondCard && firstCard != thirdCard && secondCard != thirdCard {
                            if checkForMatch(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard) {
                                let firstIndex = cards.index(of: firstCard)!
                                let secondIndex = cards.index(of: secondCard)!
                                let thirdIndex = cards.index(of: thirdCard)!
                                return (true,[firstIndex,secondIndex,thirdIndex])
                            }
                        }
                    }
                }
            }
        }
        return (false,[])
    }
    func checkForMatch(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        let colorsMatch = matchColors(firstCard: firstCard,secondCard: secondCard,thirdCard: thirdCard)
        let opacityMatch = matchOpacity(firstCard: firstCard,secondCard: secondCard,thirdCard: thirdCard)
        let ammountMatch = matchAmmount(firstCard: firstCard,secondCard: secondCard,thirdCard: thirdCard)
        let shapeMatch = matchShapes(firstCard: firstCard,secondCard: secondCard,thirdCard: thirdCard)
        if colorsMatch, opacityMatch, ammountMatch, shapeMatch {
            return true
        }
        return false
    }
    func matchColors(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        if firstCard.color == secondCard.color && secondCard.color == thirdCard.color {
            return true
        } else if firstCard.color != thirdCard.color && firstCard.color != secondCard.color &&
            secondCard.color != thirdCard.color {
            return true
        }
        return false
    }
    func matchOpacity(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        if firstCard.opacity == secondCard.opacity && secondCard.opacity == thirdCard.opacity {
            return true
        } else if firstCard.opacity != thirdCard.opacity && firstCard.opacity != secondCard.opacity &&
            secondCard.opacity != thirdCard.opacity {
            return true
        }
        return false
    }
    func matchAmmount(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        if firstCard.ammount == secondCard.ammount && secondCard.ammount == thirdCard.ammount {
            return true
        } else if firstCard.ammount != thirdCard.ammount && firstCard.ammount != secondCard.ammount &&
            secondCard.ammount != thirdCard.ammount {
            return true
        }
        return false
    }
    func matchShapes(firstCard: SetCard, secondCard: SetCard, thirdCard: SetCard) -> Bool {
        if firstCard.shape == secondCard.shape && secondCard.shape == thirdCard.shape {
            return true
        } else if firstCard.shape != thirdCard.shape && firstCard.shape != secondCard.shape &&
            secondCard.shape != thirdCard.shape {
            return true
        }
        return false
    }
}
