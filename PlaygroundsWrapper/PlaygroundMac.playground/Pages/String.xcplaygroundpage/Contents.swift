//: [Previous](@previous)

import Foundation

let format = "Are you %1$s, %2$s, %3$d, %4$.2f".replacingOccurrences(of: "$s", with: "$@")
print(String(format: format, "test", "2", 3, 45.67))

//: [Next](@next)
