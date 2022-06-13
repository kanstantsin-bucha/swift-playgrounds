//: [Previous](@previous)

import Foundation

private func getBoolSync() -> Bool {
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
        print("Done")
        dispatchGroup.leave()
    }
    dispatchGroup.wait()
    return true
}

print(Thread.current)
DispatchQueue.global().async {
    getBoolSync()
}
getBoolSync()
print(1)
print(Thread.current)



//: [Next](@next)
