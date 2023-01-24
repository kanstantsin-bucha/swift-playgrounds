//: [Previous](@previous)

import Foundation

enum IntError: Error {
    case failure(code: Int)
}


func throwing(int: Int) throws {
    throw IntError.failure(code: int)
}

func throwing(array: [Int]) throws {
    try array.forEach { try throwing(int: $0) }
}

do {
    try throwing(array: [1, 2, 3])
} catch {
    print(error)
}

//: [Next](@next)
