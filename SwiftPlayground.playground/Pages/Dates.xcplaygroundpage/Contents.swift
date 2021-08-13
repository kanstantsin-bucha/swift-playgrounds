//: [Previous](@previous)

import Foundation

func remain(date: Date) {
    let remainSec = Int(date.timeIntervalSince(Date()))
    print(remainSec)
    print(String(format: "is locked for %d sec", max(remainSec, 0)))
}

let date = Date(timeIntervalSinceNow: 30)
DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
    remain(date: date)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
    remain(date: date)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 28) {
    remain(date: date)
}

//: [Next](@next)
