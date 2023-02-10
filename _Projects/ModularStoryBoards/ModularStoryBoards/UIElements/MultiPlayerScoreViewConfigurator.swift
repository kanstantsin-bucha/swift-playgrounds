//
//  MultiPlayerScoreViewConfigurator.swift
//  ModularStoryboards
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import UIKit

class MultiPlayerScoreViewConfigurator: NSObject {
    // we use object inside MultiPlayerScoreView storyboard to get reference to scoreViewController
    private var observation: NSKeyValueObservation?
    @IBOutlet private weak var scoreViewController: MultiPlayerScoreViewController? {
        didSet {
            observation = scoreViewController?.observe(\.parent, changeHandler: { scoreViewController, changes in
                if let multiPlayerMode = scoreViewController.parent as? MultiPlayerModeViewController {
                    multiPlayerMode.playersScore = scoreViewController
                }
            })
        }
    }
    
}
 
