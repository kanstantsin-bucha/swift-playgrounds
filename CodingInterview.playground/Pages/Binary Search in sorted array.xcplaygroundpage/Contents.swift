//: [Previous](@previous)

import Foundation

// https://app.coderpad.io/dashboard/pads
// https://www.youtube.com/watch?v=F9EYpdIkDhQ&t=11s

print("Binary search in sorted array O(log n)")

func isNumberPresent(_ targetNumber: Int, in array:[Int]) -> Bool {
    var leftBound = 0
    var rightBound = array.count - 1
    while leftBound <= rightBound {
        let middleIndex = Int((rightBound + leftBound) / 2)
        let evaluatedNumber = array[middleIndex]
        print("> leftBound = \(leftBound), rightBound = \(rightBound)")
        print("evaluatedNumber = \(evaluatedNumber), middleIndex = \(middleIndex)")
        
        if evaluatedNumber == targetNumber {
            return true
        } else if evaluatedNumber > targetNumber {
            rightBound = middleIndex - 1
        } else {
            leftBound = middleIndex + 1
        }
        print(">== leftBound = \(leftBound), rightBound = \(rightBound)")
    }
    return false
}

print(isNumberPresent(4, in: [1, 2, 3, 5, 6, 7, 12, 15, 23]))

//: [Next](@next)
