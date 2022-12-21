//
//  PlayerOneViewTests.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
@testable import ModularStoryboards

final class PlayerOneViewTests: XCTestCase {
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
        XCTAssertNotNil(createPlayerOneViewController())
    }
    
    func test_playerOneView_nameSetter_updatesNameLabel() {
        // Given
        let sut = createPlayerOneViewController()
        sut?.loadView()
        // When
        sut?.name = "Test"
        // Then
        XCTAssertEqual(sut?.nameLabel.text, "Test")
    }
    
    func test_playerOneView_scoreSetter_updatesScoreLabel() {
        // Given
        let sut = createPlayerOneViewController()
        sut?.loadView()
        // When
        sut?.score = "15"
        // Then
        XCTAssertEqual(sut?.scoreLabel.text, "15")
    }
    
    private func createPlayerOneViewController() -> PlayerViewController? {
        sut = storyboard.instantiateInitialViewController() as? PlayerViewController
        return sut
    }
}
