//: [Previous](@previous)

import Foundation
import PlaygroundSupport

var optional: Int!
//optional = 7

if optional != nil {
    print("not nil")
} else {
    print("nil")
}

if let _ = optional {
    print("not nil")
} else {
    print("nil")
}

с
class Alone {
    var optional: Int?
    func work() {
        print("work")
    }
}

var one: Alone?
weak var two: Alone?

one = Alone()
one?.optional = 8
two = one

two?.work()
// ===

if let opt = one?.optional {
    print(opt)
}

// ===

one = nil
DispatchQueue.main.async() {
    print(two != nil)
    two?.work()
    PlaygroundPage.current.finishExecution()
}




PlaygroundPage.current.needsIndefiniteExecution



//: [Next](@next)
