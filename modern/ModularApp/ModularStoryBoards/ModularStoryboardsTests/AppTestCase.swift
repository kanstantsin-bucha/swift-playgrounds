//
//  AppTestCase.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 21/12/2022.
//

import XCTest

class AppTestCase: XCTestCase {
    
    func applyAppearLifeCycle(_ viewController: UIViewController) {
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }
    
    func applyDisappearLifeCycle(_ viewController: UIViewController) {
        viewController.viewWillDisappear(false)
        viewController.viewDidDisappear(false)
    }
}
