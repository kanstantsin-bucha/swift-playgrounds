//: [Previous](@previous)

import Foundation

let stringSubsec = "12,23,23,242".split(separator: ",")
print(stringSubsec)
print(stringSubsec.second)

let array = [11, 22, 33]
print(array)
print(array.second)

fileprivate extension String.SubSequence {
    var second: Element? {
        print("count \(count)")
        guard count >= 2 else { return nil }
        return self[index(after: startIndex)]
    }
}

fileprivate extension Array {
    var second: Element? {
        guard count > 2 else { return nil }
        return self[1]
    }
}

let arrayToReduce = ["1", "", "3", "4"]
let isAnyEmpty = arrayToReduce.reduce(false) { previousResult, element in
    return previousResult || element.isEmpty
}
print(isAnyEmpty)
//: [Next](@next)
