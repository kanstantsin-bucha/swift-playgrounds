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

class Alone {
    func work() {
        print("work")
    }
}

var one: Alone?
weak var two: Alone?

one = Alone()
two = one

two?.work()

one = nil
DispatchQueue.main.async() {
    print(two != nil)
    two?.work()
    PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.needsIndefiniteExecution



//: [Next](@next)
