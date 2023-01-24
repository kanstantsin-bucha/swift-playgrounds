//: [Previous](@previous)

import Foundation

typealias SendableClosure = @Sendable () -> Void



// Use Sendable Type

class SendableError: @unchecked Sendable {
    var error: Error? = nil
}

Task {
    let error: SendableError = SendableError()
    let closure: SendableClosure = {
        Task {
            await MainActor.run {
                error.error = NSError(domain: "", code: 1)
                print(error.error)
            }
        }
    }
    Task {
        closure()
        print("task 2")
    }
    print("task 1")
}

print("run")

// Use same concurrency domain like MainActor

Task { @MainActor in
    var error: Error?
    let closure: SendableClosure = {
        Task {
            await MainActor.run {
                error = NSError(domain: "", code: 2)
                print(error)
            }
        }
    }
    Task {
        closure()
        print("task 2-2")
    }
    print("task 1-2")
}

print("run 2")

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
