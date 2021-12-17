//: [Previous](@previous)

import Foundation

let data = Data(repeating: 8, count: 128)
print(data.count)
let data2 = data[0..<128]
print(data2.count)

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

public enum UnitValueState: Int {
    case good = 0
    case warning
    case danger
    case alarm
}

let range1: Range<Double> = 1..<2
print(range1.contains(1.99))

func state(value: Double) -> UnitValueState {
    switch value {
    case 0..<1:
        return .good
    case 1..<3:
        return .warning
    case 4..<10:
        return .danger
    default:
        return .alarm
    }
}

print(state(value: 1.5))


//: [Next](@next)
