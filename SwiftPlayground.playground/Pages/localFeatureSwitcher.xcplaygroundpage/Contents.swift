//: [Previous](@previous)

import Foundation

import UIKit
import XCPlayground
import PlaygroundSupport


enum MyEnum {
    case myCase1
    case myCase2
}

@propertyWrapper
struct GreaterOrEqual {
    private var value: Int
    private var minimum: Int
    var projectedValue: Bool
    var wrappedValue: Int {
        get { value }
        set {
            value = Self.max(newValue, minimum)
            projectedValue = value != newValue
        }
    }

    init() {
        value = 0
        minimum = Int.min
        projectedValue = false
        print("init \(value), \(minimum)")
    }
    init(wrappedValue: Int) {
        minimum = Int.min
        value = Self.max(wrappedValue, minimum)
        projectedValue = value != wrappedValue
        print("wrappedValue \(value), \(minimum)")
    }
    init(wrappedValue: Int, minimum: Int) {
        self.minimum = minimum
        value = Self.max(wrappedValue, minimum)
        projectedValue = value != wrappedValue
        print("wrappedValue minimum \(value), \(minimum)")
    }

    private static func max(_ a: Int, _ b: Int) -> Int {
        a > b ? a : b
    }
}

struct Test {
    @GreaterOrEqual(minimum: 12) var length = 1
}

var test = Test()
print(test.$length)
test.length = 45
print(test.$length)
test.length = 0
print(test.$length)

//: [Next](@next)
