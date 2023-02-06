//
//  ListView.swift
//  100Days
//
//  Created by Aliaksandr Bucha on 23/01/2023.
//

import SwiftUI

struct ListView: View {
    let people = ["1", "2", "3", "4"]
    var body: some View {
        List {
            Section{
                Text("Hello")
                Text("Hello")
            }
            Section("Section 2 ") {
                ForEach(people, id: \.self) {
                    Text("People \($0)")
                }
            }
        }
        .listStyle(.grouped)
    }
    func test() {
        let input = " a b c"
        let letters = input.components(separatedBy: " ")
    }
    func test2() {
        let input = """
a
b
c
"""
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func test3() {
        let word = "Swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
