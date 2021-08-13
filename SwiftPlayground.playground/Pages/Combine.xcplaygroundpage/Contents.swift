//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

enum CombineError: Error {
    case one
}

extension CombineError: CustomDebugStringConvertible {
    var debugDescription: String {
        return "One"
    }
}

let future = Combine.Future <String, Error> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print("send")
        promise(.failure(CombineError.one))
//        promise(.success("Done"))
    }
}
print("ready")
let cancelToken = future.sink(
    receiveCompletion: { error in
        print(error)
        cancelToken.cancel()
        PlaygroundPage.current.finishExecution()
    },
    receiveValue:  { value in
        print(value)
        cancelToken.cancel()
        PlaygroundPage.current.finishExecution()
    })

//: [Next](@next)
