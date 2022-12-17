//
//  SinglePlayerModeViewController.swift
//  ModularStoryboards
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import UIKit

class SinglePlayerModeViewController: UIViewController {
    // we use prepare for segue method and segue.identifier that set in the storyboard
    var playerScore: PlayerOneViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedPlayerOneView",
           let score = segue.destination as? PlayerOneViewController {
            playerScore = score
        }
    }
}
