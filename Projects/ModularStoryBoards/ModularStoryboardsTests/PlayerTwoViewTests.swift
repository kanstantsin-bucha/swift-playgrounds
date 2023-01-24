//
//  PlayerTwoViewTests.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
@testable import ModularStoryboards

final class PlayerTwoViewTests: XCTestCase {
    private let storyboard = UIStoryboard(
        name: "PlayerTwoView",
        bundle: nil
    )

    func test_playerTwoViewInitialViewController_isPlayerViewController() {
        XCTAssertNotNil(createPlayerTwoViewController())
    }
    
    func test_playerTwoView_nameSetter_updatesNameLabel() {
        // Given
        let sut = createPlayerTwoViewController()
        sut?.loadView()
        // When
        sut?.name = "Test"
        // Then
        XCTAssertEqual(sut?.nameLabel.text, "Test")
    }
    
    func test_playerTwoView_scoreSetter_updatesScoreLabel() {
        // Given
        let sut = createPlayerTwoViewController()
        sut?.loadView()
        // When
        sut?.score = "15"
        // Then
        XCTAssertEqual(sut?.scoreLabel.text, "15")
    }
    
    private func createPlayerTwoViewController() -> PlayerViewController? {
        storyboard.instantiateInitialViewController() as? PlayerViewController
    }
}
