//: [Previous](@previous)

import Foundation
import PlaygroundSupport

let group = DispatchGroup()


group.enter()

DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
    print("unlock")
    group.leave()
}

group.wait()

print("Done")
//PlaygroundPage.current.finishExecution()



//: [Next](@next)
