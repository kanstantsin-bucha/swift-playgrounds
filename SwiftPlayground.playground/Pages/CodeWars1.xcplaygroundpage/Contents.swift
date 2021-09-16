//: [Previous](@previous)

import Foundation

extension Int {
    var digits: [UInt] { String(self).compactMap { $0.wholeNumberValue.map { UInt($0) } }}
}

extension UInt {
    func power(_ power: Int) -> UInt { UInt(pow(Double(self), Double(power))) }
}

func digPow(for number: Int, using power: Int) -> Int {
    var p = power
    let k: UInt = number.digits.reduce(0) { partialResult, digit in
        let sum = partialResult + digit.power(p)
        p += 1
        return sum
    }
    return Int(k) % number == 0 ? Int(k) / number : -1
}

import XCTest

class SolutionTest: XCTestCase {
    static var allTests = [
        ("Test Example", testExample),
    ]

    func testExample() {
        XCTAssertEqual(digPow(for: 89, using: 1), 1)
        XCTAssertEqual(digPow(for: 92, using: 1), -1)
        XCTAssertEqual(digPow(for: 46288, using: 3), 51)
    }
}

SolutionTest.defaultTestSuite.run()

//: [Next](@next)
