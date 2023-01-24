//: [Previous](@previous)

import Foundation

var data = Data(count: 20)
data.withUnsafeMutableBytes { mutablePointer in
    let byte: Int8 = 5
    mutablePointer.initialize(repeating: byte, count: 20)
}
print(data.map { String(format: "%02hhx", $0) }.joined())

//: [Next](@next)
