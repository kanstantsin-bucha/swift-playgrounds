//: [Previous](@previous)

import Foundation

let date = Date()
let slightlyEarlier = date - 0.001
print(date)
print(slightlyEarlier)

struct MyOptions : OptionSet {
    let rawValue: Int

    static let None         = MyOptions(rawValue: 0)
    static let FirstOption  = MyOptions(rawValue: 1 << 0)
    static let SecondOption = MyOptions(rawValue: 1 << 1)
    static let ThirdOption  = MyOptions(rawValue: 1 << 2)
}

func test(options: MyOptions) {
    print(options)
}

test(options: [.FirstOption, .SecondOption])

let range = 1...3
range.upperBound


func triangular(_ n: Int) -> Int{
 guard n>0 else { return  0}
 guard n>1 else { return  1}
 var result = 1
 var row = 1
 for _ in 2...n {
   result += row + 1
   row += 1
   print(row)
 }
 return result
}

triangular(0)


//: [Next](@next)
