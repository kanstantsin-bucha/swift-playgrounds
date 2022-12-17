//
//  MultiPlayerScoreViewController.swift
//  ModularStoryboards
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import UIKit

class MultiPlayerScoreViewController: UIViewController {
    // We use here access to the children (all embedded controllers became children)
    var playerOne: PlayerViewController! {
        return children.compactMap { $0 as? PlayerViewController }.first
    }
    var playerTwo: PlayerViewController! {
        return children.compactMap { $0 as? PlayerViewController }.last
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
}
