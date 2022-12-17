//
//  MultiPlayerScoreViewTest.swift
//  ModularStoryboardsTests
//
//  Created by Kanstantsin Bucha on 17/12/2022.
//

import XCTest
@testable import ModularStoryboards

final class MultiPlayerScoreViewTest: XCTestCase {
    private let storyboard = UIStoryboard(
        name: "MultiPlayerScoreView",
        bundle: nil
    )

    func test_MultiPlayerScoreViewInitialViewController_isMultiPlayerScoreViewController() {
        XCTAssertNotNil(createMultiPlayerScoreViewController())
    }
    
    private func createMultiPlayerScoreViewController() -> MultiPlayerScoreViewController? {
        storyboard.instantiateInitialViewController() as? MultiPlayerScoreViewController
    }
}
