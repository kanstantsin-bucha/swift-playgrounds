//: [Previous](@previous)

import Foundation

class TasksQueue {
    private actor TaskQueueActor {
        private var closures : [() async -> Void] = []
        private var currentTask : Task<Void,Never>? = nil
        
        func async(closure: @escaping () async -> Void) {
            closures.append(closure)
            next()
        }
        
        func next() {
            guard currentTask != nil else {
                preconditionFailure("currentTask should always be nil here")
            }
            guard !closures.isEmpty else { return }
            let closure = closures.removeFirst()
            currentTask = Task {
                await closure()
                currentTask = nil
                next()
            }
        }
    }
    private let taskQueueActor = TaskQueueActor()
    
    func async(closure: @escaping () async ->Void){
        Task {
            await taskQueueActor.async(closure: closure)
        }
    }
}


//: [Next](@next)
