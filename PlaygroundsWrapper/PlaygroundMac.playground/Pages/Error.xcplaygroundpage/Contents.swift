//: [Previous](@previous)

import Foundation


public enum MyError: Error {
    case customError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return "error Description here"
        }
    }
}

let error: Error = MyError.customError
print(error)
print(error.localizedDescription)

//: [Next](@next)
