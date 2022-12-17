//
//  PlayerOneViewController.swift
//  ModularStoryboards
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import UIKit

class PlayerOneViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var name: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            nameLabel.text
        }
    }
    
    var score: String? {
        set {
            scoreLabel.text = newValue
        }
        get {
            scoreLabel.text
        }
    }
}
