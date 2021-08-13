//: [Previous](@previous)

import Foundation

var count = 0

let handler = {
    count += 1
    if count >= 3 {
        print("done")
    }
}

struct Caller {
    var closure: () -> Void

    init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    func call() {
        closure()
    }
}

let callerOne = Caller(handler)
let callerTwo = Caller(handler)

callerOne.call()
print(count)
callerTwo.call()
print(count)
callerOne.call()
print(count)

//: [Next](@next)
