//: [Previous](@previous)

import Foundation

let formatter = DateFormatter()
formatter.dateFormat = "MMMM dd, yyyy' at 'hh:mm a"
formatter.amSymbol = "AM"
formatter.pmSymbol = "PM"

formatter.string(from: Date())

//: [Next](@next)
