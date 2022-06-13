//: [Previous](@previous)

import Foundation

let group = DispatchGroup()
group.notify(queue: DispatchQueue.main) {
    print("GO BRUINS")
}
print("1")
group.enter()
group.leave()
print("2")

//: [Next](@next)
