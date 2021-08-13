//: [Previous](@previous)

import Foundation


public enum MyError: Error {
    case customError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return "errorDescription"
        }
    }
}

let error: Error = MyError.customError
print(error.errorDescription)

//: [Next](@next)
