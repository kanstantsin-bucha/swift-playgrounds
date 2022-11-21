//: [Previous](@previous)

import Foundation

// https://app.coderpad.io/dashboard/pads
// https://www.youtube.com/watch?v=F9EYpdIkDhQ&t=11s

print("Polynom O(n)")

func isPolynom1(_ string: String) -> Bool {
    guard string.count > 1 else { return true }
    return string.reversed().elementsEqual(string)
}

print(isPolynom1("ABTBA"))

print("Polynom O(n/2)")

func isPolynom2(_ string: String) -> Bool {
    guard string.count > 1 else { return true }
    let middle = Int(string.count / 2)
    for i in 0..<middle {
        let forwardIndex = string.index(string.startIndex, offsetBy: i)
        let backwardIndex = string.index(string.endIndex, offsetBy: -(i + 1))
        guard string[forwardIndex] == string[backwardIndex] else {
            return false
        }
    }
    return true
}

print(isPolynom2("ABTBA"))

//: [Next](@next)
