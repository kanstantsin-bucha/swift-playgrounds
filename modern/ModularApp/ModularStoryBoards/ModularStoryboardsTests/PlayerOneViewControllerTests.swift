//
//  PlayerOneViewControllerTests.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
import ModularStoryboards

final class PlayerOneViewControllerTests: XCTestCase {
    private let storyboard = UIStoryboard(
        name: "PlayerOneView",
        bundle: nil
    )

    func test_playerOneViewInitialViewController_isPlayerOneViewController() {
        XCTAssertTrue(storyboard.instantiateInitialViewController() is PlayerOneViewController)
    }
}
