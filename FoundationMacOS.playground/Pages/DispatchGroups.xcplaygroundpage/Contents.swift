//: [Previous](@previous)

import Foundation

func leave() {
    let group = DispatchGroup()
    group.notify(queue: DispatchQueue.main) {
        print("GO BRUINS")
    }
    print("1")
    group.enter()
    group.leave()
    print("2")
}


func wait() {
    let group = DispatchGroup()
    
    group.enter()
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        print("unlock")
        group.leave()
    }
    
    group.wait()
    
    print("Done")
}

//: [Next](@next)
