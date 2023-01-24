//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
protocol Prop {
    var property: Data { get }
}

class ImpProp: Prop {
    lazy var property: Data = Data()
}
//: [Next](@next)
