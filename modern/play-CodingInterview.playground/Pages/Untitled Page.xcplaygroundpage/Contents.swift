//: [Previous](@previous)

import Foundation


print("Two numbers: O(2 * n)")


func findTwo(target: Int, in array: [Int]) -> (Int, Int)? {
    let dict = Dictionary(array.enumerated().map { ($0.element, $0.offset) }, uniquingKeysWith: +)
    for (index1, number) in array.enumerated() {
        if let index2 = dict[target - number] {
            return (index1, index2)
        }
    }
    return nil
}

print("Numbers: \(String(describing: findTwo(target:20, in: [5, 10, 4, 15, 25])))")

//: [Next](@next)
