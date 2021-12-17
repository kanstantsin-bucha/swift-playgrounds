//: [Previous](@previous)

import Foundation

class MyClass {
    static var num: Int = 8
}

let object = MyClass()
let type = MyClass.self

//type(of: object)

typealias AnyClass = AnyObject.Type.Type
print("\(AnyClass.self)")

//: [Next](@next)
