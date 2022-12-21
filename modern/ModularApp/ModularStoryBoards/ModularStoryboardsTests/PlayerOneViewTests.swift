//
//  PlayerOneViewTests.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
@testable import ModularStoryboards

final class PlayerOneViewTests: AppTestCase {
    private let storyboard = UIStoryboard(
        name: "PlayerOneView",
        bundle: nil
    )
    private weak var sut: PlayerViewController!
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(sut)
    }

    func test_playerOneViewInitialViewController_isPlayerOneViewController() {
        _ = createSut()
    }
    
    func test_playerOneView_nameSetter_updatesNameLabel() {
        // Given
        let sut = createSut()
        sut.loadView()
        // When
        applyAppearLifeCycle(sut)
        sut.name = "Test"
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Test")
        applyDisappearLifeCycle(sut)
    }
    
    func test_playerOneView_scoreSetter_updatesScoreLabel() {
        // Given
        let sut = createSut()
        sut.loadView()
        // When
        applyAppearLifeCycle(sut)
        sut.score = "15"
        // Then
        XCTAssertEqual(sut.scoreLabel.text, "15")
        applyDisappearLifeCycle(sut)
    }
    
    private func createSut() -> PlayerViewController {
        sut = storyboard.instantiateInitialViewController() as? PlayerViewController
        XCTAssertNotNil(sut)
        return sut ?? PlayerViewController()
    }
}
