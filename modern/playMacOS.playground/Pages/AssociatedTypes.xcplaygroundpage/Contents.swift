//: [Previous](@previous)

import Foundation

protocol UserSource {
    associatedtype User
    
    func next() -> User
}

struct Company {
    var userSource: any UserSource
}

class Gamer {}
class Worker {
    func work() {
        print("working")
    }
}

struct GamerSourceImpl: UserSource {
    typealias User = Gamer
    
    func next() -> Gamer {
        Gamer()
    }
}

struct WorkerSourceImpl: UserSource {
    typealias User = Worker
    
    func next() -> Worker {
        Worker()
    }
}

let companies = [Company(userSource: WorkerSourceImpl()), Company(userSource: GamerSourceImpl())]
let gamer = companies[1].userSource.next()
let worker = companies[0].userSource.next()

print(type(of: gamer))
print(type(of: worker))

(worker as? Worker)?.work()

//: [Next](@next)
