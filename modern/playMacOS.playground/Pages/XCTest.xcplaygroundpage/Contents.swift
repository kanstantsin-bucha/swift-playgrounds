//: [Previous](@previous)

import Foundation
import XCTest

class Tests: XCTestCase {
    private var expectation: XCTestExpectation!
    override func setUp() {
        expectation = XCTestExpectation()
        expectation.isInverted = true
    }
    
    override func tearDown() {
//        expectation = nil
    }
    
    func test() {
        print("run")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.expectation.fulfill()
        }
        print(Date())
        wait(for: [expectation], timeout: 3)
        print(Date())
    }
    
    func test1() {
        print("run1")
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.expectation.fulfill()
        }
        print(Date())
        wait(for: [expectation], timeout: 3)
        print(Date())
    }
}

//Tests.defaultTestSuite.run()
Tests.testInvocations


//: [Next](@next)
