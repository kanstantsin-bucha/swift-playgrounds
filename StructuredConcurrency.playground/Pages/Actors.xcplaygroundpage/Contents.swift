//: [Previous](@previous)

import Foundation

actor ChickenFarm {
    nonisolated var feedDescription: String {
        "chicken was fed with \(food)"
    }
    let food = "Corn"
//    private(set) var chickenCount: Int = 0
    internal var chickenCount: Int = 0
    
    func addChicken(_ count: Int) {
        chickenCount += count
    }
    
    func removeChicken() {
        chickenCount -= 1
    }
    
    nonisolated func feedChicken() {
        print(feedDescription)
    }
    
    func move(chickens: Int, toFarm farm: isolated ChickenFarm) {
        chickenCount -= chickens
//        farm.addChicken(chickens)
        farm.chickenCount += chickens
    }
}
extension ChickenFarm: CustomStringConvertible {
    nonisolated var description: String {
        "farm have chickens"
    }
}

let farm = ChickenFarm()

await farm.addChicken(7)
print(await farm.chickenCount)
farm.feedChicken()

let farm2 = ChickenFarm()
await farm.move(chickens: 4, toFarm: farm2)
print(farm2)
print(farm2.feedDescription)

//: [Next](@next)
