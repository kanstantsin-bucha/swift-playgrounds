//: [Previous](@previous)

import Foundation

let format = "Are you %1$s, %2$s, %3$03d, %4$.2f".replacingOccurrences(of: "$s", with: "$@")
print(String(format: format, "test", "2", 3, 45.67))


print("I am %1$@ %2$@".localizedWith("Mike", "Tyson"))

extension String {
    func localized() -> String { self }
    
    func localizedWith(_ arguments: CVarArg...) -> String {
        return String(format: self.localized(), locale: Locale.current, arguments: arguments)
    }

}

//: [Next](@next)
