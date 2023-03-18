//: [Previous](@previous)

import Foundation

enum IntError: Error {
    case failure(String)
}

@discardableResult
func throwing(string: String) throws -> String {
    throw IntError.failure(string)
}

func throwing(array: [String]) throws {
    try array.forEach { try throwing(string: $0) }
}

func rethrowing(input: String, convert: (String) throws -> String) rethrows -> String {
    try convert(input)
}

do {
    // We don't need try here because closure do not throw
    let in1 = rethrowing(input: "A", convert: { $0.lowercased() })
    // We need try here because closure do  throw
    let in2 = try rethrowing(input: "A", convert: { try throwing(string: $0) })
} catch {
    print(error)
}

//: [Next](@next)
