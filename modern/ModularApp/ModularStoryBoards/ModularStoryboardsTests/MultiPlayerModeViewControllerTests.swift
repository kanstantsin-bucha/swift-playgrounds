//
//  MultiPlayerModeViewControllerTests.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
@testable import ModularStoryboards

final class MultiPlayerModeViewControllerTests: XCTestCase {
    private let storyboard = UIStoryboard(
        name: "MultiPlayerModeView",
        bundle: nil
    )

    func test_multiPlayerModeStoryboardInitialViewController_isMultiPlayerModeViewController() {
        XCTAssertNotNil(makeMultiPlayerModeViewController())
    }
    
    func test_multiPlayerModeStoryboard_setsPlayerScoreViewController() {
        // Given
        let sut = makeMultiPlayerModeViewController()
        // When
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        // Then
        XCTAssertNotNil(sut?.playersScore)
        window.resignKey()
    }
    
    private func makeMultiPlayerModeViewController() -> MultiPlayerModeViewController? {
        storyboard.instantiateInitialViewController() as? MultiPlayerModeViewController
    }
}
