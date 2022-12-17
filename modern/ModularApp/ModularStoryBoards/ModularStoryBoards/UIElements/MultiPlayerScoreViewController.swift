//
//  MultiPlayerScoreViewController.swift
//  ModularStoryboards
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import UIKit

class MultiPlayerScoreViewController: UIViewController {
    // We use here access to the children (all embedded controllers became children)
    var playerOne: PlayerOneViewController! {
        return children.compactMap { $0 as? PlayerOneViewController }.first
    }
    var playerTwo: PlayerTwoViewController! {
        return children.compactMap { $0 as? PlayerTwoViewController }.first
    }
}
