//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import Foundation



let state = AppState()

// MARK: - Preview

struct Container: View {
    var body: some View {
        ContentView(gradient: state.$gradient)
            .frame(width: 395, height: 700)
    }
}
import PlaygroundSupport
PlaygroundPage.current.setLiveView(Container())

//: [Next](@next)

