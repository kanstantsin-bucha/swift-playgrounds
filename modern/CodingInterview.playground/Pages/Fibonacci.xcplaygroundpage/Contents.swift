import UIKit

// https://app.coderpad.io/dashboard/pads
// https://www.youtube.com/watch?v=F9EYpdIkDhQ&t=11s

print("Fibonacci O(n)")

func fibonacci(index: Int) -> Int {
    guard index > 1 else { return 1 }
    var previous = 1
    var current = 1
    for _ in 1..<index {
        let sum = previous + current
        previous = current
        current = sum
    }
    return current
}

for index in 0...5 {
    print("\(index + 1): \(fibonacci(index: index))")
}
