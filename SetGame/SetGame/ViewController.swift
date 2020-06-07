//
//  ViewController.swift
//  SetGame
//
//  Created by Kacper Szufnarowski on 20.08.2018.
//  Copyright © 2018 Kacper Szufnarowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Play vs Iphone":
                if let svc = segue.destination as? SetGameViewController {
                    svc.AI = true
                }
            default: break
            }
        }
    }
    
}

