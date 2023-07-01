import UIKit

var greeting = "Hello, playground"

let weather = "sunny"

switch weather {
case "rain":
    print("rain")
case "snow":
    print("snow")
case "sunny":
    print("sunny")
    fallthrough
default:
    print("fallthrough")
}

let score = 85

switch score {
case (1...50):
    print("Not bad")
case (50...100):
    print("Good")
default:
    print("Some wrong")
}
