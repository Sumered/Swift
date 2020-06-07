//
//  GameDifficultyViewController.swift
//  SetGame
//
//  Created by Kacper Szufnarowski on 22.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import UIKit

class GameDifficultyViewController: UIViewController {

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EasyAI":
                if let sgvc = segue.destination as? SetGameViewController {
                    sgvc.oneTurnTime = 22.5
                    sgvc.AI = true
                }
            case "MediumAI":
                if let sgvc = segue.destination as? SetGameViewController {
                    sgvc.oneTurnTime = 15.0
                    sgvc.AI = true
                }
            case "HardAI":
                if let sgvc = segue.destination as? SetGameViewController {
                    sgvc.oneTurnTime = 7.5
                    sgvc.AI = true
                }
            default: break
            }
        }
    }

}
